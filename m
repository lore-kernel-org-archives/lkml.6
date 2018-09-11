Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C6C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E772420866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g647/M5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E772420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeILD6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:58:54 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33070 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeILD6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:58:53 -0400
Received: by mail-it0-f67.google.com with SMTP id j198-v6so10196543ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AMc594ueimTZB6U/jjVwsh5n8q34dbNmoIDf7lLDmzM=;
        b=g647/M5i/cqIIXsCDl/S7hTz7OfJksuYj7TTo26EnY4Sg0Dfii4mLdMf+ewJCbi7T4
         1KSZd40AS/wVr9h/LcHL51pKXXbi6KWaNt2uPqC6yecftQ4jiGAbPPfoSYlejCRhEUCi
         h/8kTynBREPILgzbL9lUkTDPUz92UV+d9kwh5MkMznISZyUkaIEWlKj3piQXMeGHan6D
         mo4xobje/mZCChf07djM/ZQtzTlcHq6jpREHJKncFdNkAV/9NVcLNP1SGPAWCyWUvgEg
         T0EGXJTDSYipU8l7JGDFsjmQndp5oqYE0zJ/uD1X2YLhohyAIq8ZxIEh7M/R9NTqCs2X
         RR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AMc594ueimTZB6U/jjVwsh5n8q34dbNmoIDf7lLDmzM=;
        b=OKC8+MF314jQHGehVJMCEl3W33i9iuRo2kaZLJsGW3E2GgMryQ9p08DcttnpIu6kCR
         QMg3zLaZOtcm+uUmBp8bukl2F1UoE4M0MhsXjIZr3UWnDAtmIAFSTWte6J2Jazt2xiwj
         NvlD+ZZCRjLwafRjTcRbZ8lfMgdNdZv5RUGefprEe6pdHuv+7RSy8uWJRi9tKrjDkvxm
         xVgxpny+Zol48jm17oJRrnlb2DHouGtWjnD5WTo2dLGKBnYy7Kbol8ar/i4IbuTWcFFE
         XKJ5DRKbEJZQdN9d1+kNx4yZVeZ9xHIdQK11P+sDW0HHDB/4K2BZCP95D5KIwZrIhMD1
         UVJw==
X-Gm-Message-State: APzg51BpNmPu51PdM4XHfUP7lcHsJCva7BJK7bxHeziC5NS6eHXdxVfG
        cgDg9Zx+iNvQaFr/cbw3QwR/zA==
X-Google-Smtp-Source: ANB0VdbkjmJ71dcXKuetnXWPBzfDm6oPAL1QSjWHdzeB1q52Ue8sNpfsZ4WfytWxssGrxjgMpwmX5A==
X-Received: by 2002:a24:fd04:: with SMTP id m4-v6mr3923190ith.28.1536706643929;
        Tue, 11 Sep 2018 15:57:23 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id 17-v6sm899870ite.13.2018.09.11.15.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 15:57:22 -0700 (PDT)
Subject: Re: [PATCH] pata_atiixp: Remove unnecessary parentheses
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180911214338.1109-1-natechancellor@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fee3ed2a-4aa6-e9d8-dbcd-8f1f8ee67d06@kernel.dk>
Date:   Tue, 11 Sep 2018 16:57:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180911214338.1109-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 3:43 PM, Nathan Chancellor wrote:
> Clang warns when more than one set of parentheses is used for a
> single conditional statement:
> 
> drivers/ata/pata_atiixp.c:282:19: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/ata/pata_atiixp.c:282:19: note: remove extraneous parentheses
> around the comparison to silence this warning
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>            ~             ^                              ~
> drivers/ata/pata_atiixp.c:282:19: note: use '=' to turn this equality
> comparison into an assignment
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>                          ^~
>                          =
> 1 warning generated.

Applied for 4.20, thanks.

-- 
Jens Axboe

