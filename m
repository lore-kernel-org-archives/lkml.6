Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B131C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44383218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JYCLunqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfAYLz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:55:59 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:40868 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYLz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:55:59 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B62EE24E1F01;
        Fri, 25 Jan 2019 03:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548417358; bh=sLzsIhrHvnKuCoZpk2jbAO+U4ETDaqmUABewGzbAhzA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=JYCLunqcNvalhBK2S/mHJvCbRb2d4tzRXaSFmbaco84rirEBfUJ32hW2m8gP1DD+T
         UwwTLXTbBUTeBNugz/ZsPEPuhRTzIicH3Nz/2NFpom6pv4e8zyy4sa9dFDE0RZXCge
         Cez8TmfzAhzb7Vp63YDPYgi9VECs1+uE0GGtACzYch9VxIswGH2+uIaFdW5qTHGVz3
         JN0VHsGrDfNvVfGiycPqrg2UoxKi82cN693apNVokWOKwdQRYbRtYHc4pmzh2G41Sl
         has0AwyZcIWJG154QEhjSXVYQqMt6uXYJJTT2ka4u4gioX1udlTl0v44CtuH52MBtF
         fo/J9eGprqenA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id ADBCDA0071;
        Fri, 25 Jan 2019 11:55:56 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 25 Jan 2019 03:55:56 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 25 Jan 2019 12:55:55 +0100
Received: from [10.0.2.15] (10.107.19.109) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 25 Jan
 2019 12:55:55 +0100
Subject: Re: [PATCH] i3c: master: dw: fix deadlock
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190125152300.248d58f4@xhacker.debian>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <54d8926f-f0fd-c2c7-1b8a-dce1384892b7@synopsys.com>
Date:   Fri, 25 Jan 2019 11:55:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125152300.248d58f4@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.19.109]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

Thanks for your report.

On 25/01/19 07:29, Jisheng Zhang wrote:
> In dw_i3c_master_irq_handler(), we already have gotten
> &master->xferqueue.lock, if we try to get the same lock again in
> dw_i3c_master_dequeue_xfer(), deadlock happens.
>
> We fix this issue by introduing dw_i3c_master_dequeue_xfer_locked()
> which does all what dw_i3c_master_dequeue_xfer() does without trying
> to lock &master->xferqueue.lock.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index f8c00b94817f..bb03079fbade 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -419,12 +419,9 @@ static void dw_i3c_master_enqueue_xfer(struct dw_i3c_master *master,
>  	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
>  }
>  
> -static void dw_i3c_master_dequeue_xfer(struct dw_i3c_master *master,
> -				       struct dw_i3c_xfer *xfer)
> +static void dw_i3c_master_dequeue_xfer_locked(struct dw_i3c_master *master,
> +					      struct dw_i3c_xfer *xfer)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&master->xferqueue.lock, flags);
>  	if (master->xferqueue.cur == xfer) {
>  		u32 status;
>  
> @@ -439,6 +436,15 @@ static void dw_i3c_master_dequeue_xfer(struct dw_i3c_master *master,
>  	} else {
>  		list_del_init(&xfer->node);
>  	}
> +}
> +
> +static void dw_i3c_master_dequeue_xfer(struct dw_i3c_master *master,
> +				       struct dw_i3c_xfer *xfer)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&master->xferqueue.lock, flags);
> +	dw_i3c_master_dequeue_xfer_locked(master, xfer);
>  	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
>  }
>  
> @@ -494,7 +500,7 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
>  	complete(&xfer->comp);
>  
>  	if (ret < 0) {
> -		dw_i3c_master_dequeue_xfer(master, xfer);
> +		dw_i3c_master_dequeue_xfer_locked(master, xfer);
>  		writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_RESUME,
>  		       master->regs + DEVICE_CTRL);
>  	}
Acked-by: Vitor Soares <vitor.soares@synopsys.com>
