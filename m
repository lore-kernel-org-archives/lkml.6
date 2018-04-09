Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeDIFZU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 01:25:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56876 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeDIFZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 01:25:18 -0400
Message-Id: <201804090525.w395P1qS044316@www262.sakura.ne.jp>
Subject: Re: [PATCH v5 1/1] security: Add mechanism to safely (un)load LSMs after
 boot time
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: Sargun Dhillon <sargun@sargun.me>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Peter Dolding <oiaohm@gmail.com>,
        Igor Stoppa <igor.stoppa@huawei.com>
MIME-Version: 1.0
Date: Mon, 09 Apr 2018 14:25:01 +0900
References: <201804090338.w393crfv005435@www262.sakura.ne.jp> <CAMp4zn8GOFk9EKCS9JaEsKayDZ+pLFORWBRHPaCCsN--EyvFVg@mail.gmail.com>
In-Reply-To: <CAMp4zn8GOFk9EKCS9JaEsKayDZ+pLFORWBRHPaCCsN--EyvFVg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sargun Dhillon wrote:
> >   Remove SECURITY_HOOK_COUNT and "struct security_hook_list"->owner and
> >   the exception in randomize_layout_plugin.c because preventing module
> >   unloading won't work as expected.
> >
> 
> Rather than completely removing the unloading code, might it make
> sense to add a BUG_ON or WARN_ON, in security_delete_hooks if
> allow_unload_module is false, and owner is not NULL?

Do we need to check ->owner != NULL? Although it will be true that
SELinux's ->owner == NULL and LKM-based LSM module's ->owner != NULL,
I think we unregister SELinux before setting allow_unload_module to false.
Thus, rejecting delete_security_hooks() if allow_unload_module == false will
be sufficient. SELinux might want to call panic() if delete_security_hooks()
did not unregister due to allow_unload_module == false. Also,
allow_unload_module would be renamed to allow_unregister_module.

By the way, please don't use BUG_ON() or WARN_ON() because syzbot would hit
and call panic() because syzbot runs tests with panic_on_warn == true.
