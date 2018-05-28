Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423897AbeE1LKb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422749AbeE1LKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:10:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        Eric Sandeen <sandeen@redhat.com>, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 140/272] ext4: dont complain about incorrect features when probing
Date: Mon, 28 May 2018 12:02:53 +0200
Message-Id: <20180528100252.805459949@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 0d9366d67bcf066b028e57d09c9a86ce879bcc28 ]

If mount is auto-probing for filesystem type, it will try various
filesystems in order, with the MS_SILENT flag set.  We get
that flag as the silent arg to ext4_fill_super.

If we're probing (silent==1) then don't complain about feature
incompatibilities that are found if it looks like it's actually
a different valid extN type - failed probes should be silent
in this case.

If the on-disk features are unknown even to ext4, then complain.

Reported-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Tested-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3663,6 +3663,12 @@ static int ext4_fill_super(struct super_
 			ext4_msg(sb, KERN_INFO, "mounting ext2 file system "
 				 "using the ext4 subsystem");
 		else {
+			/*
+			 * If we're probing be silent, if this looks like
+			 * it's actually an ext[34] filesystem.
+			 */
+			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
+				goto failed_mount;
 			ext4_msg(sb, KERN_ERR, "couldn't mount as ext2 due "
 				 "to feature incompatibilities");
 			goto failed_mount;
@@ -3674,6 +3680,12 @@ static int ext4_fill_super(struct super_
 			ext4_msg(sb, KERN_INFO, "mounting ext3 file system "
 				 "using the ext4 subsystem");
 		else {
+			/*
+			 * If we're probing be silent, if this looks like
+			 * it's actually an ext4 filesystem.
+			 */
+			if (silent && ext4_feature_set_ok(sb, sb_rdonly(sb)))
+				goto failed_mount;
 			ext4_msg(sb, KERN_ERR, "couldn't mount as ext3 due "
 				 "to feature incompatibilities");
 			goto failed_mount;
