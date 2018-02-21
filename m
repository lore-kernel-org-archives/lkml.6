Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225xIq0OBeVLOAxOySWWmnG42o0WO5d6k8Nz6SYq2sgKNWhJADbIKnCsLdm/qSQ2iIpxMSZa
ARC-Seal: i=1; a=rsa-sha256; t=1519218321; cv=none;
        d=google.com; s=arc-20160816;
        b=oCaMb0zhzwJvBdVnk27+kNpZql+/tt1m+GTxyYUS7ylgpZr2O4hmmrswVMcZwAVKJx
         ej0030Y/doepsA0rDvuRDTamDRM4irVFdoomAGwaH4EUH5VtTCUT3DVRwfGdbwzr8CFs
         Uv864Vj4vp/dX0nh8N5jEnyAKIohhoMP8YGYu/zUf/3+6UIDmUDYG2w9lbgOyH6XJP90
         ybutW+/qS95mb01gfa0QD6ZwTOAUYG7su3cfaVAZXFJX7k4BRqUJschQ1plvHuM5ZWdW
         7b1Mkkz3VhcwEIO/3hBWAae80UJhyDgGLJX7rciH06sAeCWaIpz3HZXgwsgIwGpxEwJv
         /IPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oiRx7AWrZQMgmO5i8Eps/kA3BeG5UONLyLQXibLhIsA=;
        b=Ser3EQViCDn7xJQbQnQ20pH5yYETfVOehGMW4jO8hj3osLMwUizgOvt+nhbnHp/jj4
         yyXKIhrdlDnuiwABJT/lOsU8f8sVQ0cD90dyEjcyu7rBuiU3+UnkfSkyvuGC0VyeeBjy
         38SosYEOQrreclAcR6r/Y93qPfuE7rcBikoasrkf97QUFfxPgCnxt5z/sMc+3ID1iJ52
         8jFHCZhfRh/jXVfA8e60x3cHPtrl6zLIFPzLlavJdXuEDw1Ke08M3RKw9BZQsSUNBSr+
         OTH3QPj1dFLnqiTgJRytn6cH34Tqi6xz/rPHURy+q3uSa/t9WpJSeZ+qazrTQkgOmI1b
         faHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"yinbo.zhu" <yinbo.zhu@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4.14 165/167] mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb
Date: Wed, 21 Feb 2018 13:49:36 +0100
Message-Id: <20180221124533.880414341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015379524832660?=
X-GMAIL-MSGID: =?utf-8?q?1593015871115518258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yinbo.zhu <yinbo.zhu@nxp.com>

commit f2bc600008bd6f7f5d0b6b56238d14f95cd454d2 upstream.

When system wakes up from sleep on ls1046ardb, the SD operation fails
with mmc error messages since ESDHC_TB_EN bit couldn't be cleaned by
eSDHC_SYSCTL[RSTA]. It's proper to clean this bit in esdhc_reset()
rather than in probe.

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-esdhc.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -589,10 +589,18 @@ static void esdhc_pltfm_set_bus_width(st
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	u32 val;
+
 	sdhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	if (mask & SDHCI_RESET_ALL) {
+		val = sdhci_readl(host, ESDHC_TBCTL);
+		val &= ~ESDHC_TB_EN;
+		sdhci_writel(host, val, ESDHC_TBCTL);
+	}
 }
 
 /* The SCFG, Supplemental Configuration Unit, provides SoC specific
@@ -785,10 +793,6 @@ static void esdhc_init(struct platform_d
 	pltfm_host = sdhci_priv(host);
 	esdhc = sdhci_pltfm_priv(pltfm_host);
 
-	val = sdhci_readl(host, ESDHC_TBCTL);
-	val &= ~ESDHC_TB_EN;
-	sdhci_writel(host, val, ESDHC_TBCTL);
-
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
