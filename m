Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr+Z39p7xjWhT0nKE2X7U0Q7PCZWlqWvbVdoW6K5TpuAWQM4XJmf2bnpZzSO7bmoCB1I38a
ARC-Seal: i=1; a=rsa-sha256; t=1525116240; cv=none;
        d=google.com; s=arc-20160816;
        b=wrX1fwO2akucRZkm4u3ljPUDULIVIXcFHHtcNiP9dbOEXWPzahmQyF3+IPY5gBq0iP
         NAUkUtJ5f3kh1kMlQp+5KL2CIzT0DF5IWdj6cHjy4gFChgU7UNbLl4hVJloXAOxxvjLo
         2L9aYsQVof0pDYoso8ojpn5SbtnaqnLNwr3smcaLI957FtmaIk/CJu67LWcuUy5KDqiw
         xJ1VNmDH5P/Lm6uvhC7iu1eCJiMfpoJzEK0HsBiaIW0u2NwNMqxAXc4w962SZgUBIcIp
         rhb1BsQphrDPudzACFV1643Nw3vof2NAj7B0ROSuv6QtZN1dj3mKa3wI1zyb06KRSfmZ
         B9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=i5UXxSaSKAUK3mh/kOXxrPLeoIv/6aD7HxKvEGohyHc=;
        b=PD0nnDQDti+rmNlN1UsFOjflfIZkxU9KK/ll2ciHmiDYc1rdhsJWRpTipf+tr+8aa/
         nG3AxKZC28lpY9zY1o4t6hnz7OsVBITphjfHr0SwoKbJEho8ld//ClBlN420mLowq1Hj
         T3LJM7TLz1MJbafAYoRxE3iT1DtYi6rxXE8vVt2wJkP35zvc1n17XFGrR53L4vyxCIkE
         zImgiKyv2oemjd7ndvtK0Cv+YwJRyZbzQ1eFwQ7WARB1X+hfhvZgho3kT5snB/rnKroi
         s6JDcI+xrNx6VHKx8ebloZJg6LZiuxgL6bZZIz60r1ZLU5Ik+hz/928L3i9Ksva81VMS
         qH+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDB522DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 3.18 23/25] ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
Date: Mon, 30 Apr 2018 12:23:30 -0700
Message-Id: <20180430183911.776436294@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287248158187?=
X-GMAIL-MSGID: =?utf-8?q?1599200287248158187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolin Chen <nicoleotsuka@gmail.com>

commit c656941df9bc80f7ec65b92ca73c42f8b0b62628 upstream.

When the desired ratio is less than 256, the savesub (tolerance)
in the calculation would become 0. This will then fail the loop-
search immediately without reporting any errors.

But if the ratio is smaller enough, there is no need to calculate
the tolerance because PM divisor alone is enough to get the ratio.

So a simple fix could be just to set PM directly instead of going
into the loop-search.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Marek Vasut <marex@denx.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/fsl/fsl_esai.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -143,6 +143,13 @@ static int fsl_esai_divisor_cal(struct s
 
 	psr = ratio <= 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_DIV8;
 
+	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
+	if (ratio <= 256) {
+		pm = ratio;
+		fp = 1;
+		goto out;
+	}
+
 	/* Set the max fluctuation -- 0.1% of the max devisor */
 	savesub = (psr ? 1 : 8)  * 256 * maxfp / 1000;
 
