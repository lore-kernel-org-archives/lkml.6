Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D666C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520ED2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691658;
	bh=/vRaWQKw3q55s8Tz0v2d2naK21I5seaKk7U91gRvlNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3p+IEeS00UxHkv2MAAKbnblwlTHKbdQo0+81bHvuJ8h26nKz+5TjjUzlwF7nSqSI
	 xdvr7jsrk2cEb4k2ZOj3dO3/xHeNQcO706F0Cij7i3h4xljnoECcGsgHoagUvfCiRd
	 mwmblEMrdhbCAp26KAKFUq0ucUWu60MBAYdqhyNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfA1QHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:07:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732220AbfA1QHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:07:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BA421738;
        Mon, 28 Jan 2019 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691652;
        bh=/vRaWQKw3q55s8Tz0v2d2naK21I5seaKk7U91gRvlNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtIZi24ngf9Rk0MYsnmb/8saaeN6QmL16/CdLAqaKW29FEBZ04CwNMNlw4X/HYmOR
         qo3qiI5hlLuNnE4BtRg2auzx5bPYmdpy7aD+U+f7HLtiQF+pKAThT3x4zFQxbkwuwO
         O+i2Fz7O9t5+aIq70PEtWooOcKTxBPZiwtmcWw7g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        live-patching@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 174/258] livepatch: check kzalloc return values
Date:   Mon, 28 Jan 2019 10:58:00 -0500
Message-Id: <20190128155924.51521-174-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 5f30b2e823484ce6a79f2b59901b6351c15effa6 ]

kzalloc() return should always be checked - notably in example code
where this may be seen as reference. On failure of allocation in
livepatch_fix1_dummy_alloc() respectively dummy_alloc() previous
allocation is freed (thanks to Petr Mladek <pmladek@suse.com> for
catching this) and NULL returned.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 439e7271dc2b ("livepatch: introduce shadow variable API")
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/livepatch/livepatch-shadow-fix1.c | 5 +++++
 samples/livepatch/livepatch-shadow-mod.c  | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 49b13553eaae..e8f1bd6b29b1 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -89,6 +89,11 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
 	 * pointer to handle resource release.
 	 */
 	leak = kzalloc(sizeof(int), GFP_KERNEL);
+	if (!leak) {
+		kfree(d);
+		return NULL;
+	}
+
 	klp_shadow_alloc(d, SV_LEAK, sizeof(leak), GFP_KERNEL,
 			 shadow_leak_ctor, leak);
 
diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
index 4c54b250332d..4aa8a88d3cd6 100644
--- a/samples/livepatch/livepatch-shadow-mod.c
+++ b/samples/livepatch/livepatch-shadow-mod.c
@@ -118,6 +118,10 @@ noinline struct dummy *dummy_alloc(void)
 
 	/* Oops, forgot to save leak! */
 	leak = kzalloc(sizeof(int), GFP_KERNEL);
+	if (!leak) {
+		kfree(d);
+		return NULL;
+	}
 
 	pr_info("%s: dummy @ %p, expires @ %lx\n",
 		__func__, d, d->jiffies_expire);
-- 
2.19.1

