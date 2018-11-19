Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4858C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF54214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9i9eARi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF54214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbeKTDAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbeKTDAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:00:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A7921479;
        Mon, 19 Nov 2018 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645366;
        bh=G1z78Zn4fIg9s09kH+P2l9ZCD3XU9wgjLV9S6+cszME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9i9eARi2g85SNWhfmI5NspQT2kQVYCw8YD8jkKNzqvq1Xs0ww5MbbOSxGBqI3wZq
         eZcwdyvFo87VRWUcmZZMXRqaHkxZZr1+5T2qoOT/YlEVVI2aCN16tqVgrcAA//GYRU
         o/ArKDV4NPOz/BTRAAt7U5tCeyiYyACzsQKHHSTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.19 134/205] ext4: missing !bh check in ext4_xattr_inode_write()
Date:   Mon, 19 Nov 2018 17:27:21 +0100
Message-Id: <20181119162637.275262481@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit eb6984fa4ce2837dcb1f66720a600f31b0bb3739 upstream.

According to Ted Ts'o ext4_getblk() called in ext4_xattr_inode_write()
should not return bh = NULL

The only time that bh could be NULL, then, would be in the case of
something really going wrong; a programming error elsewhere (perhaps a
wild pointer dereference) or I/O error causing on-disk file system
corruption (although that would be highly unlikely given that we had
*just* allocated the blocks and so the metadata blocks in question
probably would still be in the cache).

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 4.13
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1388,6 +1388,12 @@ retry:
 		bh = ext4_getblk(handle, ea_inode, block, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
+		if (!bh) {
+			WARN_ON_ONCE(1);
+			EXT4_ERROR_INODE(ea_inode,
+					 "ext4_getblk() return bh = NULL");
+			return -EFSCORRUPTED;
+		}
 		ret = ext4_journal_get_write_access(handle, bh);
 		if (ret)
 			goto out;


