Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49QlNOAWaMuxXZu6V1inaNi5Gd1V0NhRvSn8A9I+9I8fD1I5/uOLeMW2Q7Fz0imw3HXPut8
ARC-Seal: i=1; a=rsa-sha256; t=1524652741; cv=none;
        d=google.com; s=arc-20160816;
        b=FKYI1Q2w5SWQkADgz2y0fo3Ryf+CdCw0thntBaDHD3v3pi7YITcmBia/vau1ZsUItt
         DEZMouLHTBgoKt8RTnKEbqoFyAu1NIeZSv05ZThDxbbJWTjvrBYMzXkWaQoseJ+r/Zzb
         kJlPGKM+tqCDEbOTy35pzUbldZ3rTWhnYm/1Cdn7VhR4aGDFKgyUB6+xf0CWk5usBQx7
         v+bV23lJjthYIgxOezefVRVZaks0pRaw755y/f6KLU7MI1jQIMIP+70bu1gritdj/afb
         Ulhv3JE/OCBR3gf8+UdgZRJVY7l6wRPKjf3okSG/5IsnuFPjyfITOg2uUzzUXVeemMWn
         a5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rivMztVSLgNu7oXCWS6SjQ7OIyuZZ5oA0UnUwkG/8bY=;
        b=VZl0vA7T/7ROwt3V1Sxx11O4O1JKNWPrM9vTbSywv5vHRHcXHbT9UmKSKQDEjBw9os
         G0JfJsRhC7tuXYSe3zzpo+xwcJ2LgK/O//sYV0tx0dYcVleaGOtCkV513q2NY8kGlvZ7
         hbzA1+//lC7sJYjTbRZtLV6pogX9zor5p04eN9Mh0Ckzs5hJLKBFIvRURB9dASvAckE2
         LEGVfzaQhR/VUhDsT+npuaXi7aM2BFoZkq28NRy7gEYcb3gmRfW5Va6OnH1ifJTKW+9E
         Y2ropa2miz0zOW2FZd8yrv3GmYHsoiSInpNEhngdfi1py77TJ6bqJr6kz8fc/g8rkhAy
         rtfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@smile.fr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 052/183] spi: a3700: Clear DATA_OUT when performing a read
Date: Wed, 25 Apr 2018 12:34:32 +0200
Message-Id: <20180425103244.645304344@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714273342464535?=
X-GMAIL-MSGID: =?utf-8?q?1598714273342464535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@smile.fr>


[ Upstream commit 44a5f423e70374e5b42cecd85e78f2d79334e0f2 ]

When performing a read using FIFO mode, the spi controller shifts out
the last 2 bytes that were written in a previous transfer on MOSI.

This undocumented behaviour can cause devices to misinterpret the
transfer, so we explicitly clear the WFIFO before each read.

This behaviour was noticed on EspressoBin.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-armada-3700.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -624,6 +624,11 @@ static int a3700_spi_transfer_one(struct
 	a3700_spi_header_set(a3700_spi);
 
 	if (xfer->rx_buf) {
+		/* Clear WFIFO, since it's last 2 bytes are shifted out during
+		 * a read operation
+		 */
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, 0);
+
 		/* Set read data length */
 		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
 			     a3700_spi->buf_len);
