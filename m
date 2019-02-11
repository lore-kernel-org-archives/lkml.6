Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCF3C282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CC320844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfBKIIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:08:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:51600 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKIIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:08:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1B86w2Y026260;
        Mon, 11 Feb 2019 02:07:00 -0600
Message-ID: <5dadc1b0aee62ce8371cabaa35ea4bbe6b71f48f.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 03/16] powerpc/32: move LOAD_MSR_KERNEL() into
 head_32.h and use it
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 Feb 2019 19:06:58 +1100
In-Reply-To: <b074648b-8896-5591-16fe-3ecaf5c7553a@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
         <1946d8ed86a92a9a6827ec260d0d9c99e0d88184.1549630193.git.christophe.leroy@c-s.fr>
         <749f719a0881531cad2071a7011dc5e894812d3d.camel@kernel.crashing.org>
         <b074648b-8896-5591-16fe-3ecaf5c7553a@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-11 at 07:26 +0100, Christophe Leroy wrote:
> 
> Le 11/02/2019 à 01:21, Benjamin Herrenschmidt a écrit :
> > On Fri, 2019-02-08 at 12:52 +0000, Christophe Leroy wrote:
> > >   /*
> > > + * MSR_KERNEL is > 0x8000 on 4xx/Book-E since it include MSR_CE.
> > > + */
> > > +.macro __LOAD_MSR_KERNEL r, x
> > > +.if \x >= 0x8000
> > > +       lis \r, (\x)@h
> > > +       ori \r, \r, (\x)@l
> > > +.else
> > > +       li \r, (\x)
> > > +.endif
> > > +.endm
> > > +#define LOAD_MSR_KERNEL(r, x) __LOAD_MSR_KERNEL r, x
> > > +
> > 
> > You changed the limit from >= 0x10000 to >= 0x8000 without a
> > corresponding explanation as to why...
> 
> Yes, the existing LOAD_MSR_KERNEL() was buggy because 'li' takes a 
> signed u16, ie between -0x8000 and 0x7999.

Ah yes, I was only looking at the "large" case which is fine...

> By chance it was working because until now nobody was trying to set 
> MSR_KERNEL | MSR_EE.
> 
> Christophe

