Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6201DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DA620645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DA620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeIHCJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:09:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeIHCJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:09:46 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90155F07;
        Fri,  7 Sep 2018 21:26:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 31/89] dm cache metadata: save in-core policy_hint_size to on-disk superblock
Date:   Fri,  7 Sep 2018 23:09:25 +0200
Message-Id: <20180907210856.182448600@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
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

From: Mike Snitzer <snitzer@redhat.com>

commit fd2fa95416188a767a63979296fa3e169a9ef5ec upstream.

policy_hint_size starts as 0 during __write_initial_superblock().  It
isn't until the policy is loaded that policy_hint_size is set in-core
(cmd->policy_hint_size).  But it never got recorded in the on-disk
superblock because __commit_transaction() didn't deal with transfering
the in-core cmd->policy_hint_size to the on-disk superblock.

The in-core cmd->policy_hint_size gets initialized by metadata_open()'s
__begin_transaction_flags() which re-reads all superblock fields.
Because the superblock's policy_hint_size was never properly stored, when
the cache was created, hints_array_available() would always return false
when re-activating a previously created cache.  This means
__load_mappings() always considered the hints invalid and never made use
of the hints (these hints served to optimize).

Another detremental side-effect of this oversight is the cache_check
utility would fail with: "invalid hint width: 0"

Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-metadata.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -362,7 +362,7 @@ static int __write_initial_superblock(st
 	disk_super->version = cpu_to_le32(cmd->version);
 	memset(disk_super->policy_name, 0, sizeof(disk_super->policy_name));
 	memset(disk_super->policy_version, 0, sizeof(disk_super->policy_version));
-	disk_super->policy_hint_size = 0;
+	disk_super->policy_hint_size = cpu_to_le32(0);
 
 	__copy_sm_root(cmd, disk_super);
 
@@ -700,6 +700,7 @@ static int __commit_transaction(struct d
 	disk_super->policy_version[0] = cpu_to_le32(cmd->policy_version[0]);
 	disk_super->policy_version[1] = cpu_to_le32(cmd->policy_version[1]);
 	disk_super->policy_version[2] = cpu_to_le32(cmd->policy_version[2]);
+	disk_super->policy_hint_size = cpu_to_le32(cmd->policy_hint_size);
 
 	disk_super->read_hits = cpu_to_le32(cmd->stats.read_hits);
 	disk_super->read_misses = cpu_to_le32(cmd->stats.read_misses);


