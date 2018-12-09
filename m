Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E7EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253FC20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253FC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeLIWLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:11:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37650 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbeLIWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:11:09 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73H-0002pr-KB; Sun, 09 Dec 2018 21:55:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003MQ-JT; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mike Snitzer" <snitzer@redhat.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.545839705@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 115/328] dm cache metadata: save in-core
 policy_hint_size to on-disk superblock
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-cache-metadata.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -324,7 +324,7 @@ static int __write_initial_superblock(st
 	disk_super->version = cpu_to_le32(MAX_CACHE_VERSION);
 	memset(disk_super->policy_name, 0, sizeof(disk_super->policy_name));
 	memset(disk_super->policy_version, 0, sizeof(disk_super->policy_version));
-	disk_super->policy_hint_size = 0;
+	disk_super->policy_hint_size = cpu_to_le32(0);
 
 	__copy_sm_root(cmd, disk_super);
 
@@ -635,6 +635,7 @@ static int __commit_transaction(struct d
 	disk_super->policy_version[0] = cpu_to_le32(cmd->policy_version[0]);
 	disk_super->policy_version[1] = cpu_to_le32(cmd->policy_version[1]);
 	disk_super->policy_version[2] = cpu_to_le32(cmd->policy_version[2]);
+	disk_super->policy_hint_size = cpu_to_le32(cmd->policy_hint_size);
 
 	disk_super->read_hits = cpu_to_le32(cmd->stats.read_hits);
 	disk_super->read_misses = cpu_to_le32(cmd->stats.read_misses);

