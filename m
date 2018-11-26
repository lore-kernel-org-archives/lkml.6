Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C89C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2F620865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2F620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeKZMQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 07:16:04 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:11840 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726079AbeKZMQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 07:16:04 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wAQ1M9h6037983;
        Mon, 26 Nov 2018 09:22:09 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 26 Nov 2018
 09:23:13 +0800
Date:   Mon, 26 Nov 2018 09:23:10 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     "green.hu@gmail.com" <green.hu@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nick Chun-Ming Hu(?????????)" <nickhu@andestech.com>,
        <deanbo422@gmail.com>
Subject: Re: [PATCH v4 2/5] nds32: Support FP emulation
Message-ID: <20181126012310.GA26621@andestech.com>
References: <1542856478-795-1-git-send-email-vincentc@andestech.com>
 <1542856478-795-3-git-send-email-vincentc@andestech.com>
 <f0d20a4682b740659f28184c1278ae7d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0d20a4682b740659f28184c1278ae7d@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wAQ1M9h6037983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 06:53:37PM +0800, David Laight wrote:
> From: Vincent Chen
> > Sent: 22 November 2018 03:15
> > 
> > The Andes FPU coprocessor does not support denormalized number handling.
> > According to the specification, FPU generates a denorm input exception
> > that requires the kernel to deal with this instrution operation when it
> > encounters denormalized operands. Hence an nds32 FPU ISA emulator in the
> > kernel is required to meet requirement.
> 
> What does the FPU generate for results near zero?

1. The calculation result is a denormalized number
Depending on the state of underflow trap, the FPU will raise an underflow
exception or flash the result to zero.

2. One of the operands is a denormalized number
Depending on the state of the flash-to-zero mode, the FPU will raise a
denormalized input exception, which is a specific exception of the nds FPU,
or directly treats the operand as 0.


> If it doesn't generate denormalised results (but does detect them)
> then I assume it never generates FP values with exponent zero.
> (So the gap around zero is even larger than it would be if exponent
> zero values had a hidden bit.)
> So is it really worth doing anything other than treating
> denormalised values as zero?
> 
> 	David
>

Sorry, I can't fully understand what you mean, but we really have
encountered the above two cases in some testsuites such as glibc testsuite.
Hence we implement a FPU emulator in this commit which will recalculate the
instructions again by software to enhance the precision.
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
