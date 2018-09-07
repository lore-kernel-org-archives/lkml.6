Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAC3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1212075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1212075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeIGVAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:00:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53976 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeIGVAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:00:32 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w87GHqXd006448;
        Sat, 8 Sep 2018 01:17:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Sat, 08 Sep 2018 01:17:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w87GHkAS006412
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 8 Sep 2018 01:17:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: bad usercopy in __check_object_size (2)
To:     keescook@chromium.org, keescook@google.com
References: <000000000000e16cba057549aab6@google.com>
Cc:     syzbot <syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com>,
        crecklin@redhat.com, dvyukov@google.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <14d5bccf-f12d-0fc1-eddc-9fb24dc0cf14@I-love.SAKURA.ne.jp>
Date:   Sat, 8 Sep 2018 01:17:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000e16cba057549aab6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/08 0:29, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=124e64d1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=62e9b447c16085cf
> dashboard link: https://syzkaller.appspot.com/bug?extid=a3c9d2673837ccc0f22b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f9cd1400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b3e8be400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com
> 
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440479
> usercopy: Kernel memory overwrite attempt detected to spans multiple pages (offset 0, size 64)!

Kees, is this because check_page_span() is failing to allow on-stack variable

   u8 opcodes[OPCODE_BUFSIZE];

which by chance crossed PAGE_SIZE boundary?
