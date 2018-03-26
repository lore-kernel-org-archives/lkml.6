Return-Path: <tomeu.vizoso@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522054861; cv=none;
        d=google.com; s=arc-20160816;
        b=RxRux/iXXVhCqLiqdu+dMWBDdp/ioRAmz4In/lTWiN+kYq/hSomv7bNwMzrWl9jbZK
         RCLkeTeKuTCfzYQrbY8z9I0ya6bL/61uGAhcezsnCjkOIVs6U4DZXWX8u+zreLtNVpla
         ssdzgv6CZ/5lHCqeNWUqu2pLaPk20jCCcbaZB2VTCIGj7BiBCJDrRrNFv+RcJMdT1fzk
         3m0Di3Sa3B6d891V6c4doTfNtEXbnTmliFDRFX+O8GNEki0Tz/7PmC7nR7U1/Iidl0L1
         ZgDk1QtGcPrrxkDlXhzaaIt/pQC4FS8BGTIaDHJQiyFN0IC8nsKEM6VmvWbIIba0OPQu
         nJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=dpCuwO5ic8sr998ujF8XA9u7muRq892WvSDtnUohuGE=;
        b=n6QDY1dM38lQEY1ImuE3QgnpUdyZfDXmRnoy9Fq3Sy4TIVPoLTYtfqNOrhe1yVVthp
         WRHFNWkmjbX+vOtPSPNEBZcH/yYqzsLDtFlPAGmb3MO7UgC66UCYKeebSuP5fEHi8Nr3
         3curcSZa3I6pbCqAwmvdksvdXrxGkH56W5cxzss9X5tgvg75Dwb21ipanscltUqrk5Qp
         HSk+5XBzEsErDdwRKv2BB98bwzzwgiHIhOnwN2LSxr/Il9KXAwKFGwFVFVQnjJX/CVkb
         kjKGdrD3Kfn5QvsM+oQRrw6mS59o737h/FDyHdBrbpg7HRABnQPILZPNSehhWaX2X2rs
         5zng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jr4BwuHe;
       spf=pass (google.com: domain of tomeu.vizoso@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tomeu.vizoso@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=collabora.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jr4BwuHe;
       spf=pass (google.com: domain of tomeu.vizoso@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tomeu.vizoso@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=collabora.com
X-Google-Smtp-Source: AG47ELu80CFQLjeU3iVZlU/U8b5mn7lSvilKySVa2dNc0z6EMwTgUrNKkxdO2TlACuJUJLriYHQo1A==
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Amelie Delaunay <amelie.delaunay@st.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Mon, 26 Mar 2018 11:00:01 +0200
Message-Id: <20180326090001.57627-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630296773142922?=
X-GMAIL-MSGID: =?utf-8?q?1595990198497073082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

devm_regulator_get_optional returns -ENODEV if the regulator isn't
there, so if that's the case we have to make sure not to leave -ENODEV
in the regulator pointer.

Also, make sure we return 0 in that case, but correctly propagate any
other errors. Also propagate the error from _dwc2_hcd_start.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus supply")
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

v2: Only overwrite the error in the pointer after checking it (Heiko
    Stübner <heiko@sntech.de>)
v3: Remove hunks that shouldn't be in this patch
v4: Don't overwrite the error code before returning it (kbuild test
    robot <lkp@intel.com>)
---
 drivers/usb/dwc2/hcd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 190f95964000..c51b73b3e048 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -358,9 +358,14 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 
 static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
 {
+	int ret;
+
 	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
-	if (IS_ERR(hsotg->vbus_supply))
-		return 0;
+	if (IS_ERR(hsotg->vbus_supply)) {
+		ret = PTR_ERR(hsotg->vbus_supply);
+		hsotg->vbus_supply = NULL;
+		return ret == -ENODEV ? 0 : ret;
+	}
 
 	return regulator_enable(hsotg->vbus_supply);
 }
@@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	dwc2_vbus_supply_init(hsotg);
-
-	return 0;
+	return dwc2_vbus_supply_init(hsotg);
 }
 
 /*
-- 
2.14.3
