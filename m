Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224hB+mgtXri28H4DavAPSjyuyP2ppg1JZAmUS1i5U7KmlI0TV8i+y6zjSwAM6Q0971wW6aE
ARC-Seal: i=1; a=rsa-sha256; t=1517591226; cv=none;
        d=google.com; s=arc-20160816;
        b=UXyFidyB6eQ4SeA3eOLcDok5fXObzLVmAy+qgRye6dp8TIVIKFFqRX3XmbGQCNGJP0
         S2bo8ziyzPuv9Py+gHi3ls/0NXRvDP1Y3DxUcKlUcb7omhZKdzTLHXDn2Y9zwnrAnl2Y
         jA+IwhWLC0u+K+bSfCtiPMVF2gG69/lK4oyjt9EavNYehjKjbJ0jrRPW/pXl/4VtRs/S
         3j61kLWOqePPpY7N5I86g3GqMU82lmsXsNIJFKFm5XDCkTyP1pHwrAWXIfWNhHLUrx3h
         NIvpNtMqv28u8kL3uF7QXehhvhzv5aYKSz9KpRxA7eqXJ5yU5blA3vFMsdbIDwvw+7dC
         pstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=av5Ag3CFkzBS82Ty9hHriCzBRDBrB5NllK6bZ5LEqYw=;
        b=flwsCXP2E+iX403GDwmYfAb45k5/HeSjgt24dYJoc+V9JIlwd98nGWWkjC5boTWPFC
         A7TvF/VGOeQ5FoMhesN7Y8twTXgNEb+CML5Z7Q51z0htszpU+dWlY098VeJBEJ4hHHpP
         LThrzWNQgSkVUs/otq0G4mEGkLhkbGrEcRXxjR35gbRymXQ4MLD20+zSB8tNBVPoAUXl
         uZCIVigO5xo4Yx6RM+7h36E8AYeybZvl5Go1EJ95buFFCaoi3PT68YdfNZ2/FnqI0jAr
         plBlCDOfn//0yoyykXQUgmiq3cb/Pg/y7FUEA0ecqKOdNAGwzPUhHwUsTTC8hGz65CMh
         FJrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4.9 83/86] usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()
Date: Fri,  2 Feb 2018 17:58:43 +0100
Message-Id: <20180202140830.262018063@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309737270542005?=
X-GMAIL-MSGID: =?utf-8?q?1591309737270542005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 11fb37998759c48e4e4c200c974593cbeab25d3e upstream.

The current code tries to test for bits that are masked out by
usb_endpoint_maxp(). Instead, use the proper accessor to access
the new high bandwidth bits.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -913,7 +913,7 @@ int usb_gadget_ep_match_desc(struct usb_
 		return 0;
 
 	/* "high bandwidth" works only at high speed */
-	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp(desc) & (3<<11))
+	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp_mult(desc) > 1)
 		return 0;
 
 	switch (type) {
