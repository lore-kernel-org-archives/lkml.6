Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5D2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99B020840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRE3e+cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99B020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKIR3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:29:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34469 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKIR3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:29:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so843361wre.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 23:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZUHX1+rp5kaju6rV5UcvjXo+abHHVcV7SRvKzxKKBpg=;
        b=BRE3e+cgM4YcrvTx9s7248PEfO1TbDHRtir9Kk/3kdnRS7cJdZ49wBegutLIvcU7Sl
         PBcqPw0hChnkyTewUYYJiqGCUWu52RSZHF9t2vm1awgkmWlJZpjfcaLtt0CVdw7XaAbk
         N/iRkkAlWnInx0v7JSzyC6c8HBC6DvElYQJXl/erpQN8AyAyMh8bfoaaMW9tXwp5bG3n
         FeN9fEO3MZcCeClHMJFODLEJMx8aN2ogYt+las75lkNVTBDa6egAJvJDHo0k7wHZisqv
         XosiYXwiKYNf/Ps8b4WZu1kaOen9us9FW8O5aNf4TgXYAra1XlsZMT6yqwTOufS0hMAY
         5bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUHX1+rp5kaju6rV5UcvjXo+abHHVcV7SRvKzxKKBpg=;
        b=Fv5Rt8A1o83Odqzd3L0HonVfZsD0EruF6A4WfxLBef0dldsWtm9tcyT4QsesImFbwy
         0dxxyf4faGF97HKT52315MuJpGdetCJQqTxlypodNUwSLpqDlz1mWg8omN46SqMBJ862
         38W8/EoLf55Ji5COMRWkTQnB71/MHRpf6zkNoGFh9B4IAAdiQieLibDKr9OZfi8uAWY2
         1cSN9IKIJDrp44lVmqXED0jpi+D+FBOoOlM8Ka16mIGgksbJYNwR2JKK7BGfMMupuunV
         3oV5eavRgmvI8K48w65GP6gXzwfo/2V9MZ1oJneZVSZg/Irx0ZY0kKicfcH2GfAJPT5N
         9K4A==
X-Gm-Message-State: AGRZ1gJL33I0ReZRb07aRkI3ovqH7roXPs6G5UblrX37Dbtop3fnoV97
        xTlPc40V+puIyvbg1JJRASY=
X-Google-Smtp-Source: AJdET5cc0de0PLFk+IrSV77XGILdWYw+lKj+KPMdJzXNIbPBiDDRg1ZHzPim4sL4R7b3Dvwvxy7iZw==
X-Received: by 2002:adf:b1db:: with SMTP id r27-v6mr6912349wra.95.1541749811865;
        Thu, 08 Nov 2018 23:50:11 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r188-v6sm782926wmg.19.2018.11.08.23.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 23:50:11 -0800 (PST)
Date:   Fri, 9 Nov 2018 08:50:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181109075008.GA80302@gmail.com>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109072811.GB86700@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > - Does this feature have much value without retpolines?  If not, should
> >   we make it depend on retpolines somehow?
> 
> Paravirt patching, as you mention in your later reply?

BTW., to look for candidates of this API, I'd suggest looking at the 
function call frequency of my (almost-)distro kernel vmlinux:

  $ objdump -d vmlinux | grep -w callq | cut -f3- | sort | uniq -c | sort -n | tail -100

