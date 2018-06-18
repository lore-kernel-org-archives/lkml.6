Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51563C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C65820852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C65820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937122AbeFRKYJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:24:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbeFRIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:15:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77FC2C75;
        Mon, 18 Jun 2018 08:15:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>,
        Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 015/279] isofs: fix potential memory leak in mount option parsing
Date:   Mon, 18 Jun 2018 10:10:00 +0200
Message-Id: <20180618080609.443549780@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengguang Xu <cgxu519@gmx.com>

[ Upstream commit 4f34a5130a471f32f2fe7750769ab4057dc3eaa0 ]

When specifying string type mount option (e.g., iocharset)
several times in a mount, current option parsing may
cause memory leak. Hence, call kfree for previous one
in this case. Meanwhile, check memory allocation result
for it.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/isofs/inode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -394,7 +394,10 @@ static int parse_options(char *options,
 			break;
 #ifdef CONFIG_JOLIET
 		case Opt_iocharset:
+			kfree(popt->iocharset);
 			popt->iocharset = match_strdup(&args[0]);
+			if (!popt->iocharset)
+				return 0;
 			break;
 #endif
 		case Opt_map_a:


