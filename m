Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4893AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049DB223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049DB223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeKNFWt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeKNFWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:22:49 -0500
Received: from vmware.local.home (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35AF20896;
        Tue, 13 Nov 2018 19:23:18 +0000 (UTC)
Date:   Tue, 13 Nov 2018 14:23:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@gmx.us>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
 set_precision+0x84/0x90
Message-ID: <20181113142317.379dbaf7@vmware.local.home>
In-Reply-To: <1542135498.12945.20.camel@gmx.us>
References: <1542128132.12945.19.camel@gmx.us>
        <20181113172920.GI10650@smile.fi.intel.com>
        <1542135498.12945.20.camel@gmx.us>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:58:18 -0500
Qian Cai <cai@gmx.us> wrote:

> > Care to print the len and name parameters before this line?  
> len = 60612; name =

How big are pages on arm64? Because we shouldn't get to this path if
the string is bigger than PAGE_SIZE. But I know that on PPC64,
PAGE_SIZE can be 64K, and 60612 is less than that. Thus, if we get
there, the test is against signed int:16 (16 bit signed integer) that
can go up to most 32768. If the string size is bigger than that, you
would get this error.

I would just say to ignore it. The only thing that can happen if
someone does this is to trigger the warning. Unless if it is considered
a form of DOS, where userspace just bombards the console by triggering
this waring. But I don't see a problem with the actual design. There's
no reason we should be processing string variables bigger than 32768 in
vsprintf.

-- Steve


> %d%d%d%d%d%d%s%s%s%d%s%d%d%d%s%s%s%s%s%d%s%d%s%s%s%d%s%d%d%s%s%d%s%s%d%d%s%s%s%s
> %s%d%s%d%d%s%s%s%d%d%d%d%d%s%s%s%s%d%s%s%s%s%d%d%d%d%d%d%d%s%s%s%s%d%s%d%s%d%s%d
> %s%s%d%s%d%s%s%s%s%d%s%d%s%s%d%d%s%s%d%s%d%s%s%d%s%d%d%s%s%s%s%d%s%s%s%s%d%d%s%s
> %s%d%s%d%s%s%d%d%d%d%d%s%s%s%s%s%s%s%d%d%d%s%d%s%d%d%s%d%d%d%s%s%d%d%d%s%s%d%s%d
> %s%s%s%d%d%d%s%d%s%s%d%s%d%s%s%d%s%d%d%s%d%s%s%d%s%s%s%s%s%d%s%d%d%d%s%d%d%d%d%s
> %d%s%d%d%d%s%s%s%s%s%d%s%s%s%s%d%d%d%s%d%s%d%d%s%d%s%s%d%d%d%s%d%s%d%d%s%s%s%d%s
> %s%d%d%d%d%d%d%d%d%d%d%s%d%s%d%s%d%d%s%d%d%s%d%s%s%s%d%d%d%d%s%s%d%d%s%d%d%d%s%d
> %d%s%d%d%d%d%s%s%d%s%s%d%d%d%s%s%s%s%s%s%s%s%s%d%s%d%d%s%d%s%s%d%s%s%s%s%d%d%d%d
> %s%d%s%s%d%d%d%s%d%d%d%s%s%s%s%d%d%d%s%d%s%d%s%d%d%d%d%d%d%d%d%d%d%s%s%d%d%d%s%d
> %d%d%s%s%s%s%s%s%s%d%d%d%d%s%s%d%s%s%d%s%s%s%s%d%d%s%d%d%s%d%d%s%d%d%d%s%s%s%s%d
> %s%s%d%s%d%s%d%s%d%d%d%d%s%d%d%d%s%d%d%d%d%s%s%d%s%s%d%d%d%s%d%s%d%d%d%d%d%d%s%d
> %s%s%d%d%s%d%d%d%s%s%d%s%d%s%d%s%d%d%s%d%s%s%s%s%s%d%s%s%d%d%d%s%s%d%d%s%s%d%s%d
> %s%d%s%s%s%
> [  833.044728] ------------[ cut here ]------------
> [  833.137184] precision 60612 too large
> > 
