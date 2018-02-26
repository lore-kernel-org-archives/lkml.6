Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2611097-1519642627-2-8876048127517455260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519642626; b=FKmQWVenXQDgZqUp1xpFCZ47fS3sHY8cizxJx6BGJWWCZkq
    x/l+foDlZoGyIlp9Kzztyz9PJVm7hWB0zCHR9MniTHF0l7MBEFQM1yWcOuizhNbw
    NGu3E4+es/VI6oz/684CXOEDrCbtDwTca7p+8wIeesLzVA9txgxjybFWGXKlbjk7
    Fa+K7Dzek9DweRtE7nT+yLTwUkUYuCDwJmkvaV4191FJeKxkg0uWSWczDc2tIzcB
    d+rToroB5pltkKDDf+4aWZv1fobcsmMYRgZts0ZNeAGNhW2NUHp8kRrhsT6gwNWc
    k+rWrDSTGnoBST/VbeylWShSJVaucb1bm4R+4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519642626; bh=bWLaWRwkKGY9FFo23qajbqHA8S
    VKajIKhkXccjX8b7Y=; b=r8p35B7PSplFlsCkm3740arxMqpREP0q/LxCaU3Q4m
    PKCnweaYdr5/k/NiYzwR3VzEXUL0OoLsn7EsYPlzGEx3x2bKSfdWRtvnUgmMIEq1
    eA81vYyMnDF9M0okzkOD6dnR6TymngTHL8qZgI2P7gc/W1hN1u6xmKgydUORlxst
    gVRMZ/JkzDHuhlIxtlT+nOVMdpVmT5nIGiw5OTWXRDfTnXk1BaBefs26NQqwVSjO
    3fXP1Jqz2LpHaEN+ANl+PYqOhYF6ZhYB+qayhHnXVHONv2ZeDLAA4ZmITPoXS7Wn
    DOUHyvWFBMTI/kG8bKElGzLZ75k/kdKEgYbURcLe/wyw==
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
        id S1752648AbeBZK5D (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 05:57:03 -0500
Received: from nala.villavu.com ([188.165.243.101]:38384 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBZK5B (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 05:57:01 -0500
From: Merlijn Wajer <merlijn@wizzup.org>
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, merlijn@wizzup.org, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
Date: Mon, 26 Feb 2018 11:56:08 +0100
Message-Id: <20180226105609.22514-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
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
 drivers/usb/musb/musb_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index eef4ad578b31..ceaa40ef0e73 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1760,6 +1760,8 @@ vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 	val = musb->a_wait_bcon;
 	vbus = musb_platform_get_vbus_status(musb);
 	if (vbus < 0) {
+		pm_runtime_get_sync(dev);
+
 		/* Use default MUSB method by means of DEVCTL register */
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 		if ((devctl & MUSB_DEVCTL_VBUS)
@@ -1767,6 +1769,8 @@ vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 			vbus = 1;
 		else
 			vbus = 0;
+
+		pm_runtime_put_sync(dev);
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-- 
2.16.2

