Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1392184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QQ4c/JuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeLRKHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:07:50 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17165 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeLRKHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:07:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18c6f00000>; Tue, 18 Dec 2018 02:07:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Dec 2018 02:07:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 02:07:49 -0800
Received: from [10.19.64.157] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 10:07:48 +0000
Subject: Re: [PATCH 12/18] mfd: tps80031: Make it explicitly non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
 <1545078688-21217-13-git-send-email-paul.gortmaker@windriver.com>
CC:     <linux-kernel@vger.kernel.org>
From:   Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <12b9a17a-bcba-2941-c77e-5e58228b8f02@nvidia.com>
Date:   Tue, 18 Dec 2018 15:37:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1545078688-21217-13-git-send-email-paul.gortmaker@windriver.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545127664; bh=3RMBeqJNpuADxmMPKHTYe02/ctMc+KBHy65cG0++Hwc=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=QQ4c/JuBH8wQ+rDv522n0U61Ajq9L79Ss+lMl9OMT9GrTSBE4LPdSgSsAK0XaUvRh
         NM1OP1926uyE+Mv1MqsW8WpdqceB/i/XLXHx8cV9cy24pQKuhh2Py4e62gxNlF2DqQ
         8FHfCSiqfQ/quS45Dse1Xi2rWrgLAf9n6XUzQwNBShtoT/FiOzj30wr/IFpyVs2Ywa
         sIx/UcPIJyKyI6OUGkP/6NnrVf6CtUx9uV+zgECaTq5gkK01my4DHnQJ9DiYZu1CAS
         h1UhPSuorMDMpwdlmVdpabuGIhvr4jAio5ggWb0r4NIzOjPPe+P33Lnp1Vw+EgWgvs
         l5/komEdyv29g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 18 December 2018 02:01 AM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>
> drivers/mfd/Kconfig:config MFD_TPS80031
> drivers/mfd/Kconfig:    bool "TI TPS80031/TPS80032 Power Management chips"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
>
> We don't replace module.h with init.h since the file already has that.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
