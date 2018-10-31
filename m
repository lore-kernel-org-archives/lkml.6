Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E16C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616C6205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616C6205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJaSyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:54:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59774 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeJaSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:54:05 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9V9uUup097908;
        Wed, 31 Oct 2018 18:56:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Wed, 31 Oct 2018 18:56:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9V9uOUc097778
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 31 Oct 2018 18:56:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING in kernfs_get
To:     gregkh@linuxfoundation.org, tj@kernel.org
References: <000000000000f921ae05757f567c@google.com>
Cc:     syzbot <syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <c5672ee5-6acb-ac99-6c2d-f0fcb479e202@I-love.SAKURA.ne.jp>
Date:   Wed, 31 Oct 2018 18:56:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000f921ae05757f567c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/10 16:31, syzbot wrote:
> HEAD commit:    9a5682765a2e Merge branch 'x86-urgent-for-linus' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1624858e400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3dcb532381f98c86aeb1
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12657f0a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117728ae400000

Here is a simplified reproducer.

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int i;
	for (i = 0; i < 16; i++)
		if (fork() == 0)
			while (1) {
				int fd = open("/dev/vhci", O_WRONLY);
				write(fd, "\xff\x80", 2);
				close(fd);
			}
	while (1)
		pause();
	return 0;
}
----------

According to debug printk() patch,
atomic_read(&kn->active) == KN_DEACTIVATED_BIAS when we hit
WARN_ON(!atomic_read(&kn->count)) at kernfs_get().

Therefore, I guess that the caller is failing to check whether
kn is already deactivated (and hence need to recreate a new
entry by that name) before reusing existing kn.
