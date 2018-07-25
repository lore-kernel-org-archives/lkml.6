Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2EF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZGQHnSzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2EF2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeGYEA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:00:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeGYEAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d/JxmQz6XPBDdbYj1s26KRPIn+BN2cbXK4D2HjoIVCA=; b=ZGQHnSzzYLVusYII4KkxziuJJ
        FGAB1rucwTtpWj+ZwrZFhvsHIyTzmnLx7zvXmqT1bM+noPMXdPiGG/QfbefET6ezBYmhgWlJhXTsh
        ejTr+6W+pcV+GTWMobjuqNF1Iko7wt7DNeLAlIDa0vsJvaC81NHEsB68Rz1iLjp8+g5JNZPWze2Ag
        sX9j9QdorjPm6HqVVkEf/ZCfYOml7cHKBi1Hr44vNjtHyDqHoqtp4THinoRL7zf+c0+Wm14urA04d
        6mV5LeV/vU1/2pHfk5XfVtWQSPMxFpH/BZI5+wNycai4lbJiHMxfSNGYEZ5NJSYux4ScBsMiQWqMf
        WC1OlcpbQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi9td-0001zS-2i; Wed, 25 Jul 2018 02:51:25 +0000
Date:   Tue, 24 Jul 2018 19:51:24 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180725025124.GC16271@bombadil.infradead.org>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:32:50AM +0900, Minchan Kim wrote:
> > [  804.485321] BUG: Bad page state in process qemu-system-x86  pfn:1c4b08e
> > [  804.485403] page:ffffe809312c2380 count:0 mapcount:0
> > mapping:0000000000000000 index:0x1
> > [  804.485483] flags: 0x17fffc000000008(uptodate)
> > [  804.485554] raw: 017fffc000000008 0000000000000000 0000000000000001
> > 00000000ffffffff
> > [  804.485632] raw: dead000000000100 dead000000000200 0000000000000000
> > 0000000000000000
> > [  804.485709] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
> > [  804.485782] bad because of flags: 0x8(uptodate)

The message here even tells you what the problem is.  The page
was marked Uptodate at the time that it was allocated.  There aren't
any other flags that alias Uptodate, so somebody is failing to clear
the Uptodate bit when they ought to.

> > [  804.485891] Call Trace:
> > [  804.485899]  dump_stack+0x5c/0x7b
> > [  804.485902]  bad_page+0xba/0x120
> > [  804.485905]  get_page_from_freelist+0x1016/0x1250
> > [  804.485908]  __alloc_pages_nodemask+0xfa/0x250

Also note that this is in the allocation path; this flag isn't checked
at free.  But it is cleared on free, so someone's stomping on page->flags
after they're freed.  I suggest enabling more debugging code.
