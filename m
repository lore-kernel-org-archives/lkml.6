Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89558C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C59E25933
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C59E25933
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbeF1BLn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:11:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbeF1BLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:11:42 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BA82CC74;
        Thu, 28 Jun 2018 01:11:39 +0000 (UTC)
Date:   Wed, 27 Jun 2018 18:11:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vishwath Mohan <vishwath@google.com>
Cc:     Kostya Serebryany <kcc@google.com>, andreyknvl@google.com,
        aryabinin@virtuozzo.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, cl@linux.com, mark.rutland@arm.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        marc.zyngier@arm.com, dave.martin@arm.com,
        ard.biesheuvel@linaro.org, ebiederm@xmission.com, mingo@kernel.org,
        Paul Lawrence <paullawrence@google.com>, geert@linux-m68k.org,
        arnd@arndb.de, kirill.shutemov@linux.intel.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        rppt@linux.vnet.ibm.com, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        Evgenii Stepanov <eugenis@google.com>, Lee.Smith@arm.com,
        Ramana.Radhakrishnan@arm.com, Jacob.Bramley@arm.com,
        Ruben.Ayrapetyan@arm.com, Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>, cpandya@codeaurora.org
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Message-Id: <20180627181138.14c9b66e13b8778506205f89@linux-foundation.org>
In-Reply-To: <CAEZpscCcP6=O_OCqSwW8Y6u9Ee99SzWN+hRcgpP2tK=OEBFnNw@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
        <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
        <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
        <CAEZpscCcP6=O_OCqSwW8Y6u9Ee99SzWN+hRcgpP2tK=OEBFnNw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 17:59:00 -0700 Vishwath Mohan <vishwath@google.com> wrote:

> > > > time consume much less memory, trading that off for somewhat imprecise
> > > > bug detection and being supported only for arm64.
> > >
> > > Why do we consider this to be a worthwhile change?
> > >
> > > Is KASAN's memory consumption actually a significant problem?  Some
> > > data regarding that would be very useful.
> >
> > On mobile, ASAN's and KASAN's memory usage is a significant problem.
> > Not sure if I can find scientific evidence of that.
> > CC-ing Vishwath Mohan who deals with KASAN on Android to provide
> > anecdotal evidence.
> >
> Yeah, I can confirm that it's an issue. Like Kostya mentioned, I don't have
> data on-hand, but anecdotally both ASAN and KASAN have proven problematic
> to enable for environments that don't tolerate the increased memory
> pressure well. This includes,
> (a) Low-memory form factors - Wear, TV, Things, lower-tier phones like Go
> (c) Connected components like Pixel's visual core
> <https://www.blog.google/products/pixel/pixel-visual-core-image-processing-and-machine-learning-pixel-2/>
> 
> 
> These are both places I'd love to have a low(er) memory footprint option at
> my disposal.

Thanks.

It really is important that such information be captured in the
changelogs.  In as much detail as can be mustered.

