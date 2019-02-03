Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9FBC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607982084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfBCO14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:27:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55510 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730062AbfBCOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:41 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdU-0006LM-AN; Sun, 03 Feb 2019 14:20:40 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9d-00076R-4E; Sun, 03 Feb 2019 14:49:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jonathan Calmels" <jcalmels@nvidia.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.37120095@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 160/305] mount: Don't allow copying MNT_UNBINDABLE|MNT_LOCKED
 mounts
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

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

Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Reported-by: Jonathan Calmels <jcalmels@nvidia.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/namespace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1574,8 +1574,14 @@ struct mount *copy_tree(struct mount *mn
 			struct mount *t = NULL;
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

