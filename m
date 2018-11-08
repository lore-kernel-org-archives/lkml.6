Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD3E2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD3E2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeKIAaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:30:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41968 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeKIAaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:30:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E55D720970; Thu,  8 Nov 2018 15:54:14 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id A0E6720510;
        Thu,  8 Nov 2018 15:54:14 +0100 (CET)
Date:   Thu, 8 Nov 2018 15:54:14 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH 3/7] mtd: spi-nor: add restriction for nmaps in smpt
 parser
Message-ID: <20181108155414.48b64084@bbrezillon>
In-Reply-To: <4de81d92-ca8e-34f1-55b2-ef1b6b9dcec7@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
        <20181108110653.21063-4-tudor.ambarus@microchip.com>
        <20181108135447.36a0314c@bbrezillon>
        <86d16e39-15df-c12c-7bf3-25996db0c3a9@microchip.com>
        <20181108151509.364e3a85@bbrezillon>
        <4de81d92-ca8e-34f1-55b2-ef1b6b9dcec7@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 14:48:11 +0000
<Tudor.Ambarus@microchip.com> wrote:
  
> >>>> +    
> >>>
> >>> Maybe I missed something but it sounds like this change is just
> >>> optimizing the SPMT parsing a bit, and to be honest, I'm not sure this
> >>> is really needed. Most of the time, smpt_len will be rather small, so
> >>> trying to bail out earlier is not bringing much perf improvements.    
> >>
> >> It's rather a smtp validity check. I want to return an error if there are not
> >> enough detection commands to identify the map id.  
> > 
> > You would have failed the same way without this validity check after a
> > maximum of smpt_len iterations, right?
> >   
> 
> Right. The correct fix would be to count nmaps in a loop, then do these checks,
> and if all ok, search for the map_id in another loop :).

Or just error out when !ncmds && nmaps > 1.

If you insist on keeping the ncmds && nmaps >= (1 << (ncmds + 1))
check, that's fine, but it's not replacing the consistency check I was
doing ;-).
