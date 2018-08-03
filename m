Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1C4C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA56321724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA56321724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeHCEuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:50:01 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59394 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeHCEuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:50:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 7C87D27E24;
        Thu,  2 Aug 2018 22:55:54 -0400 (EDT)
Date:   Fri, 3 Aug 2018 12:56:23 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     zhong jiang <zhongjiang@huawei.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>
Subject: Re: [PATCH] scsi:NCR5380: remove same check condition in
 NCR5380_select
In-Reply-To: <928ae07a-8c4a-05fc-16af-48fb6e9c341d@gmail.com>
Message-ID: <alpine.LNX.2.21.1808031148320.16@nippy.intranet>
References: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com> <c99a75a2905c1eef50f94ccc0871c36af431e21a.camel@wdc.com> <5B627E71.5020600@huawei.com> <928ae07a-8c4a-05fc-16af-48fb6e9c341d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Michael Schmitz wrote:

> 
> This redundant load of the ICR has been in the driver code for a long 
> time. There's a small chance it is intentional,

Actually, it is intentional.

> so at least minimal testing might be in order.
> 

Minimal testing is almost useless if you are trying to prove the absence 
of race conditions. SCSI arbitration is a race between targets by design; 
so a race between the CPU and the 5380 is going to be hard to observe.

> Finn - does the ICR_ARBITRATION_LOST bit have to be cleared by a write 
> to the mode register?
> 

Something like that: the write to the mode register does clear the 
ICR_ARBITRATION_LOST bit, because it clears the MR_ARBITRATE bit.

> In that case, the first load would have been redundant and can be 
> omitted without changing driver behaviour?

This code is a faithful rendition of the arbitration flow chart in the 
datasheet, so even if you are right, I wouldn't want to change the code.

Besides, I think your argument assumes that ICR and MR are synchronized, 
and also assumes that targets are obeying the spec.

-- 

> Cheers,
> 
> 	Michael
> 
> 
