Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3170FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A71208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A71208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964816AbeFMMSc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:18:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39431 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935273AbeFMMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:17:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id w7-v6so2522688wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRYvMb4AaSuggbLT60uXuONVk/kchUT0e/4Fx3rF52E=;
        b=aGhFfo57Xc34bVxrE5pg0Y0o3yltYbF1uu5wbEFuWOGvbHYQU8Z8MzgVTDGQs9ofrM
         rCA8MUCM9gbhxE6JJwCZzkySEqSvXBtoDGkSzw8pCswR+ITa78VUAyDQdxC9UyeyHmpM
         9Fuf/BH+vle3KXNEPFTpFcKoHe+lgw994tDcsEuNW+k4AczFYjZ4LrDBd1jdju6rvuBh
         Q/4q6NaV0etYgxDESjBF41Pl8KUVvUXCKfPBNXxlDAWXjYOL4udwWK2yQ30uFsssGqZG
         SK/ojpTpCI9rxEYScC+b59fp8tx9VFbrkDYKqAsedgqfTcuuGIR5b2xpRaSiaVWjJT2q
         xCHQ==
X-Gm-Message-State: APt69E0VXekRBpqv1eDj1LoesdxeOBaUe/03FZqIR+LhkeSkehuZ1Rz+
        Yl7E8tWFZ6m0xON5AHHK3bqaLA==
X-Google-Smtp-Source: ADUXVKJ4pLbhXsTuaq+Ee/rNVG3pGmClf0vgTNIIAKeet54ms7fDBRKyNyDvxOywkvwRv7X7ocI1LQ==
X-Received: by 2002:adf:9405:: with SMTP id 5-v6mr4351936wrq.283.1528892247561;
        Wed, 13 Jun 2018 05:17:27 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id 137-v6sm4943673wmv.28.2018.06.13.05.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:17:26 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v4 1/5] sched/topology: Add check to backup comment about hotplug lock
Date:   Wed, 13 Jun 2018 14:17:07 +0200
Message-Id: <20180613121711.5018-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180613121711.5018-1-juri.lelli@redhat.com>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

The comment above function partition_sched_domains() clearly state that
the cpu_hotplug_lock should be held but doesn't mandate one to abide to
it.

Add an explicit check backing that comment, so to make it impossible
for anyone to miss the requirement.

Suggested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
[modified changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 61a1125c1ae4..96eee22fafe8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1858,6 +1858,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	int i, j, n;
 	int new_topology;
 
+	lockdep_assert_cpus_held();
 	mutex_lock(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
-- 
2.14.3

