Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DEEC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CE927F3D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CE927F3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755629AbeF3DPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 23:15:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33042 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755530AbeF3DPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 23:15:49 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F2C2C49;
        Sat, 30 Jun 2018 03:15:48 +0000 (UTC)
Date:   Fri, 29 Jun 2018 20:15:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-Id: <20180629201547.5322cfc4b52d19a0443daec2@linux-foundation.org>
In-Reply-To: <084aeccb-2c54-2299-8bf0-29a10cc0186e@linux.alibaba.com>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
        <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
        <20180629183501.9e30c26135f11853245c56c7@linux-foundation.org>
        <084aeccb-2c54-2299-8bf0-29a10cc0186e@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 19:28:15 -0700 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> 
> 
> > we're adding a bunch of code to 32-bit kernels which will never be
> > executed.
> >
> > I'm thinking it would be better to be much more explicit with "#ifdef
> > CONFIG_64BIT" in this code, rather than relying upon the above magic.
> >
> > But I tend to think that the fact that we haven't solved anything on
> > locked vmas or on uprobed mappings is a shostopper for the whole
> > approach :(
> 
> I agree it is not that perfect. But, it still could improve the most use 
> cases.

Well, those unaddressed usecases will need to be fixed at some point. 
What's our plan for that?

Would one of your earlier designs have addressed all usecases?  I
expect the dumb unmap-a-little-bit-at-a-time approach would have?

> For the locked vmas and hugetlb vmas, unmapping operations need modify 
> vm_flags. But, I'm wondering we might be able to separate unmap and 
> vm_flags update. Because we know they will be unmapped right away, the 
> vm_flags might be able to be updated in write mmap_sem critical section 
> before the actual unmap is called or after it. This is just off the top 
> of my head.
> 
> For uprobed mappings, I'm not sure how vital it is to this case.
> 
> Thanks,
> Yang
> 
> >
