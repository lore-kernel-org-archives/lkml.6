Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1ACC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F3F217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R4xswFCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeLRKGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:06:41 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17127 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLRKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:06:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18c6aa0001>; Tue, 18 Dec 2018 02:06:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Dec 2018 02:06:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 02:06:40 -0800
Received: from [10.19.64.157] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 10:06:38 +0000
Subject: Re: [PATCH 07/18] mfd: rc5t583: Make it explicitly non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
 <1545078688-21217-8-git-send-email-paul.gortmaker@windriver.com>
CC:     <linux-kernel@vger.kernel.org>
From:   Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <2853fd33-c4ee-1698-606a-7846425234ac@nvidia.com>
Date:   Tue, 18 Dec 2018 15:34:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1545078688-21217-8-git-send-email-paul.gortmaker@windriver.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545127594; bh=YkpwxAbOse7q+vM63LHpYMvKtV//Wgx8jbMyVCFBduU=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=R4xswFCM8ZNFcop7eWfQJbEU0PQkaAII0OhXxWUdA+AR2HJO5DEXPB0Hp1/BVHeVs
         9Pdyy2p15rEEHf1kB+Woy7ivoLtdSoV7BckSTeTwVU5DUO0Y4M7A6HErW8ANCMTUGC
         OQuKqlx08B5y6dyoHjlpvzLgEDITV5f1HV6eWmnXdvxqjLkAVm1a9TgH+LKrr05/vH
         JisWunpEB4L6sIJpvWSeBQ5aL1xyukrfcL1zSndEBHlt6XDxwXU+ZGJomzTRP7hp0u
         PT4uL7bklqr2DlLJexs+K+pbWrtHEnHYmo4DV8+B3XyzGdxFmN9cFMNLGLr9fg4vf9
         XzCNRBlMLDh5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 18 December 2018 02:01 AM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>
> drivers/mfd/Kconfig:config MFD_RC5T583
> drivers/mfd/Kconfig:    bool "Ricoh RC5T583 Power Management system device"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
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
