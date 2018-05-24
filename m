Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoLx068soIBz8R5/msFC4WroQHq7fFH6lBGrMwSuHSsxptsGpBPw1NKGd6kD02owPW8UFte
ARC-Seal: i=1; a=rsa-sha256; t=1527156203; cv=none;
        d=google.com; s=arc-20160816;
        b=bRB9+SEnrBIWvEVTZNQMHycEs9nqOo0S7/m0eiZmHxE0NHP7QSFqMGigppdJ1YAE9o
         l/JC58D3RdoHd8jXExQXFXCE15+xeNJQPV79JBvRNmxxvi1g+PujtmAMkaE7ACXhtaZG
         qnFHbgpVWW8cF6UGOEW8bu/t1e46emWVTqZUzmMY/3upQsKrOjevchAcVmcpX4REilPX
         5xOrde0t025bh3PmCptlbWSCiAcjn6LseqXJIFpyCQtaXgN2izbG/CBfOuCsQ1IJBX4T
         nq8n+j3aMf6JWx1MhzDdAlOF1iaZw0eciVP31bXKk8cF8tYf9CSFvUo074kYcMIfNvHd
         osrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=84Zc8fVAwRI0HgLca5JRwLI+/ttVX9TDI1m+rUHT+5c=;
        b=FUHnU8wDI4FZ5qyXbt5DpqFSWYG2graDLMYWRdJsLMp0c7DuLPABPxVtBabHS21xrD
         4pi3Z9uFglHMIlL60ary+hJvmowJ2Xu/gz1fGJiw6bm+J+CBLsrfwqrviwAsCB00jVk7
         CrrtgdSFTFv/bFIc0d6qo91/Ts5qBtuqYP1c3WdO8hwp/kMIS5qwvITgSaGRXcqNungV
         lVeXf1JLxU2dIVrk/hewloSpKy4JClQcuCavl/6/gMzhT+ClLaDShdOP3hqHDl0Itk5A
         Nd/8mHy90cfjxzCE/9Nb9qBTZMr154JmgE5XIPD1uVlLv4FdBCCJY251iJNzQa31qDnu
         j4fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Dkfo0aLg;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Dkfo0aLg;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 068/161] usb: dwc3: Add SoftReset PHY synchonization delay
Date: Thu, 24 May 2018 11:38:13 +0200
Message-Id: <20180524093026.645181858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338394714654901?=
X-GMAIL-MSGID: =?utf-8?q?1601339343700106771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -232,7 +232,7 @@ static int dwc3_core_soft_reset(struct d
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		if (!(reg & DWC3_DCTL_CSFTRST))
-			return 0;
+			goto done;
 
 		udelay(1);
 	} while (--retries);
@@ -241,6 +241,17 @@ static int dwc3_core_soft_reset(struct d
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
