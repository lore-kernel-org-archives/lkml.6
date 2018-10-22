Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E5ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCAA20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCAA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeJVPbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:31:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43530 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeJVPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:31:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id q1-v6so2130176pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 00:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBCBxQHOTmvZgHJl60t6jyJTwJfcDyQfW3eSyeZ8neA=;
        b=UDQPK+zWTtGMk5+nYP+8JJChs23KFf539SRaWit0rpo/6pF692hx4pylh8JI7TEF70
         /9gpiqp4Q/xOQCiN0i5c4Gq7xVF6ABEXxfIBeFGnl3ros/443MrEtGiRJyMDhyUNRQdW
         /Loll1WpdSl8yjR3vnO4Ogjh3slV0uIy4WVQdkHJj0Lm5ykFPBPB+rPHIklACFVQrL9H
         /L5ojzFwpANPyyzCLQs1B61RSNSJGygqRlorCEfwgfIZN0wr+PfKvNDrB/SKj/X8F2Er
         sNq6Rl2lQp32v7aThHW0jBAqJlMSem+NGdVW1UErRKpGO5FlNENddeFh9BdQzuk1ibtT
         309g==
X-Gm-Message-State: ABuFfogKxTgIC1cnwjsR2IlDnKifFsTm0MGvNIy0TtXMfApXqCTT3jOI
        Q41qhA+FusQSg6L1Ah2ud3M=
X-Google-Smtp-Source: ACcGV6064Z1dWqa7QMCXfgEb9cpfEDaa6ZH2gbgOOmik96tlPssDIV7b2W3tmlzucX76u01TUKPNKw==
X-Received: by 2002:a62:569d:: with SMTP id h29-v6mr16163789pfj.42.1540192424428;
        Mon, 22 Oct 2018 00:13:44 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c79-v6sm38097542pfc.92.2018.10.22.00.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 00:13:43 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Date:   Mon, 22 Oct 2018 09:13:23 +0200
Message-Id: <20181022071323.9550-3-mhocko@kernel.org>
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

Tetsuo has reported [1] that a single process group memcg might easily
swamp the log with no-eligible oom victim reports due to race between
the memcg charge and oom_reaper

Thread 1		Thread2				oom_reaper
try_charge		try_charge
			  mem_cgroup_out_of_memory
			    mutex_lock(oom_lock)
  mem_cgroup_out_of_memory
    mutex_lock(oom_lock)
			      out_of_memory
			        select_bad_process
				oom_kill_process(current)
				  wake_oom_reaper
							  oom_reap_task
							  MMF_OOM_SKIP->victim
			    mutex_unlock(oom_lock)
    out_of_memory
      select_bad_process # no task

If Thread1 didn't race it would bail out from try_charge and force the
charge. We can achieve the same by checking tsk_is_oom_victim inside
the oom_lock and therefore close the race.

[1] http://lkml.kernel.org/r/bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e79cb59552d9..a9dfed29967b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1380,10 +1380,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		.gfp_mask = gfp_mask,
 		.order = order,
 	};
-	bool ret;
+	bool ret = true;
 
 	mutex_lock(&oom_lock);
+
+	/*
+	 * multi-threaded tasks might race with oom_reaper and gain
+	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
+	 * to out_of_memory failure if the task is the last one in
+	 * memcg which would be a false possitive failure reported
+	 */
+	if (tsk_is_oom_victim(current))
+		goto unlock;
+
 	ret = out_of_memory(&oc);
+
+unlock:
 	mutex_unlock(&oom_lock);
 	return ret;
 }
-- 
2.19.1

