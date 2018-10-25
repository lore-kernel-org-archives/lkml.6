Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D70C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB0720831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB0720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJYVsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:48:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:42204 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeJYVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:48:06 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9PDF4X2024317;
        Thu, 25 Oct 2018 22:15:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Thu, 25 Oct 2018 22:15:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9PDExVI024230
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 25 Oct 2018 22:15:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: KASAN: use-after-free Read in task_is_descendant
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d11bc954-5a30-e6bd-1668-866a187e0aac@i-love.sakura.ne.jp>
Date:   Thu, 25 Oct 2018 22:14:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025121709.GD3725@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/25 21:17, Oleg Nesterov wrote:
>>> And yes, task_is_descendant() can hit the dead child, if nothing else it can
>>> be killed. This can explain the kasan report.
>>
>> The kasan is reporting that child->real_parent (or maybe child->real_parent->real_parent
>> or child->real_parent->real_parent->real_parent ...) was pointing to already freed memory,
>> isn't it?
> 
> Yes. and you know, I am all confused. I no longer can understand you :/

Why don't we need to check every time like shown below?
Why checking only once is sufficient?

--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -285,7 +285,7 @@ static int task_is_descendant(struct task_struct *parent,
 	rcu_read_lock();
 	if (!thread_group_leader(parent))
 		parent = rcu_dereference(parent->group_leader);
-	while (walker->pid > 0) {
+	while (pid_alive(walker) && walker->pid > 0) {
 		if (!thread_group_leader(walker))
 			walker = rcu_dereference(walker->group_leader);
 		if (walker == parent) {
