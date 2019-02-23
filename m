Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE432084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qsnmM+tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfBWGew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:34:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44802 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfBWGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:34:51 -0500
Received: by mail-qk1-f193.google.com with SMTP id r21so2467200qkl.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZPXrhRn9IM7/mDZO/dEG8SNIp0XQzzuRffsSWdXti4=;
        b=qsnmM+tct+fgfu/vlgLGEIJPlGi2rIdsBE5znz16lhw2+SCqf6T24bz3WHyLvApaHJ
         O9GsHP/xCYA4VMVUhu/eNXnATeybrZH0iuoKkKELAry7Mt4q/CUrgx2DXV8sJhOy5FuH
         nJsPMzKoxjgdUkY3V6LBViXbapudw1z5vpdQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZPXrhRn9IM7/mDZO/dEG8SNIp0XQzzuRffsSWdXti4=;
        b=WfL6bZ1WNNz/g6KyAUawkeDxXk++3+72AIh9ulZIvpidhj0mAuUhLpYvN3J+OwJDnp
         sQgHSefAtaZ0EdrsAdgmKKl8cxv4/B8JpOnuCBll0iCE59MO09p7I+hibXaAlUvzH0Fs
         m/8JBhNnZ13uBpehDJqIBxGESVwWH2zL+aTDrx9GqhNDFKQJvWcQrFZlF5hBTr2/SALF
         t4JcdP0iVvqMifmib0priQFdJ633OPm/TPysVuvPv1F5EgxuXN/UwhqiTLA/9zYmmNO6
         xtFZX7EQs+7iHjUgirBjpFkBmFc7VQmtENuM2hwAgdBebxmlrd9Qe4ld2mkBZ1pnkG+h
         VvwA==
X-Gm-Message-State: AHQUAuZkQ9kCeWD/PNL+PnCLy44tQ2ORZRgfEZ0dV6COVRxLC+/LAOOm
        iBhncIKXVazuECSmyCG2/Bt3khxvzpI=
X-Google-Smtp-Source: AHgI3IZAv5oBDCvRHQZTZtHlN92W9LAJA8xKIMsIky7TQzQqSbTSj0qWYk7MeaVsEhML0ZMwnerO+w==
X-Received: by 2002:a05:620a:13af:: with SMTP id m15mr5760550qki.198.1550903689958;
        Fri, 22 Feb 2019 22:34:49 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d32sm2189408qtc.88.2019.02.22.22.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:34:48 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 0/6] RCU fixes for rcu_assign_pointer() usage
Date:   Sat, 23 Feb 2019 01:34:28 -0500
Message-Id: <20190223063434.6793-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix various sparse errors found as a result of the recent check
to add rcu_check_sparse() to rcu_assign_pointer().  The errors in some cases
seem to either missing API usage, or missing annotations. The annotations added
in the series can also help avoid future incorrect usages and bugs so it is a
good idea to do in any case.

RFC v1 -> Patch v2:
Made changes to various scheduler patches (Peter Zijlstra)

Joel Fernandes (Google) (6):
net: rtnetlink: Fix incorrect RCU API usage
ixgbe: Fix incorrect RCU API usage
sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu
sched_domain: Annotate RCU pointers properly
rcuwait: Annotate task_struct with __rcu
sched: Annotate perf_domain pointer with __rcu

drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++--
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 ++++++++++-----
include/linux/rcuwait.h                       |  2 +-
include/linux/sched/topology.h                |  4 ++--
kernel/sched/cpufreq.c                        |  2 +-
kernel/sched/sched.h                          | 18 +++++++++---------
kernel/sched/topology.c                       | 10 +++++-----
net/core/rtnetlink.c                          |  4 ++--
8 files changed, 32 insertions(+), 27 deletions(-)

--
2.21.0.rc0.258.g878e2cd30e-goog

