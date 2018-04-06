Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/QCBSN5KdnockTxtEOLco72D22kVdPt5sq1DrWqteLbpnetd6A38QsQGUEYfcAtqcAuquo
ARC-Seal: i=1; a=rsa-sha256; t=1523021532; cv=none;
        d=google.com; s=arc-20160816;
        b=k7a4yA+vHT4a9mY5qhTQb0eCNtW7ZHVtAhPABuNXIg6hMYd0NlXFunIR2cxkvyyTUy
         J9/tXvot6BQLPScsXTjHn8BuxLvQlgmzr6/2yxMSWrw9FFMlN2iYoP4jaGTxR8g++oaH
         9okA6FMhho7YsC5shovw8X24uP9tjU7FjSBOXVOJwS3nHig1UURn+fBtMwIp8NpMVdka
         1Sdpm3hvjnuZ4NmzzJWH9E4VeTWQxByLY0oowX9p3ovpifmazloF9yoH05g2EIAsmHir
         s/jP5OLetMGnoXXlT1R6I3OtEteu1yZRfcvcXw7V1fLAcuTm+LHWQgwksDzKCp2bQ0J4
         NVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B/2SnQ6JlItL4d6qxtJdwa6LJ5IB8OLod7kGUJA8Iks=;
        b=ba6fn0FxV2J6fVv91TI5U0UwzY+W53ywc0qcZPHPokveu8Wd7xlcCUR65XTW7e3/aw
         osAEpkqbF7DKIdyMzzI/6z5h95BqPQYB1KfSy4k04QVST7D6Pt8Cl0ElnfTedP/WeU0L
         IVC15ulyHaWjm2qi5gYgII4vvv1NB//ZvaCLK59NaDH9ZFrkD/qE/z16/eelu0NhBttY
         Hy1d6DZJ1MHewqz+B7pDkj5oxrBKjY9/Gi+1gPE+zEY9oih6Rf7GJOYI4LB93xl6b6am
         MKS34l7bNPH1ugEVNPjAdU77a8Q1V+FFDZEo4pUoaYl5ArNfqIPJHxlG8ghj9Px9sX4r
         f+6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Kevin Hilman <khilman@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.4 70/72] spi: davinci: fix up dma_mapping_error() incorrect patch
Date: Fri,  6 Apr 2018 15:24:11 +0200
Message-Id: <20180406084311.645523815@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003827159127567?=
X-GMAIL-MSGID: =?utf-8?q?1597003827159127567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 11dd9e2c480324b46118ff708ea2ca8d7022539b, which is commit
c5a2a394835f473ae23931eda5066d3771d7b2f8 upstream had an error in it.

Ben writes:
    The '!' needs to be deleted.  This appears to have been fixed upstream
    by:

    commit 8aedbf580d21121d2a032e4c8ea12d8d2d85e275
    Author: Fabien Parent <fparent@baylibre.com>
    Date:   Thu Feb 23 19:01:56 2017 +0100

	spi: davinci: Use SPI framework to handle DMA mapping

    which is not suitable for stable.

So I'm just fixing this up directly.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-davinci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -651,7 +651,7 @@ static int davinci_spi_bufs(struct spi_d
 			buf = t->rx_buf;
 		t->rx_dma = dma_map_single(&spi->dev, buf,
 				t->len, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
+		if (dma_mapping_error(&spi->dev, t->rx_dma)) {
 			ret = -EFAULT;
 			goto err_rx_map;
 		}
