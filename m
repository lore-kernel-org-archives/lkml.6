Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3AAC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB1217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360830;
	bh=49bzgydITqAYmohR8ACu7eyOvq1Cr/l2Kg02XwmaiHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NE3XDWMyyMKPbt00Dr1+SCXf35IcWLUfPof8qaFSB6BwJRV688UKYPbtJMX2e6N6W
	 crPgL875Ae3/dQSrh2+BjaEkxt8tGpWXGfP+gIZNSjff1HNRrR4J0w+xbiyAC0EaiA
	 B56WukYu397r/DIcqDDzeCLYP686d7pQdVEyhsss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfAXTZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:25:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbfAXTZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD051218EA;
        Thu, 24 Jan 2019 19:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357926;
        bh=49bzgydITqAYmohR8ACu7eyOvq1Cr/l2Kg02XwmaiHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPNbPujBJhcVGroAEqp+/W6Mim3HlbUqOQpfTAhmGee8KZdc6d1TZ/kHUC2x3ZuwP
         ovhhwWNcjKJuv58Ehm2KC/HXl5rz+EQQ7zh+jyyIQh0LD89JApN+HNYBTvWDACvR5P
         sCPKdL5EMhfHPThG27fFA3urBjIPGeBZT9gbx58s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 036/104] f2fs: fix missing up_read
Date:   Thu, 24 Jan 2019 20:19:25 +0100
Message-Id: <20190124190159.129465657@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 89d13c38501df730cbb2e02c4499da1b5187119d upstream.

This patch fixes missing up_read call.

Fixes: c9b60788fc76 ("f2fs: fix to do sanity check with block address in main area")
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1342,8 +1342,10 @@ static int f2fs_write_node_page(struct p
 	}
 
 	if (__is_valid_data_blkaddr(ni.blk_addr) &&
-		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC))
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC)) {
+		up_read(&sbi->node_write);
 		goto redirty_out;
+	}
 
 	set_page_writeback(page);
 	fio.blk_addr = ni.blk_addr;


