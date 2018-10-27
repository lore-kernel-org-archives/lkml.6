Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3974C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 23:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990B92075D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 23:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990B92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeJ1IIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 04:08:12 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44483 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbeJ1IIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 04:08:12 -0400
Received: by mail-ot1-f41.google.com with SMTP id p23so4326349otf.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 16:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3XGhtQa0ffhtNI6zR5OcePdWUQ4i2+7y34CEZmM2VmE=;
        b=ijMCilJXlhCw7Nwpy922AKUn9TGUQOf6ZFXbLzTa+85yHzWftFAy+WKdwEzOfUp6Cl
         iBK2BXC7LH+qJzBuQxkuOpsZC0/nEoCyBSVLWxK0od8WhYPhLAIqd/72ndXmGZFY8GJq
         qtjzh/yk5g2HjjxEQmUNoxom6JfcCzJeNx2t66acdmx4oX7rcGNArLNKPGgR5hgN1TX9
         b5XSE3TxPqRw3zKRcbOw+vVhZlpB4TIlBkdZ3AwICt4fhJhdRC7ZF3Qf34kB+/MfuAJM
         SuWExltbXadLOHsENGgd7JrsiksI3ED+XKb3WO/jBst+qaMJU6ZEhJOasEYyqvJr8bpg
         5aoQ==
X-Gm-Message-State: AGRZ1gIaRjBxTRCvGaOTLkFzS1wN6BsJDJeqk9TeRepOQU1w8ul45FMZ
        SoVYgNp3fgFXWvWLrY8rnuAX3x13RQ5zNsfZt6e5yA==
X-Google-Smtp-Source: AJdET5cA0gQd2JRFZ6vVOjXDALvLVE5qMUuhQzr1EzmADoK6VRD8ssD5D56DulzggXx4s4VxXicBzxjc3f9OXkeY5Sc=
X-Received: by 2002:a9d:1ea5:: with SMTP id n34mr5208354otn.160.1540682735152;
 Sat, 27 Oct 2018 16:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:479b:0:0:0:0:0 with HTTP; Sat, 27 Oct 2018 16:25:34
 -0700 (PDT)
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Sun, 28 Oct 2018 01:25:34 +0200
Message-ID: <CAE4VaGA2vDxbn3EuaVvjrLAQSe6rkv7OEmQmtQ=CYkPQkbPwBg@mail.gmail.com>
Subject: Group Imbalance Bug - performance drop by factor 10x on NUMA boxes
 with cgroups
To:     Mel Gorman <mgorman@techsingularity.net>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel and Srikar,

I would like to ask you if you could look into the Group Imbalance Bug
described in this paper

http://www.ece.ubc.ca/~sasha/papers/eurosys16-final29.pdf

in chapter 3.1. See also comment [1]. The paper describes the bug on
workload which involves different ssh sessions and it assumes
kernel.sched_autogroup_enabled=1. We have found out that it can be
reproduced more easily with cgroups.

