Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAD_ENC_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D6C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B72204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B72204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbeIMTFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:05:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeIMTFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:05:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65D65D10;
        Thu, 13 Sep 2018 13:55:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+01ffaf5d9568dd1609f7@syzkaller.appspotmail.com>,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 038/197] hfsplus: dont return 0 when fill_super() failed
Date:   Thu, 13 Sep 2018 15:29:47 +0200
Message-Id: <20180913131843.077619787@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 7464726cb5998846306ed0a7d6714afb2e37b25d ]

syzbot is reporting NULL pointer dereference at mount_fs() [1].  This is
because hfsplus_fill_super() is by error returning 0 when
hfsplus_fill_super() detected invalid filesystem image, and mount_bdev()
is returning NULL because dget(s->s_root) == NULL if s->s_root == NULL,
and mount_fs() is accessing root->d_sb because IS_ERR(root) == false if
root == NULL.  Fix this by returning -EINVAL when hfsplus_fill_super()
detected invalid filesystem image.

[1] https://syzkaller.appspot.com/bug?id=21acb6850cecbc960c927229e597158cf35f33d0

Link: http://lkml.kernel.org/r/d83ce31a-874c-dd5b-f790-41405983a5be@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+01ffaf5d9568dd1609f7@syzkaller.appspotmail.com>
Reviewed-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hfsplus/super.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -524,8 +524,10 @@ static int hfsplus_fill_super(struct sup
 		goto out_put_root;
 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
 		hfs_find_exit(&fd);
-		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER))
+		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
+			err = -EINVAL;
 			goto out_put_root;
+		}
 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);


