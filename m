Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BD32073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BD32073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeH3Nxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:53:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:57241 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeH3Nxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:53:41 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fvJcf-0004Nf-MN; Thu, 30 Aug 2018 11:52:17 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fvJcf-0002d0-Dm; Thu, 30 Aug 2018 11:52:17 +0200
Subject: Re: KASAN: stack-out-of-bounds Read in __schedule
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+45a34334c61a8ecf661d@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>
References: <000000000000fef39305748083ae@google.com>
 <20180829134620.GD7369@quack2.suse.cz>
 <CAG_fn=VMcHaGrFs_YvtBttmfuz8Rr1C_dfmKRibvPrbqeKFGCA@mail.gmail.com>
 <CACT4Y+a2bwVvDRfL=wg=5bnOv6S7RrJYoh4ygaizqVm3JpNu1A@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <279041ab-d449-1bfb-a05d-2d8b0d5c601b@iogearbox.net>
Date:   Thu, 30 Aug 2018 11:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a2bwVvDRfL=wg=5bnOv6S7RrJYoh4ygaizqVm3JpNu1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24886/Thu Aug 30 06:46:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 06:11 AM, Dmitry Vyukov wrote:
> On Wed, Aug 29, 2018 at 7:03 AM, 'Alexander Potapenko' via
> syzkaller-bugs <syzkaller-bugs@googlegroups.com> wrote:
>> On Wed, Aug 29, 2018 at 3:46 PM Jan Kara <jack@suse.cz> wrote:
>>> On Tue 28-08-18 08:30:02, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    5b394b2ddf03 Linux 4.19-rc1
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14f4d8e1400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=45a34334c61a8ecf661d
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13127e5a400000
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+45a34334c61a8ecf661d@syzkaller.appspotmail.com
>>>>
>>>> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
>>>> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
>>>> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>>>> 8021q: adding VLAN 0 to HW filter on device team0
>>>> ==================================================================
>>>> BUG: KASAN: stack-out-of-bounds in schedule_debug kernel/sched/core.c:3285
>>>> [inline]
>>>> BUG: KASAN: stack-out-of-bounds in __schedule+0x1977/0x1df0
>>>> kernel/sched/core.c:3395
>>>> Read of size 8 at addr ffff8801ad090000 by task syz-executor0/4718
>>>
>>> Weird, can you please help me decipher this? So here KASAN complains about
>>> wrong memory access in the scheduler.
> 
> This looks like a result of a previous bad silent memory corruption.
> 
> The KASAN report says there is a stack out-of-bounds in scheduler. And
> that if followed by slab corruption report in another task.
> 
> fs/jbd2/transaction.c happens to be the first meaningful file in this
> crash, and so that's where it is attributed to.
> 
> Rerunning the reproducer several times can maybe give some better
> glues, or maybe not, maybe they all will look equally puzzling.
> 
> This part of the repro looks familiar:
> 
> r1 = bpf$MAP_CREATE(0x0, &(0x7f0000002e40)={0x12, 0x0, 0x4, 0x6e, 0x0,
> 0x1}, 0x68)
> bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000180)={r1, &(0x7f0000000000),
> &(0x7f0000000140)}, 0x20)
> 
> We had exactly such consequences of a bug in bpf map very recently,
> but that was claimed to be fixed. Maybe not completely?
> +bpf maintainers

Looks like syzbot found this in Linus tree with HEAD commit 5b394b2ddf03 ("Linux 4.19-rc1")
one day later net PR got merged via 050cdc6c9501 ("Merge git://git.kernel.org/pub/...").

This PR contained a couple of fixes I did on sockmap code during audit such as:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b845c898b2f1ea458d5453f0fa1da6e2dfce3bb4

Looking at the reproducer syzkaller found it contains:

  r1 = bpf$MAP_CREATE(0x0, &(0x7f0000002e40)={0x12, 0x0, 0x4, 0x6e, 0x0, 0x1}, 0x68)
                                                    ^^^

So it found the crash with map type of sock hash and key size of 0x0 (which is invalid),
where subsequent map update triggered the corruption. I just did a 'syz test' and it
wasn't able to trigger the crash anymore.

#syz fix: bpf, sockmap: fix sock_hash_alloc and reject zero-sized keys
