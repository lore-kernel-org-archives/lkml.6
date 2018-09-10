Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14B1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7920865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1No+XZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF7920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeIJONT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:13:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35373 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbeIJONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:13:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so20674040wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QT0hWnBSCRfYfVbtB7L1bFvADDtsDgQtjakRjEQjcBE=;
        b=j1No+XZpudUDrA/OczB50CV3YvK1Cim/0xn0lhiWsQcd/47jISI2evR18/ZJ18onI3
         XmlK0ScOjS2m1pQBoxqjcb3PqV6kqPu7qIkYp5VPD4QjoVXoevkV/Xfh4neGAY8/Knll
         jXvLcqHfRkLfRpCkpykvXXV8wbHVGF7Z/2d5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QT0hWnBSCRfYfVbtB7L1bFvADDtsDgQtjakRjEQjcBE=;
        b=D6Xf/+qN26pNxlmTZlO4bjDVGkr1CEsln40Ufbkheu5cUI0kYfwY+yqzTJUGQwRs1t
         NWVfjxRRPTcGiB+FMTmhQ+QN2zyIW2YHuWigLDNFoMsCBmA744pH/gXaC7aJn/mYR8a7
         mLmgEx3+TlG1wBoR3OhgbJWcVxzyIKZM0n6TUQrAkBaYfMwe5uiKTpf9J08XTx1L002e
         S5jMLLNmIGK6419DdBcB8WIpL35TbVCYhgVCiptWQpZMErhnXebUleSwaRPepUG4T7Zh
         C43RFPJ12UWPXV7xUTGzkPDCJ3cYDII2KqZpXXUT1YyMvlx+Bjpek7TraD8CQUrWz9GH
         6bIQ==
X-Gm-Message-State: APzg51CjT8g8NQWBTV8VSvFg7CRGJ7UdfJVn0bM/8/EjiGy+4dYaF0Ou
        faxQOlF+EMeytB5kCLZf+tP88w==
X-Google-Smtp-Source: ANB0VdZtL19nuYfZKxyeQAWqJTLJVxAPOjeqWogX6NFpUvw8/xe4xXv8RTinvTKnd2WIM6yyAxyofg==
X-Received: by 2002:a1c:1182:: with SMTP id 124-v6mr41526wmr.75.1536571212100;
        Mon, 10 Sep 2018 02:20:12 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q135-v6sm25809676wmd.4.2018.09.10.02.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 02:20:11 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:20:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Victor Chong <victor.chong@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Fwd: [PATCH] tee: optee: log message if dynamic shm is enabled
Message-ID: <20180910092009.y2p5n5owozaz6etw@holly.lan>
References: <CAHqM-Qgy7zPjrnNm0Xdyz_F_BYbSPgDfQrkv0tGv_rB1G7tSXg@mail.gmail.com>
 <CAHqM-QgH3d3Fz=P-_Gj_ZJODK1YOxT49G=qhzAnM=g2HAYqoow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHqM-QgH3d3Fz=P-_Gj_ZJODK1YOxT49G=qhzAnM=g2HAYqoow@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 05:57:28PM +0900, Victor Chong wrote:

This (empty) patch description seems unusually terse! Surely there
should be some clues in the description about why this messages
deserves user/dev/admin attention...


> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Victor Chong <victor.chong@linaro.org>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/tee/optee/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index e1aafe842d66..cca5c091e55a 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -631,6 +631,9 @@ static struct optee *optee_probe(struct device_node *np)
> 
>         optee_enable_shm_cache(optee);
> 
> +       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> +               pr_info("dynamic shared memory is enabled\n");
> +
>         pr_info("initialized driver\n");
>         return optee;
>  err:
> --
> 2.17.1
