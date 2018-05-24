Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqMblk1/iFTokL94JxBXV4hm3TlmujZYV5kvXCwwmB4ylrI11JgnbinQ4zJIxalC2NODgVD
ARC-Seal: i=1; a=rsa-sha256; t=1527155661; cv=none;
        d=google.com; s=arc-20160816;
        b=mlh67oxyFYZkdbc7ycwhH9+AlH7/C+odnqe8zCwWziChkSfKwW3uJVJP+8lhd7KiVJ
         dSZ7cZE1xxisWTBEBRQLFZejWOUhn9WkeehE3i2dQPm6AiF/9m/V+X3VArSerzigPao0
         dgobYATCz1TRgtn7dEdK9nSmBfbe05P+hVtklpoL/oadYWxvXPNaS/mIz9tgL2aqMnAB
         DxbXh0CY8k/NVhOgMEPT71O9tONA1p/4I6yFsANXsWaa5htv+4t3AXkxbCqwn4rVOMqI
         lzHf4htEoYbO4oyj6QpbvW/I1GYGnqgXdf1r8u+QMno2o844fFFBwDydqtrYjhsX27ZX
         yxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=nV+FYAuRN6N4olWyHeuHwKcVTdZKylrJQOgyqDB/R+g=;
        b=HIpvXZlpx73PSH90vc7qtHrkLRtxabvLkGVilvwbK3tnoEjO7hCZniMxskXjbDVqjz
         2SOqX6EqX5ku0O+CWQ1UdXdtyt83N0pqaLsPSupLWXxxGI4KLgp3TrKu7531nX6k+j0T
         xdxLfFXaDuh6BBAtcr3zvrNnbCjsvw/qhiMHmjmy7U4NNl8BqDa5/UjmyQmNhdRp4Zub
         L1qfAU4NyXA49A8tSX+X7aH58pxPUN6QFZFq4CMU/DY3aI9SsvgCL1u1HQuqhcYlLVYX
         a/gQ/hGMTapuRmrLcmflAY4ryuUMV6Oc4SGSU9OFkBSTHJZLGza96YJHmQGzigCx8dD+
         iDzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1AJoRn0w;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1AJoRn0w;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 069/165] usb: dwc3: Add SoftReset PHY synchonization delay
Date: Thu, 24 May 2018 11:37:55 +0200
Message-Id: <20180524093624.811696897@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338394714654901?=
X-GMAIL-MSGID: =?utf-8?q?1601338774707657530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit fab3833338779e1e668bd58d1f76d601657304b8 ]

>From DWC_usb31 programming guide section 1.3.2, once DWC3_DCTL_CSFTRST
bit is cleared, we must wait at least 50ms before accessing the PHY
domain (synchronization delay).

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -243,7 +243,7 @@ static int dwc3_core_soft_reset(struct d
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		if (!(reg & DWC3_DCTL_CSFTRST))
-			return 0;
+			goto done;
 
 		udelay(1);
 	} while (--retries);
@@ -252,6 +252,17 @@ static int dwc3_core_soft_reset(struct d
 	phy_exit(dwc->usb2_generic_phy);
 
 	return -ETIMEDOUT;
+
+done:
+	/*
+	 * For DWC_usb31 controller, once DWC3_DCTL_CSFTRST bit is cleared,
+	 * we must wait at least 50ms before accessing the PHY domain
+	 * (synchronization delay). DWC_usb31 programming guide section 1.3.2.
+	 */
+	if (dwc3_is_usb31(dwc))
+		msleep(50);
+
+	return 0;
 }
 
 /*
