Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43658C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94122175C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94122175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbeHNN6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:58:16 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:37320 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeHNN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:58:16 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fpXEW-00017C-FW; Tue, 14 Aug 2018 13:11:28 +0200
Message-ID: <1534245028.3547.16.camel@sipsolutions.net>
Subject: Re: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@aculab.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Aug 2018 13:10:28 +0200
In-Reply-To: <CAK8P3a2-rQ2wp77dHJv9sKg+0oZrnNqMxGGJmyMWxBSfL03LKA@mail.gmail.com> (sfid-20180814_130819_139141_6879BFD8)
References: <20180813220950.194841-1-arnd@arndb.de>
         <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
         <1534233405.3547.4.camel@sipsolutions.net>
         <74bd14d45d2b47978218517093ae9de1@AcuMS.aculab.com>
         <CAK8P3a2-rQ2wp77dHJv9sKg+0oZrnNqMxGGJmyMWxBSfL03LKA@mail.gmail.com>
         (sfid-20180814_130819_139141_6879BFD8)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 13:08 +0200, Arnd Bergmann wrote:

> > It would be much more useful to indicate where the values are used.
> > Such a field/parameter could (probably) have the type of the enum.
> > But, at some point, the compiler might start barfing at that at well.
> 
> I think the compiler warning here only happens because one uses
> a compile-time constant expression that is not a numeric literal value
> into a boolean operator. That doesn't mean that there is something
> wrong with the enum in particular, or that enums cause a lot of
> issues elsewhere.
> 
> I would also argue that generally speaking the BUILD_BUG_ON_MSG()
> should try to either produce the specific build failure it was designed
> for, or not produce any output at all, rather than something
> that is more confusing to developers. If we want to enforce
> passing in number literals here, we should make that an explicit
> check, or otherwise allow any compile-time constant values.

I don't see why we should only be allowed to pass a number literal
(perhaps after pre-processing), rather than any constant integer value.
Clearly it needs to be a constant for all the constant-folding to work,
but nothing else is required.

> > There are also a whole load of crappy __packed in that header file.
> > There might be one or two 64bit items on 32bit boundaries but
> > that can be solved without using __packed.
> 
> Agreed, this likely causes problems on architectures without unaligned
> load/store instructions that end up doing byte accesses to the descriptor
> fields, which in turn can confuse the hardware, and can become very
> slow when they live in dma_alloc_coherent() memory. That looks
> like a completely unrelated issue though.

We know about this, but it doesn't cause issues apart from perhaps
somewhat slower access on some architectures, since all of the
structures live only in DRAM and are not usually used with coherent
memory, just sent to/from the device.

Since the devices really only ship on x86 systems, we decided to ignore
that slight performance issue (for now).

johannes
