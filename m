Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0B8ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E53620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gb11VYnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E53620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeJYQv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:51:29 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44388 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:51:29 -0400
Received: by mail-yb1-f194.google.com with SMTP id p144-v6so3305170yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A3SL80mL39iVIj/yWo+0mJZddveN6mpgQU9LfmZY+rs=;
        b=Gb11VYncwaoXe3WL3BwW8U7og/Fel4XkJiRfA/rGlMdnaiadeDtgelU+JO8PZSTOkT
         xT0zH4X0PNazioZqBmHzFsx/3SKx0Vki6jXg84f71G5iJwV2GM9TX5BX+ghU/KCA09fN
         2xg2hTKp4NQTgAYXJtW3jZkQUfFRg8lTMEdIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A3SL80mL39iVIj/yWo+0mJZddveN6mpgQU9LfmZY+rs=;
        b=At5czbsc/ncx0PTrax1HaCvtod9iMhhf8TK8Ul9Q0KZ7UQcdvkblbOhhFEPGKWeZVj
         +zfIcy6uecUxqSaGuc/8E/HLpbMewPT4EdZHkXu43uS7JzjIdOXGYc6MD24a1VNw9d/G
         ALF+/e9kvZIN3FO7g9BNltWLcmTErbggkUQu7jkJu2NH+v6Z162Ivhrsy8GAxdPinI+I
         FVbtihexDtxGBqLNVPMYm38wlw5nbbOPcIMavTwgNAdlmWvfkzO+9E/pyK0Hg5L3lKs6
         BzX8rojycOhqDofwW44u6VaEHrZ9Q1NP50xixKjb40gb86QcJUVUkFy/IB+6JtfCIpGx
         5A4w==
X-Gm-Message-State: AGRZ1gI84szT+TcZcEFzCUMQixTG58ZjIjMMWIy2TJ3wZAPuuC3R043W
        eVRjarLeD4mIFuAzPv8QGJF5EovXVMA=
X-Google-Smtp-Source: AJdET5dI9t6IGYFlHWqI3/D4tpX0v2yX6QscHnoGdtmYAFNQZ7EkDL/DDocx2u6As8j4fa7tZmd7dQ==
X-Received: by 2002:a25:9349:: with SMTP id g9-v6mr439587ybo.181.1540455587600;
        Thu, 25 Oct 2018 01:19:47 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id f11-v6sm1404421ywk.78.2018.10.25.01.19.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 01:19:46 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id v1-v6so3242830ywv.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:19:46 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr434415ywg.353.1540455585842;
 Thu, 25 Oct 2018 01:19:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 01:19:45
 -0700 (PDT)
In-Reply-To: <20181022095439.GA4613@redhat.com>
References: <0000000000004904df0578b7d3da@google.com> <bf1a083c-0d09-07fb-6ad2-4bf30ac49cd8@I-love.SAKURA.ne.jp>
 <20181022095439.GA4613@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 25 Oct 2018 09:19:45 +0100
X-Gmail-Original-Message-ID: <CAGXu5jLxLqieLCZfAzw_xX-k3bbESUF3pjuGEDRRH1CY2O8JSA@mail.gmail.com>
Message-ID: <CAGXu5jLxLqieLCZfAzw_xX-k3bbESUF3pjuGEDRRH1CY2O8JSA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in task_is_descendant
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 10:54 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 10/21, Tetsuo Handa wrote:
>>
>> On 2018/10/21 16:10, syzbot wrote:
>> > BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:188 [inline]
>> > BUG: KASAN: use-after-free in task_is_descendant.part.2+0x610/0x670 security/yama/yama_lsm.c:295
>> > Read of size 8 at addr ffff8801c4666b20 by task syz-executor3/12722
>> >
>> > CPU: 1 PID: 12722 Comm: syz-executor3 Not tainted 4.19.0-rc8+ #70
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> > Call Trace:
>> >  __dump_stack lib/dump_stack.c:77 [inline]
>> >  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>> >  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>> >  kasan_report_error mm/kasan/report.c:354 [inline]
>> >  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>> >  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>> >  __read_once_size include/linux/compiler.h:188 [inline]
>> >  task_is_descendant.part.2+0x610/0x670 security/yama/yama_lsm.c:295
>>
>> Do we need to hold
>>
>>   write_lock_irq(&tasklist_lock);
>>
>> rather than
>>
>>   rcu_read_lock();
>>
>> when accessing
>>
>>   "struct task_struct"->real_parent
>
> Well, if "task" is stable (can't exit), then I think
>
>         rcu_dereference(task->real_parent)
>
> is fine, we know that ->real_parent did not pass exit_notif() yet.
>
> However, task_is_descendant() looks unnecessarily complicated, it could be
>
>         static int task_is_descendant(struct task_struct *parent,
>                                       struct task_struct *child)
>         {
>                 int rc = 0;
>                 struct task_struct *walker;
>
>                 if (!parent || !child)
>                         return 0;
>
>                 rcu_read_lock();
>                 for (walker = child; walker->pid; walker = rcu_dereference(walker->real_parent))
>                         if (same_thread_group(parent, walker)) {
>                                 rc = 1;
>                                 break;
>                         }
>                 rcu_read_unlock();
>
>                 return rc;
>         }
>
> And again, I do not know how/if yama ensures that child is rcu-protected, perhaps
> task_is_descendant() needs to check pid_alive(child) right after rcu_read_lock() ?

task_is_descendant() is called under rcu_read_lock() in both
ptracer_exception_found() and yama_ptrace_access_check() so I don't
understand how any of the tasks could get freed? This is walking
group_leader and real_parent -- are these not stable under rcu_lock()?

-- 
Kees Cook
