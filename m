Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420A7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDA620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDA620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeGTWrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:47:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37599 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeGTWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:47:31 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.l.tihix.com)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fgdOm-0004ZT-Hx; Fri, 20 Jul 2018 21:57:16 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [PATCH net-next v3 0/8] Make /sys/class/net per net namespace objects belong to container
Date:   Fri, 20 Jul 2018 21:56:46 +0000
Message-Id: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revival of an older patch set from Dmitry Torokhov:

 https://lore.kernel.org/lkml/1471386795-32918-1-git-send-email-dmitry.torokhov@gmail.com/

My submission of v2 is here:

 https://lore.kernel.org/lkml/1531497949-1766-1-git-send-email-tyhicks@canonical.com/

Here's Dmitry's description:

 There are objects in /sys hierarchy (/sys/class/net/) that logically
 belong to a namespace/container. Unfortunately all sysfs objects start
 their life belonging to global root, and while we could change
 ownership manually, keeping tracks of all objects that come and go is
 cumbersome. It would be better if kernel created them using correct
 uid/gid from the beginning. 

 This series changes kernfs to allow creating object's with arbitrary
 uid/gid, adds get_ownership() callback to ktype structure so subsystems
 could supply their own logic (likely tied to namespace support) for
 determining ownership of kobjects, and adjusts sysfs code to make use
 of this information. Lastly net-sysfs is adjusted to make sure that
 objects in net namespace are owned by the root user from the owning
 user namespace.

 Note that we do not adjust ownership of objects moved into a new
 namespace (as when moving a network device into a container) as
 userspace can easily do it.

I'm reviving this patch set because we would like this feature for
system containers. One specific use case that we have is that libvirt is
unable to configure its bridge device inside of a system container due
to the bridge files in /sys/class/net/ being owned by init root instead
of container root. The last two patches in this set are patches that
I've added to Dmitry's original set to allow such configuration of the
bridge device.

Eric had previously provided feedback that he didn't favor these changes
affecting all layers of the stack and that most of the changes could
remain local to drivers/base/core.c. That feedback is certainly sensible
but I wanted to send out v2 of the patch set without making that large
of a change since quite a bit of time has passed and the bridge changes
in the last patch of this set shows that not all of the changes will be
local to drivers/base/core.c. I'm happy to make the changes if the
original request still stands.

* Changes since v2:
  - Added my Co-Developed-by and Signed-off-by tags to all of Dmitry's
    patches that I've modified
  - Patch 1 received build failure fixes in
    arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
  - Patch 2 was updated to drop the declaration of sysfs_add_file() from
    sysfs.h since the patch removed all other uses of the function
  - Patch 5 is a new patch that prevents tx_maxrate from being written
    to from inside of a container
    + Maybe I'm being too cautious here but the restriction can always
      be loosened up later
  - Patches 6 and 7 were updated to make net_ns_get_ownership() always
    initialize uid and gid, even when the network namespace is NULL, so
    that it isn't a dangerous function to reuse
    + Requested by Christian Brauner
  - I've looked at all sysfs attributes affected by this patch set and
    feel comfortable about the changes. There are quite a few affected
    attributes that don't have any capable()/ns_capable() checks in
    their store operations (per_bond_attrs, at91_sysfs_attrs,
    sysfs_grcan_attrs, ican3_sysfs_attrs, cdc_ncm_sysfs_attrs,
    qmi_wwan_sysfs_attrs) but I think this is acceptable. It means that
    container root, rather than specifically CAP_NET_ADMIN inside of the
    network namespace that the device belongs to, can write to those
    device attributes. It's the same situation that those devices have
    today in that init root is able to write to the attributes without
    necessarily having CAP_NET_ADMIN. I think that this should probably
    be fixed in order to be consistent with what netdev_store() does by
    verifying CAP_NET_ADMIN in the network namespace but that it doesn't
    need to happen in this patch set.

Thanks!

Tyler

