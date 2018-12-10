Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18027C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC54C20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC54C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeLJMzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:55:39 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:57786 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbeLJMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:55:38 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gWL5y-0007nG-Qx; Mon, 10 Dec 2018 13:55:34 +0100
Date:   Mon, 10 Dec 2018 13:55:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+0b2f1bc876d301440d44@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in xfrm_policy_inexact_gc_tree
Message-ID: <20181210125534.kkqm6ulfehm4kzso@breakpoint.cc>
References: <000000000000d58636057ca63247@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d58636057ca63247@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+0b2f1bc876d301440d44@syzkaller.appspotmail.com> wrote:
> 
> HEAD commit:    74c4a24df7ca Add linux-next specific files for 20181207
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bbea7d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6e9413388bf37bed
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b2f1bc876d301440d44
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0b2f1bc876d301440d44@syzkaller.appspotmail.com
> 
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> WARNING: CPU: 0 PID: 13116 at net/xfrm/xfrm_policy.c:1066
> xfrm_policy_inexact_gc_tree+0x233/0x280 net/xfrm/xfrm_policy.c:1066

This means we're exiting from net namespace, but for some reason
policies would be left behind.

At this point the storage should only contain empty nodes,
as all policies are supposed to be gone.

I'll have a look.
