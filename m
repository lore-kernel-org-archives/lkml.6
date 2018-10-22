Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC92ECDE45
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11E92083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11E92083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJVPa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:30:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32967 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeJVPa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:30:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id z2-v6so2193488pgp.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 00:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nh6TfIAAE16IGcEuFepCvkCmMAK/HAXyj6StssKZLCY=;
        b=La29VbUbqeJp4BbmBb4bmfbzZIoG4ZuE5Dm2vrllwi/HieHdULK/yKWLdGozrKgrQ/
         k99on5ILE/0Q1jMvkYBibLXjtJxUk+1iWRB7I6zhkomKFiF3hN8/j+ohnhdXGG9sCSvG
         hqgdyE0Qg5cD8XbI/m33/cb8EqIOtlTVX1IvO7gEdzy9cSGZu5lK9cIHgfISqApqfJ/N
         ZlVi/2HmSN/DlAizbuL2HaydvpJAsJERnMex/Xi6dHTmg97OZLUzBUGNB9iBEesiyOYT
         Gl1DFVHU9vTORrxa08IbYnE+dYCDjrIUp/8fKU5FYYZzpRLqorcxBJOh04lN3rbRwYze
         su5A==
X-Gm-Message-State: ABuFfogDgRPWji1DU+oCrbIFMSCbn8rZ7b/skwWWTyBrpXMeGkDboHSq
        l3xtRPYhQn2/nY+JGh1RhB4=
X-Google-Smtp-Source: ACcGV61sNTv2hP9X+aRVQzT807Pkr7WqK6I4GYWbREGx1dxf5Pui9ID4vSxD8kgaVDsPxeQBnUwtfw==
X-Received: by 2002:a62:ca4d:: with SMTP id n74-v6mr43743422pfg.10.1540192422214;
        Mon, 22 Oct 2018 00:13:42 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c79-v6sm38097542pfc.92.2018.10.22.00.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 00:13:41 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 1/2] mm, oom: marks all killed tasks as oom victims
Date:   Mon, 22 Oct 2018 09:13:22 +0200
Message-Id: <20181022071323.9550-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022071323.9550-1-mhocko@kernel.org>
References: <20181022071323.9550-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Historically we have called mark_oom_victim only to the main task
selected as the oom victim because oom victims have access to memory
reserves and granting the access to all killed tasks could deplete
memory reserves very quickly and cause even larger problems.

Since only a partial access to memory reserves is allowed there is no
longer this risk and so all tasks killed along with the oom victim
can be considered as well.

The primary motivation for that is that process groups which do not
shared signals would behave more like standard thread groups wrt oom
handling (aka tsk_is_oom_victim will work the same way for them).

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa5360616..188ae490cf3e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -898,6 +898,7 @@ static void __oom_kill_process(struct task_struct *victim)
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
+		mark_oom_victim(p);
 	}
 	rcu_read_unlock();
 
-- 
2.19.1

