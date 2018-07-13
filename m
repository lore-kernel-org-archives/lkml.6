Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24D0208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24D0208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeGMQWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:22:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38348 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeGMQWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:22:05 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.ubuntu-ci)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fe0aj-0006pX-Lz; Fri, 13 Jul 2018 16:06:45 +0000
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
Subject: [PATCH v2 net-next 0/7] Make /sys/class/net per net namespace objects belong to container
Date:   Fri, 13 Jul 2018 16:05:42 +0000
Message-Id: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revival of an older patch set from Dmitry Torokhov:

 https://lore.kernel.org/lkml/1471386795-32918-1-git-send-email-dmitry.torokhov@gmail.com/

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

I've verified that all of the bridge related files affected by patch 7
have proper access control checks for CAP_NET_ADMIN inside of the
user namespace. I have *not* yet verified that all of the network
device related sysfs files affected by patch 5 have proper access
control checks. I was working under the assumption that those code paths
already were verified when the first iteration of the patches were sent
out.

* Changes since v1:
  - Patch 1 was forward ported to use idr instead of ida for the inode
    num
  - Patch 5 was forward ported around the ro_after_init changes
  - Patch 5 received a build failure fix for !CONFIG_SYSFS
  - Patch 6 and 7 are new

Thanks!

Tyler

