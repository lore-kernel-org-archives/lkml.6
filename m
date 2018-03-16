Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443417-1521219083-2-3118910097174119510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521219082; b=Wl+qz/bitFjxBu2f0CiFIvBP2FbD0npw87s/dys5M3yEOUH
    W11ZZwdFSCXnUHoUtQIfRpnYxpW9ZWfZVPRHHxDObf2Da7DEjYpjer31WIOZG2WD
    Uyzu0mAgk83lkXIZrUH+F2oMMTX/+Mn9u3w2xFIn2YYDxFv16r1R21E7KPou7L1u
    Lx3k4coGMAE9QvXD6CQ7YUt/V6rKr2OQ3CynX8roTI2Z5QZLdZR/mBLKXHt4Q4Ei
    +C8JMq2Casx+G7PJXnYU6q+Z98fVBcOvwlsZN6mrawu+RP9K3zEdxmIC5bJkLSD6
    g3ex8VTxQgfcgyPkiA1oIR9g0DINdg9NZTX4AaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521219082; bh=WCEZhiJBO2yvnItHL6z4P4Pogi
    s7m/ZjP4vhb9cve40=; b=Rm96lJ2k0CSr8+FP07p5jG5Nw9lS6Wng5+j9XnT1vq
    2iSElfD9BmXmF8FBG1bPAhqNN0s4iffZ80liiSWRJ3U7RPmvY1aILOEwfatKhgTW
    KTAJbSJagHJm9dfU3oWxvBDbGDGDmBMOMOQs7DJhgbd7tq59vxjhv1+YZArA+f35
    x8Pt+oSTm05gWN1lUUQqTH8aAaEWIIl4gjafjT3VV7CEV9Ept5+P9Fx+9RaQeaYH
    iBp+062auG6SSe6AdNI724ggAsQ79+Vrp0mR+Aj9XUkHvRd6OlBjbP/osQwatiPB
    2yQYVrzAjwPA9lJpuvGsla7+wcT1sqP9g8OSCBESb0HA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeCPPem (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:34:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933999AbeCPPek (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:34:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 021/109] usb: dwc3: Fix lock-up on ID change during system suspend/resume
Date: Fri, 16 Mar 2018 16:22:50 +0100
Message-Id: <20180316152331.103409541@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit 084a804e01205bcd74cd0849bc72cb5c88f8e648 upstream.

To reproduce the lock up do the following
- connect otg host adapter and a USB device to the dual-role port
so that it is in host mode.
- suspend to mem.
- disconnect otg adapter.
- resume the system.

If we call dwc3_host_exit() before tasks are thawed
xhci_plat_remove() seems to lock up at the second usb_remove_hcd() call.

To work around this we queue the _dwc3_set_mode() work on
the system_freezable_wq.

Fixes: 41ce1456e1db ("usb: dwc3: core: make dwc3_set_mode() work properly")
Cc: <stable@vger.kernel.org> # v4.12+
Suggested-by: Manu Gautam <mgautam@codeaurora.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -186,7 +186,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32
 	dwc->desired_dr_role = mode;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	queue_work(system_power_efficient_wq, &dwc->drd_work);
+	queue_work(system_freezable_wq, &dwc->drd_work);
 }
 
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
