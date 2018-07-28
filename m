Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF678C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E7F20878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E7F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeG1QF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:05:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbeG1QF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:05:26 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D421C75;
        Sat, 28 Jul 2018 14:38:41 +0000 (UTC)
Date:   Sat, 28 Jul 2018 16:38:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhaoxiu Zeng <zengzhaoxiu@163.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 1/1] lib: use sunday algorithm to do strstr() and
 strnstr()
Message-ID: <20180728143838.GC3681@kroah.com>
References: <20180722173715.25327-1-zengzhaoxiu@163.com>
 <20180722183706.GA7979@kroah.com>
 <9b18802b-a451-eb81-3317-1de406f03118@163.com>
 <6dc928cd-adbb-0304-1308-fb556d48698d@163.com>
 <CAHp75Vd2Lu110om-hPE2bx_XFa0zpNHHC4RC_uLsTBSywJO2KQ@mail.gmail.com>
 <6b33eb08-b7f8-0104-4fe0-1c0f4cd5edfc@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b33eb08-b7f8-0104-4fe0-1c0f4cd5edfc@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 10:02:51PM +0800, Zhaoxiu Zeng wrote:
> 在 2018/7/27 18:39, Andy Shevchenko 写道:
> > On Fri, Jul 27, 2018 at 8:48 AM, Zhaoxiu Zeng <zengzhaoxiu@163.com> wrote:
> >> 在 2018/7/27 1:17, Zhaoxiu Zeng 写道:
> >>> 在 2018/7/23 2:37, Greg Kroah-Hartman 写道:
> >>>> On Mon, Jul 23, 2018 at 01:37:15AM +0800, Zhaoxiu Zeng wrote:
> > 
> >>>>> The Sunday algorithm is a variation of Boyer-Moore algorithm, it is easy and fast.
> >>>>> For the Sunday algorithm, to see
> >>>>>     http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sundayen.htm
> >>>>
> >>>> So you say, but what does this really buy us?  Why make this change?
> >>>> How was it tested?  What is the downside of not taking this?
> > 
> >>> I use the following program to test on fc28.
> >>> Compile with O2, the new version is almost 2X faster than the original.
> > 
> >>> The code size of the original is 0x80, the newer is 0xB0.
> > 
> > So, output of bloat-o-meter would be good to have in commit message.
> > 
> >>> The test result:
> > 
> > Compact performance statistics as well.
> > 
> >>> Thanks!
> > 
> >> The original strnstr might has a bug too!
> >> For example, assume s1 is "123\0abc...." and s2 is "abc\0",
> >> call strnstr(s1, s2, 7) will return &s1[4], but the correct result is NULL.
> > 
> > If there is a bug, send another patch to fix the bug first.
> > 
> 
> The bug could be fixed by this patch.

Given that there doesn't seem to be a good reason to take your patch
yet, that might be hard :)

You need to convince us that the patch is a valid thing to accept, by
writing a correct changelog and showing proof of its correctness as this
is modifying a core function in the kernel.

thanks,

greg k-h
