Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA8DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5FB2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vnMYgtGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5FB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbeLMJWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:22:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45408 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeLMJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6FavMZivlXXT+bx2cCfK4GzatzlI1o0S4bdTkl/mZqY=; b=vnMYgtGFYDS3IRivSxCjXn8Am
        I+He4usxqESnNq12Ehuk7URuPLpVhaQsAPFWLFyIuHbH8jlIBgNciQM+nLDK2EAW1o9Iej6fGDVnU
        DRet6AMfm3Nt+Ju4G2uCtT4CJ0AY/MDtxKyKFS70fGHL2IGK5ID20e8NEQkpQnALtMTb5rFHm1NZW
        W3mWjGeAHH08VOD77Bib8wokXsDMUDLZhubhbpIeG1KO90JzjKxah2AYMoLtFw1fXZXeixz0M+Pyu
        svua8HCajB5UkpKjgGnsDb01l76PTGbfJoaNvkRP6rBFp7svBKV4zDHYzOxZ9fLcdQGVnZ6UwG7GP
        eAIrHwJjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXNBw-0002Nb-JQ; Thu, 13 Dec 2018 09:22:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55DEE207261E4; Thu, 13 Dec 2018 10:21:59 +0100 (CET)
Date:   Thu, 13 Dec 2018 10:21:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181213092159.GE5289@hirez.programming.kicks-ass.net>
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
 <20181213025940.GF4860@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213025940.GF4860@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:59:40AM +0900, Sergey Senozhatsky wrote:
> On (12/12/18 17:28), Waiman Long wrote:
> > 
> > warning from lockdep as reported in https://lkml.org/lkml/2018/12/11/143.
> > 
> 
> That link shows an empty page, lkml.org is quite unstable. Let's
> use this one instead:
> 
> https://lore.kernel.org/lkml/20181211091154.GL23332@shao2-debian/T/#u

Better yet:

  https://lkml.kernel.org/r/20181211091154.GL23332@shao2-debian