Reproducer consists of this workload
* 2 separate "stress --cpu 1" processes. Each stress process needs 1 CPU.
* NAS benchmark (https://www.nas.nasa.gov/publications/npb.html) from
which I use lu.C.x binary (Lower-Upper Gauss-Seidel solver) in the
Open Multi-Processing (OMP) mode.

We run the workload in two modes:

NORMAL - both stress and lu.C.x are run in the same control group
GROUP  - each binary is run in a separate control group:
stress, first instance: cpu:test_group_1
stress, seconds instance: cpu:test_group_2
lu.C.x : cpu:test_group_main

I run lu.C.x with a different number of threads - for example on 4
NUMA server with 4x Xeon Gold 6126 CPU (total 96 CPUs) - I run lu.C.x
with 72, 80, 88, and 92 threads. Since the server has 96 CPUs in
total, even with 92 threads for lu.C.x and two stress processes server
is still not fully loaded.

Here are the runtimes in seconds for lu.C.x for different number of threads

#Threads  NORMAL GROUP
72             21.27        30.01
80             15.32         164
88             17.91         367
92             19.22         432

As you can see, already for 72 threads lu.C.x is significantly slower
when executed in dedicated cgroup. And it gets much worse with an
increasing number of threads (slowdown by the factor 10x and greater).

Some more details are below.

Please let me know if it sounds interesting and if you would like to
look into it. I can provide you with the reproducer plus some
supplementary python scripts to further analyze the results.

Thanks a lot!
Jirka

Some more details on the case with 80 threads for lu.C.x, 2 stress
processes run  on 96 CPUs server with 4 NUMA nodes.

Analyzing ps output is very interesting (here for 5 subsequent runs of
the workload):
========================================================
Average number of threads scheduled for NUMA NODE  0      1      2      3
========================================================
lu.C.x_80_NORMAL_1.ps.numa.hist         Average    21.25  21.00  19.75  18.00
lu.C.x_80_NORMAL_1.stress.ps.numa.hist  Average    1.00  1.00
lu.C.x_80_NORMAL_2.ps.numa.hist         Average    20.50  20.75  18.00  20.75
lu.C.x_80_NORMAL_2.stress.ps.numa.hist  Average    1.00  0.75  0.25
lu.C.x_80_NORMAL_3.ps.numa.hist         Average    21.75  22.00  18.75  17.50
lu.C.x_80_NORMAL_3.stress.ps.numa.hist  Average    1.00  1.00
lu.C.x_80_NORMAL_4.ps.numa.hist         Average    21.50  21.00  18.75  18.75
lu.C.x_80_NORMAL_4.stress.ps.numa.hist  Average    1.00  1.00
lu.C.x_80_NORMAL_5.ps.numa.hist         Average    18.00  23.33  19.33  19.33
lu.C.x_80_NORMAL_5.stress.ps.numa.hist  Average    1.00  1.00


As you can see, in NORMAL mode lu.C.x is uniformly scheduled over NUMA nodes.

Compare it with cgroups mode:
========================================================
Average number of threads scheduled for NUMA NODE  0      1      2      3
========================================================
lu.C.x_80_GROUP_1.ps.numa.hist         Average    13.05  13.54  27.65  25.76
lu.C.x_80_GROUP_1.stress.ps.numa.hist  Average    1.00  1.00
lu.C.x_80_GROUP_2.ps.numa.hist         Average    12.18  14.85  27.56  25.41
lu.C.x_80_GROUP_2.stress.ps.numa.hist  Average    1.00  1.00
lu.C.x_80_GROUP_3.ps.numa.hist         Average    15.32  13.23  26.52  24.94
lu.C.x_80_GROUP_3.stress.ps.numa.hist  Average    1.00  1.00
lu.C.x_80_GROUP_4.ps.numa.hist         Average    13.82  14.86  25.64  25.68
lu.C.x_80_GROUP_4.stress.ps.numa.hist  Average    1.00  1.00
lu.C.x_80_GROUP_5.ps.numa.hist         Average    15.12  13.03  25.12  26.73
lu.C.x_80_GROUP_5.stress.ps.numa.hist  Average    1.00  1.00

In cgroup mode, the scheduler is moving lu.C.x away from the nodes #0
and #1 where stress processes are running. It does it to such extent
that NUMA nodes #2 and #3 are overcommitted - these NUMA nodes have
more NAS threads scheduled than CPUs available - there are 24 CPUs in
each NUMA node.

Here is the detailed report:
$more lu.C.x_80_GROUP_1.ps.numa.hist
#Date                   NUMA 0  NUMA 1  NUMA 2  NUMA 3
2018-Oct-27_04h39m57s    6       7       37      30
2018-Oct-27_04h40m02s    16      15      23      26
2018-Oct-27_04h40m08s    13      12      27      28
2018-Oct-27_04h40m13s    9       15      29      27
2018-Oct-27_04h40m18s    16      13      27      24
2018-Oct-27_04h40m23s    16      14      25      25
2018-Oct-27_04h40m28s    16      15      24      25
2018-Oct-27_04h40m33s    10      11      34      25
2018-Oct-27_04h40m38s    16      13      25      26
2018-Oct-27_04h40m43s    10      10      32      28
2018-Oct-27_04h40m48s    12      16      26      26
2018-Oct-27_04h40m53s    13      11      30      26
2018-Oct-27_04h40m58s    13      14      28      25
2018-Oct-27_04h41m03s    11      15      28      26
2018-Oct-27_04h41m08s    13      15      28      24
2018-Oct-27_04h41m13s    14      17      25      24
2018-Oct-27_04h41m18s    14      17      24      25
2018-Oct-27_04h41m24s    13      12      28      27
2018-Oct-27_04h41m29s    11      12      30      27
2018-Oct-27_04h41m34s    13      15      26      26
2018-Oct-27_04h41m39s    13      15      27      25
2018-Oct-27_04h41m44s    13      15      26      26
2018-Oct-27_04h41m49s    12      7       36      25
2018-Oct-27_04h41m54s    14      13      27      26
2018-Oct-27_04h41m59s    16      13      25      26
2018-Oct-27_04h42m04s    15      14      26      25
2018-Oct-27_04h42m09s    16      12      26      26
2018-Oct-27_04h42m14s    12      15      27      26
2018-Oct-27_04h42m19s    13      15      26      26
2018-Oct-27_04h42m24s    14      15      26      25
2018-Oct-27_04h42m29s    14      15      26      25
2018-Oct-27_04h42m34s    8       11      36      25
2018-Oct-27_04h42m39s    13      14      28      25
2018-Oct-27_04h42m45s    13      16      26      25
2018-Oct-27_04h42m50s    13      16      27      24
2018-Oct-27_04h42m55s    13      16      26      25
2018-Oct-27_04h43m00s    16      10      26      28
Average                  13.05   13.54   27.65   25.76

Please notice that NODEs #3 and #4 have SIGNIFICANTLY (upto 36!!) more
threads scheduled than the number of available CPUs (24) while nodes
#0 and #1 have plenty of idle cores. I think that this is the best
illustration of the Group Imbalance bug - some cores are overcommitted
while others cores are idle and this disbalance is not getting any
better over time.


[1]
There are four bugs described in the paper. I have actively worked
over past two years on all of them; this is the current status: Group
Construction bug and Missing Scheduling Domains bugs are fixed. I was
not able to reproduce Overload on Wakeup bug (despite great effort). I
have created reproducer for the Group Imbalance Bug using the cgroups,
but it seems there is no easy fix.)
