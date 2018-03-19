Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsm3gnZUnVxhHKup8484SrXbhmL+Yx2L27lk6H49t1gad5PEnCmL7e3iDM7t3Uh/u1aKRvm
ARC-Seal: i=1; a=rsa-sha256; t=1521483744; cv=none;
        d=google.com; s=arc-20160816;
        b=0t8NvPD3EBAqBv20e1mkPmv/fl9b0XitHOG45wkiDgWAtErGX1dPYl3uLFzPQCoWnx
         uZebAG67nE6fIvTxr1idwd4V1HaH+JnvAW2I7/9oISU1kLYH3XvJHpE7+CdE8M2JQ6yQ
         j53iKPVDmwdxQbJ03YGe/IZs9ZxHExar78lPf55wPQdnQneNyI0bhYVyUbaudeKYfI/l
         O9kvsVVzbSOU82s8cXLGKiM9LplDXneMc4+6hYTbTKvlae8UbJSerkQ/DP8m/NdbLEdz
         NrpZ0SepW2mu3IevnVFhsv4gB7LG1k2a3JFtxrjCAV7G7tqmqYG/WGaxd/iwLXioVzNb
         gOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SQnHc3Q3PTfHcn27IqkRnWWjs5B2m0p2jU3o8oeQ3PM=;
        b=QaG7GlXl7NHWb6AqmCECRAz7i1KeVqDu4yt+NGfxiMiPerkh8u16VXn6p2tMLtuM5c
         9adqCxD7K8My3Of43fK/n0K0lIkfj6GQPfd0U4MqG+RcBQbVTwJMClpoTEYPt00bD147
         jrbbv5Tm9xlUUcQ2xGhptZpeejz9EFRJIw4pr9YXySCYZ+zAV1ub433HnVsd0jKdFVMZ
         J2dyElqF9YUE7WEWKzP4I3YYu2TOTSKLhOa4a8A92vQ1UIJ3KvCUxm7nHAZod9mWZYJ/
         3SmfDnBaBm6CzncGN0CsOgSZponLc3uL9n80muOeYvFitcqrYw8oLz2/EkGI5KdqCY+z
         aonA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 066/241] usb: dwc3: make sure UX_EXIT_PX is cleared
Date: Mon, 19 Mar 2018 19:05:31 +0100
Message-Id: <20180319180753.935840605@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391338668454298?=
X-GMAIL-MSGID: =?utf-8?q?1595391338668454298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Balbi <felipe.balbi@linux.intel.com>


[ Upstream commit 1966b8657d058ecb95031809b607bf3fd1e01c10 ]

This bit is only supposed to be used with known
buggy PHYs, however some platforms might erroneously
set it. In order to avoid it, let's make sure this
bit is always cleared. If some PHY needs this, we
will need to add a quirk flag.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |    6 ++++++
 drivers/usb/dwc3/core.h |    1 +
 2 files changed, 7 insertions(+)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -464,6 +464,12 @@ static int dwc3_phy_setup(struct dwc3 *d
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
 	/*
+	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
+	 * PHYs. Also, this bit is not supposed to be used in normal operation.
+	 */
+	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
+
+	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
 	 * to '0' during coreConsultant configuration. So default value
 	 * will be '0' when the core is reset. Application needs to set it
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -223,6 +223,7 @@
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
 #define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
+#define DWC3_GUSB3PIPECTL_UX_EXIT_PX	(1 << 27)
 #define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
