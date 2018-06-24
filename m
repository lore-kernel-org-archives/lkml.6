Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3BDC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684EC24FA5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684EC24FA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeFXP3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:29:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeFXP3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:29:46 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6EBBE49F;
        Sun, 24 Jun 2018 15:29:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Becky Ligon <ligon@clemson.edu>,
        Martin Brandenburg <martin@omnibond.com>, hubcap@omnibond.com
Subject: [PATCH 4.14 46/52] orangefs: set i_size on new symlink
Date:   Sun, 24 Jun 2018 23:21:39 +0800
Message-Id: <20180624142747.151270278@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Brandenburg <martin@omnibond.com>

commit f6a4b4c9d07dda90c7c29dae96d6119ac6425dca upstream.

As long as a symlink inode remains in-core, the destination (and
therefore size) will not be re-fetched from the server, as it cannot
change.  The original implementation of the attribute cache assumed that
setting the expiry time in the past was sufficient to cause a re-fetch
of all attributes on the next getattr.  That does not work in this case.

The bug manifested itself as follows.  When the command sequence

touch foo; ln -s foo bar; ls -l bar

is run, the output was

lrwxrwxrwx. 1 fedora fedora 4906 Apr 24 19:10 bar -> foo

However, after a re-mount, ls -l bar produces

lrwxrwxrwx. 1 fedora fedora    3 Apr 24 19:10 bar -> foo

After this commit, even before a re-mount, the output is

lrwxrwxrwx. 1 fedora fedora    3 Apr 24 19:10 bar -> foo

Reported-by: Becky Ligon <ligon@clemson.edu>
Signed-off-by: Martin Brandenburg <martin@omnibond.com>
Fixes: 71680c18c8f2 ("orangefs: Cache getattr results.")
Cc: stable@vger.kernel.org
Cc: hubcap@omnibond.com
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/orangefs/namei.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -314,6 +314,13 @@ static int orangefs_symlink(struct inode
 		ret = PTR_ERR(inode);
 		goto out;
 	}
+	/*
+	 * This is necessary because orangefs_inode_getattr will not
+	 * re-read symlink size as it is impossible for it to change.
+	 * Invalidating the cache does not help.  orangefs_new_inode
+	 * does not set the correct size (it does not know symname).
+	 */
+	inode->i_size = strlen(symname);
 
 	gossip_debug(GOSSIP_NAME_DEBUG,
 		     "Assigned symlink inode new number of %pU\n",


