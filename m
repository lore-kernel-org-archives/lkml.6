Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90F3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836C9218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900950;
	bh=yIvTbwd3Xq8HveIJYZX05QBb+Dn6UDUr6nK6r5UEa8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ouYQlVjkKCSb8+48Oy+KOmau0ifbu7IoPeiE0ZyAy/Bh0hGhdwWEqfHRwRuohquFs
	 ofk8uhejd/q9DJYCnljbSeq0NvsWJzo3iIH4QplKIrHoyUS9XmTJBzVDxvatS682dX
	 vlgCWoUjNWTibZGiPYxC4KvBca+dpCS5sKyMYR48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfBKQC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:02:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729606AbfBKOaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9063720675;
        Mon, 11 Feb 2019 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895415;
        bh=yIvTbwd3Xq8HveIJYZX05QBb+Dn6UDUr6nK6r5UEa8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6gT0XXY5kn3ouB5o/fYi4fDjoYUhZHhIQnWzdm27zi8yIWFilAOh5EOhbXzwL5Bn
         KIkXEYdE4dtWBo9+2/H3qHWNm6LoiVI4J1dJY5jqQjN+6jkuujZpuDt7uj5SfWKMbd
         zHviTK51O9+s2aYFVSLZqx/8xlUDV1dkpbUX+pqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 197/352] livepatch: check kzalloc return values
Date:   Mon, 11 Feb 2019 15:17:04 +0100
Message-Id: <20190211141859.673024218@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



