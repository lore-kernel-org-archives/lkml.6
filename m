Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B513FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5214D20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jYvES1gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5214D20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbeGWPDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:03:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NWQt7U5xZWX+04emklGrNLrQvySHXzM9x204aMbtzFc=; b=jYvES1gTo9Ljw683DU3BBnbG4
        dsuMAivJYNZqQjTBYl4/+odZtXRrwP/y/wXW93iaSmeoiSAtJ9b9PrmmBAuGWM/9pIifwFEkg5cWx
        x8Anb7N4NOeW0Qbc0AMldUh/M1J8ixRx+0MSuxG5KhJCPdSd6gk2adEzkI9A+5maQmk17BcA70jnC
        JGAnU0XCHsqhOE+QrMlpnr2n0y/fKjpplxCb7IWHU0S2xNGIgDEw+51rOhrQnPS4dcdn3H/ZCthwQ
        59ku7v4XB42KpxTp6aOsbcS15VcDK5hDHwSGvMQs/XN7FcwG7kaJTCpK0JUlSBFgaAp9GNY7P1gxP
        zeDRBdjgQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhbPK-0007ZB-S8; Mon, 23 Jul 2018 14:01:50 +0000
Date:   Mon, 23 Jul 2018 07:01:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
Message-ID: <20180723140150.GA31843@bombadil.infradead.org>
References: <000000000000d624c605705e9010@google.com>
 <20180709143610.GD2662@bombadil.infradead.org>
 <alpine.LSU.2.11.1807221856350.5536@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1807221856350.5536@eggly.anvils>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 07:28:01PM -0700, Hugh Dickins wrote:
> Whether or not that fixed syzbot's kernel BUG at mm/shmem.c:815!
> I don't know, but I'm afraid it has not fixed linux-next breakage of
> huge tmpfs: I get a similar page_to_pgoff BUG at mm/filemap.c:1466!
> 
> Please try something like
> mount -o remount,huge=always /dev/shm
> cp /dev/zero /dev/shm
> 
> Writing soon crashes in find_lock_entry(), looking up offset 0x201
> but getting the page for offset 0x3c1 instead.

Hmm.  I don't see a crash while running that command, but I do see an RCU
stall in find_get_entries() called from shmem_undo_range() when running
'cp' the second time -- ie while truncating the /dev/shm/zero file.
Maybe I'm seeing the same bug as you, and maybe I'm seeing a different
one.  Do we have a shmem test suite somewhere?

> I've spent a while on it, but better turn over to you, Matthew:
> my guess is that xas_create_range() does not create the layout
> you expect from it.

I've dumped the XArray tree on my machine and it actually looks fine
*except* that the pages pointed to are free!  That indicates to me I
screwed up somebody's reference count somewhere.
