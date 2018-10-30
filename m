Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6075C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1FF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1FF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeJaFUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:20:15 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:43255 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbeJaFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:20:15 -0400
X-IronPort-AV: E=Sophos;i="5.54,445,1534802400"; 
   d="scan'208";a="353523191"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 21:25:15 +0100
Date:   Tue, 30 Oct 2018 21:25:15 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [RESEND PATCH 2/2] staging: vboxvideo: Use
 unsigned int instead bool
In-Reply-To: <20181030201816.joihhwd7htgixo5i@smtp.gmail.com>
Message-ID: <alpine.DEB.2.21.1810302122290.2949@hadrien>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com> <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com> <20181026204225.GH2015@sasha-vm> <20181028075209.GA1938@himanshu-Vostro-3559> <alpine.DEB.2.21.1810280932030.2450@hadrien>
 <20181028112011.GA5157@himanshu-Vostro-3559> <alpine.DEB.2.21.1810281243420.2433@hadrien> <20181030201816.joihhwd7htgixo5i@smtp.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Oct 2018, Shayenne Moura wrote:

> Hi,
>
> > On Sun, 28 Oct 2018, Himanshu Jha wrote:
> >
> > > On Sun, Oct 28, 2018 at 09:47:15AM +0100, Julia Lawall wrote:
> > > > > The "possible alignement issues" in CHECK report is difficult to figure
> > > > > out by just doing a glance analysis. :)
> > > > >
> > > > > Linus also suggested to use bool as the base type i.e., `bool x:1` but
> > > > > again sizeof(_Bool) is implementation defined ranging from 1-4 bytes.
> > > >
> > > > If bool x:1 has the size of bool, then wouldn't int x:1 have the size of
> > > > int?  But my little experiments suggest that the size is the smallest that
> > > > fits the requested bits and alignment chosen by the compiler, regardless of
> > > > the type.
> > >
> > > Yes, correct!
> > > And we can't use sizeof on bitfields *directly*, nor reference it using a
> > > pointer.
> > >
> > > It can be applied only when these bitfields are wrapped in a structure.
> > >
> > > Testing:
> > >
> > > #include <stdio.h>
> > > #include <stdbool.h>
> > >
> > > struct S {
> > > bool a:1;
> > > bool b:1;
> > > bool c:1;
> > > bool d:1;
> > > };
> > >
> > > int main(void)
> > > {
> > >     printf("%zu\n", sizeof(struct S));
> > > }
> > >
> > > Output: 1
> > >
> > > If I change all bool to unsigned int, output is: *4*.
> > >
> > > So, conclusion is compiler doesn't squeeze the size less than
> > > native size of the datatype i.e., if we changed all members to
> > > unsigned int:1,
> > > total width = 4 bits
> > > padding = 4 bits
> > >
> > > Therefore, total size should have been = 1 byte!
> > > But since sizeof(unsigned int) == 4, it can't be squeezed to
> > > less than it.
> >
> > This conclusion does not seem to be correct, if you try the following
> > program.  I get 4 for everything, meaning that the four unsigned int bits
> > are getting squeezed into one byte when it is convenient.
> >
> > #include <stdio.h>
> > #include <stdbool.h>
> >
> > struct S1 {
> > bool a:1;
> > bool b:1;
> > bool c:1;
> > bool d:1;
> > char a1;
> > char a2;
> > char a3;
> > };
> >
> > struct S2 {
> > unsigned int a:1;
> > unsigned int b:1;
> > unsigned int c:1;
> > unsigned int d:1;
> > char a1;
> > char a2;
> > char a3;
> > };
> >
> > int main(void)
> > {
> >     printf("%zu\n", sizeof(struct S1));
> >     printf("%zu\n", sizeof(struct S2));
> >     printf("%zu\n", sizeof(unsigned int));
> > }
> >
> > > Well, int x:1 can either have 0..1 or -1..0 range due implementation
> > > defined behavior as I said in the previous reply.
> > >
> > > If you really want to consider negative values, then make it explicit
> > > using `signed int x:1` which make range guaranteed to be -1..0
> >
> > The code wants booleans, not negative values.
> >
> > julia
>
> Thank you all for the discussion!
>
> However, I think I do not understand the conclusion.
>
> It means that the best way is to use only boolean instead of use unsigned
> int with bitfield? I mean specifically in the case of my patch, where there
> are some boolean variables are mixed with other variables types.

To my recollection, your code had a bool with larger types on either side.
In that case, I think bool is fine.  The compiler it likely to align those
larger typed values such that the field with the bool type will get more
than one byte no matter what type you use.  If there are several fields
with very small types adjacent, there might be some benefit to thinking
about what the type should be.

julia
