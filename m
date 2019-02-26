Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80430C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8D02173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="E7UQjXtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfBZLiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:38:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39452 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfBZLiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:38:23 -0500
Received: from zn.tnic (p200300EC2BCDB2001DA4ECEFA9208567.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:1da4:ecef:a920:8567])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3990A1EC023E;
        Tue, 26 Feb 2019 12:38:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551181101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SgzHwqbqQa6892+kC8DluEMNyaRZPOf77dEZGKPYUD0=;
        b=E7UQjXtu/H2Du4oouFSLoTtdDDNI4126VZVJnGw1wrcv0jHom29Pe2VNHaohFZr4QmKGhh
        7Mc2yjHCS4wD4EEtNfo0EieP31DQlcKlMffswWCv4EkeGI2p9JQutcTJxXvbs/5fZLdJSA
        i8OMWOBYTBoeQQROcAmu8FonRWkB1gQ=
Date:   Tue, 26 Feb 2019 12:38:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226113813.GA14753@zn.tnic>
References: <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226113008.GI32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
> still broken.

As requested on IRC:

$ gcc --version
gcc (SUSE Linux) 4.8.5
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ cat ptr.c
#include <stdio.h>
#include <string.h>
int y = 2, x = 1;
int main (int argc, char **argv) {
        int *p = &x + 1;
        int *q = &y;
        printf("p=%p q=%p\n", p, q);
        if (!memcmp(&p, &q, sizeof(p))) {
                *p = 11;
                printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);

$ gcc -O2 -fno-strict-aliasing  -o ptr ptr.c ; ./ptr
p=0x601044 q=0x601044
x=1 y=2 *p=11 *q=2

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
