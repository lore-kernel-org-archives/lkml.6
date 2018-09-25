Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291BDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F562208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F562208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeIYShw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:37:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:37374 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIYShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:37:52 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8PCUUSU067212;
        Tue, 25 Sep 2018 21:30:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Tue, 25 Sep 2018 21:30:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8PCUQnn067056
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 25 Sep 2018 21:30:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in fsnotify_connector_destroy_workfn (2)
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <0000000000006364200575dfc280@google.com>
 <2f4ce251-cf84-8bd2-72fc-a3ff687d5188@I-love.SAKURA.ne.jp>
 <CAOQ4uxhmFsvy6y6NgcFPs4NF1Lg7J0h2VoWgiL8WfXdDz+Z0FQ@mail.gmail.com>
 <nycvar.YFH.7.76.1809241511500.15880@cbobk.fhfr.pm>
 <20180925085506.ddzq42ci4ul3voxm@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <19a86705-308f-17af-f5d2-9abb150d2bdb@i-love.sakura.ne.jp>
Date:   Tue, 25 Sep 2018 21:30:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925085506.ddzq42ci4ul3voxm@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/25 17:55, Petr Mladek wrote:
>> I guess the patch below fixes it, however the kworker should not really be 
>> blocked by this I think ... adding a few more printk folks to double-check 
>> why the kworker would get stuck due to massive printk() flood.
> 
> It seems that the many printk() calls just delay the entire
> process and rcu gets blocked for too long. The messages are
> the same all the time. So some rate limiting looks like
> a reasonable solution.
> 

Yes. Commit 128f380410350012 ("android: binder: Rate-limit debug and userspace triggered err msgs")
chose ratelimiting as a fix for https://syzkaller.appspot.com/bug?id=0e75779a6f0faac461510c6330514e8f0e893038 .

Since syzbot did not reproduce the problem with Jiri's patch applied,
I think we can apply Jiri's patch as a fix for this problem.
