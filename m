Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id n/N5LyeBHFuFQQAAmS7hNA
	; Sun, 10 Jun 2018 01:38:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A2355608C8; Sun, 10 Jun 2018 01:38:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A6647601D2;
	Sun, 10 Jun 2018 01:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6647601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbeFJBik (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 21:38:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15941 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753564AbeFJBij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 21:38:39 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5A1cQpY049942;
        Sun, 10 Jun 2018 10:38:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Sun, 10 Jun 2018 10:38:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5A1cKPF049790
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 10 Jun 2018 10:38:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 sock_poll
To: syzbot <syzbot+344bb0f46d7719cd9483@syzkaller.appspotmail.com>,
        ubraun@linux.ibm.com, linux-s390@vger.kernel.org
References: <00000000000080d9a6056e3aeb35@google.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1250334f-7220-2bff-5d87-b87573758d81@I-love.SAKURA.ne.jp>
Date: Sun, 10 Jun 2018 10:38:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <00000000000080d9a6056e3aeb35@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/10 4:57, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1188a05f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f04d8d0a2afb789a
> dashboard link: https://syzkaller.appspot.com/bug?extid=344bb0f46d7719cd9483
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12b5841f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f4005f800000

This is a same report except s/epoll/poll/ .

----------
#include <sys/socket.h>
#include <sys/poll.h>
#define PF_SMC 43

int main(int argc, char *argv[])
{
	int sfd = socket(PF_SMC, SOCK_STREAM, 0);
	struct pollfd pfd = { .fd = sfd };
	poll(&pfd, 1, 0);
	return 0;
}
----------

#syz dup: BUG: unable to handle kernel NULL pointer dereference in corrupted
