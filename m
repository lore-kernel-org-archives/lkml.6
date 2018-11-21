Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2450C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C494721479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C494721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbeKVATo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:19:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45663 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeKVATo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:19:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E35C8F50A;
        Wed, 21 Nov 2018 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A04AF60923;
        Wed, 21 Nov 2018 13:45:13 +0000 (UTC)
Message-ID: <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org
Date:   Wed, 21 Nov 2018 14:45:12 +0100
In-Reply-To: <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
         <20181121063609.GA109082@gmail.com>
         <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 21 Nov 2018 13:45:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 06:32 -0700, Jens Axboe wrote:
> I did some more investigation yesterday, and found this:
> 
> commit 236222d39347e0e486010f10c1493e83dbbdfba8
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Thu Jun 29 15:55:58 2017 +0200
> 
>     x86/uaccess: Optimize copy_user_enhanced_fast_string() for short strings
> 
> which does attempt to rectify it, but only using ERMS for >= 64 byte copies.
> At least for me, looks like the break even point is higher than that, which
> would mean that something like the below would be more appropriate. 

Back then I used a custom kernel module and the tsc to micro-benchmark
the patched function and the original one with different buffer sizes.
I'm sorry, the relevant code has been lost.

In my experiments 64 bytes was the break even point for all the CPUs I
had handy, but I guess that may change with other models.

Cheers,

Paolo

