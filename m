Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59581C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117662146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544080056;
	bh=p89x8/Ecj0i3f50IaduVGZLPzHHtU/3du/xVUJMfbDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B6+0IrWaB94e+qV4XYB2xVhQ3Eh1Th8OazK0gr5JfTe7kJkY+FDHKDbWLTKyKX64m
	 IJxD7JBFOYhWjn8HHS6WHeWOO724wH9UVpH4ZegfVkQVSfqopaVtV4eEnsN0dcEQ6D
	 YXrgYjbifTzwVHwloKHBRIHW9H9hWUrBS2AD0Zts=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117662146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeLFHHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbeLFHHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:07:34 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89662146D;
        Thu,  6 Dec 2018 07:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544080053;
        bh=p89x8/Ecj0i3f50IaduVGZLPzHHtU/3du/xVUJMfbDU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ScPD+18mKALaPyireSPpkekGXTFNbLrDefJ73u0ivtvJJ3f0XuAO/NFMSmI9aaUei
         5BTzyKC32jRYWezcBYJclnDgg7aPW7LGiIr28VAiPEF73ovHGgnImz+eyhTFIK8AGO
         3gXSBu/2E31C0Wza/Kr+t/teW1OlOtjwJPTKB0aA=
Received: by mail-lj1-f178.google.com with SMTP id x85-v6so20701852ljb.2;
        Wed, 05 Dec 2018 23:07:32 -0800 (PST)
X-Gm-Message-State: AA+aEWZJnjleSDigJkPnkrQM2pUFSUL6Tx/xfZf5nP3Ik66Uh7mnrHNt
        xIUxQPetfxUabvyeMw+kDuirh1UVd7RWw28xO8s=
X-Google-Smtp-Source: AFSGD/WW+BnZTCM6YbFT7FuFSFNmMVzf0AeG6stFhtlf2ZpNzPMgSsvoXoPPxx4gfc01vASPL2b5Xe7q9vjLxkLkytE=
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr16931330ljb.153.1544080050900;
 Wed, 05 Dec 2018 23:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-20-robh@kernel.org>
In-Reply-To: <20181205195050.4759-20-robh@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Dec 2018 08:07:18 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfzAFqQX-WHkEmvhp4OGY_tFtouG7d1JOD+_SRjYzd3cA@mail.gmail.com>
Message-ID: <CAJKOXPfzAFqQX-WHkEmvhp4OGY_tFtouG7d1JOD+_SRjYzd3cA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_node_name_eq for node name comparisons
To:     linus.walleij@linaro.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        s.nawrocki@samsung.com, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 20:51, Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Linus,
I do not have anything queued in pinctrl samsung for next release, so
maybe you could apply this directly?

Best regards,
Krzysztof
