Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC39C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C3221904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBGQxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:53:55 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46698 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:53:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so300615qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 08:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hkqMO2ItAK6ooIZ/JT39WbR1HbEjH3KlNsiLbXtUQGw=;
        b=BDNCELD+wpzzY4nhQAax7EL/i1/fcD4IubfDqxTNvOSfy/w/Vhuqoa9azGyFclxbOh
         2M9bFSVkXYHxiEq5iKIO5vyHhkumqXzVeq2l9qTi3DU73h4byHLAdJrN3jBYnkG4EicS
         Fnd7CZFc9IzZqZnRkUEZ4hEN21XGC6SjfAEgrfM5mM2/mELFzvrNd/Z/zSPIU2PBTHx8
         Qo7b6y9SuyAuyI/GZx1q9lb9s7KnCCe0NuAlP87qCzMz67hfrHLUrGLOOXOxFvKZVJLr
         O3FWfRS1UeoRxl/yUqf/ToqZFn+N5ISUG6kfEmgwOCNX+WtqxGSkuCXNdRoyzJZyaP8W
         PEYw==
X-Gm-Message-State: AHQUAuabXT8nVOs76fU9/ze9i1krkLlfXr5j8lgiD7iCkF5dTO/hCi6C
        epfKbSf/dE6vA4p5v6pwKF/hpQ==
X-Google-Smtp-Source: AHgI3IYGrgpw0Y2UeQUPfGQtE5DPWInQ2WMRw4KWHLZld9uawDUPT9yj7L9aUD2q6KR9VGJc1XOl3A==
X-Received: by 2002:a37:d912:: with SMTP id u18mr12109420qki.95.1549558432921;
        Thu, 07 Feb 2019 08:53:52 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id s21sm3045138qki.94.2019.02.07.08.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 08:53:51 -0800 (PST)
Date:   Thu, 7 Feb 2019 09:53:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH v2] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
Message-ID: <20190207165350.jkj4bbi4mha3nukm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>
References: <20190204135943.15756-1-jarkko.sakkinen@linux.intel.com>
 <20190207163157.DA4A62175B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190207163157.DA4A62175B@mail.kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 07 19, Sasha Levin wrote:
>Hi,
>
>[This is an automated email]
>
>This commit has been processed because it contains a "Fixes:" tag,
>fixing commit: 30fc8d138e91 tpm: TPM 2.0 CRB Interface.
>
>The bot has tested the following trees: v4.20.6, v4.19.19, v4.14.97, v4.9.154, v4.4.172.
>
>v4.20.6: Build OK!
>v4.19.19: Build OK!
>v4.14.97: Build OK!
>v4.9.154: Failed to apply! Possible dependencies:
>    13b1f4a571cc ("tpm_crb: map locality registers")
>    b4e2eb0651ac ("tpm crb: Work around BIOS's that report the wrong ACPI region size")
>
>v4.4.172: Failed to apply! Possible dependencies:
>    13b1f4a571cc ("tpm_crb: map locality registers")

I'm guessing it is tripping over this not being applied

>    14ddfbf488a0 ("tpm_crb: drop struct resource res from struct crb_priv")
>    1bd047be37d9 ("tpm_crb: Use devm_ioremap_resource")
>    1e3ed59d6200 ("tpm_crb: Drop le32_to_cpu(ioread32(..))")
>    25112048cd59 ("tpm: rework tpm_get_timeouts()")
>    30f9c8c9e2ea ("tpm_crb/tis: fix: use dev_name() for /proc/iomem")
>    422eac3f7dea ("tpm_crb: fix mapping of the buffers")
>    4886cd80cb8e ("Revert "tmp/tpm_crb: implement runtime pm for tpm_crb"")
>    4d627e672bd0 ("tpm_tis: Do not fall back to a hardcoded address for TPM2")
>    51dd43dff74b ("tpm_tis: Use devm_ioremap_resource")
>    55a889c2cb13 ("tpm_crb: Use the common ACPI definition of struct acpi_tpm2")
>    7ab4032fa579 ("tpm_tis: Get rid of the duplicate IRQ probing code")
>    9514ff1961c6 ("tmp/tpm_crb: fix Intel PTT hw bug during idle state")
>    aa77ea0e43dc ("tpm/tpm_crb: cache cmd_size register value.")
>    ba5287b6ef6a ("tpm/tpm_crb: implement tpm crb idle state")
>    e17acbbb69d3 ("tpm/tpm_crb: implement tpm crb idle state")
>    e350e24694e4 ("tmp/tpm_crb: implement runtime pm for tpm_crb")
>    e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
>    ef7b81dc7864 ("tpm_tis: Disable interrupt auto probing on a per-device basis")
>
>
>How should we proceed with this patch?
>
>--
>Thanks,
>Sasha
