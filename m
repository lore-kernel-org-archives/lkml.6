Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49411C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A8220664
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A8220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeK0NnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:43:21 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:13852 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727621AbeK0NnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:43:21 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wAR2jTVY024938;
        Tue, 27 Nov 2018 10:45:29 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 27 Nov 2018
 10:46:41 +0800
Date:   Tue, 27 Nov 2018 10:46:38 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     "green.hu@gmail.com" <green.hu@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nick Chun-Ming Hu(?????????)" <nickhu@andestech.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>
Subject: Re: [PATCH v4 2/5] nds32: Support FP emulation
Message-ID: <20181127024638.GA6633@andestech.com>
References: <1542856478-795-1-git-send-email-vincentc@andestech.com>
 <1542856478-795-3-git-send-email-vincentc@andestech.com>
 <f0d20a4682b740659f28184c1278ae7d@AcuMS.aculab.com>
 <20181126012310.GA26621@andestech.com>
 <3dcd9764570e4565911b74b08513e2d3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3dcd9764570e4565911b74b08513e2d3@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wAR2jTVY024938
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 06:18:01PM +0800, David Laight wrote:
> From: Vincent Chen
> > Sent: 26 November 2018 01:23
> > On Fri, Nov 23, 2018 at 06:53:37PM +0800, David Laight wrote:
> > > From: Vincent Chen
> > > > Sent: 22 November 2018 03:15
> > > >
> > > > The Andes FPU coprocessor does not support denormalized number handling.
> > > > According to the specification, FPU generates a denorm input exception
> > > > that requires the kernel to deal with this instrution operation when it
> > > > encounters denormalized operands. Hence an nds32 FPU ISA emulator in the
> > > > kernel is required to meet requirement.
> > >
> > > What does the FPU generate for results near zero?
> > 
> > 1. The calculation result is a denormalized number
> > Depending on the state of underflow trap, the FPU will raise an underflow
> > exception or flash the result to zero.
> > 
> > 2. One of the operands is a denormalized number
> > Depending on the state of the flash-to-zero mode, the FPU will raise a
> > denormalized input exception, which is a specific exception of the nds FPU,
> > or directly treats the operand as 0.
> 
> You didn't mention (1) in the commit message.
>
  I use two commits to complete the implementation of the FPU emulator in
  this patch set. The handling for (1) case is in another patch, "nds32:
  support denormalized result through FP emulator". Sorry, the above
  description may be misleading.
 
> It ought to be possibly for the exception routine to rescale the values,
> re-issue the same FP instruction, then scale the result.
> 
> 	David
> 
  
  I Agree. The scheme is common when dealing with denormalized numbers,
  including the softfp module of the kernel used in this patchset.

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
