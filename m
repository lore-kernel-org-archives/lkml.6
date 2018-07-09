Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67015C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2024C208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2024C208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeGIHrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:47:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34297 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbeGIHrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:47:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id d3-v6so13179327edi.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 00:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZH7enT3vT1Ar8WueFAqatFtw3lASThB9hmJKWhdyUrU=;
        b=FQcdwaXtB6jSd3JOEEOMHKOIhWQRHKP7ucMpKioIebZzaTkmslnVETO7+3CSdT9LV+
         EzEa52d1hirXjgMAhabqJcahg9f2NCnzTmmxZ80taR7FPgCQL3Ub3M3QioMbp7+zE/Mg
         xvHEy+fYBhXjHcpvaUb5CmYNMzVnsoV8Znqg0jFOEmbYRKTrTCCSuk1JeDfmjdpSOQUx
         6CH6WrmzPJirml/kx9/D2AOx9S5ElSUzROsokjtZD4slQ/Twi22OWzNHqnd4l+PKsv0R
         367tw5X5NHbub9g5rkNd0YvRgv+h/cgtWoWrzKC1DeLU/epcabuAwj0KBYdsaS16Efo8
         A1wQ==
X-Gm-Message-State: APt69E3/xaKyBFmm5r4eDMZogzFvCVti0e0ncn7LdASgnzb1cVDaj9qg
        Dlvein68Ky1HUVnu65ALNg0=
X-Google-Smtp-Source: AAOMgpe+lYuDeuT4w/Y4cpotsv3872vZqikzG/aHOGvoKMZrVAR1aGMikVsH7GldHoZzCzGiYpSFGg==
X-Received: by 2002:a50:b410:: with SMTP id b16-v6mr9280230edh.190.1531122431577;
        Mon, 09 Jul 2018 00:47:11 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id e20-v6sm6235649eds.20.2018.07.09.00.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 00:47:10 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, oom: remove sleep from under oom_lock
Date:   Mon,  9 Jul 2018 09:47:06 +0200
Message-Id: <20180709074706.30635-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Tetsuo has pointed out that since 27ae357fa82b ("mm, oom: fix concurrent
munlock and oom reaper unmap, v3") we have a strong synchronization
between the oom_killer and victim's exiting because both have to take
the oom_lock. Therefore the original heuristic to sleep for a short time
in out_of_memory doesn't serve the original purpose.

Moreover Tetsuo has noticed that the short sleep can be more harmful
than actually useful. Hammering the system with many processes can lead
to a starvation when the task holding the oom_lock can block for a
long time (minutes) and block any further progress because the
oom_reaper depends on the oom_lock as well.

Drop the short sleep from out_of_memory when we hold the lock. Keep the
sleep when the trylock fails to throttle the concurrent OOM paths a bit.
This should be solved in a more reasonable way (e.g. sleep proportional
to the time spent in the active reclaiming etc.) but this is much more
complex thing to achieve. This is a quick fixup to remove a stale code.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8ba6cb88cf58..ed9d473c571e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1077,15 +1077,9 @@ bool out_of_memory(struct oom_control *oc)
 		dump_header(oc, NULL);
 		panic("Out of memory and no killable processes...\n");
 	}
-	if (oc->chosen && oc->chosen != (void *)-1UL) {
+	if (oc->chosen && oc->chosen != (void *)-1UL)
 		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
 				 "Memory cgroup out of memory");
-		/*
-		 * Give the killed process a good chance to exit before trying
-		 * to allocate memory again.
-		 */
-		schedule_timeout_killable(1);
-	}
 	return !!oc->chosen;
 }
 
-- 
2.18.0

