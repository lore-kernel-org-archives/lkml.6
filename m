Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F1C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129ED21871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGLgjRI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfAEDhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:37:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38267 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfAEDhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:37:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so18246138plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 19:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/VyUyzTj/Ns+LNXLQBk9Rd6U8O/FkeaSfUH8ZvZpNI=;
        b=bGLgjRI5ZAb0Zw9jhKlEy4R4cyFc60RhxdnN4SztDzozjLku2nGtGTj4ZvSwWX6o5l
         sG7Ui0/DsgGQd3zyYZgPrjap+tivhj4GfCZM4J8urBRt6KzoMdaFQZIc8/hLWdlRBeyA
         K8TxQrkHBnJwxbQv4BrQKV5NugVRByOefYv/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/VyUyzTj/Ns+LNXLQBk9Rd6U8O/FkeaSfUH8ZvZpNI=;
        b=nuu/JA9S7zvB/yM5yMoEYGMnAz0DCgnE907CLmXJd//CK2fvu6HzBbxCY4ONtXr6uH
         A1S1H/zDjxk4EOsonWvQdP3+2hxL27h876g7uIFKy3CCKHg0XnTEeKU8A/geCs4CLUMw
         V4SZf4uJkA+LT5/u7mnFgjbl0uMgwhGJuEWy7/IV0YgjjkPO+O5svBc+fZ6RtZKODGm0
         Bs2PJYdLwjWAdBTX3bAtJqzyRekQDVw/Ap0t4IleDq3nH0ftubIjHlv5vVXEhyQTFj6E
         b1beKI+3RB9pxUfvidqlB8kP7puIzykZbBAcqKJG3EvqfstCGwyi4+Cc84ewtoOpHpoW
         ntqQ==
X-Gm-Message-State: AJcUukd4qLFI3FSk3AW8Uf2ufvPe1iJ41mqZW6fap0K1ZoB5GjM5ZR2Q
        jSUxdiwZ724GSL51ffnVZ2cK
X-Google-Smtp-Source: ALg8bN7RkvRnvHUC2VHG0Kfbm9d0Mh66AklAtvp41flEH/tYy1U98D2roVlbIkaFRsgjE+6oT3d30Q==
X-Received: by 2002:a17:902:b40d:: with SMTP id x13mr54211052plr.237.1546659468862;
        Fri, 04 Jan 2019 19:37:48 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id 125sm111944623pfx.159.2019.01.04.19.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 19:37:48 -0800 (PST)
Date:   Sat, 5 Jan 2019 09:07:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Ryan Grachek <ryan@edited.us>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8 v2] k3dma patches to add support for hi3660/HiKey960
Message-ID: <20190105033738.GA2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jan 04, 2019 at 12:56:20PM -0800, John Stultz wrote:
> This patch series is based on recent work by Tanglei Han, and
> adds support for hi3660 SoCs as found on the HiKey960 board,

Not sure about the description/subject here! This patchset adds support
for ASP DMAC found in HI3660 SoCs, Peripheral DMAC is already supported.

Thanks,
Mani

> along with a few patches I've been carrying.
> 
> Review and feedback would be greatly appreciated!
> 
> thanks
> -john
> 
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Ryan Grachek <ryan@edited.us>
> CC: devicetree@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> John Stultz (3):
>   Documentation: bindings: k3dma: Add binding for dma-avail-chan
>   arm64: dts: hi3660: Add dma to uart nodes
>   arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-avail-chan
> 
> Li Yu (2):
>   dma: k3dma: Delete axi_config
>   dma: k3dma: Add support to dma_avail_chan
> 
> Youlin Wang (3):
>   Documentation: bindings: k3dma: Extend the k3dma driver binding to
>     support hisi-asp
>   dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
>   arm64: dts: hi3660: Add hisi asp dma device
> 
>  Documentation/devicetree/bindings/dma/k3dma.txt |  7 ++-
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 22 ++++++++-
>  drivers/dma/k3dma.c                             | 60 +++++++++++++++++++++----
>  3 files changed, 78 insertions(+), 11 deletions(-)
> 
> -- 
> 2.7.4
> 
