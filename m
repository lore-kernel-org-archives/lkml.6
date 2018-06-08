Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6F4bE+WNGltyQwAAmS7hNA
	; Fri, 08 Jun 2018 14:08:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3DDBB607E4; Fri,  8 Jun 2018 14:08:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C77A560290;
	Fri,  8 Jun 2018 14:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C77A560290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeFHOIe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:08:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63040 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeFHOId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:08:33 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w58E8KVT086166;
        Fri, 8 Jun 2018 23:08:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Fri, 08 Jun 2018 23:08:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w58E8DvY086102
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 8 Jun 2018 23:08:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 corrupted
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+f5066e369b2d5fff630f@syzkaller.appspotmail.com>,
        ubraun@linux.ibm.com, linux-s390@vger.kernel.org
Cc: David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000b98577056e212120@google.com>
 <CACT4Y+Z9PL4m85TGBfoLLOrw3PtqiCf+vLgdXnLUMPmHcBC33A@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <c85f1751-a6de-7993-d687-8277a48a118e@I-love.SAKURA.ne.jp>
Date: Fri, 8 Jun 2018 23:08:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z9PL4m85TGBfoLLOrw3PtqiCf+vLgdXnLUMPmHcBC33A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/08 22:39, Dmitry Vyukov wrote:
> On Fri, Jun 8, 2018 at 3:11 PM, syzbot
> <syzbot+f5066e369b2d5fff630f@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    68abbe729567 Merge branch 'akpm' (patches from Andrew)
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16f7cebf800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5a4673d4582131c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f5066e369b2d5fff630f
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1191756f800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162236af800000
> 
> The reproducer suggests that this is in smc.
> +smc maintainers

Yes, an unprivileged user can trigger this oops.

----------
#include <sys/socket.h>
#include <sys/epoll.h>
#define PF_SMC 43

int main(int argc, char *argv[])
{
	struct epoll_event ev = { };
	int sfd = socket(PF_SMC, SOCK_STREAM, 0);
	int epfd = epoll_create(1);
	epoll_ctl(epfd, EPOLL_CTL_ADD, sfd, &ev);
	return 0;
}
----------
