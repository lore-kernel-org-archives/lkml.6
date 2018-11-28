Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91BEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B457206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="cszwS0Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B457206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeK2Ksn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:48:43 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:42231 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbeK2Krl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=PqlK/Oq+bLGFZ4Tj8JXCzvdPT4lvoZwRfgmw3N0vu40=; b=cszwS0Si8t+c
        z1hnGEL/mf5botkCQrkoaNTd8l3yEZyf8CZ8lutXa9hF1FmIZWmCT+TXizQGNPJm18KA+HqfSI1ta
        b/I/KBUIAR5jo0h3bC3BVRnceE8GvjlfXD1iORxbW3TerwfEQUUuUHh6OekRsnZNgopnCWsjyZhem
        9LrbiVnhwCEyi8v78pwmFN/j3oabnJxChmhlur2g6mz65rr9RGlVK/LDY0vAelliTzWRNYZZ2obP2
        1xDAxoIxUWC/l349bPRnvOgUhFosEcpFcbqaxLM3XJuWWa9ZXzK7A7M1csXtAni7AIQxjzgwrBxE5
        hDd+7LyiOQcLbivZLfo/Mw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9V4-000241-QZ; Thu, 29 Nov 2018 00:44:10 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id AB8B1C11D1;
        Thu, 29 Nov 2018 00:44:08 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 18/27] locking/lockdep: Reorder struct lock_class members
Date:   Wed, 28 Nov 2018 15:43:16 -0800
Message-Id: <20181128234325.110011-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ggO8nMhWAy0OAepVgqxWwl602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aWXsh68
 eDQqE+q318QvnQnsq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi2wFVccsCAZ2dyI5DAR
 qfkZNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18n4mJSlGpCLjjP2
 TVCcvwpq3H6DD0enaMXF0oGkbhV/ApPtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MXesoM06hO5vnrARUpuCUNr5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality but makes the patch that
frees lock classes that are no longer in use easier to read.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6d0f8d1c2bee..9421f028c26c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -76,6 +76,13 @@ struct lock_class {
 	 */
 	struct list_head		lock_entry;
 
+	/*
+	 * These fields represent a directed graph of lock dependencies,
+	 * to every node we attach a list of "forward" and a list of
+	 * "backward" graph nodes.
+	 */
+	struct list_head		locks_after, locks_before;
+
 	struct lockdep_subclass_key	*key;
 	unsigned int			subclass;
 	unsigned int			dep_gen_id;
@@ -86,13 +93,6 @@ struct lock_class {
 	unsigned long			usage_mask;
 	struct stack_trace		usage_traces[XXX_LOCK_USAGE_STATES];
 
-	/*
-	 * These fields represent a directed graph of lock dependencies,
-	 * to every node we attach a list of "forward" and a list of
-	 * "backward" graph nodes.
-	 */
-	struct list_head		locks_after, locks_before;
-
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
 	 * to ensure that we check one node only once:
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

