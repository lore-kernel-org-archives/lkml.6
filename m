Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26609C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E753320872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfALAJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:09:53 -0500
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:46786
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfALAJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:09:51 -0500
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 19:09:45 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ANAADXLDlc//yp0HYNVhsBAQEBAwE?=
 =?us-ascii?q?BAQcDAQEBgVMEAQEBCwGEEoQBlFkBB4R7hWmJRIUHgXuEdAMCAoJLNgcNAQM?=
 =?us-ascii?q?BAQEBAQEChmACAQMjBFIQGAEMAiYCAkcQBhOFF64AcXwzGoobgQuBc4lYeIE?=
 =?us-ascii?q?HgRGEUwGDCINAglcCkEA2kQUJkhsLAoofA4dOLYJnmRwGggFNLgqDJ4InDAu?=
 =?us-ascii?q?OK2WICoJNAQE?=
X-IPAS-Result: =?us-ascii?q?A2ANAADXLDlc//yp0HYNVhsBAQEBAwEBAQcDAQEBgVMEA?=
 =?us-ascii?q?QEBCwGEEoQBlFkBB4R7hWmJRIUHgXuEdAMCAoJLNgcNAQMBAQEBAQEChmACA?=
 =?us-ascii?q?QMjBFIQGAEMAiYCAkcQBhOFF64AcXwzGoobgQuBc4lYeIEHgRGEUwGDCINAg?=
 =?us-ascii?q?lcCkEA2kQUJkhsLAoofA4dOLYJnmRwGggFNLgqDJ4InDAuOK2WICoJNAQE?=
X-IronPort-AV: E=Sophos;i="5.56,467,1539619200"; 
   d="scan'208";a="155670383"
Received: from unknown (HELO [192.168.1.228]) ([118.208.169.252])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 12 Jan 2019 08:00:34 +0800
Subject: [PATCH 2/3] autofs - fix error return in autofs_fill_super()
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Date:   Sat, 12 Jan 2019 08:00:33 +0800
Message-ID: <154725123240.11260.796773942606871359.stgit@pluto-themaw-net>
In-Reply-To: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In autofs_fill_super() on error of get inode/make root dentry the
return should be ENOMEM as this is the only failure case of the
called functions.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 0e8ea2d9a2bb..078992eee299 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -266,8 +266,10 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	}
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
 	root = d_make_root(root_inode);
-	if (!root)
+	if (!root) {
+		ret = -ENOMEM;
 		goto fail_ino;
+	}
 	pipe = NULL;
 
 	root->d_fsdata = ino;

