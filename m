Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755069AbeEHNSV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:18:21 -0400
Received: from mail5.windriver.com ([192.103.53.11]:33930 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeEHNST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:18:19 -0400
Subject: Re: KMSAN: uninit-value in strcmp
To: David Miller <davem@davemloft.net>,
        <syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com>
CC: <jon.maloy@ericsson.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <tipc-discussion@lists.sourceforge.net>
References: <00000000000059f907056b519603@google.com>
 <20180503.152213.740988890883315228.davem@davemloft.net>
From: Ying Xue <ying.xue@windriver.com>
Message-ID: <cb60d6f0-4e32-b360-d1f2-032ee7777fcd@windriver.com>
Date: Tue, 8 May 2018 21:12:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503.152213.740988890883315228.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 03:22 AM, David Miller wrote:
> From: syzbot <syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com>
> Date: Thu, 03 May 2018 11:44:02 -0700
> 
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:17 [inline]
>>  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>>  strcmp+0xf7/0x160 lib/string.c:329
>>  tipc_nl_node_get_link+0x220/0x6f0 net/tipc/node.c:1881
>>  genl_family_rcv_msg net/netlink/genetlink.c:599 [inline]
> 
> Hmmm, TIPC_NL_LINK_GET uses tipc_nl_policy, which has a proper nesting
> entry for TIPC_NLA_LINK.  I wonder how the code goes about validating
> TIPC_NLA_LINK_NAME in such a case?  Does it?
> 
> This may be the problem.

David, you are right. This is absolutely a real bug. As you said, we
didn't validate TIPC_NLA_LINK_NAME attribute in tipc_nl_node_get_link()
at all.

I will submit a patch to fix the issue soon.

> 
