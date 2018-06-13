Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 25F73C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BEB208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BEB208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935575AbeFMSN3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:13:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:47078 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935445AbeFMSN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:13:26 -0400
Received: from [178.197.249.11] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fTAGo-00008h-RC; Wed, 13 Jun 2018 20:13:22 +0200
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_skb_vlan_push
To:     syzbot <syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com>,
        ast@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000219be6056e8850fa@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b3af0f35-b0f8-859d-4f8f-b919d35ebaaa@iogearbox.net>
Date:   Wed, 13 Jun 2018 20:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000219be6056e8850fa@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24659/Wed Jun 13 14:39:08 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 06:17 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    75d4e704fa8d netdev-FAQ: clarify DaveM's position for stab..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1754783f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
> dashboard link: https://syzkaller.appspot.com/bug?extid=76de61614cb1abdd73fc
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12c1e1bf800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com
> 
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in skb_at_tc_ingress include/net/sch_generic.h:535 [inline]
> BUG: KASAN: slab-out-of-bounds in bpf_push_mac_rcsum net/core/filter.c:1625 [inline]
> BUG: KASAN: slab-out-of-bounds in ____bpf_skb_vlan_push net/core/filter.c:2446 [inline]
> BUG: KASAN: slab-out-of-bounds in bpf_skb_vlan_push+0x6b7/0x720 net/core/filter.c:2437
> Read of size 5 at addr ffff8801b77347d0 by task syz-executor6/6529

Should be fixed already by:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58990d1ff3f7896ee341030e9a7c2e4002570683


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
