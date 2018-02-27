Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2581406-1519770535-2-53690563309254613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519770534; b=rnoBQQxC9rkk2lsTkBrlOs1XyX6RNTYXD3iJbMDVbByWCKu
    9H2sCUS6DXEOyRAgy++aHs0QRTTZ1K6VHvJoSjR4q/Vog6W0i828cewnhrc1oFRB
    ELT9AVP7YsII6oBj3EwjDKo2tK9hjDcWKeghHUmZu+7z2AwuS7R0yLgMqdMBPH1f
    BZCUyP7hT42XGOm/LjI3tou9gNaC2JhTQ7sBZOAFihB3Pll7JTttS6EgKFSqbL3z
    OYD81mSPsS1MzfnUNXaG9EF/BP6dXZXMgfOhF7BklAzIOrqPgcc+7Pn0Hz/0B7Ri
    0bg/D2fDAdguS6UHYOgvSi8+iI173N3rfWKIKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519770534;
    bh=R9I1uV9E2Afaq85bc3LOA0JGZbp5GbNiF9we6rhKCTA=; b=IUdqm66AQJn0
    SMUIIiwCOXyHdUyLN5g543z7cJpsdjMyTtrfxtr3/RO1aRQFKtt1Sds5V4ryFDAr
    pJQrBHMzhx4gdkpKUEKEw188CR7C/uhteqpXGfeJ/JcJn04jusRl6rduM4Mn/Bi7
    ctakBbZ/I7j6Upikp2RagBGEc1gm3zh4ZR+PPW+O3DcZMChRukni4RpfdzI2N53v
    hzSoctyKUBFvfonN5z5Sz013oexNs4RwKCbqur0s8PrFWhEisIfT5dxTNkDg5lOe
    3V5mDPyg3VXibWpkod0frx3AqY9BRA+cjHVlPmZVxnFEzlQLz0oIFhRS8dIJllGL
    zDgX10flqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeB0W2l (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:28:41 -0500
Received: from nala.villavu.com ([188.165.243.101]:42275 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752283AbeB0W2j (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 17:28:39 -0500
From: Merlijn Wajer <merlijn@wizzup.org>
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, merlijn@wizzup.org, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
Date: Tue, 27 Feb 2018 23:27:39 +0100
Message-Id: <20180227222740.2150-2-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227222740.2150-1-merlijn@wizzup.org>
References: <20180227222740.2150-1-merlijn@wizzup.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Without pm_runtime_{get,put}_sync calls in place, reading
vbus status via /sys causes the following error:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
pgd = b333e822
[fa0ab060] *pgd=48011452(bad)

[<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
[<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
[<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
[<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
[<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
[<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
[<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
[<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)

Solution was suggested by Tony Lindgren <tony@atomide.com>.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/usb/musb/musb_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index eef4ad578b31..c344ef4e5355 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1756,6 +1756,7 @@ vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int		vbus;
 	u8		devctl;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	val = musb->a_wait_bcon;
 	vbus = musb_platform_get_vbus_status(musb);
@@ -1769,6 +1770,7 @@ vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 			vbus = 0;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return sprintf(buf, "Vbus %s, timeout %lu msec\n",
 			vbus ? "on" : "off", val);
-- 
2.16.2

