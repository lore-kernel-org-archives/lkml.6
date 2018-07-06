Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA78C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7158923E8C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7158923E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeGFLmc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:42:32 -0400
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:41370 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeGFLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:42:30 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id E1DB33C09AC;
        Fri,  6 Jul 2018 13:42:28 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xwcU2gppkTFg; Fri,  6 Jul 2018 13:42:21 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id D29B53C0160;
        Fri,  6 Jul 2018 13:42:21 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 6 Jul 2018
 13:42:21 +0200
Date:   Fri, 6 Jul 2018 13:42:18 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] usb: gadget: f_uac2: fix endianness of 'struct
 cntrl_*_lay3'
Message-ID: <20180706114218.GA15693@vmlxhi-102.adit-jv.com>
References: <20180702214647.1574-1-erosca@de.adit-jv.com>
 <CAB=otbQiUDtZBAn0RhtQsizqz-r0Do+8nd991rvE+DQv_71o0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAB=otbQiUDtZBAn0RhtQsizqz-r0Do+8nd991rvE+DQv_71o0Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ruslan,

On Tue, Jul 03, 2018 at 01:36:17AM +0300, Ruslan Bilovol wrote:
> On Tue, Jul 3, 2018 at 12:46 AM, Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
> > The list [1] of commits doing endianness fixes in USB subsystem is long
> > due to below quote from USB spec Revision 2.0 from April 27, 2000:
> >
> > ------------
> > 8.1 Byte/Bit Ordering
> >
> > Multiple byte fields in standard descriptors, requests, and responses
> > are interpreted as and moved over the bus in little-endian order, i.e.
> > LSB to MSB.
> > ------------
> >
> > This commit belongs to the same family.
> >
> > [1] Example of endianness fixes in USB subsystem:
> > commit 14e1d56cbea6 ("usb: gadget: f_uac2: endianness fixes.")
> > commit 42370b821168 ("usb: gadget: f_uac1: endianness fixes.")
> > commit 63afd5cc7877 ("USB: chaoskey: fix Alea quirk on big-endian hosts")
> > commit 74098c4ac782 ("usb: gadget: acm: fix endianness in notifications")
> > commit cdd7928df0d2 ("ACM gadget: fix endianness in notifications")
> > commit 323ece54e076 ("cdc-wdm: fix endianness bug in debug statements")
> > commit e102609f1072 ("usb: gadget: uvc: Fix endianness mismatches")
> >        list goes on
> >
> > Fixes: 132fcb460839 ("usb: gadget: Add Audio Class 2.0 Driver")
> > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
> Good catch!
> 
> Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

Thanks for the review. FWIW, I've accidentally noticed post-push that
a similar fix has been incorporated by you in the UAC3 implementation
from https://lkml.org/lkml/2017/11/6/1514 ("[PATCH 1/1] usb: gadget: add
USB Audio Device Class 3.0 gadget support").

Best regards,
Eugeniu.
