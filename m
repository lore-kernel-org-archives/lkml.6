Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0ADC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642E520657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b4e32TDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642E520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeKACjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:39:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbeKACjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pjq19D//p3UoJ5RYfbIbxvjAymoVDf4guMv3jU5GGu8=; b=b4e32TDzDOn66t3O2PtXXI03C
        6N5yJrLkvu34blE6hUgDwSABp945Y3rw/xuqVkTfLoTx7vo9vPg46E+/y2ekMr3DNyGNjmnWPOR2G
        MLjToWWj6xW2hJehUwJsYbhZdpAk88ZsLIMm8G25DWTzE636R/Jy4k+9UtzWglOJUookRD8nFASqM
        DrOlQqYXIvqCI2458kx70156SkOjk+GLU+BuOoN2Kj0EP5Hsth2ETC+b9cjcU/l1TfDcu8ECzHcC2
        HweJhae7OSg+KrRO1XCr7PTKR54L86sEqJbQEOQHOxLSB+R6q2VxCYy41K28OlZXNbM98PRO0tQwL
        /7VzEOgkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHuT8-0005tW-ED; Wed, 31 Oct 2018 17:39:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC8692029F87F; Wed, 31 Oct 2018 18:39:47 +0100 (CET)
Date:   Wed, 31 Oct 2018 18:39:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181031173947.GE13219@hirez.programming.kicks-ass.net>
References: <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <20181030104554.GB8177@hirez.programming.kicks-ass.net>
 <20181030120804.2f30c2da@sweethome>
 <2942706f-db18-6d38-02f7-ef21205173ca@redhat.com>
 <20181031164009.GM18091@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031164009.GM18091@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 05:40:10PM +0100, Juri Lelli wrote:
> I'm seeing something along the lines of what Peter suggested as a last
> resort measure we probably still need to put in place.

Yes, you certainly hope to never hit that, and should not in a proper
setup. But we need something to keep things 'working'.
