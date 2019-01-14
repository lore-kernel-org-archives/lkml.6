Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87DBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D47F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ew6D27yT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANWHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:07:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42810 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANWG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:06:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so253753plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R58TcNvDHlHFxkdOMm8GfSB1F7KGYFTPXSDMgykzj7w=;
        b=Ew6D27yTEay56OLd3oa3GPWUBLwoQIvyhD/jcXVmgKZKJK630cX3nm6Bjm4F4hlGRL
         KPrSpD3ZlY6ndNvo+Ug5jhZKs8gmDdfKFKR0zEt8w7dCctar7OrU2D20cc79MNxoXjYM
         9j6hVtTGeE8FkoKMlO/XgbZakKRgph585xx9xPDwt/4pAk3HCHOHilNh9c7/RRlkpPN5
         NCU62E8JtzWc/KUGdZP3movwGw8F9soW0m8r5Z3rUAVH21LoK6l9nKC2JogC6UICyg9d
         L2ecG4P8tOdsergRP6O2ZeCELBfYsUVg8rVwbxRRdL18V6W/zTcck+clZy0J2umw5LFp
         0nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R58TcNvDHlHFxkdOMm8GfSB1F7KGYFTPXSDMgykzj7w=;
        b=ZQVxb4Xy7JPjUjZpay76VvzCvDe3MBSutQnU7tL2CD4JsAdFRlGw1qvKgywl42+NIz
         ZySZnYLE/CB7uxyVFW5A9vCh1Z7nXIf+UL5ZLDIxpffi9J+X7jHDry7Q9ep2x4nVyxAz
         14Tau8YstFzZxYsx/ZziiL8ZGz6SB4/3s9jb24MOV+x9yyj+jF5G3QRe3Mp2l/E4rgX0
         S5Ue1GZBXx6CnKEE/09pW+8DRCabN/AsEDMROzd57japKTLRxWw1xXT0h5rL5vS83muA
         i1fZRTWw0ZOJ7cv7yn0QLQEVQW2OYupHp0Nw4iuF4oaS4ikZd28m3sK3GfT6RWqAHIKP
         RhNg==
X-Gm-Message-State: AJcUuke04Ukfl1e+rNrZJEkTgfSsRCvrC7waWkr1rajPuLxSGyVO66dn
        3NB7YPGLo++1ZoAow50UapClZw==
X-Google-Smtp-Source: ALg8bN4jp4d5DIma3avVG3f0Q6HYl38K8r0j80Oi0Ok5Pc9cNIdmp8igeNvxcJcd6BC0HBgP/8Ctpw==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr703866plt.98.1547503619147;
        Mon, 14 Jan 2019 14:06:59 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z127sm1763657pfb.80.2019.01.14.14.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:06:56 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gjANj-00053c-7i; Mon, 14 Jan 2019 15:06:55 -0700
Date:   Mon, 14 Jan 2019 15:06:55 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        liuyixian@huawei.com, zhangxiping3@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, xavier_huwei@163.com
Subject: Re: [PATCH rdma-rc 1/3] RDMA/hns: Fix the Oops during rmmod or
 insmod ko when reset occurs
Message-ID: <20190114220655.GD1208@ziepe.ca>
References: <1547128663-69220-1-git-send-email-xavier.huwei@huawei.com>
 <1547128663-69220-2-git-send-email-xavier.huwei@huawei.com>
 <20190111213411.GA22310@ziepe.ca>
 <5C399D73.5000902@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C399D73.5000902@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 03:55:31PM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2019/1/12 5:34, Jason Gunthorpe wrote:
> > On Thu, Jan 10, 2019 at 09:57:41PM +0800, Wei Hu (Xavier) wrote:
> >> +	/* Check the status of the current software reset process, if in
> >> +	 * software reset process, wait until software reset process finished,
> >> +	 * in order to ensure that reset process and this function will not call
> >> +	 * __hns_roce_hw_v2_uninit_instance at the same time.
> >> +	 * If a timeout occurs, it indicates that the network subsystem has
> >> +	 * encountered a serious error and cannot be recovered from the reset
> >> +	 * processing.
> >> +	 */
> >> +	if (ops->ae_dev_resetting(handle)) {
> >> +		dev_warn(dev, "Device is busy in resetting state. waiting.\n");
> >> +		end = msecs_to_jiffies(HNS_ROCE_V2_RST_PRC_MAX_TIME) + jiffies;
> >> +		while (ops->ae_dev_resetting(handle) &&
> >> +		       time_before(jiffies, end))
> >> +			msleep(20);
> > Really? Does this have to be so ugly? Why isn't there just a simple
> > lock someplace that is held during reset?
> >
> > I'm skeptical that all this strange looking stuff is properly locked
> > and concurrency safe.
> Hi, Jason
> 
> The hns3 NIC driver notifies the hns RoCE driver to perform
> reset related processing by calling the .reset_notify() interface
> registered by the RoCE driver.
> 
> There is a constraint on the hip08 chip, the NIC driver needs to
> stop the flow before hardware startup reset, otherwise the chip
> may hang up.
> 
> We've also thought about using locks, but found using locks can
> lead to more serious problems because of that restriction of the
> chip.
> If using locks here, reset processing may wait for uninstallation
> to complete, this may lead that NIC driver fails to stop the flow
> in time in the reset process, thus causing the chip to hang up.

If you are sleeping then I'm sure a lock can be used instead, how
would it be any different?

Jason
