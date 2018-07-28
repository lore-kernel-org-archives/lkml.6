Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35455C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA96A20873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA96A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeG1HVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:21:31 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:49794 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeG1HVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:21:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4A18D60A3584;
        Sat, 28 Jul 2018 07:56:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id g9G42RoGs3U3; Sat, 28 Jul 2018 07:56:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EB32560A3590;
        Sat, 28 Jul 2018 07:56:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oyV-3sfmINSQ; Sat, 28 Jul 2018 07:56:15 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C5F6C60A3584;
        Sat, 28 Jul 2018 07:56:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     martin bayern <Martinbayern@outlook.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 15/47] ubi: fastmap: Correctly handle interrupted erasures in EBA
Date:   Sat, 28 Jul 2018 07:56:09 +0200
Message-ID: <2079260.rIAgkgY78I@blindfold>
In-Reply-To: <1532741338.21552.55.camel@codethink.co.uk>
References: <20180710182337.047502999@linuxfoundation.org> <2465050.YMUAORSpTR@blindfold> <1532741338.21552.55.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Am Samstag, 28. Juli 2018, 03:28:58 CEST schrieb Ben Hutchings:
> > > Isn't there a risk here, that a read error leads to erasing data that
> > > might be recoverable if the read is retried?
> > 
> > Well, read error means that already something went very wrong. At other places
> > in UBI wo also don't retry reading headers and consider it as fatal when we 
> > are unable to read it.
> > We could also read the EC header, but what do we gain from that?
> > If the VID header is not readable we cannot check fastmap either.
> > 
> > What case exactly do you have in mind?
> 
> I suppose I'm thinking about data recovery from a flash device that has
> become unreliable.  I'm not familiar with ubi; is there a read-only
> mode where the erase wouldn't actually be performed?

We have a ready only mode, UBI enters this mode upon fatal errors.
But I don't see what this has to do with the case this patch addresses.
Here we need to recover from interrupted erases when fastmap is used.
With fastmap the mapping still looks valid to the upper layer but due to
a bad erase we might face later ECC errors and therefore we have to check
whether it is still valid upon first access.
If data is present, mapping is ok. If not (no data or ECC error), unmap it
to make the state sync with the upper layer.

Thanks,
//richard

