Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56233C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F405920832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2//ZgiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F405920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeK2JEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:04:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44340 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2JEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:04:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so7394007pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7aj3LJl/otFhIEi9eRonY/qXn3nkgbWFEKET08mBECw=;
        b=j2//ZgiJUWr5rpEUo9ivQshZmZbLAU665/2VlD/AG2hMmzIFFXAJ2A6uuiKt55QF9Z
         U0yoyfkSC8y/LYUVQmfGWn68r9+ScyzAvFlQ1xI9w2VJgmYtvbmJIKvvXm61752+w/y8
         xnXpqaLZWvStAeOiuDjQyBtcE7thE/b9eoJ+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7aj3LJl/otFhIEi9eRonY/qXn3nkgbWFEKET08mBECw=;
        b=EBH5Fu0gXJMJJLIh8uUfq+fsDuJNRbLPDS2x3x7JKR4t255SpJjugBdnl+dPGSz1lb
         hlE3reu1sv5GJg7oY3MqIGYnzHip28SwhrXK92ZGUzNDfRwfHOaW78ospO+qZXYqVJWI
         xu3KRyg4gDGFEgZVm0keQLLaDxR2wGbY6tXSJwX7jMydaL6OO/03CtQoFGy10A2SW3U+
         BW548CmlkOtYKMPqPp/fIk6jX4OU8uh4dccCrLSMjDCVrP5KZD0X6yvrcuEzRYOE/Ega
         a+Bv6oRToMqXO6Pa0VbyM0l5axjIiQg/LxEyVttO9zOyyDTV+xvIVSgQ7BFzzA08VLuy
         jiaA==
X-Gm-Message-State: AA+aEWbosXEg6McqAOtPaFvucQa1G41cRN763Cye+j7wc8Yk8aoUpjwa
        74lFZHryI9+KmDl0szuS00VvCw==
X-Google-Smtp-Source: AFSGD/WKkpX1MX45VwfMDgqmEEiYCgeOwNXpjNm/SKpsZZTC83u6esIlb1gW8zzITO3gZ8pyu4OXMQ==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr39017356pld.181.1543442480554;
        Wed, 28 Nov 2018 14:01:20 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 12sm8698051pgd.35.2018.11.28.14.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:01:19 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/6] perf: Add ioctl for PMU driver configuration 
Date:   Wed, 28 Nov 2018 15:01:12 -0700
Message-Id: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth iteration of a set that adds the capability to communicate
event specific configuration to PMU kernel drivers using an ioctl().  Though
targeted at the identification of CoreSight sinks when operating in CPU-wide
trace scenarios the functionality is made generic enough for anyone to use.

The work fits in a wider scheme to support CPU-wide trace scenarios on CoreSight
that is available here[1].  If someone is to test the functionality using this 
branch, note that only dumping of CPU-wide trace data is working.  Full decoding
capability is being verified.

Patch 1 to 3 deal with kernel enhancement to the perf core while patch 4 is
CoreSight specific.  Patches 5 and 6 concentrate on the perf tools.

# Before this set: 

root@juno:/home/linaro# perf record -e cs_etm/@20070000.etr/ -C 2,3 sleep 1
failed to mmap with 12 (Cannot allocate memory)

# After this set:

root@juno:/home/linaro# perf record -e cs_etm/@20070000.etr/ -C 2,3 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.145 MB perf.data ]


Thanks,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/log/?h=cpu-wide-coresight 

---
Changes for V4:
. Made passing of information between ioctl() and PMU simpler.
. Rebased to 4.20-rc4


Mathieu Poirier (6):
  perf: Introduce ioctl to communicate driver configuration to kernel
  perf/core: Use ioctl to communicate driver configuration to kernel
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: Use PMU driver configuration for sink selection
  perf tools: Make perf_evsel accessible to PMU driver configuration
    code
  perf tools: Use ioctl function to send sink configuration to kernel

 arch/s390/kernel/perf_cpum_sf.c                  |  6 +--
 arch/x86/events/intel/bts.c                      |  4 +-
 arch/x86/events/intel/pt.c                       |  5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 64 ++++++++++++++++------
 drivers/perf/arm_spe_pmu.c                       |  6 +--
 include/linux/perf_event.h                       | 40 +++++++++++++-
 include/uapi/linux/perf_event.h                  |  1 +
 kernel/events/core.c                             | 69 ++++++++++++++++++++++++
 kernel/events/ring_buffer.c                      |  2 +-
 tools/include/uapi/linux/perf_event.h            |  1 +
 tools/perf/arch/arm/util/cs-etm.c                | 67 ++++++++++++++++++++++-
 tools/perf/arch/arm/util/cs-etm.h                |  3 +-
 tools/perf/util/drv_configs.c                    | 30 +++--------
 tools/perf/util/evsel.c                          |  7 +++
 tools/perf/util/evsel.h                          |  1 +
 tools/perf/util/pmu.h                            |  3 +-
 16 files changed, 257 insertions(+), 52 deletions(-)

-- 
2.7.4

