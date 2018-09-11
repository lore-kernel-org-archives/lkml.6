Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06463C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A5C20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JIlvb+Kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A5C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIKRCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:02:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60216 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeIKRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yfJhim6pRD+xTnTPDZSwfKgny7CkKGpMGh9jvDzSbjU=; b=JIlvb+Kl4TrruRCRaPeaB7Isg
        BcwZwxZpk7hBGsY+UrBit0cFes9zkC2pQ0/UqEqvj1EidcBhUsPDWGOpr0Jxp4Tc6qA7epnj7AM43
        xsEziErFepgh9PSeMh25ZLXgBwDzLB89uCKjHw8ml7qIrz4d79SJDOlEPTPlLJNq+coLFOir3xYNx
        Q97ba9a+Xxq8/jVv/7GDFiRgTXufTOFGoqr5J/G0beZe2BKg/Nm2plVOlL1R8RpFfqJ8oXERqnDs1
        F1MDsoSc+nqm10VHZeypd8F6UKTnR2iBZhVfQhVi9Z8tAYEjOIHsHIpUA71SB9aNS034VsLjJi+sW
        EIyumHomQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzhNj-0005lq-MZ; Tue, 11 Sep 2018 12:02:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 763E22057F82D; Tue, 11 Sep 2018 14:02:58 +0200 (CEST)
Date:   Tue, 11 Sep 2018 14:02:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCHv3 6/6] tty/ldsem: Decrement wait_readers on timeouted
 down_read()
Message-ID: <20180911120258.GC19234@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-7-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911014821.26286-7-dima@arista.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:48:21AM +0100, Dmitry Safonov wrote:
> It seems like when ldsem_down_read() fails with timeout, it misses
> update for sem->wait_readers. By that reason, when writer finally
> releases write end of the semaphore __ldsem_wake_readers() does adjust
> sem->count with wrong value:
> sem->wait_readers * (LDSEM_ACTIVE_BIAS - LDSEM_WAIT_BIAS)
> 
> I.e, if update comes with 1 missed wait_readers decrement, sem->count
> will be 0x100000001 which means that there is active reader and it'll
> make any further writer to fail in acquiring the semaphore.
> 
> It looks like, this is a dead-code, because ldsem_down_read() is never
> called with timeout different than MAX_SCHEDULE_TIMEOUT, so it might be
> worth to delete timeout parameter and error path fall-back..

You might want to think about ditching that ldsem thing entirely, and
use a regular rwsem ?
