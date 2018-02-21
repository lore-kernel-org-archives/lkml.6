Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2245vawaEHu2LcYhzEzs/9rpdA0k9Wdy3QXbiUdm/CnhnurukWkkk6Mz3nJRm23IaE248QkU
ARC-Seal: i=1; a=rsa-sha256; t=1519217852; cv=none;
        d=google.com; s=arc-20160816;
        b=MEyq1wAWkZ4BdsFDyku4kdaDdqX9yX5DNBxCqNL2WlVGJFP8UkxsaM47nxqxjL2RZ0
         NYkbtCOWelEnuW/EkhDrHc3cnvtM/HiAZQXjXo8YqTDCBaJeGix179EC1ohPn293++2e
         UJPxvgKM00EqOfC64l0nO4qXvo25/lVBtCt+XPjyGJgzkDMG3W0jKGsVqPfBRpbI5aLw
         pe/U9ETZVU+OJqVuSVNJCBE0XYo64FumIXINvNWqcyxlPtIx2bM8azbopWGi9rMww38q
         GHwcNkYzKOf94zq11e9Kn4OGbX/y/gix1tWzq1w54+zQigmQNhn19n+/gDvpELOgyKUq
         Q88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/PfMogpv8FnI1HE76417pMF3MrfecPkVV7ERajFE/3Q=;
        b=RvAEZfPJ2aJf0Ubp7x8EKABo2L53PAmq60WAAQTAjEG1q7wVRJxDmYSS223VUVWGKH
         Ps3vVSWCSGEl1eRm1dHjDv9vDm3B2HI2CjfjEDsANdkZCIqepVAVhG/Gn3cZi8lS5gdq
         S1eihoNIG3AhA7jUse2ydJCiv/TRw7OsX8YhgxJ88grIiXtcAluQ6V2PqIRNzhVCazCJ
         cvrzDKLf8+nN2Cz7SN3yk/9mDCE0w9PZPOud/Do2ZQeQIo/InZU2e/HXVxtc5biJKE3r
         YdMK9T8XoP/VLwEHYfNFS1z76ibwE4ryrhdXTxWVfD8xGnwdQyQb9K98dqCv5BOrXFQg
         BjIQ==
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
Subject: [PATCH 4.9 77/77] mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb
Date: Wed, 21 Feb 2018 13:49:26 +0100
Message-Id: <20180221124435.417056678@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015379524832660?=
X-GMAIL-MSGID: =?utf-8?q?1593015379524832660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -489,10 +489,18 @@ static void esdhc_pltfm_set_bus_width(st
 
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
 
 #ifdef CONFIG_PM_SLEEP
@@ -584,10 +592,6 @@ static void esdhc_init(struct platform_d
 	pltfm_host = sdhci_priv(host);
 	esdhc = sdhci_pltfm_priv(pltfm_host);
 
-	val = sdhci_readl(host, ESDHC_TBCTL);
-	val &= ~ESDHC_TB_EN;
-	sdhci_writel(host, val, ESDHC_TBCTL);
-
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
