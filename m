Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D55C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F672250BF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F672250BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeFXPsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:48:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:48:12 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2705B2C;
        Sun, 24 Jun 2018 15:48:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Becky Ligon <ligon@clemson.edu>,
        Martin Brandenburg <martin@omnibond.com>, hubcap@omnibond.com
Subject: [PATCH 4.17 65/70] orangefs: report attributes_mask and attributes for statx
Date:   Sun, 24 Jun 2018 23:22:57 +0800
Message-Id: <20180624142744.546301833@linuxfoundation.org>
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

From: Martin Brandenburg <martin@omnibond.com>

commit 7f54910fa8dfe504f2e1563f4f6ddc3294dfbf3a upstream.

OrangeFS formerly failed to set attributes_mask with the result that
software could not see immutable and append flags present in the
filesystem.

Reported-by: Becky Ligon <ligon@clemson.edu>
Signed-off-by: Martin Brandenburg <martin@omnibond.com>
Fixes: 68a24a6cc4a6 ("orangefs: implement statx")
Cc: stable@vger.kernel.org
Cc: hubcap@omnibond.com
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/orangefs/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -269,6 +269,13 @@ int orangefs_getattr(const struct path *
 		else
 			stat->result_mask = STATX_BASIC_STATS &
 			    ~STATX_SIZE;
+
+		stat->attributes_mask = STATX_ATTR_IMMUTABLE |
+		    STATX_ATTR_APPEND;
+		if (inode->i_flags & S_IMMUTABLE)
+			stat->attributes |= STATX_ATTR_IMMUTABLE;
+		if (inode->i_flags & S_APPEND)
+			stat->attributes |= STATX_ATTR_APPEND;
 	}
 	return ret;
 }


