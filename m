Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B8EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D932087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YEzc1aPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfARKYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:24:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfARKYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:24:49 -0500
Received: from zn.tnic (p200300EC2BCB1B0039C8CE17CD8BEE66.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:1b00:39c8:ce17:cd8b:ee66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 038BF1EC0242;
        Fri, 18 Jan 2019 11:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547807088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rHjjAoPZ5WzSd01uaObMcFJeh6ALPK1Gb/WHY2w5Pz8=;
        b=YEzc1aPy3mXS3qxIvYcxq0E0DAJLq2Su44Fw1dsitFo2thcK2+srOrcFwxCWb+FW9zfvGD
        Mp0RL3mPPcq42t6gQeBz44emTDHXFAiNCAUHtLZ9ASqvYKiynA5XIoaZfnSQU55h/J64oH
        /g6G2YYqbOWCKCKDI2x8qQqVzpNWh+w=
Date:   Fri, 18 Jan 2019 11:24:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     James Morse <james.morse@arm.com>,
        Waiman Long <longman@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Question about qspinlock nest
Message-ID: <20190118102427.GA622@zn.tnic>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
 <d06126a1-1db8-f937-2084-2c1234b6f56f@arm.com>
 <20190110201217.GH2861@worktop.programming.kicks-ass.net>
 <a270215d-ec5a-8b8a-3786-c0480b640abc@arm.com>
 <20190114131613.GB10486@hirez.programming.kicks-ass.net>
 <830db851-d5cb-4081-8d72-e3f3a0a282df@arm.com>
 <20190118100229.GB27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118100229.GB27931@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:02:29AM +0100, Peter Zijlstra wrote:
> Well, x86 too has multiple non-maskable vectors, and afaik only the
> actual NMI vector is covered in tricky. But our MCE vector is
> non-maskable too (and I have vague memories of there being more).
> 
> Boris, Rostedt, WTH happens if our MCE code goes and hits a #BP ? (not
> unlikely with this proliferation of self-modifying code)
> 
> Anyway, the idea is that they can indeed not interrupt themselves, but I
> would not be surprised if the whole MCE thing is riddled with fail (on
> x86).

As we talked on IRC: we'll apply a mixture of "So don't do that
then!" hints i.e., kprobing MCE code etc, and fix the issues like the
schedule_work() invocation.

In general, I'd like to make/keep the #MC handler as simple and
as idiot-proof as possible.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
