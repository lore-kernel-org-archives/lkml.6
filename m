Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ktFnEH+YhQGXnde4VGcyaHhhMH9C5I5JOWXk/wvbvt6rGn4gm+a/TfiwU7Tp6/nNAb7Xk
ARC-Seal: i=1; a=rsa-sha256; t=1523021861; cv=none;
        d=google.com; s=arc-20160816;
        b=EaKYEYNueNaTTmj0LlVqyNUAqJk2vXVpcHYR1ExyQ9queoL/GklIrLu+0Bm/2U+2GA
         mRjL6XCafcvCmHF1MasIpbNbKjv2///f9ag5YVO0MQgrlGIZvtneCQE83G30iSJm40FG
         7UueF26VM/MIA2lN8GZD3Feq8p97AxFO6lXcuaxIdpRMgQwW1xFh2NgrWYo5RRXT2JXs
         fnajRTu3iksw76MVgdmAtyA+EWqT4obw3w1A+G3wL7jcya4PpVkPp+Y4/+1zyaPbbEBx
         3YQtWMKRKzs8UI3LdvDrwB20k3I29xp8xgVTlJn+0lXHLgGHVpFDD0R4aXzBsRXXCkdU
         hI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1bicykIlEE3LoHVHDQd+yPjD+o13jf9JekrDxEXnFS4=;
        b=pq6Ii+rwFP/1XYtwp0aWTs9fWJ120JWXwEHpDw/cOEt7uyN9r9Hd1haNegkBQU1yKf
         gem9QHfPgHS0dd3Btr/Pni/3kCcP69ih6QqVN1f4oAuGUsnomhiTaQgUmbjS4UlYl7vC
         BN2ewXDWOS1mI4dacU3IN+8Pz0FkAfsEkORVk7GwutjfQsa1IBetnIF9OVnv731+u3we
         bzHahabCa6hxUYQTveCovIjA9YZbWJGYmW1m3m6TFFeGn7+y9U/M6TGkbOMhd435x8CE
         H1PhDuG7IDcRe+wBIe63cOdTJF3X9GD7ItEieFewD2BNCFm6nHN2HUFTBLxcbJ85u1Vy
         Vdog==
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
Subject: [PATCH 4.9 102/102] spi: davinci: fix up dma_mapping_error() incorrect patch
Date: Fri,  6 Apr 2018 15:24:23 +0200
Message-Id: <20180406084345.761541623@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003827159127567?=
X-GMAIL-MSGID: =?utf-8?q?1597004171234376076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit aabb797b4c1204b2e8518538b2616e476f2bac92, which is commit
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
@@ -646,7 +646,7 @@ static int davinci_spi_bufs(struct spi_d
 			buf = t->rx_buf;
 		t->rx_dma = dma_map_single(&spi->dev, buf,
 				t->len, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
+		if (dma_mapping_error(&spi->dev, t->rx_dma)) {
 			ret = -EFAULT;
 			goto err_rx_map;
 		}
