Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE9FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FB8262D7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIDp9hDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FB8262D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeF0L3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752063AbeF0L3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:29:40 -0400
Received: from localhost (LFbn-NCY-1-193-82.w83-194.abo.wanadoo.fr [83.194.41.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F827262C8;
        Wed, 27 Jun 2018 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530098979;
        bh=9cKcjtTUr9r9vDvIynHgoGZdEkfTT8F5BJN5GXji3D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIDp9hDYlF6YBV/hWoKBLmFBN1Sw4+qw3H7WXQDLmhRPJiyJ/a0zyp47iHHbozvLZ
         IlNvTOiauizX84xft+2I57R9DbmbcHDTYmXmjdm9ssLCuXvMoCM+4NUax5Slg1mouc
         1Ip570iqpzNf29MyHZms268kvYBfJb2Fl68/2egE=
Date:   Wed, 27 Jun 2018 13:29:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: sched/core warning triggers on rcu torture test
Message-ID: <20180627112935.GC10102@lerouge>
References: <alpine.DEB.2.21.1806261709001.19188@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806261709001.19188@somnus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 06:16:04PM +0200, Anna-Maria Gleixner wrote:
> Hi,
> 
> during rcu torture tests (TREE04 and TREE07) I noticed, that a
> WARN_ON_ONCE() in sched core triggers on a recent 4.18-rc2 based
> kernel (6f0d349d922b ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")) as well as
> on a 4.17.3.
> 
> I'm running the tests on a machine with 144 cores:
> 
>   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "9*TREE07"
>   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "18*TREE04"
> 
> 
> The warning was introduced by commit d84b31313ef8 ("sched/isolation:
> Offload residual 1Hz scheduler tick").
> 
> 
> Output looks similar for all tests I did (this one is the output of
> the 4.18-rc2 based kernel):
> 
> WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0
> Modules linked in:
> CPU: 11 PID: 906 Comm: kworker/u32:3 Not tainted 4.18.0-rc2+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Workqueue: events_unbound sched_tick_remote
> RIP: 0010:sched_tick_remote+0xb6/0xc0
> Code: e8 0f 06 b8 00 c6 03 00 fb eb 9d 8b 43 04 85 c0 75 8d 48 8b 83 e0 0a 00 00 48 85 c0 75 81 eb 88 48 89 df e8 bc fe ff ff eb aa <0f> 0b eb c5 66 0f 1f 44 00 00 bf 17 00 00 00 e8 b6 2e fe ff 0f b6
> Call Trace:
>  process_one_work+0x1df/0x3b0
>  worker_thread+0x44/0x3d0
>  kthread+0xf3/0x130
>  ? set_worker_desc+0xb0/0xb0
>  ? kthread_create_worker_on_cpu+0x70/0x70
>  ret_from_fork+0x35/0x40
> ---[ end trace 7c99b83eb0ec64e8 ]---
> 
> 
> Do you need some more information?
> 
> 
> Thanks,
> 
> 	Anna-Maria


Ok so now I reproduce it immediately after the boot, time for me to debug :-)

Thanks.
