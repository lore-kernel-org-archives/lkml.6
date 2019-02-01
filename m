Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CAC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6E721902
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfBANKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:10:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:35861 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBANKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:10:05 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x11D9Ccq066519;
        Fri, 1 Feb 2019 22:09:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Fri, 01 Feb 2019 22:09:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x11D95h3066451
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 1 Feb 2019 22:09:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <000000000000c178e305749daba4@google.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
 <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
 <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
 <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
 <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
 <e598f3c7-22bc-91c2-2f47-0eec068f5180@I-love.SAKURA.ne.jp>
 <CACT4Y+YXsD4f+ngzN7SGXcUGBn-jG1KeyrZJBzcUWo-AbdTe4w@mail.gmail.com>
 <05340d28-36c2-267e-d54e-416fddfba211@i-love.sakura.ne.jp>
 <CACT4Y+Ynyy-bMK4cxhgNoAaauFdjzExuELM6u0amksbR4wy7GQ@mail.gmail.com>
 <71e3652b-b222-0c3f-8b48-5980ddcaeb93@i-love.sakura.ne.jp>
 <CACT4Y+Z036bZfN1-_VaQ5EorwFt_tpPm=RTnrYN5qKV_ebgoFw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <52531a69-10ed-d263-be66-e707705597d6@i-love.sakura.ne.jp>
Date:   Fri, 1 Feb 2019 22:09:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z036bZfN1-_VaQ5EorwFt_tpPm=RTnrYN5qKV_ebgoFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/01 19:50, Dmitry Vyukov wrote:
> On Fri, Feb 1, 2019 at 11:44 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2019/02/01 19:09, Dmitry Vyukov wrote:
>>> Thanks for the explanations.
>>>
>>> Here is the change that I've come up with:
>>> https://github.com/google/syzkaller/commit/aa53be276dc84aa8b3825b3416542447ff82b41a
>>
>> You are not going to apply this updated config to upstream kernels now, are you?
>> Removing CONFIG_DEFAULT_SECURITY="apparmor" from configs used by upstream kernels
>> will cause failing to enable AppArmor (unless security=apparmor is specified).
> 
> 
> We do use  security=apparmor, see:
> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-apparmor.cmdline
> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-selinux.cmdline
> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-smack.cmdline
> 

Oh, security= parameter is explicitly specified on all targets?
Then, we can abuse CONFIG_DEBUG_AID_FOR_SYZBOT option. ;-)

LSM folks, may we use this patch for linux-next.git ?
CONFIG_DEBUG_AID_FOR_SYZBOT is a linux-next.git-only kernel config option used by syzbot.



From c7d21f9c1c0b610ddea4233b89edf7d3140b8baf Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 1 Feb 2019 22:03:55 +0900
Subject: [PATCH linux-next] LSM: Allow syzbot to ignore security= parameter.

LSM is going to get infrastructure managed security blob support in Linux
5.1, and it becomes possible to run TOMOYO with SELinux/Smack/AppArmor.
But for compatibility reason, since security= parameter makes it
impossible to run TOMOYO with SELinux/Smack/AppArmor, syzbot can't
test that combination. Therefore, this patch allows syzbot to temporarily
ignore security= parameter. This patch is meant for linux-next.git only,
and will be removed after infrastructure managed security blob support
went to linux.git.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/security.c b/security/security.c
index ef03643..0632feb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -346,12 +346,14 @@ int __init security_init(void)
 }
 
 /* Save user chosen LSM */
+#ifndef CONFIG_DEBUG_AID_FOR_SYZBOT
 static int __init choose_major_lsm(char *str)
 {
 	chosen_major_lsm = str;
 	return 1;
 }
 __setup("security=", choose_major_lsm);
+#endif
 
 /* Explicitly choose LSM initialization order. */
 static int __init choose_lsm_order(char *str)
-- 
1.8.3.1

