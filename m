Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C1AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E1920672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544470714;
	bh=O15yZ5VkjaDOPI3ZTPBJ7BoKGzciiD4ftgdGZmJMeKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UMxgjpWDzDDaJQhSe9v5RHikb2xhDwldFQUaNYRQSJNm3KNMqBECfbw6dXzEMvh6f
	 NH8Phrl6gd59MIzj/uWXvMi4ukLhUxHiL5yr8ZjxGXpNUAs0STTj0uS3Tc1x7L0gZN
	 4v1ny6VYmtcZH8d2L3u6cfaDGtYixvrfBZUBV8wk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E1920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeLJTid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbeLJTid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:38:33 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514CC20672
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 19:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544470711;
        bh=O15yZ5VkjaDOPI3ZTPBJ7BoKGzciiD4ftgdGZmJMeKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kCguRRkKtTdZnVgGlbn8AK4mY1qWnLaIyA3yKT+YAnIdfq+OR8CM6Aq5TFZWAObVA
         vIajpIuaIyiUPHOeon6tQ3Jstc01AfTMxrq/4AGyfmUAUScQDvC/h2xpZxzlIJGnxf
         +JFwOs4R1vJlnssLHbi+KtUsWeuuXg1eKWapkUxk=
Received: by mail-wm1-f43.google.com with SMTP id y139so12126945wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:38:31 -0800 (PST)
X-Gm-Message-State: AA+aEWbH7gNQ6EPFJQaBZseNL3wj9jqNUCN0aQRBCVeB6a1rO7GS68M+
        uXBQwbVLV5PeHyB+0iBWnCqD88NF8B9c2Kp/EkJp8w==
X-Google-Smtp-Source: AFSGD/VPDhGBkUlKFvQTmwI5BONq9wQx2CqfULacy53dcRcjoNuOGwh9kyiEAUNstSRPSFElfRND+6FoRhQvk1I2eGs=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr11446080wme.108.1544470709792;
 Mon, 10 Dec 2018 11:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20181210043126.GX6131@altlinux.org> <201812102200.snodXJSH%fengguang.wu@intel.com>
 <20181210160940.GF14149@altlinux.org>
In-Reply-To: <20181210160940.GF14149@altlinux.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Dec 2018 11:38:17 -0800
X-Gmail-Original-Message-ID: <CALCETrV4J8+_gSHONAcQHt6XFgtuW487b9DHZ8MV-xa6XhZ_Og@mail.gmail.com>
Message-ID: <CALCETrV4J8+_gSHONAcQHt6XFgtuW487b9DHZ8MV-xa6XhZ_Og@mail.gmail.com>
Subject: Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     paul.burton@mips.com, Ralf Baechle <ralf@linux-mips.org>,
        jhogan@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        strace-devel@lists.strace.io, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 10, 2018, at 8:09 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> Hi, things are getting too complicated and we need some advice how to deal
> with this frame_pointer issue.
>
>> On Mon, Dec 10, 2018 at 10:26:50PM +0800, kbuild test robot wrote:
>> Hi Elvira,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.20-rc6]
>> [cannot apply to next-20181207]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Dmitry-V-Levin/ptrace-add-PTRACE_GET_SYSCALL_INFO-request/20181210-174745
>> config: mips-malta_kvm_defconfig (attached as .config)
>> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>        chmod +x ~/bin/make.cross
>>        # save the attached .config to linux build tree
>>        GCC_VERSION=7.2.0 make.cross ARCH=mips
>>
>> All errors (new ones prefixed by >>):
>>
>>   kernel/ptrace.c: In function 'ptrace_get_syscall_info':
>>>> kernel/ptrace.c:942:20: error: implicit declaration of function 'frame_pointer'; did you mean 'trace_printk'? [-Werror=implicit-function-declaration]
>>      .frame_pointer = frame_pointer(regs)
>>                       ^~~~~~~~~~~~~
>>                       trace_printk
>>   cc1: some warnings being treated as errors
>>
>> vim +942 kernel/ptrace.c
>>
>>   931
>>   932    static int
>>   933    ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
>>   934                void __user *datavp)
>>   935    {
>>   936        struct pt_regs *regs = task_pt_regs(child);
>>   937        struct ptrace_syscall_info info = {
>>   938            .op = PTRACE_SYSCALL_INFO_NONE,
>>   939            .arch = syscall_get_arch(child),
>>   940            .instruction_pointer = instruction_pointer(regs),
>>   941            .stack_pointer = user_stack_pointer(regs),
>>> 942            .frame_pointer = frame_pointer(regs)
>>   943        };
>>   944        unsigned long actual_size = offsetof(struct ptrace_syscall_info, entry);
>>   945        unsigned long write_size;
>>   946
>>   947        /*
>>   948         * This does not need lock_task_sighand() to access
>>   949         * child->last_siginfo because ptrace_freeze_traced()
>>   950         * called earlier by ptrace_check_attach() ensures that
>>   951         * the tracee cannot go away and clear its last_siginfo.
>>   952         */
>>   953        switch (child->last_siginfo ? child->last_siginfo->si_code : 0) {
>>   954        case SIGTRAP | 0x80:
>>   955            switch (child->ptrace_message) {
>>   956            case PTRACE_EVENTMSG_SYSCALL_ENTRY:
>>   957                actual_size = ptrace_get_syscall_info_entry(child, regs,
>>   958                                        &info);
>>   959                break;
>>   960            case PTRACE_EVENTMSG_SYSCALL_EXIT:
>>   961                actual_size = ptrace_get_syscall_info_exit(child, regs,
>>   962                                       &info);
>>   963                break;
>>   964            }
>>   965            break;
>>   966        case SIGTRAP | (PTRACE_EVENT_SECCOMP << 8):
>>   967            actual_size = ptrace_get_syscall_info_seccomp(child, regs,
>>   968                                      &info);
>>   969            break;
>>   970        }
>>   971
>>   972        write_size = min(actual_size, user_size);
>>   973        return copy_to_user(datavp, &info, write_size) ? -EFAULT : actual_size;
>>   974    }
>>   975
>
> We decided to add .frame_pointer to struct ptrace_syscall_info just for
> consistency with .instruction_pointer and .stack_pointer; I must have been
> misled by comments in asm-generic/ptrace.h into thinking that
> frame_pointer() is universally available across architectures.
>
> Unlike .instruction_pointer and .stack_pointer that are actually needed
> in strace, .frame_pointer is not used, so from strace PoV we don't really
> need it.
>
> So the question is, does anybody need a
> struct ptrace_syscall_info.frame_pointer?
>
> If yes, how can frame_pointer() be defined on MIPS?
> Or should we just forget about making sense of frame_pointer() and remove
> struct ptrace_syscall_info.frame_pointer from the proposed API?
>

I would suggest getting rid of frame_pointer. Anyone who needs that
degree of debugging can use existing ptrace APIs for it.

>
> --
> ldv
