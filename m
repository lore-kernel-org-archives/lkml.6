Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C964CC677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9304D214DC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWOFe2D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9304D214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbeJICAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbeJICAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B326204FD;
        Mon,  8 Oct 2018 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024456;
        bh=NEHEC+kMKHYYFu+Gz40bNY3oj8b9NZF2V20XFJmMt+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWOFe2D7ZxdsSD6qm6nYS0YWSpl1+wnnHrX3W60zaJIkR89kZm2uYRbCldzv17CF+
         xwL1P/ki6cjCWlF2yOEEYkwdPijjmNZFDUdsvtrGl8YKEOrqtl3vOW4Qut+udgV6M4
         smRj50kOEdueAxmV99YlntoHtqT4MMLfaxYXskXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 046/168] md/raid5-cache: disable reshape completely
Date:   Mon,  8 Oct 2018 20:30:26 +0200
Message-Id: <20181008175621.806900860@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Shaohua Li <shli@fb.com>

[ Upstream commit e254de6bcf3f5b6e78a92ac95fb91acef8adfe1a ]

We don't support reshape yet if an array supports log device. Previously we
determine the fact by checking ->log. However, ->log could be NULL after a log
device is removed, but the array is still marked to support log device. Don't
allow reshape in this case too. User can disable log device support by setting
'consistency_policy' to 'resync' then do reshape.

Reported-by: Xiao Ni <xni@redhat.com>
Tested-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5-log.h |    5 +++++
 drivers/md/raid5.c     |    6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -46,6 +46,11 @@ extern int ppl_modify_log(struct r5conf
 extern void ppl_quiesce(struct r5conf *conf, int quiesce);
 extern int ppl_handle_flush_request(struct r5l_log *log, struct bio *bio);
 
+static inline bool raid5_has_log(struct r5conf *conf)
+{
+	return test_bit(MD_HAS_JOURNAL, &conf->mddev->flags);
+}
+
 static inline bool raid5_has_ppl(struct r5conf *conf)
 {
 	return test_bit(MD_HAS_PPL, &conf->mddev->flags);
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -735,7 +735,7 @@ static bool stripe_can_batch(struct stri
 {
 	struct r5conf *conf = sh->raid_conf;
 
-	if (conf->log || raid5_has_ppl(conf))
+	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return false;
 	return test_bit(STRIPE_BATCH_READY, &sh->state) &&
 		!test_bit(STRIPE_BITMAP_PENDING, &sh->state) &&
@@ -7739,7 +7739,7 @@ static int raid5_resize(struct mddev *md
 	sector_t newsize;
 	struct r5conf *conf = mddev->private;
 
-	if (conf->log || raid5_has_ppl(conf))
+	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return -EINVAL;
 	sectors &= ~((sector_t)conf->chunk_sectors - 1);
 	newsize = raid5_size(mddev, sectors, mddev->raid_disks);
@@ -7790,7 +7790,7 @@ static int check_reshape(struct mddev *m
 {
 	struct r5conf *conf = mddev->private;
 
-	if (conf->log || raid5_has_ppl(conf))
+	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return -EINVAL;
 	if (mddev->delta_disks == 0 &&
 	    mddev->new_layout == mddev->layout &&


