Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48qVAV+V2aaXyzO++Js+dY5QvCpV9YQraypAOeUWSn9ggTvPtCHScN8xsGfwnbwEXJ/Kg//
ARC-Seal: i=1; a=rsa-sha256; t=1523399303; cv=none;
        d=google.com; s=arc-20160816;
        b=tVhNvPPemuRwEbt52NnUGbKzPLU9xz09T76SPOn9kEl6zTV2vIvOVjUOZfNbaPVleX
         BJK8TNy5WmnBZ30q1HbEmnlnkOeZWj/dQVPmGSBRF7wussZi8Muuj7PHp4DOSkIJJ4By
         5jwCRcbSfwgjj44mMYp4N7VzCZf2zGKSXnWJV0DVYE2hQzdzXvfeTHZbpWLudkubF2TN
         laz64v/lJI4QY7NLO4i72DGOY0B4A3e3SSB0p6VK9dg40ErJ+Gg2J8UO+Eg1VLUMWd/9
         CLCRcwFSpjN0ewhPvep1mlaFgUa/tZGrfLMO3fiU2/CF/1eQ8Z5FxSPDMzTkPrjKMl5b
         c8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CbSgfOdMZAQ4MOsO1ZYg65FnSEJdOGpLOAk/zUvPdfc=;
        b=GU6/+MhCopR/7TCMU6p7wstoxS1LqvrOV5Gd5GZzkqOHHSidkJwuROEZBOX+kc6nME
         abBEo9kMF91X476TO0pRkF0fr1SxAVL5uSS9zbvwHCkTwhofyZS+NisnLzBjkK8kZsnR
         /ZlxTTg+nKq18ejqHu/8I+3Co2M2B9KG+iUEsvQP67WGr0qv4tDGpTEnZg8oj3CxaTkl
         KyizkU6CGypem5WtYL5c81RYZxfZCvAUP3cv6btYiYW39UpCT3RDODt8coonPFwAxReO
         1DwviDqoo9ZIrzfo5YAiQgMFWg4kyjx7/g260hROgDqIP0wJNbQLHOBzugv6g0HP/8xg
         M7kA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 038/168] spi: sh-msiof: Fix timeout failures for TX-only DMA transfers
Date: Wed, 11 Apr 2018 00:23:00 +0200
Message-Id: <20180410212801.816711702@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399948316723931?=
X-GMAIL-MSGID: =?utf-8?q?1597399948316723931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 89434c3c35081439627baa2225622d5bd12242fe ]

When using RX (with or without TX), the DMA interrupt triggers
completion when the RX FIFO has been emptied, i.e. after the full
transfer has finished.

However, when using TX without RX, the DMA interrupt triggers completion
as soon as the DMA engine has filled the TX FIFO, i.e. before the full
transfer has finished.  Then sh_msiof_modify_ctr_wait() will spin until
the transfer has really finished and the TFSE bit is cleared, for at
most 1 ms.  For slow speeds and/or large transfers, this may cause
timeouts and transfer failures:

    spi_sh_msiof e6e10000.spi: failed to shut down hardware
    74x164 spi2.0: SPI transfer failed: -110
    spi_master spi2: failed to transfer one message from queue
    74x164 spi2.0: Failed writing: -110

Fix this by waiting explicitly until the TX FIFO has been emptied.

Based on a patch in the BSP by Hiromitsu Yamasaki.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sh-msiof.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -797,11 +797,21 @@ static int sh_msiof_dma_once(struct sh_m
 		goto stop_dma;
 	}
 
-	/* wait for tx fifo to be emptied / rx fifo to be filled */
+	/* wait for tx/rx DMA completion */
 	ret = sh_msiof_wait_for_completion(p);
 	if (ret)
 		goto stop_reset;
 
+	if (!rx) {
+		reinit_completion(&p->done);
+		sh_msiof_write(p, IER, IER_TEOFE);
+
+		/* wait for tx fifo to be emptied */
+		ret = sh_msiof_wait_for_completion(p);
+		if (ret)
+			goto stop_reset;
+	}
+
 	/* clear status bits */
 	sh_msiof_reset_str(p);
 
