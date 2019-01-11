Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C319C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8AB21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547200002;
	bh=uMEjfMSqnjC4fCVJMMPj18/F1l1sJACJ6bmQ0AGcTic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pvSz6lDnz8ZcThIRquF40MPjmLxVAMGh8YN87av+XPQC8ieIkxRlbmpt+xcsNJNhK
	 WzFqLhA5xZQQnU+rzt5zNk+IdUUBDLIKSBPyFQknl5HfZ0S/UpYON5h2KFRlcRUfGw
	 KBfVJOFq3lFh4n1bGZgx3Cz+IJz771zxnkJkwVGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfAKJql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbfAKJqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:46:40 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868E721783;
        Fri, 11 Jan 2019 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547199999;
        bh=uMEjfMSqnjC4fCVJMMPj18/F1l1sJACJ6bmQ0AGcTic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ml7dfCHmow21/DE7SBEP5YOJF1qpt2tndN2ujw2w+pD10o1p2lueRPM0c7cRpapse
         DmR9FxyVFYnlmOitS31BWIe+jRKYNcBUPB8HZvd3NPkXNtsvpff+m/errEzKCX/jYi
         q+BYrCBl9eQIkH+QI3dIhHJxyAKz4fKNXyXTd4X0=
Received: by mail-lf1-f49.google.com with SMTP id a8so10354533lfk.5;
        Fri, 11 Jan 2019 01:46:39 -0800 (PST)
X-Gm-Message-State: AJcUukclgqIKx8Z+W/gQf1lyCxrDjnBXdaiMAtAZ6BgSy56fiXpJJIhh
        IOu7u+W3xnmaWthK9MEk+U8IwrSWxQpnXN4i6Ug=
X-Google-Smtp-Source: ALg8bN7JOfJUWRedo42QQ45VUS0GyU10FwJUgBKqD0/QC0C3yKrFyPxWTsXxyLlgaZT6dSRWNHC6d4Wr6hxCzVgTVEQ=
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr8211983lfc.124.1547199997640;
 Fri, 11 Jan 2019 01:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com> <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 11 Jan 2019 10:46:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
Message-ID: <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cpufreq: s5pv210: Defer probe if getting
 regulators fail
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 21:53, Pawe=C5=82 Chmiel
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
> Changes from v1:
>   - Fix compilation error
>   - Reorganize code so it's smaller
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 32 ++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-=
cpufreq.c
> index f51697f1e0b3..6df95941ba96 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -594,6 +594,25 @@ static int s5pv210_cpufreq_probe(struct platform_dev=
ice *pdev)
>          * this whole driver as soon as S5PV210 gets migrated to use
>          * cpufreq-dt driver.
>          */
> +       arm_regulator =3D regulator_get(NULL, "vddarm");
> +       if (IS_ERR(arm_regulator)) {
> +               if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER)
> +                       pr_debug("vddarm regulator not ready, defer\n");
> +               else
> +                       pr_err("failed to get regulator vddarm\n");
> +               return PTR_ERR(arm_regulator);
> +       }
> +
> +       int_regulator =3D regulator_get(NULL, "vddint");
> +       if (IS_ERR(int_regulator)) {
> +               if (PTR_ERR(int_regulator) =3D=3D -EPROBE_DEFER)
> +                       pr_debug("vddint regulator not ready, defer\n");
> +               else
> +                       pr_err("failed to get regulator vddint\n");
> +               regulator_put(arm_regulator);
> +               return PTR_ERR(int_regulator);
> +       }
> +

Error paths are now not correct. You should put the regulators when
returning later. The previous code had these error paths wrong as well
- not iounmapping - but if you move things around, maybe let's fix
things.

Best regards,
Krzysztof
