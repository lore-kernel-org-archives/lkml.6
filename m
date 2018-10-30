Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0967DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634920827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B634920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJ3TJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:09:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:50676 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeJ3TJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:09:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 03:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="diff'?scan'208";a="103732945"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2018 03:16:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Oct 2018 12:16:35 +0200
Date:   Tue, 30 Oct 2018 12:16:35 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chen Yu <chenyu56@huawei.com>
Cc:     wangbinghui@hisilicon.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 07/10] hikey960: Support usb functionality of Hikey960
Message-ID: <20181030101635.GC14534@kuha.fi.intel.com>
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-8-chenyu56@huawei.com>
 <20181029143040.GB14534@kuha.fi.intel.com>
 <33a6ac59-b545-e2c8-2bb7-0a5460fcf5e9@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <33a6ac59-b545-e2c8-2bb7-0a5460fcf5e9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 30, 2018 at 10:50:22AM +0800, Chen Yu wrote:
> > I think you have too many things integrated into this one driver. IMO
> > it would at least be better to just let the Type-C port driver take
> > care of VBUS like I mentioned above. I'm also wondering if it would
> > make sense to handle the role switch and the "hub" in their own
> > drivers, but I don't know enough about your platform at this point to
> > say for sure.
> 
> Thanks for your advice! The HiKey 960 development platform is based around the Huawei Kirin 960.
> The Hikey960 Development Board supports three USB host port via a USB hub (U1803 USB5734).
> The Hikey960 Development Board also implements a USB2.0 typeC OTG port.??
> The Dp and Dm of Soc can be switched between the typeC port and the USB hub.
> If there is no cable on the typeC port, then dwc3 core of Soc will be switch to host mode and the
> driver of this patch will switch Dp and Dp to the hub. The driver also power on the hub in the meantime.

Thank you for the explanation. I got the picture now. I realized that
there is some online information for this board:
https://www.96boards.org/documentation/consumer/hikey/hikey960/hardware-docs/hardware-user-manual.md.html#usb-ports

So that mux is actually _not_ switching between the host and device
modes, but instead, it's switching between Type-C and Type-A
connectors (I'm skipping the hub, as it's irrelevant from the PoW of
the mux), so I've misunderstood. And yes, you did say that it is
switching between connectors in the commit message, but I got confused
because you are registers a role switch.

I don't think you should register a role switch from this driver. This
driver is not really representing USB role switch. The mux on this
board is something else. Instead you should register the role switch
from the dwc3 drd code. That is the part that is representing the role
switch here. I actually think that we should do that in any case. The
dwc3 drd code should always register a role switch.

We can solve the problem of getting the role change events in this
driver by adding notification chain to struct usb_role_switch (check
the attached diff). You would then just need to call
usb_role_switch_get() and usb_role_switch_register_notifier(), and
wait for those notifications. The extcon device does not serve any
purpose anymore.

This driver would continue to take care of the hub powering and the
mux, and also the VBUS like before.


br,

-- 
heikki

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="roles.diff"

diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
index bb52e006d203..2881777c16e5 100644
--- a/drivers/usb/common/roles.c
+++ b/drivers/usb/common/roles.c
@@ -20,6 +20,7 @@ struct usb_role_switch {
 	struct device dev;
 	struct mutex lock; /* device lock*/
 	enum usb_role role;
+	struct blocking_notifier_head nh;
 
 	/* From descriptor */
 	struct device *usb2_port;
@@ -49,8 +50,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw->dev.parent, role);
-	if (!ret)
+	if (!ret) {
 		sw->role = role;
+		blocking_notifier_call_chain(&sw->nh, role, NULL);
+	}
 
 	mutex_unlock(&sw->lock);
 
@@ -110,6 +113,20 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
+int usb_role_switch_register_notifier(struct usb_role_switch *sw,
+				      struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&sw->nh, nb);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_register_notifier);
+
+int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
+					struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&sw->nh, nb);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_unregister_notifier);
+
 /**
  * usb_role_switch_get - Find USB role switch linked with the caller
  * @dev: The caller device
@@ -267,6 +284,7 @@ usb_role_switch_register(struct device *parent,
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&sw->lock);
+	BLOCKING_INIT_NOTIFIER_HEAD(&sw->nh);
 
 	sw->allow_userspace_control = desc->allow_userspace_control;
 	sw->usb2_port = desc->usb2_port;

--YiEDa0DAkWCtVeE4--
