Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D791FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90480218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZK4BQ1/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfAWWko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:40:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42446 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:40:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1880898plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hv3ipkHpsLhLZsV9/QoVgNgoHyDuVYazwamwYgfQVVE=;
        b=ZK4BQ1/S0kHkBJf4qqA2bSuCu0ZyYpJVaC/Xt2rdIC96nViEp4gRfjjF3B6F3dH4FL
         I0S+KnUOWMAKH7cO/SA/iBXIVZLUYRySfLmf/yIJrFvgbde0OLVa+qwshsUUljjNIcC/
         s1DAUPcoRVKS+uwWHgsa5oi1lUKLBd9TZmzG214dL6EvNzyH53tB/Uvq08M9g1IOlh96
         pL8YMXs9qSe7c8NvFRA/q2jkixwwuWpXrZcgLaoHUrQNp9ogEKeDJ7FAQKnZsF30ozQI
         z2ILcJP0RKvsGSxx3ZzYrvKNRd6Cjuzd8cVeC7R3d483AIVbwQwzF0HSkueeE+BRvyJo
         b0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hv3ipkHpsLhLZsV9/QoVgNgoHyDuVYazwamwYgfQVVE=;
        b=S5axVYjcePZLm2DB+pkuUsU9BQS4o40XePtg4I9V+0w4dj7YyrHUhPvuM+AUl1MFQr
         mh3nVpTp2vGI/S3eu6hZ4dbYqqrLG8P4Y71eFaUSAwUSCSxh9YzEHBe6KDSvs2cuBVZN
         ONUMVT8uYdkIu/GMIDW2Y1uSildAhhrYFXuWf94nRlBurdHfzTzWovAgPe8hpHX6JUu2
         M70dCFkXfQcSQZIzzHNM28dDeNNgn07zdDiZGRxEB4AiZbDZwfPt6d7Viusv7JlQCw3T
         +k1xN5zVa1YHZ49K8pqIIGvpNuy2CaX7xEeIA26uOBrivUZAT+Xca1g8zgXCJluwbtxT
         2uNg==
X-Gm-Message-State: AJcUukdE2rZq4uHxdt9RfKdy3ZC3qqvG0F4awLkup70CsRTleTZf1aC3
        /0DRMOjS3UCHvevkRPuIsVd3pg==
X-Google-Smtp-Source: ALg8bN79Q8+mF4/CDezXcgDIYARssUcBAM1JZnkjSLY0J4/+rf0W4tuQHOV+QWqYxpV+CKO+yb0TAw==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr4139113plb.217.1548283243431;
        Wed, 23 Jan 2019 14:40:43 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u123sm28820504pfb.1.2019.01.23.14.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 14:40:42 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gmRCL-00031b-Ub; Wed, 23 Jan 2019 15:40:41 -0700
Date:   Wed, 23 Jan 2019 15:40:41 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        xavier_huwei@163.com
Subject: Re: [PATCH V2 rdma-next 2/3] RDMA/hns: Fix the chip hanging caused
 by sending mailbox&CMQ during reset
Message-ID: <20190123224041.GA11605@ziepe.ca>
References: <1547868967-115951-1-git-send-email-xavier.huwei@huawei.com>
 <1547868967-115951-3-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547868967-115951-3-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:36:06AM +0800, Wei Hu (Xavier) wrote:

> +static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
> +					unsigned long instance_stage,
> +					unsigned long reset_stage)
> +{
> +	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
> +	struct hnae3_handle *handle = priv->handle;
> +	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
> +	unsigned long end;
> +
> +	/* When hardware reset is detected, we should stop sending mailbox&cmq
> +	 * to hardware, and wait until hardware reset finished. If now
> +	 * in .init_instance() function, we should exit with error. If now at
> +	 * HNAE3_INIT_CLIENT stage of soft reset process, we should exit with
> +	 * error, and then HNAE3_INIT_CLIENT related process can rollback the
> +	 * operation like notifing hardware to free resources, HNAE3_INIT_CLIENT
> +	 * related process will exit with error to notify NIC driver to
> +	 * reschedule soft reset process once again.
> +	 */
> +	end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
> +	while (ops->get_hw_reset_stat(handle) && time_before(jiffies, end))
> +		udelay(1);

I thought you were getting rid of these loops?

Jason
