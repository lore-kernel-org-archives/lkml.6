Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D974AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9636E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFVXLHcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9636E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeJWT3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:29:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34800 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeJWT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:29:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so11347473wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=uHM+jdir1+RuR9Iypy3fFskkuv084yO+HT5lt28JMiI=;
        b=iFVXLHcJlVzJ5CH7K55cLxaJYitVWResQJQrzxh/okhMs9lUfpw/0ahHzvAVHtwIGr
         w6pPoovrXkfG81oCgO75SQwMghsApqSdPUlsyOiT/MSu+AzzEWKsFPO+bdXtqbkdkpqR
         wP4FYXG/mbJcNNdVt7/G7uISzHrzjTwEKuR7dBWlpzJ4mfA3wXZkb2yuGz8DvpBEb9iG
         CJ89HuDGdSW5SQvN/2n7iKrHjbxCxuF+MziX/iptVOFnMY6O+22Cyrl5AW/kqSzkzkqD
         xh+Uj3As7enRXXWE2fBURvkzsID+mE6d/ZYH7xamL8PConGZa1MEx0mWeWZFT10NiGO3
         9aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=uHM+jdir1+RuR9Iypy3fFskkuv084yO+HT5lt28JMiI=;
        b=lm6PnLb5E3j5ugnw563uPtR1AWs5y8OT005smRyppqt4N1yUyVMp1gTxSmadPnQTod
         uL5PTgdQDSSrqHLMIhRuE7qned72243e2SNrTGPHc1qEC9NeVsF5SAr5CmaL9OwNPl++
         FnHDe9whjKjDZh+oUEZQBYfekhJhh01XlDUKF/szNf816mGOiZHDdrEO0jJKc4mu2aph
         9MuR+QVjp6rDe2GDM8qJMGakMIHiInQXrykmAttAGIJcCsEnqdWx2bM/jm/ylEXihZ69
         3o/a9OXbdEER/nT77LfSEcnw16Vt1rk5GM1jVODtsOyweO70/zn8JIV/Rt6dRHUqXpcV
         TUBg==
X-Gm-Message-State: ABuFfojLXt7khCyuTX9duvV+dwU83ylxdnDKBTa36yeSY4b5ylHf/s+B
        WomSjNHeFTEEidA+8WbzVtk=
X-Google-Smtp-Source: ACcGV60xM7DOexNqnhz9sBlDTzLEHyaHHlLBCHD82GQX9+HJPqX76rlvtFJk7G3y2d/25K5j63eKMw==
X-Received: by 2002:a1c:b605:: with SMTP id g5-v6mr18978470wmf.97.1540292763410;
        Tue, 23 Oct 2018 04:06:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c24-v6sm1889354wre.44.2018.10.23.04.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:06:02 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:06:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler updates for v4.20
Message-ID: <20181023110600.GA43785@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

   # HEAD: 11e13696a08e838ba48c72404c2b3f41429b5b20 sched/completions/Documentation: Add recommendation for dynamic and ONSTACK completions

The main changes are:

 - Migrate CPU-intense 'misfit' tasks on asymmetric capacity systems, to 
   better utilize (much) faster 'big core' CPUs.
   (Morten Rasmussen, Valentin Schneider)

 - Topology handling improvements, in particular when CPU capacity 
   changes and related load-balancing fixes/improvements (Morten Rasmussen)

 - ... plus misc other improvements, fixes and updates.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      cpu/SMT: State SMT is disabled even with nosmt and without "=force"

Chris Redpath (1):
      sched/fair: Don't move tasks to lower capacity CPUs unless necessary

Dietmar Eggemann (2):
      sched/fair: Disable LB_BIAS by default
      sched/fair: Remove setting task's se->runnable_weight during PELT update

Ingo Molnar (1):
      sched/completions/Documentation: Clean up the document some more

John Garry (1):
      sched/completions/Documentation: Fix a couple of punctuation nits

Morten Rasmussen (9):
      sched/topology: Add SD_ASYM_CPUCAPACITY flag detection
      sched/topology, drivers/base/arch_topology: Rebuild the sched_domain hierarchy when capacities change
      sched/topology, arch/arm64: Rebuild the sched_domain hierarchy when the CPU capacity changes
      sched/topology, arch/arm: Rebuild sched_domain hierarchy when CPU capacity changes
      sched/topology: Add static_key for asymmetric CPU capacity optimizations
      sched/fair: Add 'group_misfit_task' load-balance type
      sched/fair: Add sched_group per-CPU max capacity
      sched/fair: Consider misfit tasks when load-balancing
      sched/core: Disable SD_PREFER_SIBLING on asymmetric CPU capacity domains

Nicholas Mc Guire (1):
      sched/completions/Documentation: Add recommendation for dynamic and ONSTACK completions

Peter Zijlstra (1):
      sched/debug: Explicitly cast sched_feat() to bool

Rafael J. Wysocki (1):
      sched/core: Fix comment regarding nr_iowait_cpu() and get_iowait_load()

Uwe Kleine-König (1):
      sched/debug: Use symbolic names for task state constants

Valentin Schneider (5):
      sched/fair: Kick nohz balance if rq->misfit_task_load
      sched/fair: Change 'prefer_sibling' type to bool
      sched/core: Change root_domain->overload type to int
      sched/fair: Wrap rq->rd->overload accesses with READ/WRITE_ONCE()
      sched/fair: Set rq->rd->overload when misfit

Vincent Guittot (3):
      sched/numa: Remove unused code from update_numa_stats()
      sched/numa: Remove unused numa_stats::nr_running field
      sched/pelt: Fix warning and clean up IRQ PELT config

zhong jiang (1):
      sched/topology: Make local variables static

