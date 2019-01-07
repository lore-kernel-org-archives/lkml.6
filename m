Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014502183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546871988;
	bh=gttrDAgLwtvr0RfIf1rm39h7ohKZPxQ4Yq85/9N6G8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YVrzJoJmgV3aXTE0Em75jtunS8gKy6A6jxJmMNCbF56lDCi3FsT+2TJJKw0BD11kZ
	 D0XHBrb66+0sl55J2HOo1djvV5Dv6kg8c15m0uErh5QjrFCUiNrf25wpWsU0kMvLWY
	 P46IXcSgdF2ckuOg5NG3U7xLGLgjXh0vIF2aWMgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfAGOjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:39:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33194 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfAGOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:39:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so1128951eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czsf4vL5FOcnDURNZogytxKTVT3D/fN437qEHjVuQNY=;
        b=KAzdgZu4hD+GR40bTiM3Me1xmDOw7cWaipvG7L3bLfMXk8jPfg+6CWSOq74jTWiGis
         xxOZ+gFRcuY/gJGERQCttNsYlGSrlZPEIvp6VdhYJBnI7CIac4ymM2uKRGpPhSJB69+Q
         rTy+1ff+CeLeABcIGA5X4/TL6xc2VSsW1piHvc6Ur0yEi6DuUoIKiVVhvWGglLszLGf1
         iYyF+4qDQbyP2LA2CqW069uYAcXEp7qOxwLsob0sAXZhySlnhqsqNsDoYiYazxgYGxQm
         EBo04g+BloivgxtEX7K/8uXFKohyvajNbLu1VG44Yaew60jNBt7QZOS9YwswgAi7yDBc
         jdSg==
X-Gm-Message-State: AA+aEWaJGDkrPkz+6Fglc8SaaeL+TPeAiUFZEj1U+NO4begPXuGZFxcw
        frE1knuecqMbkzpacnzD2Ek=
X-Google-Smtp-Source: AFSGD/Uhw9JeGaHha/JfMcZjkBf21wzOw/01k7ipnizHZJkKEM6lzU1I0tG3yeYB8iVCpINRJsmKrg==
X-Received: by 2002:a50:d311:: with SMTP id g17mr55094523edh.187.1546871982911;
        Mon, 07 Jan 2019 06:39:42 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l18sm29285813edq.87.2019.01.07.06.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:39:41 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Date:   Mon,  7 Jan 2019 15:38:02 +0100
Message-Id: <20190107143802.16847-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107143802.16847-1-mhocko@kernel.org>
References: <20190107143802.16847-1-mhocko@kernel.org>
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
index af7f18b32389..90eb2e2093e7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1387,10 +1387,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
2.20.1

