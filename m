Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDDECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EA720673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dzq8NqPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EA720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbeGTCL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:11:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbeGTCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/vqA3JYo6kYqrtPKg3h/IW4GQuM+/SGZXzmqNxV2oMY=; b=dzq8NqPjDJrSRKAxXlyuq0y1J
        GkQffvFBEEWsv6JKnpWw7Qsd5E/TF1wdbAMUXyFIqic9FV52p+lJVPfM8aGyzJmIXQ8VDNGZwqL0g
        FYEyNZXITqWfHdJEZpKFs5X5m8wsg1fNmfsWTqpsaRtP9CgqygxWKi5yVsyGxvxCM7rz5cZHOLTji
        kxmjwDboWydvp+/BFHMXC1R6fi5qILzjl2fIQp39wdRrCZZSfN3+l2DBjZuuwjfcRObKdbCNb5QPz
        d1wPLPlu7YU0AaOg8tUxcajd5a42YQFzKJns2eMtfQ+dCJ86ZUpWIY8M5yRRWzfeoyFlJ4XiBpZP4
        a/rFcHxOA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgKAq-0003If-B5; Fri, 20 Jul 2018 01:25:36 +0000
Date:   Thu, 19 Jul 2018 18:25:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+b173e77096a8ba815511@syzkaller.appspotmail.com>,
        jack@suse.cz, jlayton@redhat.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, mgorman@techsingularity.net
Subject: Re: [V9fs-developer] KASAN: use-after-free Read in
 generic_perform_write
Message-ID: <20180720012536.GA27335@bombadil.infradead.org>
References: <00000000000047116205715df655@google.com>
 <20180719170718.8d4e7344fe79b2ad411dde98@linux-foundation.org>
 <20180720002704.GA20844@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720002704.GA20844@nautica>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:27:05AM +0200, Dominique Martinet wrote:
> Andrew Morton wrote on Thu, Jul 19, 2018:
> > On Thu, 19 Jul 2018 11:01:01 -0700 syzbot <syzbot+b173e77096a8ba815511@syzkaller.appspotmail.com> wrote:
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    1c34981993da Add linux-next specific files for 20180719
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16e6ac44400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7002497517b09aec
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b173e77096a8ba815511
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > 
> > > Unfortunately, I don't have any reproducer for this crash yet.
> 
> > I'm suspecting v9fs.  Does that fs attempt to write to the fs from a
> > kmalloced buffer?
> 
> Difficult to say without any idea of what syzkaller tried doing, but it
> looks like it hook'd up a fd opened to a local ext4 file into a trans_fd
> mount; so sending a packet to the "server" would trigger a local write
> instead.
> The reason it's freed too early probably is that the reply came from a
> read before the write happened; this is going to be tricky to fix as
> that write is 100% asynchronous without any feedback right now (the
> design assumes that the write has to have finished by the time reply
> came), but if we want to protect ourselves from rogue servers we'll have
> to think about something.
> 
> I'll write it down to not forget, thanks for the cc.

I suspect this got unmasked by my changes; before it would allocate
buffers and just leave them around.  Now it'll free them, which means we
get to see this reuse (rather than having the buffer reused and getting
corrupt data written).

Not that I'm volunteering to fix this problem ;-)
