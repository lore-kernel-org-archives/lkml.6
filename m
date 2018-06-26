Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898C4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAAB26812
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXAlo17q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAAB26812
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933714AbeFZJnN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:43:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46349 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeFZJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:43:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so5102648lju.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I4uf5/AFuxUT69s/WM8PEa4R/wc7zU5ADyv8FxL//aQ=;
        b=LXAlo17qcjh9PK9D49yyIBHNuqEyBxiidCULUgJGtze4JZ32IjjvgGx/iHgxJRXbkD
         ZjLl0JduV3fNwiN+jtzANUkLhAi8soekCsfw0v3uo8IzN+XmNCICCRTkumjiL+CxD+mB
         DA2Gs9iVQ0zb7b4EJcKYVhavNIZoDtu2vmbfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I4uf5/AFuxUT69s/WM8PEa4R/wc7zU5ADyv8FxL//aQ=;
        b=C05L/vgv735RQwuiufrzC6CCaiDxurI8MrNzvUOeM2qdFTB8Te6INzvVlv/lMZEZ0o
         s5rXdYtbFXM56+ktnlR31IXsWbV0Hx5Kv/HiXgZ8jxtx0vKFP1/7eBneQ/Ymb+dw2HNt
         VQEvom8Yolf/pkYIBOPA9KsacPujK4DSduhjOXUrcrVoCw6LW/N/qiPWJYE/LZ49fEtr
         c6reJ5omgSnKHVU96GRxtzMdRYCDrV7MAm8JQH4HvWGFp1XentucPzsL6VhykzY8QGfq
         AvEyQC6BoRZ7xaauOU7nIGx4j6F72jQ4kMcwlLo0ChUMxHdAkvjx07X2rrWP3pDk645+
         V21g==
X-Gm-Message-State: APt69E1diwO/DOfh4fKjH5XlXGUTuJVbhi6JRRwQu8KsGY5uJW8GI9R6
        G2E7o4qrfafL/wtB0jPjogfnUA==
X-Google-Smtp-Source: ADUXVKJavV3tEnxvnZ9GIX82RjbA6ZwZC3WsjHkl5opX9RATbifP1R6n8Vz/JQfg/lWgZ6qBBZzCjQ==
X-Received: by 2002:a2e:6d11:: with SMTP id i17-v6mr654815ljc.116.1530006190020;
        Tue, 26 Jun 2018 02:43:10 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u24-v6sm169536ljj.96.2018.06.26.02.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:43:09 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:43:07 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/12] ASoC: qdsp6: Fix dt based module loading and
 minor fixes
Message-ID: <20180626094307.GI25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:20:04AM +0100, Srinivas Kandagatla wrote:
> Recent discussion on https://lkml.org/lkml/2018/6/18/1282 suggested
> that qdsp6 code is using less common of_platform apis which would
> not give dt based module loading support.
> 
> Suggestion from Rob was to add compatible strings to the dais nodes
> This patchset adds this. Also this patchset has 3 trivial fixes which
> is removing redundant owner, remove unused struct member and fix a
> error check in q6routing.
> 
> Changes since v1:
> - Addressed few trivial comments from Niklas

Hello Srini!

I didn't see a response to my review comment in:
https://marc.info/?l=devicetree&m=152998662313684

"Since adding the compatible is a prerequisite for using
of_platform_populate()/of_platform_depopulate(),
I think that the patches that make use of
of_platform_populate()/of_platform_depopulate() should
come after the patches that adds the of_table entries."

If the code is bisectable with the current ordering
of the patches, then feel free to ignore this review
comment.

Kind regards,
Niklas

> 
> Thanks,
> srini
> 
> Srinivas Kandagatla (12):
>   ASoC: q6adm: dt-bindings: add compatible string to routing
>   ASoC: q6asm: dt-bindings: add compatible string to dais
>   ASoC: q6afe: dt-bindings: add compatible string to dais
>   ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()
>   ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()
>   ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()
>   ASoC: qdsp6: q6afe-dai: support dt based module loading
>   ASoC: qdsp6: q6asm-dai: support dt based module loading
>   ASoC: qdsp6: q6routing: support dt based module loading
>   ASoC: qcom: apq8096: remove redundant owner assignment
>   ASoC: qdsp6: q6routing: add proper error check
>   ASoC: qdsp6: q6asm: remove unused struct q6asm member
> 
>  Documentation/devicetree/bindings/sound/qcom,q6adm.txt |  6 ++++++
>  Documentation/devicetree/bindings/sound/qcom,q6afe.txt |  6 ++++++
>  Documentation/devicetree/bindings/sound/qcom,q6asm.txt |  6 ++++++
>  sound/soc/qcom/apq8096.c                               |  1 -
>  sound/soc/qcom/qdsp6/q6adm.c                           | 16 ++--------------
>  sound/soc/qcom/qdsp6/q6afe-dai.c                       |  7 +++++++
>  sound/soc/qcom/qdsp6/q6afe.c                           | 16 ++--------------
>  sound/soc/qcom/qdsp6/q6asm-dai.c                       |  7 +++++++
>  sound/soc/qcom/qdsp6/q6asm.c                           | 17 ++---------------
>  sound/soc/qcom/qdsp6/q6routing.c                       |  9 ++++++++-
>  10 files changed, 46 insertions(+), 45 deletions(-)
> 
> -- 
> 2.16.2
> 
