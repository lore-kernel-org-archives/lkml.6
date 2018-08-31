Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8197A2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jelIu//P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8197A2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeHaXZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:25:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XkRtyCxu3r8Zhxu8rcdfGndJLyorZ5E6H4SaM8QtWDY=; b=jelIu//PsXEjYCk42oRW9uIj8W
        dnkroLfQxhOAYas1h4gpv/IRN+nPCBADzDzBfby+qpp/Mzp0ySAF0S+cQoT5qXfAqs5U6BlHywq05
        i6fw33weIuowEnMNm+29onidP7aYve2JC89bVweYqR8VGa7NemXIx7KrSJNE5wnSsuZ4uGpOwseDA
        VBbXPv3RF22OwkMtPmVt12P8EqOLYQROeTp9cOxtLuhti341e+Fki8qu7Pxg8JFqMskH4p86bd5uU
        +i1kgruDlmTQt4DOfRoC8XdRmhMoLfebCnkDexC8v7BE9xHoIbvUTw6d01QdEmMGc4MJHg74vXstN
        LAVdz28g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvou2-0000iR-Ly; Fri, 31 Aug 2018 19:16:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2AD02024EB09; Fri, 31 Aug 2018 21:16:11 +0200 (CEST)
Date:   Fri, 31 Aug 2018 21:16:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Numan =?utf-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: Keyboard not responding after resuming from
 suspend/hibernate
Message-ID: <20180831191611.GR24124@hirez.programming.kicks-ass.net>
References: <20180831215121.1b1f66bf@korsan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831215121.1b1f66bf@korsan.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 09:53:11PM +0300, Numan Demirdöğen wrote:
> If I put laptop to suspend or hibernate by closing lid, power
> manager or any other method and then I resume/wake up laptop, keyboard
> is not responding. My laptop is a Sony Vaio VPCEH2F1E. 
> 
> Steps to produce bug:
> 1. Boot
> 2. Put laptop to sleep
> 3. Resume
> What I expect to happen: Keyboard responds to key press.
> What happens: Keyboard does not respond but mouse and trackball are
> working.
> 
> git bisect point 9d659ae14b545c4296e812c70493bfdc999b5c1c as the first
> bad commit.
> 
> Bad commit link:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=9d659ae14b545c4296e812c70493bfdc999b5c1c

That doesn't make any kind of sense... if that commit had trouble (oddly
there is one another report fingering this) all the mutex locking should
be busted (and there is a _lot_ of that in the kernel).

I really wouldn't know where to begin debugging this. Suspend/resume
isn't really something I know much of, all I can say it that it works on
my laptop.

Rafael, any idea where to start looking for this?

>  Link to actual bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=195471

No, _this_ is the actual report, that is a random website you put stuff
on.
