Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD711C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FF920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HbST/1CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FF920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeIKQnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:43:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59994 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YyviicP+lTpBCPn/WgAStSGu/SbAo4yVeTel1oh4zLI=; b=HbST/1CFOQ3I9Ifcj0cDPUO2z
        6bGp1TLfmK8nmtJUw1OA9NMsksbtiUE/mxORwFenquCGkWmIZG7IPPFuJMJRIRrhvcwOQ5VxEKg0Z
        CEf5i/yPuau8IAuHf9t0LMnqL99ioaGp8NHCI0wnaiBP9YnGt7de0zrtm+0RtEfKvxxxyN7UJiUkD
        BvuqtSovjn97DOWonDp0H65tfdoeeZgY4n6qbSueyAS31+8lmQVMSzW94G7EigwuG2si+Cdz33aZa
        hHOGVErR/Seks74uE+JcRbpYzFXusugA4zhwFlUGNPbBWJuXArSSC3LjYmiq6XDS3bu0yjCumhogs
        WPP5L1rSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzh5q-0005gP-PT; Tue, 11 Sep 2018 11:44:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 934692057F833; Tue, 11 Sep 2018 13:44:29 +0200 (CEST)
Date:   Tue, 11 Sep 2018 13:44:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCHv3 2/6] tty/ldsem: Update waiter->task before waking up
 reader
Message-ID: <20180911114429.GT24106@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-3-dima@arista.com>
 <20180911050449.GB4065@jagdpanzerIV>
 <20180911054129.GC4065@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911054129.GC4065@jagdpanzerIV>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:41:29PM +0900, Sergey Senozhatsky wrote:
> On (09/11/18 14:04), Sergey Senozhatsky wrote:
> > >  	for (;;) {
> > >  		set_current_state(TASK_UNINTERRUPTIBLE);
> > 
> > I think that set_current_state() also executes memory barrier. Just
> > because it accesses task state.
> > 
> > > -		if (!waiter.task)
> > > +		if (!READ_ONCE(waiter.task))
> > >  			break;
> > >  		if (!timeout)
> > >  			break;
> 
> This READ_ONCE(waiter.task) looks interesting. Maybe could be moved
> to a loop condition
> 
> 	while (!READ_ONCE(waiter.task)) {
> 		...
> 	}

No, it must be after set_current_state(). See that same comment.
