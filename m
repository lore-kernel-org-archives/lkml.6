Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A2A20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gkJaVu3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfAKVeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:34:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAKVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:34:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so7298914plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jn0izMxK2WRXRJ2AIRWYMhRuxof+OnZ7ISXl763YYig=;
        b=gkJaVu3LINUvNEHQdjosXVb87J6w73pfbfxMCKQ+LUTnCAgvXmquXp7YTbbjDT6+qS
         nkzUG4wRuuaiI4+itTnyCqmH1AAv/YoNh/a2D0M4gATAOf79S/xiPLTmNb3oYEedYTHo
         6ld2gs4hMq6PpmOmYVF39twVa0TbHWvixRnCv7rBCPjbc8+TeKcCBIhlKIZLJemf8Oq+
         nflmeSDFekA3qrrRCtdY6M5++USRpLg2Svz7paI12obgcEldl5o3krL8H+Lsab/a6r2I
         UFbmd7F1iwl1NSoM+Hgn1IqoKBuHSS04l4N9nMC/2gCaU6oziLaMqTazK///crbH4P74
         ENRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jn0izMxK2WRXRJ2AIRWYMhRuxof+OnZ7ISXl763YYig=;
        b=qcrJZAl0VkyFwOlMJGogHE7zinnPmtkpwq4S0+KRARi9FkFzfslg70oax4SWKe7sZR
         GwNQIO2YqLUzdwLcQrnXqqz6kX7pwtXssWKN3ukkEBOFMKKbQp1VXPqHvYYqo2c7NE8Y
         yXfmDGJkPKufVaXaTbPP1XhRAfv91adayqbtitn6CogQn2jXhfBNuPNU+VQp2dYtKF/n
         TxXVs15yvLvHJQTOUG/7/DVraEkTisP0jZxq8WbfcOgFBuH05OSFk6Sge0T8ofkY8N2f
         154hTsouWp0ntRR7OJqHWgJF5AbDziSHrUkzhQOeAX/oGHud7IFDhrMjDoU6kzeSMEye
         52CQ==
X-Gm-Message-State: AJcUukdWjE9IkCwlo6DpvBG4tsmeP5QC55diOOyfrWwmYEnEeimBtIVW
        M/PEdOmdMOrnSLocsT+GU/8e1Q==
X-Google-Smtp-Source: ALg8bN58LHvUkDh8x20C/Qjh/9wYDdZLo8FvYpz12c50vSwfeNgJ/kUs9dF5U1eQCX3ygiNRyk4GWQ==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr16444510plk.291.1547242452814;
        Fri, 11 Jan 2019 13:34:12 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t24sm112938169pfm.127.2019.01.11.13.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 13:34:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gi4RP-0005oV-2J; Fri, 11 Jan 2019 14:34:11 -0700
Date:   Fri, 11 Jan 2019 14:34:11 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        liuyixian@huawei.com, zhangxiping3@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, xavier_huwei@163.com
Subject: Re: [PATCH rdma-rc 1/3] RDMA/hns: Fix the Oops during rmmod or
 insmod ko when reset occurs
Message-ID: <20190111213411.GA22310@ziepe.ca>
References: <1547128663-69220-1-git-send-email-xavier.huwei@huawei.com>
 <1547128663-69220-2-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547128663-69220-2-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:57:41PM +0800, Wei Hu (Xavier) wrote:
> +	/* Check the status of the current software reset process, if in
> +	 * software reset process, wait until software reset process finished,
> +	 * in order to ensure that reset process and this function will not call
> +	 * __hns_roce_hw_v2_uninit_instance at the same time.
> +	 * If a timeout occurs, it indicates that the network subsystem has
> +	 * encountered a serious error and cannot be recovered from the reset
> +	 * processing.
> +	 */
> +	if (ops->ae_dev_resetting(handle)) {
> +		dev_warn(dev, "Device is busy in resetting state. waiting.\n");
> +		end = msecs_to_jiffies(HNS_ROCE_V2_RST_PRC_MAX_TIME) + jiffies;
> +		while (ops->ae_dev_resetting(handle) &&
> +		       time_before(jiffies, end))
> +			msleep(20);

Really? Does this have to be so ugly? Why isn't there just a simple
lock someplace that is held during reset?

I'm skeptical that all this strange looking stuff is properly locked
and concurrency safe.

Also, this series seems a bit big for -rc

Jason
