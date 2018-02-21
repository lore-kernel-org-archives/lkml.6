Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224dBbk6/w6tp7U9M4Wq63brIjidfoxwnCWo5YqqpmVcQ3WDT0t9GLqeV3/XNyrb4/2htrfv
ARC-Seal: i=1; a=rsa-sha256; t=1519217850; cv=none;
        d=google.com; s=arc-20160816;
        b=f9XUU+jgHpTD4rypJnrEtFtt55BG9hZdOKqhxl65UC7ogxMb8k32XFeptQdcXvJ2d/
         oPkHttjFYAN8IFbxQwpW4J8vTncCkRpKQ0C1UUQOyuh1J8zrCnsnt125gI7CrkRzSVgB
         50eRrcpenHvVeNqIEVKhLPfHluKNBG3gxPImk45lBoP7H7iXiWV1KZAyxoo2qeCSQ/63
         fuXxceB3YjSnajUSBWXazuC4y5Php6W7B1cakEbAR+T9hhwr14xRp/B7xGnq7hOuOVYp
         ic/r7Yl+OgTqUMuekP7jokDaaGYUk2/1Qxwo8lSeFSS5dNP751QqXObLlHnk+a+Ry8gQ
         Itkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gQB3ek5QFZRAgXrB2mCtXvyZ0D5vkWEPPxKgqVxuHgU=;
        b=kN6WdBa/s3JXYfi6Xxlyo0BsKW2uvJ5HFLE42bpe0OpGPIWWVWeo0apjEA+HoB+g1U
         9fVmq4aUlOMnuWlNUdw7MwbsolGnKXG4Thw3A/cvMuemxrIkUAV5vIpH9ohrg5Qcsaci
         0msbi4OtQv56fyhnMqmjSwApa86+fF5Dy2v7bfGpxOu1y9jDf1ODA8UKPzCPUE681E+F
         J9VJuP0xLRbLsCIbKCn2/t4MWQXNE5RnRQDo8Jh1pPg4Eoc6kahaB3tM7qQ89h0aggdM
         B7kQMMtKYNGe29dPbqWW5recZJEK5jPF4HJxdPhjQ0a6UyvzN2Ty3MtDaljCpifLoTi1
         ZPXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"yinbo.zhu" <yinbo.zhu@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4.9 76/77] mmc: sdhci-of-esdhc: fix eMMC couldnt work after kexec
Date: Wed, 21 Feb 2018 13:49:25 +0100
Message-Id: <20180221124435.380851164@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015376217156636?=
X-GMAIL-MSGID: =?utf-8?q?1593015376217156636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yinbo.zhu <yinbo.zhu@nxp.com>

commit 97618aca1440b5addc5c3d78659d3e176be23b80 upstream.

The bit eSDHC_TBCTL[TB_EN] couldn't be reset by eSDHC_SYSCTL[RSTA] which is
used to reset for all. The driver should make sure it's cleared before card
initialization, otherwise the initialization would fail.

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-esdhc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -584,6 +584,10 @@ static void esdhc_init(struct platform_d
 	pltfm_host = sdhci_priv(host);
 	esdhc = sdhci_pltfm_priv(pltfm_host);
 
+	val = sdhci_readl(host, ESDHC_TBCTL);
+	val &= ~ESDHC_TB_EN;
+	sdhci_writel(host, val, ESDHC_TBCTL);
+
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
