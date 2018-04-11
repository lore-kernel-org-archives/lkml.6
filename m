Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeDKVgp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:36:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38672 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeDKVgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:36:44 -0400
X-Google-Smtp-Source: AIpwx49UpTqz8YHwZjzbZdqzgsDbTkErK/CPmLf7c1i93d/CKk73jDiZuuUh7N13H+Da0pxnGNcQXiuiR1LhyEmQir0=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <9cacbdfa-d224-189b-1e79-155a81f3dcdf@tycho.nsa.gov>
References: <201804090338.w393crfv005435@www262.sakura.ne.jp>
 <CAMp4zn8GOFk9EKCS9JaEsKayDZ+pLFORWBRHPaCCsN--EyvFVg@mail.gmail.com>
 <201804090525.w395P1qS044316@www262.sakura.ne.jp> <CAMp4zn9uc-Z4NOn_0YQ-8qgdDdJxdNA56GCWGhjEbYQBzp_pOg@mail.gmail.com>
 <9cacbdfa-d224-189b-1e79-155a81f3dcdf@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Apr 2018 17:36:41 -0400
Message-ID: <CAHC9VhTCh5N_hKgiAnv0ZqTrn-+79bcPbXMbOUyyNNRv2LEfdg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] security: Add mechanism to safely (un)load LSMs
 after boot time
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Sargun Dhillon <sargun@sargun.me>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Peter Dolding <oiaohm@gmail.com>,
        Igor Stoppa <igor.stoppa@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:17 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 04/10/2018 05:24 PM, Sargun Dhillon wrote:
>> On Sun, Apr 8, 2018 at 10:25 PM, Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> Sargun Dhillon wrote:
>>>>>   Remove SECURITY_HOOK_COUNT and "struct security_hook_list"->owner and
>>>>>   the exception in randomize_layout_plugin.c because preventing module
>>>>>   unloading won't work as expected.
>>>>>
>>>>
>>>> Rather than completely removing the unloading code, might it make
>>>> sense to add a BUG_ON or WARN_ON, in security_delete_hooks if
>>>> allow_unload_module is false, and owner is not NULL?
>>>
>>> Do we need to check ->owner != NULL? Although it will be true that
>>> SELinux's ->owner == NULL and LKM-based LSM module's ->owner != NULL,
>>> I think we unregister SELinux before setting allow_unload_module to false.
>>> Thus, rejecting delete_security_hooks() if allow_unload_module == false will
>>> be sufficient. SELinux might want to call panic() if delete_security_hooks()
>>> did not unregister due to allow_unload_module == false. Also,
>>> allow_unload_module would be renamed to allow_unregister_module.
>>>
>>> By the way, please don't use BUG_ON() or WARN_ON() because syzbot would hit
>>> and call panic() because syzbot runs tests with panic_on_warn == true.
>>
>> I think my primary question is for the SELinux folks -- what do you
>> think the behaviour should be? If allow_unload_modules /
>> allow_unregister_module is set, do you want to be able to call
>> security_delete_hooks? What do you think the right
>> action should be if it fails?
>
> The one that avoids breakage for existing users ;)
>
> I personally am in favor of killing SELinux support for runtime disable aka
> CONFIG_SECURITY_SELINUX_DISABLE; the only reason it exists is that Red Hat
> originally insisted that bootloader configuration is too painful to modify/update on
> certain platforms and therefore the selinux=0 boot parameter is insufficient
> as a mechanism for disabling SELinux.

I too would like to remove the SELinux runtime disable code, and we
have looked at it briefly but there are a number of
userspace/bootloader upgrade concerns that need to be addressed first
(some of the issues have been captured in the BZ linked below).
Unfortunately it isn't as trivial a chance as it would initially
appear.

* https://bugzilla.redhat.com/show_bug.cgi?id=1430944

> However, we can't break existing users.  Userspace should still attempt to proceed
> even if runtime disable fails, just with SELinux left in permissive mode and no
> policy loaded.  That generally should work, but does retain the performance overhead
> of the SELinux hook function processing, unlike a real disable.
>
> I don't think we particularly care about allow_unload_modules / allow_unregister_module
> since there is no existing userspace or configurations relying on it.

-- 
paul moore
www.paul-moore.com
