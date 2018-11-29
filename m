Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86749C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B14A208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPzCGDci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B14A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeK3BUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeK3BUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1839208E7;
        Thu, 29 Nov 2018 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500876;
        bh=6bpSCKat1HNZcwMXZjgqsK739KFg6NtmcnltQ2WOZK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPzCGDci27aLC8SocjjjjZEMs+NnwquODP3HWHd5FAN8qZrv6LTAjGTvCcuoEQBb9
         oJmyhAeJn7PNtZyMxh2SzsbIBW0gkzzLMdvCpx5nGRoouMa14aQ2rohMdshT7noLOJ
         y30OwP2dxWLhEZ3vIXnIWcCTSoM3XhTladzokiOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+dcb8b3587445007f5808@syzkaller.appspotmail.com,
        Andrew Price <anprice@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 3.18 05/83] gfs2: Dont leave s_fs_info pointing to freed memory in init_sbd
Date:   Thu, 29 Nov 2018 15:11:23 +0100
Message-Id: <20181129140138.338163508@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Price <anprice@redhat.com>

commit 4c62bd9cea7bcf10292f7e4c57a2bca332942697 upstream.

When alloc_percpu() fails, sdp gets freed but sb->s_fs_info still points
to the same address. Move the assignment after that error check so that
s_fs_info can only point to a valid sdp or NULL, which is checked for
later in the error path, in gfs2_kill_super().

Reported-by: syzbot+dcb8b3587445007f5808@syzkaller.appspotmail.com
Signed-off-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/ops_fstype.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -71,13 +71,13 @@ static struct gfs2_sbd *init_sbd(struct
 	if (!sdp)
 		return NULL;
 
-	sb->s_fs_info = sdp;
 	sdp->sd_vfs = sb;
 	sdp->sd_lkstats = alloc_percpu(struct gfs2_pcpu_lkstats);
 	if (!sdp->sd_lkstats) {
 		kfree(sdp);
 		return NULL;
 	}
+	sb->s_fs_info = sdp;
 
 	set_bit(SDF_NOJOURNALID, &sdp->sd_flags);
 	gfs2_tune_init(&sdp->sd_tune);


