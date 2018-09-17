Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DCD2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DCD2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeIRERR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:17:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeIRERQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:17:16 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DFB34CA0;
        Mon, 17 Sep 2018 22:47:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlong Song <yunlong.song@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 23/56] f2fs: do not set free of current section
Date:   Tue, 18 Sep 2018 00:41:56 +0200
Message-Id: <20180917213828.907056684@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlong Song <yunlong.song@huawei.com>

[ Upstream commit 3611ce9911267cb93d364bd71ddea6821278d11f ]

For the case when sbi->segs_per_sec > 1, take section:segment = 5 for
example, if segment 1 is just used and allocate new segment 2, and the
blocks of segment 1 is invalidated, at this time, the previous code will
use __set_test_and_free to free the free_secmap and free_sections++,
this is not correct since it is still a current section, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -381,6 +381,8 @@ static inline void __set_test_and_free(s
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
 
+		if (IS_CURSEC(sbi, secno))
+			goto skip_free;
 		next = find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >= start_segno + sbi->segs_per_sec) {
@@ -388,6 +390,7 @@ static inline void __set_test_and_free(s
 				free_i->free_sections++;
 		}
 	}
+skip_free:
 	spin_unlock(&free_i->segmap_lock);
 }
 


