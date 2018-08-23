Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0120C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AD4208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AD4208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeHWSO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:14:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:42816 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732373AbeHWSO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:14:59 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7NEfLRi023954;
        Thu, 23 Aug 2018 09:41:22 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w7NEfImD023951;
        Thu, 23 Aug 2018 09:41:18 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 23 Aug 2018 09:41:18 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common to PGD and hugepages
Message-ID: <20180823144118.GU24439@gate.crashing.org>
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr> <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr> <6dea8d0c-c4ab-49aa-da26-a729c18fa818@linux.ibm.com> <006e5f33-b816-7508-faac-da26a860659c@c-s.fr> <3e6412ac-c645-908f-a3bb-c9a2a72f4b68@linux.ibm.com> <cb121f38-ac89-4971-fd84-5473e7e9ced5@c-s.fr> <20180823103625.GR24439@gate.crashing.org> <8ada20e9-3bc1-fdaf-d78f-2f5a317e8216@c-s.fr> <87a7pdl2jy.fsf@concordia.ellerman.id.au> <d561e11b-b85e-6f6c-0936-4a93cf309915@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d561e11b-b85e-6f6c-0936-4a93cf309915@au1.ibm.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:32:16PM +1000, Andrew Donnellan wrote:
> On 23/08/18 21:56, Michael Ellerman wrote:
> >Christophe LEROY <christophe.leroy@c-s.fr> writes:
> >
> >>Le 23/08/2018 à 12:36, Segher Boessenkool a écrit :
> >>>On Thu, Aug 23, 2018 at 11:40:22AM +0200, Christophe LEROY wrote:
> >>>>The only small problème I have is that some version of GCC seems to
> >>>>complain about big memset() (132k and 256k ones). Is there a way to tell
> >>>>GCC we really want to do it ?
> >>>
> >>>I'm not sure what you mean.  Complain, is that a warning, is that an 
> >>>error?
> >>>What does it say?  Do you have some example code to reproduce it?  Etc.
> >>
> >>I saw the warnings in the checks at
> >>https://patchwork.ozlabs.org/patch/957566/
> >>Unfortunatly the link is now broken.
> >
> >ruscur/ajd any idea what happened to the snowpatch links here?
> 
> I think they've disappeared because our log rotation is too fast - I've 
> now upped it to 30 days. I guess over time we'll figure out what we need 
> in this regard, ideally we'd keep logs indefinitely but they're several 
> megs per build.
> 
> I've kicked off another build for this series and the links in Patchwork 
> should update to point to the new job when it's done (probably in the 
> next couple of hours).

It's back, thanks Andrew!

The warnings are not from GCC at all: the warnings are from sparse.


Segher