which gives:

    502 callq  ffffffff8157d050 <nla_put>
    522 callq  ffffffff81aaf420 <down_write>
    536 callq  ffffffff81547e60 <_copy_to_user>
    615 callq  ffffffff81a97700 <snprintf>
    624 callq  *0xffffffff82648428
    624 callq  ffffffff810cc810 <__might_sleep>
    625 callq  ffffffff81a93b90 <strcmp>
    649 callq  ffffffff81547dd0 <_copy_from_user>
    651 callq  ffffffff811ba930 <trace_seq_printf>
    654 callq  ffffffff8170b6f0 <_dev_warn>
    691 callq  ffffffff81a93790 <strlen>
    693 callq  ffffffff81a88dc0 <cpumask_next>
    709 callq  *0xffffffff82648438
    723 callq  ffffffff811bdbd0 <trace_hardirqs_on>
    735 callq  ffffffff810feac0 <up_write>
    750 callq  ffffffff8163e9f0 <acpi_ut_status_exit>
    768 callq  *0xffffffff82648430
    814 callq  ffffffff81ab2710 <_raw_spin_lock_irq>
    841 callq  ffffffff81a9e680 <__memcpy>
    863 callq  ffffffff812ae3d0 <__kmalloc>
    899 callq  ffffffff8126ac80 <__might_fault>
    912 callq  ffffffff81ab2970 <_raw_spin_unlock_irq>
    939 callq  ffffffff81aaaf10 <_cond_resched>
    966 callq  ffffffff811bda00 <trace_hardirqs_off>
   1069 callq  ffffffff81126f50 <rcu_read_lock_sched_held>
   1078 callq  ffffffff81097760 <__warn_printk>
   1081 callq  ffffffff8157b140 <__dynamic_dev_dbg>
   1351 callq  ffffffff8170b630 <_dev_err>
   1365 callq  ffffffff811050c0 <lock_is_held_type>
   1373 callq  ffffffff81a977f0 <sprintf>
   1390 callq  ffffffff8157b090 <__dynamic_pr_debug>
   1453 callq  ffffffff8155c650 <__list_add_valid>
   1501 callq  ffffffff812ad6f0 <kmem_cache_alloc_trace>
   1509 callq  ffffffff8155c6c0 <__list_del_entry_valid>
   1513 callq  ffffffff81310ce0 <seq_printf>
   1571 callq  ffffffff81ab2780 <_raw_spin_lock_irqsave>
   1624 callq  ffffffff81ab29b0 <_raw_spin_unlock_irqrestore>
   1661 callq  ffffffff81126fd0 <rcu_read_lock_held>
   1986 callq  ffffffff81104940 <lock_acquire>
   2050 callq  ffffffff811c5110 <trace_define_field>
   2133 callq  ffffffff81102c70 <lock_release>
   2507 callq  ffffffff81ab2560 <_raw_spin_lock>
   2676 callq  ffffffff81aadc40 <mutex_lock_nested>
   3056 callq  ffffffff81ab2900 <_raw_spin_unlock>
   3294 callq  ffffffff81aac610 <mutex_unlock>
   3628 callq  ffffffff81129100 <rcu_is_watching>
   4462 callq  ffffffff812ac2c0 <kfree>
   6454 callq  ffffffff8111a51e <printk>
   6676 callq  ffffffff81101420 <lockdep_rcu_suspicious>
   7328 callq  ffffffff81e014b0 <__x86_indirect_thunk_rax>
   7598 callq  ffffffff81126f30 <debug_lockdep_rcu_enabled>
   9065 callq  ffffffff810979f0 <__stack_chk_fail>

The most prominent callers which are already function call pointers today 
are:

  $ objdump -d vmlinux | grep -w callq | grep \* | cut -f3- | sort | uniq -c | sort -n | tail -10

    109 callq  *0xffffffff82648530
    134 callq  *0xffffffff82648568
    154 callq  *0xffffffff826483d0
    260 callq  *0xffffffff826483d8
    297 callq  *0xffffffff826483e0
    345 callq  *0xffffffff82648440
    345 callq  *0xffffffff82648558
    624 callq  *0xffffffff82648428
    709 callq  *0xffffffff82648438
    768 callq  *0xffffffff82648430

That's all pv_ops->*() method calls:

   ffffffff82648300 D pv_ops
   ffffffff826485d0 D pv_info

Optimizing those thousands of function pointer calls would already be a 
nice improvement.

But retpolines:

   7328 callq  ffffffff81e014b0 <__x86_indirect_thunk_rax>

  ffffffff81e014b0 <__x86_indirect_thunk_rax>:
  ffffffff81e014b0:       ff e0                   jmpq   *%rax

... are even more prominent, and turned on in every distro as well, 
obviously.

Thanks,

	Ingo
