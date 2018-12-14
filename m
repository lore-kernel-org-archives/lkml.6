Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705E6C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DD0214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789742;
	bh=oXKKfHzJ/iJtbc8UIvs0asSdD+pygrKUmFyiO1qzwL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pngSnrcpUWrxIlgF2tp/7/l2DRQLgUAApvmUsbb/+aDiY3b2mBdJKstquDZYQOPFl
	 1nZtLYh7bYkJQoR2v3nebd8A1CCFvAAwPwzrmHohUXVa9qx4LFPe51BxUay3sehyhw
	 1V+p6MbLk6V/oJUsEiwh6Cm3aEzsqyjwu0zkSjdU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DD0214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbeLNMPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:15:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732593AbeLNMPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCCFF21479;
        Fri, 14 Dec 2018 12:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789735;
        bh=oXKKfHzJ/iJtbc8UIvs0asSdD+pygrKUmFyiO1qzwL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFWoj2V9T45ImKe6H8A4bL7e8SjlnV2hmla9Vd9QiSz1ww9oVvx9xlqvNGGIZq1pw
         cOxMt9cA2JXAbfU7CLHyowTeu6H0iSIVA3D2/s0x58I4HIQ7Cc6N7z8qw2bl5c8ZpN
         zFPmgsvY1V8j5yZSzmIYRCQRUWhVtggvo0VeqznI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@gmx.us>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 37/88] debugobjects: avoid recursive calls with kmemleak
Date:   Fri, 14 Dec 2018 13:00:11 +0100
Message-Id: <20181214115705.241791978@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8de456cf87ba863e028c4dd01bae44255ce3d835 ]

CONFIG_DEBUG_OBJECTS_RCU_HEAD does not play well with kmemleak due to
recursive calls.

fill_pool
  kmemleak_ignore
    make_black_object
      put_object
        __call_rcu (kernel/rcu/tree.c)
          debug_rcu_head_queue
            debug_object_activate
              debug_object_init
                fill_pool
                  kmemleak_ignore
                    make_black_object
                      ...

So add SLAB_NOLEAKTRACE to kmem_cache_create() to not register newly
allocated debug objects at all.

Link: http://lkml.kernel.org/r/20181126165343.2339-1-cai@gmx.us
Signed-off-by: Qian Cai <cai@gmx.us>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index a26328ec39f1..bb37541cd441 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1088,7 +1088,8 @@ void __init debug_objects_mem_init(void)
 
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
-				      SLAB_DEBUG_OBJECTS, NULL);
+				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
+				      NULL);
 
 	if (!obj_cache || debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
-- 
2.19.1



