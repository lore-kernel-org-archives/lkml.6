Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E4DC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8481D22562
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iD8GgOjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8481D22562
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGGC5z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:57:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbeGGC5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uJHxrICdYUxXfUbHJjdzFJIZm/ZbGmWsfuMMRIlKcqg=; b=iD8GgOjJS+CuxfsN+xo78hVKc
        NI124JzHZ2aiLlmWZt0jKiuLDbg31UwUOmOw6DjD6GduPVbv78yhDHNZGATSvTxgM1cDQYEtP1Vdi
        ZTje6hUGg33SuYqAw0AVIWL+KMcGNeHbhfgsRqfhRhvp3UktZ2wr4ZLnspxVuFhHSboT9jsWqq6dS
        2afg8v50wY62u7nwGF0eHFJXOB+9bBZPesQlBMpKCUKyUXkDVq0flQcfr5e5dpNuYVomKsKkj/I+g
        TzZIJL/X2a1AZVaFS9ZR2E5virVhPbZsghREjI0Nxy3ALgLVYvX5hqhmDQNZLsU1D2Wps4LGR0Bfw
        Kzx631BOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbdQ0-0005DK-4N; Sat, 07 Jul 2018 02:57:52 +0000
Date:   Fri, 6 Jul 2018 19:57:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>
Cc:     hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
Message-ID: <20180707025751.GA18609@bombadil.infradead.org>
References: <000000000000d624c605705e9010@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d624c605705e9010@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:19:02PM -0700, syzbot wrote:
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com
> 
> raw: 02fffc0000001028 ffffea0007011dc8 ffffea0007058b48 ffff8801a7576ab8
> raw: 000000000000016e ffff8801a7588930 00000003ffffffff ffff8801d9a44c80
> page dumped because: VM_BUG_ON_PAGE(page_to_pgoff(page) != index)
> page->mem_cgroup:ffff8801d9a44c80
> ------------[ cut here ]------------
> kernel BUG at mm/shmem.c:815!
> invalid opcode: 0000 [#1] SMP KASAN
> CPU: 0 PID: 4429 Comm: syz-executor697 Not tainted 4.18.0-rc3-next-20180706+
> #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:shmem_undo_range+0xdaa/0x29a0 mm/shmem.c:815

Pretty sure this one's mine.  At least I spotted a codepath earlier
today which could lead to it.  I'll fix it in the morning.
