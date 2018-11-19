Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816ECC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0F022502
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmRbZuMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0F022502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406110AbeKTD1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405180AbeKTD1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:27:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE1820659;
        Mon, 19 Nov 2018 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646975;
        bh=BqHvSBFfTgio/ghArI52/uGqkumBhnjscUueIj2EDjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmRbZuMa4+TG0A3Ua1N/D2n9QypvRat8Nw4BzM1+kWp6PMB/DEstMBu1m4plGUDvG
         3t+GlfrA1AfVUPz5dMgxl91iJ5GMKJHev8XMvboqvbKFlB1MMnhjDHVjOHGVbIW2FA
         AylaCWWm4znqBoHieVSZbL5O7xZTeQc//V53Og+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Calmels <jcalmels@nvidia.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.4 150/160] mount: Dont allow copying MNT_UNBINDABLE|MNT_LOCKED mounts
Date:   Mon, 19 Nov 2018 17:29:49 +0100
Message-Id: <20181119162644.079551794@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit df7342b240185d58d3d9665c0bbf0a0f5570ec29 upstream.

Jonathan Calmels from NVIDIA reported that he's able to bypass the
mount visibility security check in place in the Linux kernel by using
a combination of the unbindable property along with the private mount
propagation option to allow a unprivileged user to see a path which
was purposefully hidden by the root user.

Reproducer:
  # Hide a path to all users using a tmpfs
  root@castiana:~# mount -t tmpfs tmpfs /sys/devices/
  root@castiana:~#

  # As an unprivileged user, unshare user namespace and mount namespace
  stgraber@castiana:~$ unshare -U -m -r

  # Confirm the path is still not accessible
  root@castiana:~# ls /sys/devices/

  # Make /sys recursively unbindable and private
  root@castiana:~# mount --make-runbindable /sys
  root@castiana:~# mount --make-private /sys

  # Recursively bind-mount the rest of /sys over to /mnnt
  root@castiana:~# mount --rbind /sys/ /mnt

  # Access our hidden /sys/device as an unprivileged user
  root@castiana:~# ls /mnt/devices/
  breakpoint cpu cstate_core cstate_pkg i915 intel_pt isa kprobe
  LNXSYSTM:00 msr pci0000:00 platform pnp0 power software system
  tracepoint uncore_arb uncore_cbox_0 uncore_cbox_1 uprobe virtual

Solve this by teaching copy_tree to fail if a mount turns out to be
both unbindable and locked.

Cc: stable@vger.kernel.org
Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Reported-by: Jonathan Calmels <jcalmels@nvidia.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1765,8 +1765,14 @@ struct mount *copy_tree(struct mount *mn
 		for (s = r; s; s = next_mnt(s, r)) {
 			if (!(flag & CL_COPY_UNBINDABLE) &&
 			    IS_MNT_UNBINDABLE(s)) {
-				s = skip_mnt_tree(s);
-				continue;
+				if (s->mnt.mnt_flags & MNT_LOCKED) {
+					/* Both unbindable and locked. */
+					q = ERR_PTR(-EPERM);
+					goto out;
+				} else {
+					s = skip_mnt_tree(s);
+					continue;
+				}
 			}
 			if (!(flag & CL_COPY_MNT_NS_FILE) &&
 			    is_mnt_ns_file(s->mnt.mnt_root)) {


