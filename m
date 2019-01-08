Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B64C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5363120827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ssi.gouv.fr header.i=@ssi.gouv.fr header.b="d9CwV737"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfAHN3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:29:32 -0500
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:60000 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfAHN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:29:32 -0500
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id D4B12D0006F;
        Tue,  8 Jan 2019 14:29:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1546954176;
        bh=XmNbVTXzFtbP+Mqfud8yrCx8TLq29RKGAXwDt1ZPKf8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=d9CwV737+I60XmspBx4UBDzjQ06DwdMZApGsJpUHeYhAuoPQgeofCR51x43kbxOeF
         hDAIwoHxi5pf9vBDJ8LsOn9wcp64R4pkhKIVUGo9H/VjvAkLE0+sokyxF/A/1oM8Po
         ZiUFbZm1Yg+Y33OLq1FKlKbBPyFp91XD9rhAZJ3lAaZr49pYzeX3qojUSS0M67ajnM
         svVWhRIgPSgAMvmKznD9AWJP7tUjl4CguGSLT5s76YBWm7zGBxZ/VDTkhatneky1E6
         JgS0PeJa0oQqsNSk8UKp935OrzUSJd8MI5x6nADcHUwQa1Dcn3rxjC2dnzWw3lYgol
         r6dplZS2MjyiQ==
Subject: Re: [RFC PATCH v1 3/5] Yama: Enforces noexec mounts or file
 executability through O_MAYEXEC
To:     Jann Horn <jannh@google.com>
CC:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        <zohar@linux.ibm.com>, <philippe.trebuchet@ssi.gouv.fr>,
        <shuah@kernel.org>, <thibaut.sautereau@ssi.gouv.fr>,
        <vincent.strubel@ssi.gouv.fr>, <yves-alexis.perez@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181212081712.32347-4-mic@digikod.net>
 <CAG48ez3SAW8EyaJ9T1U3qPoRhYwe4CCyL9bAxuc3GxjrXipi-A@mail.gmail.com>
 <f13bf750-f418-343c-baa6-9eee6e0f5e19@ssi.gouv.fr>
 <CAG48ez00CpXOOJPLgpQd_e0gG2KgYb1p8bwssA8FDOugHTxRAA@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <0f7d39f8-035b-8566-94c9-ea836b280e24@ssi.gouv.fr>
Date:   Tue, 8 Jan 2019 14:29:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez00CpXOOJPLgpQd_e0gG2KgYb1p8bwssA8FDOugHTxRAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/01/2019 12:17, Jann Horn wrote:
> On Thu, Dec 13, 2018 at 3:49 PM Mickaël Salaün
> <mickael.salaun@ssi.gouv.fr> wrote:
>> On 12/12/2018 18:09, Jann Horn wrote:
>>> On Wed, Dec 12, 2018 at 9:18 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>> Enable to either propagate the mount options from the underlying VFS
>>>> mount to prevent execution, or to propagate the file execute permission.
>>>> This may allow a script interpreter to check execution permissions
>>>> before reading commands from a file.
>>>>
>>>> The main goal is to be able to protect the kernel by restricting
>>>> arbitrary syscalls that an attacker could perform with a crafted binary
>>>> or certain script languages.  It also improves multilevel isolation
>>>> by reducing the ability of an attacker to use side channels with
>>>> specific code.  These restrictions can natively be enforced for ELF
>>>> binaries (with the noexec mount option) but require this kernel
>>>> extension to properly handle scripts (e.g., Python, Perl).
>>>>
>>>> Add a new sysctl kernel.yama.open_mayexec_enforce to control this
>>>> behavior.  A following patch adds documentation.
> [...]
>>>> +{
>>>> +       if (!(mask & MAY_OPENEXEC))
>>>> +               return 0;
>>>> +       /*
>>>> +        * Match regular files and directories to make it easier to
>>>> +        * modify script interpreters.
>>>> +        */
>>>> +       if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
>>>> +               return 0;
>>>
>>> So files are subject to checks, but loading code from things like
>>> sockets is always fine?
>>
>> As I said in a previous email, these checks do not handle fifo either.
>> This is relevant in a threat model targeting persistent attacks (and
>> with additional protections/restrictions). We may want to only whitelist
>> fifo, but I don't get how a socket is relevant here. Can you please clarify?
> 
> I don't think that there's a security problem here. I just think it's
> weird to have the extra check when it seems to me like it isn't really
> necessary - nobody is going to want to execute a socket or fifo
> anyway, right?

Right, the fifo whitelisting should answer your concern then.

> 
>>>
>>>> +       if ((open_mayexec_enforce & YAMA_OMAYEXEC_ENFORCE_MOUNT) &&
>>>> +                       !(mask & MAY_EXECMOUNT))
>>>> +               return -EACCES;
>>>> +
>>>> +       /*
>>>> +        * May prefer acl_permission_check() instead of generic_permission(),
>>>> +        * to not be bypassable with CAP_DAC_READ_SEARCH.
>>>> +        */
>>>> +       if (open_mayexec_enforce & YAMA_OMAYEXEC_ENFORCE_FILE)
>>>> +               return generic_permission(inode, MAY_EXEC);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>  static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
>>>> +       LSM_HOOK_INIT(inode_permission, yama_inode_permission),
>>>>         LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>>>>         LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>>>>         LSM_HOOK_INIT(task_prctl, yama_task_prctl),
>>>> @@ -447,6 +489,37 @@ static int yama_dointvec_minmax(struct ctl_table *table, int write,
>>>>         return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
>>>>  }
>>>>
>>>> +static int yama_dointvec_bitmask_macadmin(struct ctl_table *table, int write,
>>>> +                                         void __user *buffer, size_t *lenp,
>>>> +                                         loff_t *ppos)
>>>> +{
>>>> +       int error;
>>>> +
>>>> +       if (write) {
>>>> +               struct ctl_table table_copy;
>>>> +               int tmp_mayexec_enforce;
>>>> +
>>>> +               if (!capable(CAP_MAC_ADMIN))
>>>> +                       return -EPERM;
>>>
>>> Don't put capable() checks in sysctls, it doesn't work.
>>>
>>
>> I tested it and the root user can indeed open the file even if the
>> process doesn't have CAP_MAC_ADMIN, however writing in the sysctl file
>> is denied. Btw there is a similar check in the previous function
>> (yama_dointvec_minmax).
> 
> It's still wrong. If an attacker without CAP_MAC_ADMIN opens the
> sysctl file, then passes the file descriptor to a setcap binary that
> has CAP_MAC_ADMIN as stdout/stderr, and the setcap binary writes to
> it, then the capable() check is bypassed. (But of course, to open the
> sysctl file in the first place, you'd need to be root (uid 0), so the
> check doesn't really matter.)

I agree with you that a confused deputy attack may uses file
descriptors, but I don't see how the current sysctl API may be used to
check the process capability at open time. Anyway, on a properly
configured system, especially one leveraging Linux capabilities (e.g.
CLIP OS), root processes may not have CAP_SYS_ADMIN. Moreover, SUID or
fcap binaries may not be available to an attacker (e.g. in a container).
