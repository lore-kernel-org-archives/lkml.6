Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE04C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C008F20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547452340;
	bh=7St7aUOJaIWijS9yl62rkzDA8MFLn7sCTDGjRe648AI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uc8pbqArs2VQW1943fLe3Bkt0FdvJCoRqL/UM1iIDpozR+R1QliRQQGUbyDLY5uFt
	 J/Wxu+K8rOJbv++7T8DyQ0CeKp1nmIkg4pdp7FmTg5OpK90S1RJZAwDw00NC44rE1u
	 6s6d0970Z2jUBqyUFrFltlo4U3xdGBXiRYvvETj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfANHwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfANHwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:52:14 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88EE2087E;
        Mon, 14 Jan 2019 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547452333;
        bh=7St7aUOJaIWijS9yl62rkzDA8MFLn7sCTDGjRe648AI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Api1M0led/8WUeQTQxVpNZdbMFt10oaNZ+Cxl7mtjL+iVIbxek9hGlWg+72rPOKqG
         QMRkgg+LgihYZL+qVAbip60P5E9vfpDvyzeNR97koPTSnAfVFWyK36Yai63YS+jRPL
         laupYoqKttX/SuUZDrCOza8F3aB4OcAq3QhQNS4c=
Received: by mail-lf1-f52.google.com with SMTP id i26so14897518lfc.0;
        Sun, 13 Jan 2019 23:52:12 -0800 (PST)
X-Gm-Message-State: AJcUukev4SHaEiij2oMi23qyDyXA0ZC4d6bbqALAOVREVtpC4MQmbrwI
        qoH3zp3fpF6mHsz8hX7Htu/6gfBLgXaiBXRY524=
X-Google-Smtp-Source: ALg8bN7XJmMKBAZQatGvjKB0aLZIBhNajxj93l3cVRSLI1sUGphrfzOYcFa+Ym8OLJXGPOMTbf1pUnhfhysVUsbF6X8=
X-Received: by 2002:a19:c396:: with SMTP id t144mr12232535lff.110.1547452331079;
 Sun, 13 Jan 2019 23:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 14 Jan 2019 08:51:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
Message-ID: <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
Subject: Re: [PATCH v4] cpufreq: s5pv210: Defer probe if getting regulators fail
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2019 at 20:58, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> There is possibility, that when probing driver, regulators are not yet
> initialized. In this case we should return EPROBE_DEFER and wait till
> they're initialized, since they're required currently for cpufreq driver
> to work. Also move regulator initialization code at beginning of probe,
> so we can defer as fast as posibble.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v3:
>   - Zero dmc_base pointers after unmapping them
>   - If getting vddarm regulator fails just return, no need to do goto
>     jump which would do the same
>
> Changes from v2:
>   - Handle all error paths in probe
>
> Changes from v1:
>   - Fix compilation error
>   - Reorganize code so it's smaller

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
