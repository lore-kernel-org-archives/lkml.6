Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F974C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191E3249B0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191E3249B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeGAQxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:53:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964788AbeGAQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:45:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E137A73;
        Sun,  1 Jul 2018 16:45:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.17 195/220] udf: Detect incorrect directory size
Date:   Sun,  1 Jul 2018 18:23:39 +0200
Message-Id: <20180701160916.330434753@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit fa65653e575fbd958bdf5fb9c4a71a324e39510d upstream.

Detect when a directory entry is (possibly partially) beyond directory
size and return EIO in that case since it means the filesystem is
corrupted. Otherwise directory operations can further corrupt the
directory and possibly also oops the kernel.

CC: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
CC: stable@vger.kernel.org
Reported-and-tested-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/udf/directory.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -152,6 +152,9 @@ struct fileIdentDesc *udf_fileident_read
 			       sizeof(struct fileIdentDesc));
 		}
 	}
+	/* Got last entry outside of dir size - fs is corrupted! */
+	if (*nf_pos > dir->i_size)
+		return NULL;
 	return fi;
 }
 


