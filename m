Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeDJVYp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:24:45 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34494 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbeDJVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:24:43 -0400
X-Google-Smtp-Source: AIpwx4+Ycc35qn4hWG25lhDzHn1G71fP4Th/76UmLJTCCtQunnMIlDwbDvdTP8bZah2U6zdoOV/jxl4q7zcc6GH018o=
MIME-Version: 1.0
In-Reply-To: <201804090525.w395P1qS044316@www262.sakura.ne.jp>
References: <201804090338.w393crfv005435@www262.sakura.ne.jp>
 <CAMp4zn8GOFk9EKCS9JaEsKayDZ+pLFORWBRHPaCCsN--EyvFVg@mail.gmail.com> <201804090525.w395P1qS044316@www262.sakura.ne.jp>
From: Sargun Dhillon <sargun@sargun.me>
Date: Tue, 10 Apr 2018 14:24:02 -0700
Message-ID: <CAMp4zn9uc-Z4NOn_0YQ-8qgdDdJxdNA56GCWGhjEbYQBzp_pOg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] security: Add mechanism to safely (un)load LSMs
 after boot time
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Peter Dolding <oiaohm@gmail.com>,
        Igor Stoppa <igor.stoppa@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 10:25 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Sargun Dhillon wrote:
>> >   Remove SECURITY_HOOK_COUNT and "struct security_hook_list"->owner and
>> >   the exception in randomize_layout_plugin.c because preventing module
>> >   unloading won't work as expected.
>> >
>>
>> Rather than completely removing the unloading code, might it make
>> sense to add a BUG_ON or WARN_ON, in security_delete_hooks if
>> allow_unload_module is false, and owner is not NULL?
>
> Do we need to check ->owner != NULL? Although it will be true that
> SELinux's ->owner == NULL and LKM-based LSM module's ->owner != NULL,
> I think we unregister SELinux before setting allow_unload_module to false.
> Thus, rejecting delete_security_hooks() if allow_unload_module == false will
> be sufficient. SELinux might want to call panic() if delete_security_hooks()
> did not unregister due to allow_unload_module == false. Also,
> allow_unload_module would be renamed to allow_unregister_module.
>
> By the way, please don't use BUG_ON() or WARN_ON() because syzbot would hit
> and call panic() because syzbot runs tests with panic_on_warn == true.

I think my primary question is for the SELinux folks -- what do you
think the behaviour should be? If allow_unload_modules /
allow_unregister_module is set, do you want to be able to call
security_delete_hooks? What do you think the right
action should be if it fails?
