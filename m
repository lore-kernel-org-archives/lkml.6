Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF929C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8FD20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8FD20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407821AbeHATRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:17:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389912AbeHATRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:17:43 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 602DBD5B;
        Wed,  1 Aug 2018 17:30:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        James Simmons <jsimmons@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 125/144] staging: lustre: ldlm: free resource when ldlm_lock_create() fails.
Date:   Wed,  1 Aug 2018 18:52:32 +0200
Message-Id: <20180801164958.093721725@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

[ Upstream commit d8caf662b4aeeb2ac83ac0b22e40db88e9360c77 ]

ldlm_lock_create() gets a resource, but don't put it on
all failure paths. It should.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
@@ -1489,8 +1489,10 @@ struct ldlm_lock *ldlm_lock_create(struc
 		return ERR_CAST(res);
 
 	lock = ldlm_lock_new(res);
-	if (!lock)
+	if (!lock) {
+		ldlm_resource_putref(res);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	lock->l_req_mode = mode;
 	lock->l_ast_data = data;
@@ -1533,6 +1535,8 @@ out:
 	return ERR_PTR(rc);
 }
 
+
+
 /**
  * Enqueue (request) a lock.
  * On the client this is called from ldlm_cli_enqueue_fini


