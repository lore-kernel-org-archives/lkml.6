Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvE4cVyVPxpvtgrOHHvJdb9be8wLw65GEsf/fAM5lbak5AGl27zPnBEzEfsQ3xEOGaVhRzU
ARC-Seal: i=1; a=rsa-sha256; t=1521800313; cv=none;
        d=google.com; s=arc-20160816;
        b=dEvylGhwwQrkhEA4eVvQXfZZ/lF9xrN/2bXo8Bk8fOBIJWORTudo8UhQ+jJLqecq+8
         BSeAjiQoV0sQy8AnL1zcqmLpuA0JiWNRNZc/DB+RT/lcJNEyAXO+m276w+xPNvDsea0e
         PobE/I19vFzJiBFWgEKs63YiJBjwXrUBRBu3C2VI+bUm0R/VjL4RQFAMtglpyRUke3ps
         VuUSTxSZM9nwcGtRLoNr8l1Ji8nanQ32R8LhqlDZZk3XbRyWiOmHSm4zVdQ9DItJ/U9z
         Lkk4WkEarZ0RJPmruqULs+qIYkchseVFMMzpiQVOSKQpRjEirzB3YT2DKC9IWyOIAaux
         wKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NPGFki4TeSehQyqlcZQ7wF3k5/09y9xNvx/2NWZMdYs=;
        b=RIjq4oc5EZHplI/LewkZoAd2YcdGdlv0T676u+aqUzf4A14b88p3vPTTQuqvp3/Lss
         IGFlGwLcVbA/IXM11M7tQuO3unlBQEsWy3UCXf0bTWWWcnIfZEWehTicGRzY3qoNtqBS
         hqZ+HbBBjI13tXXUVMEPj4kZT0m4qSgfHCuUbN6vUpur2gMO5LoUjv3nrr0XtqUsdUBf
         9ecMiK+vvSRBqfQQ23FzVqxtUAA7Dz85nGCyRpdQYld1JJL+gArFqMi80UgjKxzRdZ32
         hru/DCosmf8ZqPXEDtfYUieiH9V6wM5EglvFjqAviMZ5ReaRHihwAtfLdxQQ7hIC1e/O
         bMhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 10/47] spi: dw: Disable clock after unregistering the host
Date: Fri, 23 Mar 2018 10:55:01 +0100
Message-Id: <20180323094248.559569426@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722454469888802?=
X-GMAIL-MSGID: =?utf-8?q?1595723285274879230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>


[ Upstream commit 400c18e3dc86e04ef5afec9b86a8586ca629b9e9 ]

The dw_mmio driver disables the block clock before unregistering
the host. The code unregistering the host may access the SPI block
registers. If register access happens with block clock disabled,
this may lead to a bus hang. Disable the clock after unregistering
the host to prevent such situation.

This bug was observed on Altera Cyclone V SoC.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-dw-mmio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -118,8 +118,8 @@ static int dw_spi_mmio_remove(struct pla
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(dwsmmio->clk);
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->clk);
 
 	return 0;
 }
