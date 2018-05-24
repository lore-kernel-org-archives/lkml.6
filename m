Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp6GBItbR/m8uRfMU2OAU8x+7nUERHIiigEy4AbA9CKyVX1mDuy/MavjufBYTdk+gDw9k4a
ARC-Seal: i=1; a=rsa-sha256; t=1527155641; cv=none;
        d=google.com; s=arc-20160816;
        b=efzqjEFovfQ5TnaqlqxZKdEdwSvCUHMTHBuneh4oiaPB7XEJrm66iEJoL+63dOZ8ID
         hhu8uey9NILwL6xniaFT2MUuByep9FvO4XNF3VB+Y/bdyv2O3RVHyD3v/NevivbfThT+
         poOkmqyMkdEQmjMccrgUdxgi6pITrY13eb5Z8lcWIikbZsTWY3XVHBu8cdMu9myYyF/G
         qMuYgjLC23L0zkwprFl3A6e9WaNqGTZHX2CrIg/+cryZf95BsGTPogHzON8xrgOcAUSF
         IKlUjYZZpQq1sTIMTU1XZQCQxYewb4eDtN5VG3j0QtXaKDxMvdDfyquXBd0emL/HmZ7n
         +mVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Tef+F/H4NCyt37GWwaWF9qhUffXb3ke6tyaoxLjdQD4=;
        b=A03V+ExLVa4DE23AFSe1o//eq0CbtWQuAb8OxPfEZe6chMpn4Bt9+e8F4agl00MhB0
         y4TyBWX/0m+LfvLJjaKms3jcFtmJ+68ywv05xUu9qL252b5rrXrKU07R8F4xnvaOnJ5I
         v+h/7WMq8hUoj76Ow9MPRnlMeHl8Vu5NPHpHUH163NvwJERWs7Gk5tm8wY4BfEpNNmnI
         sNmcTZ8TzfXypozBXZntd1oOwTw9/Z503wS+qmlvmk1XtyLGOlYiDNqNz6uUuiMfStgv
         3kmRZQnhImENZvfUFs8XXPRD0nLOFnjILcp/2U6tTRQYvmQl3cKXqc1jLaI4bxIzHZQd
         fUyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bumJdb/2;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bumJdb/2;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 063/165] usb: host: xhci-plat: revert "usb: host: xhci-plat: enable clk in resume timing"
Date: Thu, 24 May 2018 11:37:49 +0200
Message-Id: <20180524093624.571694301@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338754533557820?=
X-GMAIL-MSGID: =?utf-8?q?1601338754533557820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit d56e57ca030c8b4296944a2ae61ac167bf979c07 ]

This patch reverts the commit 835e4241e714 ("usb: host: xhci-plat:
enable clk in resume timing") because this driver also has runtime PM
and the commit 560869100b99 ("clk: renesas: cpg-mssr: Restore module
clocks during resume") will restore the clock on R-Car H3 environment.

If the xhci_plat_suspend() disables the clk, the system cannot enable
the clk in resume like the following behavior:

< In resume >
 - genpd_resume_noirq() runs and enable the clk (enable_count = 1)
 - cpg_mssr_resume_noirq() restores the clk register.
  -- Since the clk was disabled in suspend, cpg_mssr_resume_noirq()
     will disable the clk and keep the enable_count.
 - Even if xhci_plat_resume() calls clk_prepare_enable(), since
   the enable_count is 1, the clk will be not enabled.

After this patch is applied, the cpg-mssr driver will save the clk
as enable, so the clk will be enabled in resume.

Fixes: 835e4241e714 ("usb: host: xhci-plat: enable clk in resume timing")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-plat.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -355,7 +355,6 @@ static int __maybe_unused xhci_plat_susp
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
-	int ret;
 
 	/*
 	 * xhci_suspend() needs `do_wakeup` to know whether host is allowed
@@ -365,12 +364,7 @@ static int __maybe_unused xhci_plat_susp
 	 * reconsider this when xhci_plat_suspend enlarges its scope, e.g.,
 	 * also applies to runtime suspend.
 	 */
-	ret = xhci_suspend(xhci, device_may_wakeup(dev));
-
-	if (!device_may_wakeup(dev) && !IS_ERR(xhci->clk))
-		clk_disable_unprepare(xhci->clk);
-
-	return ret;
+	return xhci_suspend(xhci, device_may_wakeup(dev));
 }
 
 static int __maybe_unused xhci_plat_resume(struct device *dev)
@@ -379,9 +373,6 @@ static int __maybe_unused xhci_plat_resu
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
-	if (!device_may_wakeup(dev) && !IS_ERR(xhci->clk))
-		clk_prepare_enable(xhci->clk);
-
 	ret = xhci_priv_resume_quirk(hcd);
 	if (ret)
 		return ret;
