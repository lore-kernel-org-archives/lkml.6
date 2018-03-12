Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeCLPt7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:49:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44265 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932326AbeCLPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:49:58 -0400
X-Google-Smtp-Source: AG47ELtET0Isq+VeGbGYO7rE/dpL8jvKQivKgppZ1miXSGWttnREM+Qt0TaGMcRi8zFNEo6gcC+Zst4NzTM7IImOn7I=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180312161735.3447ad56@ivy-bridge>
References: <cover.1520835596.git.rgb@redhat.com> <20180312161735.3447ad56@ivy-bridge>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Mar 2018 11:49:56 -0400
Message-ID: <CAHC9VhSx7C=6OxEpe7ss+LmngsLp0947kXWXOjug7fnxD5GUOw@mail.gmail.com>
Subject: Re: [PATCH ghak21 V2 0/4] audit: address ANOM_LINK excess records
To: Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 11:17 AM, Steve Grubb <sgrubb@redhat.com> wrote:
> On Mon, 12 Mar 2018 02:31:16 -0400
> Richard Guy Briggs <rgb@redhat.com> wrote:
>
>> Audit link denied events were being unexpectedly produced in a
>> disjoint way when audit was disabled, and when they were expected,
>> there were duplicate PATH records.  This patchset addresses both
>> issues for symlinks and hardlinks.
>>
>> This was introduced with
>>       commit b24a30a7305418ff138ff51776fc555ec57c011a
>>       ("audit: fix event coverage of AUDIT_ANOM_LINK")
>>       commit a51d9eaa41866ab6b4b6ecad7b621f8b66ece0dc
>>       ("fs: add link restriction audit reporting")
>>
>> Here are the resulting events:
>>
>> symlink:
>> type=PROCTITLE msg=audit(03/12/2018 02:21:49.578:310) :
>> proctitle=ls ./my-passwd type=PATH msg=audit(03/12/2018
>> 02:21:49.578:310) : item=1 name=/tmp/ inode=13529 dev=00:27
>> mode=dir,sticky,777 ouid=root ogid=root rdev=00:00
>> obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none
>> cap_fi=none cap_fe=0 cap_fver=0 type=PATH msg=audit(03/12/2018
>> 02:21:49.578:310) : item=0 name=./my-passwd inode=17090 dev=00:27
>> mode=link,777 ouid=rgb ogid=rgb rdev=00:00
>> obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none
>> cap_fi=none cap_fe=0 cap_fver=0 type=CWD msg=audit(03/12/2018
>> 02:21:49.578:310) : cwd=/tmp type=SYSCALL msg=audit(03/12/2018
>> 02:21:49.578:310) : arch=x86_64 syscall=stat success=no
>> exit=EACCES(Permission denied) a0=0x7ffd79950dda a1=0x563f658a03c8
>> a2=0x563f658a03c8 a3=0x79950d00 items=2 ppid=552 pid=629 auid=root
>> uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
>> fsgid=root tty=ttyS0 ses=1 comm=ls exe=/usr/bin/ls
>> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
>> type=ANOM_LINK msg=audit(03/12/2018 02:21:49.578:310) :
>> op=follow_link ppid=552 pid=629 auid=root uid=root gid=root euid=root
>> suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1
>> comm=ls exe=/usr/bin/ls
>
> So, if we now only emit the ANOM_LINK event when audit is enabled, we
> should get rid of all the duplicate information in that record. The
> SYSCALL record has all that information.

As discussed previously, I'm not going to merge any patches which
remove fields from existing records.

-- 
paul moore
www.paul-moore.com
