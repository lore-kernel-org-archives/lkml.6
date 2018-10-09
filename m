Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB23EC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C5213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5C5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJIJYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:24:41 -0400
Received: from nautica.notk.org ([91.121.71.147]:36588 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeJIJYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:24:41 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 99392C009; Tue,  9 Oct 2018 04:10:04 +0200 (CEST)
Date:   Tue, 9 Oct 2018 04:09:49 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Subject: Re: BUG: corrupted list in p9_read_work
Message-ID: <20181009020949.GA29622@nautica>
References: <000000000000ca61cd0571178677@google.com>
 <000000000000fddb150577c15af6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000fddb150577c15af6@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot wrote on Mon, Oct 08, 2018:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    0854ba5ff5c9 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1514ec06400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
> dashboard link: https://syzkaller.appspot.com/bug?extid=2222c34dc40b515f30dc
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b91685400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com
> 
> list_del corruption, ffff88019ae36ee8->next is LIST_POISON1
> (dead000000000100)
> ------------[ cut here ]------------
> [...]
>  list_del include/linux/list.h:125 [inline]
>  p9_read_work+0xab6/0x10e0 net/9p/trans_fd.c:379

Hmm this looks very much like the report from
syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com 
which should have been fixed by Tomas in 9f476d7c540cb
("net/9p/trans_fd.c: fix race by holding the lock")...

It looks like another double list_del, looking at the code again there
actually are other ways this could happen around connection errors.
For example,
 - p9_read_work receives something and lookup works... meanwhile
 - p9_write_work fails to write and calls p9_conn_cancel, which deletes
from the req_list without waiting for other works to finish (could also
happen in p9_poll_mux)
 - p9_read_work finishes processing the read and deletes from list again

For this one the simplest fix would probably be to just not
list_del/call p9_client_cb at all if m->r?req->status isn't
REQ_STATUS_ERROR in p9_read_work after the "got new packet" debug print,
and frankly I think that's saner so I'll send a patch shortly doing
that, but I have zero confidence there aren't similar bugs around, the
tcp code is so messy... Most of the syzbot reports recently have been
around trans_fd which I don't think is used much in real life, and this
is not really motivating (i.e. I think it would probably need a more
extensive rewrite but nobody cares) :/


Dmitry, on that note, do you think syzbot could possibly test other
transports somehow? rdma or virtio cannot be faked as easily as passing
a fd around, but I'd be very interested in seeing these flayed a bit.

(I'm also curious what logic is used to generate the syz tests, the
write$P9_Rxx replies have nothing to do with what the client would
expect so it probably doesn't test very far; this test in particular
does not even get past the initial P9_TVERSION that the client would
expect immediately after mount, so it's basically only testing logic
around packet handling on error... Or if we're accepting a RREADDIR in
reply to TVERSION we have bigger problems, and now I'm looking at it I
think we just might never check that....... I'll look at that for the
next cycle)


Back to the current patch, since as I said I am not confident this is a
good enough fix for the current bug, will I get notified if the bug
happens again once the patch hits linux-next with the Reported-by tag ?
(I don't have the setup necessary to run a syz repro as there is no C
repro, and won't have much time to do that setup sorry)


> FS-Cache: N-cookie d=000000000a092700 n=00000000d8ee0022
> FS-Cache: N-key=[10] '34323935303034313132'
> FS-Cache: Duplicate cookie detected
> FS-Cache: O-cookie c=00000000911358e4 [p=000000006545c95d fl=222 nc=0 na=1]
> FS-Cache: O-cookie d=000000000a092700 n=000000007635356b
> FS-Cache: O-key=[10] '
> [...]

(on an unrelated topic, I got these FS-Cache warnings quite often when
testing with cache enabled and have no idea what they mean. I don't
normally use cache so haven't spent time looking at it, but I find these
rather worrying... If someone having a clue reads this, I'd love to hear
what they could mean and what we should look at)

Thanks,
-- 
Dominique
