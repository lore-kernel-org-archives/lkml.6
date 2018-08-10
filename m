Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EFDC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF63622448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ryxz3LZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF63622448
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeHJTmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:42:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44987 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbeHJTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:42:40 -0400
Received: by mail-qt0-f193.google.com with SMTP id b15-v6so10960725qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BYfEQDr68iH+R3gG31Q32XvSo83Zkp2kexYYaePl+B8=;
        b=Ryxz3LZkQ4w4GAeFC7WXHKd4MmpbO4KPtYzNbhrHZiwVfhTouFMUDWgn2T3eQGgg7Q
         sC5BSoR9Qpoxd2bsza+IdVUor3bjHKhm0qAKBf3dLMAxu1qMh+ib45Y6rDV60up2gJl+
         /HgQAelXXKYc5PbEP6tjMU2MAdBe9tRVUcJDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BYfEQDr68iH+R3gG31Q32XvSo83Zkp2kexYYaePl+B8=;
        b=S8uhiIAer7kbhwXFkWfXn3XMsWh0d+BWONAAk/lpdCGLPwf23k64W6E7ENLtM8XYLI
         Rz3xSO50Xcl2o5Fbd+VmfmgCSy4RmQKAexHvts9hT/GRDtMarAOcoyyPmhdMC2m/n2kg
         YkSaoLl1uJT4XTxARaDSH3q4YhH7jKWrlSQYx2iEEB1BwSB3fG0YAqk0lVa24OfvhByY
         EC8M5ciWFIFlGlCfd3SGQ9tGkJtmfv09WGD2VncjzgjY0Iar0tmCLOQammghbXSLHkhp
         v0OXKQsse+FuXCI6TEwnm2Ii9bNK8DG8ICeCCrUGp5OxcRThtNs2XalNSw1H1J++1tqJ
         LdWQ==
X-Gm-Message-State: AOUpUlFkyI20HxwD8Fx/CeV38D6iedpmrVOqnzADhLr5ZdQ/BdTEMICj
        3EEJnRAm+/JuViEJmh2aR2YwOK08x3jfiV5SiYUl6/K2
X-Google-Smtp-Source: AA+uWPw5qbWIqCiijotLIQ7jcsuHKJk0lL2na4BRJQXJTp74vRpaXep00P4oIF+rDNIpELKnL80A1My6hHwEcZdkNSI=
X-Received: by 2002:aed:24b0:: with SMTP id t45-v6mr7335928qtc.86.1533921116261;
 Fri, 10 Aug 2018 10:11:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3442:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 10:11:55
 -0700 (PDT)
In-Reply-To: <20180810123042.51ceddb9@gandalf.local.home>
References: <20180810123042.51ceddb9@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 10 Aug 2018 10:11:55 -0700
Message-ID: <CAEXW_YQPFOrxd_jvHaKF=9gzHd6f=7MLTtkf_VxQXtDxt9Q_dA@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracepoints: Free early tracepoints after RCU is initialized
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 9:30 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> When enabling trace events via the kernel command line, I hit this warning:
>
> WARNING: CPU: 0 PID: 13 at kernel/rcu/srcutree.c:236 check_init_srcu_struct+0xe/0x61
> Modules linked in:
> CPU: 0 PID: 13 Comm: watchdog/0 Not tainted 4.18.0-rc6-test+ #6
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> RIP: 0010:check_init_srcu_struct+0xe/0x61
> Code: 48 c7 c6 ec 8a 65 b4 e8 ff 79 fe ff 48 89 df 31 f6 e8 f2 fa ff ff 5a
> 5b 41 5c 5d c3 0f 1f 44 00 00 83 3d 68 94 b8 01 01 75 02 <0f> 0b 48 8b 87 f0
> 0a 00 00 a8 03 74 45 55 48 89 e5 41 55 41 54 4c
> RSP: 0000:ffff96eb9ea03e68 EFLAGS: 00010246
> RAX: ffff96eb962b5b01 RBX: ffffffffb4a87420 RCX: 0000000000000001
> RDX: ffffffffb3107969 RSI: ffff96eb962b5b40 RDI: ffffffffb4a87420
> RBP: ffff96eb9ea03eb0 R08: ffffabbd00cd7f48 R09: 0000000000000000
> R10: ffff96eb9ea03e68 R11: ffffffffb4a6eec0 R12: ffff96eb962b5b40
> R13: ffff96eb9ea03ef8 R14: ffffffffb3107969 R15: ffffffffb3107948
> FS:  0000000000000000(0000) GS:ffff96eb9ea00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff96eb13ab2000 CR3: 0000000192a1e001 CR4: 00000000001606f0
> Call Trace:
>  <IRQ>
>  ? __call_srcu+0x2d/0x290
>  ? rcu_process_callbacks+0x26e/0x448
>  ? allocate_probes+0x2b/0x2b
>  call_srcu+0x13/0x15
>  rcu_free_old_probes+0x1f/0x21
>  rcu_process_callbacks+0x2ed/0x448
>  __do_softirq+0x172/0x336
>  irq_exit+0x62/0xb2
>  smp_apic_timer_interrupt+0x161/0x19e
>  apic_timer_interrupt+0xf/0x20
>  </IRQ>
>
> The problem is that the enabling of trace events before RCU is set up will
> cause SRCU to give this warning. To avoid this, add a list to store probes
> that need to be freed till after RCU is initialized, and then free them
> then.
>
> Link: http://lkml.kernel.org/r/20180810113554.1df28050@gandalf.local.home
>
> Fixes: e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use SRCU")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
