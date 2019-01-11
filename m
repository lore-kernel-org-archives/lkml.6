Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA4BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C753D20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfAKKif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:38:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:13374 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbfAKKie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:38:34 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0BAcXig049434;
        Fri, 11 Jan 2019 19:38:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Fri, 11 Jan 2019 19:38:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0BAcXpt049430
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 11 Jan 2019 19:38:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [GIT PULL] blob-stacking updates for security-next
To:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <20190108213504.GA32901@beast>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <ce79cdd5-3020-8901-a5a4-ec42005734fd@I-love.SAKURA.ne.jp>
Date:   Fri, 11 Jan 2019 19:38:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108213504.GA32901@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/09 6:35, Kees Cook wrote:
> Hi James,
> 
> Please pull these blob-stacking changes for security-next.
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/blob-stacking-security-next
> 
> for you to fetch changes up to a5e2fe7ede1268d2f80fe49ca1f717d0e3750995:
> 
>   TOMOYO: Update LSM flags to no longer be exclusive (2019-01-08 13:18:45 -0800)
> 

And syzbot already found a bug.
This is occurring immediately after memory allocation failure for cred object.
We need to be prepared for free() function being called when alloc() function failed.

[   59.992498][ T8010] FAULT_INJECTION: forcing a failure.
[   59.992498][ T8010] name failslab, interval 1, probability 0, space 0, times 1
[   60.005214][ T8010] CPU: 0 PID: 8010 Comm: syz-executor178 Not tainted 5.0.0-rc1-next-20190111 #10
[   60.014337][ T8010] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   60.024383][ T8010] Call Trace:
[   60.027657][ T8010]  dump_stack+0x1db/0x2d0
[   60.063731][ T8010]  should_fail.cold+0xa/0x14
[   60.089894][ T8010]  __should_failslab+0x121/0x190
[   60.094810][ T8010]  should_failslab+0x9/0x14
[   60.099411][ T8010]  __kmalloc+0x2dc/0x740
[   60.124293][ T8010]  security_prepare_creds+0x123/0x190
[   60.129644][ T8010]  prepare_creds+0x3c4/0x510
[   60.149852][ T8010]  __x64_sys_capset+0x58c/0x9b0
[   60.185347][ T8010]  do_syscall_64+0x1a3/0x800
[   60.206747][ T8010]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
