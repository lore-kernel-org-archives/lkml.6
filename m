Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1554C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712C325063
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712C325063
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756016AbeFXPlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:41:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755737AbeFXPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:41:43 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84A0349F;
        Sun, 24 Jun 2018 15:41:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.17 23/70] Btrfs: allow empty subvol= again
Date:   Sun, 24 Jun 2018 23:22:15 +0800
Message-Id: <20180624142741.907866859@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit 37becec95ac31b209eb1c8e096f1093a7db00f32 upstream.

I got a report that after upgrading to 4.16, someone's filesystems
weren't mounting:

[   23.845852] BTRFS info (device loop0): unrecognized mount option 'subvol='

Before 4.16, this mounted the default subvolume. It turns out that this
empty "subvol=" is actually an application bug, but it was causing the
application to fail, so it's an ABI break if you squint.

The generic parsing code we use for mount options (match_token())
doesn't match an empty string as "%s". Previously, setup_root_args()
removed the "subvol=" string, but the mount path was cleaned up to not
need that. Add a dummy Opt_subvol_empty to fix this.

The simple workaround is to use / or . for the value of 'subvol=' .

Fixes: 312c89fbca06 ("btrfs: cleanup btrfs_mount() using btrfs_mount_root()")
CC: stable@vger.kernel.org # 4.16+
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/super.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -323,6 +323,7 @@ enum {
 	Opt_ssd, Opt_nossd,
 	Opt_ssd_spread, Opt_nossd_spread,
 	Opt_subvol,
+	Opt_subvol_empty,
 	Opt_subvolid,
 	Opt_thread_pool,
 	Opt_treelog, Opt_notreelog,
@@ -388,6 +389,7 @@ static const match_table_t tokens = {
 	{Opt_ssd_spread, "ssd_spread"},
 	{Opt_nossd_spread, "nossd_spread"},
 	{Opt_subvol, "subvol=%s"},
+	{Opt_subvol_empty, "subvol="},
 	{Opt_subvolid, "subvolid=%s"},
 	{Opt_thread_pool, "thread_pool=%u"},
 	{Opt_treelog, "treelog"},
@@ -461,6 +463,7 @@ int btrfs_parse_options(struct btrfs_fs_
 			btrfs_set_opt(info->mount_opt, DEGRADED);
 			break;
 		case Opt_subvol:
+		case Opt_subvol_empty:
 		case Opt_subvolid:
 		case Opt_subvolrootid:
 		case Opt_device:


