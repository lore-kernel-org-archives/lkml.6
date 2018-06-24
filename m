Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528EC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38886214E2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38886214E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeFXPoi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:44:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeFXPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:44:37 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 170A92C;
        Sun, 24 Jun 2018 15:44:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Xu, Wen" <wen.xu@gatech.edu>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, stable@kernel.org
Subject: [PATCH 4.17 20/70] ext4: correctly handle a zero-length xattr with a non-zero e_value_offs
Date:   Sun, 24 Jun 2018 23:22:12 +0800
Message-Id: <20180624142741.738473698@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 8a2b307c21d4b290e3cbe33f768f194286d07c23 upstream.

Ext4 will always create ext4 extended attributes which do not have a
value (where e_value_size is zero) with e_value_offs set to zero.  In
most places e_value_offs will not be used in a substantive way if
e_value_size is zero.

There was one exception to this, which is in ext4_xattr_set_entry(),
where if there is a maliciously crafted file system where there is an
extended attribute with e_value_offs is non-zero and e_value_size is
0, the attempt to remove this xattr will result in a negative value
getting passed to memmove, leading to the following sadness:

[   41.225365] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[   44.538641] BUG: unable to handle kernel paging request at ffff9ec9a3000000
[   44.538733] IP: __memmove+0x81/0x1a0
[   44.538755] PGD 1249bd067 P4D 1249bd067 PUD 1249c1067 PMD 80000001230000e1
[   44.538793] Oops: 0003 [#1] SMP PTI
[   44.539074] CPU: 0 PID: 1470 Comm: poc Not tainted 4.16.0-rc1+ #1
    ...
[   44.539475] Call Trace:
[   44.539832]  ext4_xattr_set_entry+0x9e7/0xf80
    ...
[   44.539972]  ext4_xattr_block_set+0x212/0xea0
    ...
[   44.540041]  ext4_xattr_set_handle+0x514/0x610
[   44.540065]  ext4_xattr_set+0x7f/0x120
[   44.540090]  __vfs_removexattr+0x4d/0x60
[   44.540112]  vfs_removexattr+0x75/0xe0
[   44.540132]  removexattr+0x4d/0x80
    ...
[   44.540279]  path_removexattr+0x91/0xb0
[   44.540300]  SyS_removexattr+0xf/0x20
[   44.540322]  do_syscall_64+0x71/0x120
[   44.540344]  entry_SYSCALL_64_after_hwframe+0x21/0x86

https://bugzilla.kernel.org/show_bug.cgi?id=199347

This addresses CVE-2018-10840.

Reported-by: "Xu, Wen" <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Cc: stable@kernel.org
Fixes: dec214d00e0d7 ("ext4: xattr inode deduplication")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1688,7 +1688,7 @@ static int ext4_xattr_set_entry(struct e
 
 	/* No failures allowed past this point. */
 
-	if (!s->not_found && here->e_value_offs) {
+	if (!s->not_found && here->e_value_size && here->e_value_offs) {
 		/* Remove the old value. */
 		void *first_val = s->base + min_offs;
 		size_t offs = le16_to_cpu(here->e_value_offs);


