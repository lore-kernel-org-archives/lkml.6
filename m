Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4FEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F08208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F08208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389837AbeHARds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:33:48 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:33200 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389766AbeHARds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:33:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 871F787F2;
        Wed,  1 Aug 2018 15:47:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: girls96_40d45acf53c60
X-Filterd-Recvd-Size: 1865
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Aug 2018 15:47:25 +0000 (UTC)
Message-ID: <77b011b9862cb5c89ddf9e0c8cb0743ba21d9cce.camel@perches.com>
Subject: Re: [PATCH 1/4] driver/scsi/fnic/fnic_trace: Use vzalloc to zero
 instead of vmalloc+memset
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        zhong jiang <zhongjiang@huawei.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        aacraid@microsemi.com, linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Aug 2018 08:47:24 -0700
In-Reply-To: <CAHp75Vchu7QwNBeYQxa9fY8=PinGzPpUPaRbk_MyoZ+w07hA4A@mail.gmail.com>
References: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com>
         <1533129976-51930-2-git-send-email-zhongjiang@huawei.com>
         <CAHp75Vchu7QwNBeYQxa9fY8=PinGzPpUPaRbk_MyoZ+w07hA4A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 18:30 +0300, Andy Shevchenko wrote:
> On Wed, Aug 1, 2018 at 4:26 PM, zhong jiang <zhongjiang@huawei.com> wrote:
> > The vzalloc is better than vmalloc+memset, so replace them to make
> > the code concise.
> > -       fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
> > +       fnic_trace_buf_p = (unsigned long)vzalloc((trace_max_pages * PAGE_SIZE));
> 
> At the same time you may get rid of unnecessary parens.

And at the same time, perhaps use kvcalloc and kvfree
instead of always using vmalloc as the allocation size
can be less than the allowable for a single kmalloc.


