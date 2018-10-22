Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE9C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B4A20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B4A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJVPa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:30:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45140 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbeJVPa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:30:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id s3-v6so5374275pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 00:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs3YbkCsACHgrOrnt/lFGxBwk0qJv2SFVnezPfy1QL0=;
        b=lcupcTe4ClCdV+fcCp0OzqMfbVfZJCKgtjs9+ZdZELqJR4uMvkjgry/o7fhz4iqa+S
         G/mxO7ul5981sLwDsKmOCxkKcUIz58jD677/IfbAqx7Q/BCtxeFgE1JjuK6Iqsnh7bup
         gcXSv70uhxh6YEsoIGFAk3/Me9piX/hNAbqleivwv8tx4rabJQNXo8Sge2Wwkz2vKg8n
         JEw7j5AwuGrtZ4LhRjyCjeskixUrZr+o3dvbIJAKF9h5QFhf/3JhlLxYBzEWbuKRWZg9
         LYIwMtLYAGugs7VV1jxCQjjmAh8Judl0DL8oForVwjm+ZfchnRrk3fprSQH5Sro7jpjC
         s1NA==
X-Gm-Message-State: AGRZ1gK1JLHYVRZeBaIg7hiprBr3G/HoNeum4LbB9FT98VyCJyAVGcSh
        W9xc65alI1jZM9aXuxtM2B4=
X-Google-Smtp-Source: AJdET5dT+wKg92h18/DCxcwlslfCxt/6wcm+RiDImOTChsOvJziT0vhyjqKvrCfhf3aSTIjrgzEVDQ==
X-Received: by 2002:a63:d705:: with SMTP id d5-v6mr7343141pgg.27.1540192419965;
        Mon, 22 Oct 2018 00:13:39 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c79-v6sm38097542pfc.92.2018.10.22.00.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 00:13:38 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
Date:   Mon, 22 Oct 2018 09:13:21 +0200
Message-Id: <20181022071323.9550-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this is a follow up for [1] which has been nacked mostly because Tetsuo
was able to find a simple workload which can trigger a race where
no-eligible task is reported without a good reason. I believe the patch2
addresses that issue and we do not have to play dirty games with
throttling just because of the race. I still believe that patch proposed
in [1] is a useful one but this can be addressed later.

This series comprises 2 patch. The first one is something I meant to do
loooong time ago, I just never have time to do that. We need it here to
handle CLONE_VM without CLONE_SIGHAND cases. The second patch closes the
race.

I didn't get to test this throughly so it is posted as an RFC.

Feedback is appreciated of course.

[1] http://lkml.kernel.org/r/20181010151135.25766-1-mhocko@kernel.org


