Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D0FC04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5066D208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5066D208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbeHWMlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:41:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbeHWMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:41:32 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B06EBC8;
        Thu, 23 Aug 2018 09:12:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 075/217] Smack: Mark inode instant in smack_task_to_inode
Date:   Thu, 23 Aug 2018 09:53:08 +0200
Message-Id: <20180823075508.877166245@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit 7b4e88434c4e7982fb053c49657e1c8bbb8692d9 ]

Smack: Mark inode instant in smack_task_to_inode

/proc clean-up in commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
resulted in smack_task_to_inode() being called before smack_d_instantiate.
This resulted in the smk_inode value being ignored, even while present
for files in /proc/self. Marking the inode as instant here fixes that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/smack/smack_lsm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2281,6 +2281,7 @@ static void smack_task_to_inode(struct t
 	struct smack_known *skp = smk_of_task_struct(p);
 
 	isp->smk_inode = skp;
+	isp->smk_flags |= SMK_INODE_INSTANT;
 }
 
 /*


