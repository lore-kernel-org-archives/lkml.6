Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3340C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418DC21571
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418DC21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHXGmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:48244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbeHXGmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:42:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4AE85AF3A;
        Fri, 24 Aug 2018 03:09:34 +0000 (UTC)
Date:   Thu, 23 Aug 2018 20:09:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org,
        ltp@lists.linux.it
Subject: [PATCH] ipc/shm: properly return EIDRM in shm_lock()
Message-ID: <20180824030920.GD3677@linux-r8p5>
References: <20180823024051.GC13343@shao2-debian>
 <20180823041434.GC3677@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180823041434.GC3677@linux-r8p5>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When getting rid of the general ipc_lock(), this was missed
furthermore, making the comment around the ipc object validity
check bogus. Under EIDRM conditions, callers will in turn not
see the error and continue with the operation.

Fixes: 82061c57ce9 (ipc: drop ipc_lock())
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ipc/shm.c b/ipc/shm.c
index b0eb3757ab89..4cd402e4cfeb 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -199,6 +199,7 @@ static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 	}
 
 	ipc_unlock_object(ipcp);
+	ipcp = ERR_PTR(-EIDRM);
 err:
 	rcu_read_unlock();
 	/*
-- 
2.16.4

