Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23501ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84802146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84802146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeIRE2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:28:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbeIRE15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:27:57 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0B562C03;
        Mon, 17 Sep 2018 22:58:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Daniel J. Axtens" <daniel.axtens@canonical.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 56/70] partitions/aix: append null character to print data from disk
Date:   Tue, 18 Sep 2018 00:42:29 +0200
Message-Id: <20180917211653.551594601@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit d43fdae7bac2def8c4314b5a49822cb7f08a45f1 ]

Even if properly initialized, the lvname array (i.e., strings)
is read from disk, and might contain corrupt data (e.g., lack
the null terminating character for strings).

So, make sure the partition name string used in pr_warn() has
the null terminating character.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Suggested-by: Daniel J. Axtens <daniel.axtens@canonical.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/partitions/aix.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -281,10 +281,14 @@ int aix_partition(struct parsed_partitio
 				next_lp_ix += 1;
 		}
 		for (i = 0; i < state->limit; i += 1)
-			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous)
+			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
+				char tmp[sizeof(n[i].name) + 1]; // null char
+
+				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
 				pr_warn("partition %s (%u pp's found) is "
 					"not contiguous\n",
-					n[i].name, lvip[i].pps_found);
+					tmp, lvip[i].pps_found);
+			}
 		kfree(pvd);
 	}
 	kfree(n);


