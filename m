Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C1C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7496D2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549182944;
	bh=vRWB5RhHRTXvGL85gHEuG5jXta4dJ+fDhuM9kZ/+Xys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Xs8qNy6PGnlMU2Bp9h++DcDvZu4NtA3S4g6ax8Gt0k/T1CIXbHT6acPwwrV5xYCxY
	 610wL8nWMX0K7x0c7QhUDy6YYdua3GGOOD2Mfrhz3g2Xr+vhdXBUrIcfDiAnps4ITd
	 DsmJHB7hq30fFVWxOqQTfKdub4Djlze860EArZic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBCIfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfBCIfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:35:21 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253652082F;
        Sun,  3 Feb 2019 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549182920;
        bh=vRWB5RhHRTXvGL85gHEuG5jXta4dJ+fDhuM9kZ/+Xys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FDHpiiy2+Wga/FXzcgrJt6t40Z0XLG60xXqGedfvg/8sWzC3LZQQTFgWdpm2HMtac
         dlLIQQXZRJv39RtqNZzA6D9Mi/YSMFmRv537UcMNqQB0y1KzN8n2X6qRKi/AGUwsuW
         rxqfTo3AG94cW6sgAbGvNhjZaqgB6uheOVNB1Ntk=
Date:   Sun, 3 Feb 2019 09:35:09 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Liu Jian <liujian56@huawei.com>, <ikegami@allied-telesis.co.jp>
Cc:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <joakim.tjernlund@infinera.com>, <keescook@chromium.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Przemyslaw Sobon <psobon@amazon.com>
Subject: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Message-ID: <20190203093509.269bf1e1@bbrezillon>
In-Reply-To: <20190203092645.18d1495b@bbrezillon>
References: <1548977439-318904-1-git-send-email-liujian56@huawei.com>
        <20190203092645.18d1495b@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2019 09:26:45 +0100
Boris Brezillon <bbrezillon@kernel.org> wrote:

> +Przemyslaw
> 
> On Fri, 1 Feb 2019 07:30:39 +0800
> Liu Jian <liujian56@huawei.com> wrote:
> 
> > In function do_write_buffer(), in the for loop, there is a case
> > chip_ready() returns 1 while chip_good() returns 0, so it never
> > break the loop.
> > To fix this, chip_good() is enough and it should timeout if it stay
> > bad for a while.  
> 
> Looks like Przemyslaw reported and fixed the same problem.
> 
> > 
> > Fixes: dfeae1073583(mtd: cfi_cmdset_0002: Change write buffer to check
> > correct value)  
> 
> Can you put the Fixes tag on a single, and the format is
> 
> Fixes: <hash> ("message")
> 
> > Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> > Signed-off-by: Liu Jian <liujian56@huawei.com>  
> 
> [1]http://patchwork.ozlabs.org/patch/1025566/
> 
> > ---
> >  drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
> > index 72428b6..818e94b 100644
> > --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> > +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> > @@ -1876,14 +1876,14 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
> >  			continue;
> >  		}
> >  
> > -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
> > -			break;
> > -
> >  		if (chip_good(map, adr, datum)) {
> >  			xip_enable(map, chip, adr);
> >  			goto op_done;
> >  		}
> >  
> > +		if (time_after(jiffies, timeo))
> > +			break;
> > +
> >  		/* Latency issues. Drop the lock, wait a while and retry */
> >  		UDELAY(map, chip, adr, 1);
> >  	}  
> 

BTW, the patch itself looks good to me. Ikegami, can you confirm it
does the right thing?

Thanks,

Boris
