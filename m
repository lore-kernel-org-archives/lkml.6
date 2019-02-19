Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD9DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF61F21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550567469;
	bh=bxAhFaJzYeh+kug4n0sOfuGcn+g4Ssg6hQRIRRNZKtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sfHC6B/2WL3Od99HGck534v6Z3nmWplW2+wysvjOzZn6veSwy7Yt7Ywd7uMKLZkwA
	 b7He0mg/8r5NyrranXkE89m/HIst9oHjoeSVxIWuhiLNO5QaipS+NM1UPk1brqTQFC
	 ewz5z65XcAvVjvSiqBfHIbdaL/GCgp+1gWnpi1fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfBSJLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:11:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46797 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfBSJLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:11:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id c18so11408484otl.13;
        Tue, 19 Feb 2019 01:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxDA+/dzu0nOfBkkmiudLRSxaWUAW+hOuZ4AgzPO4rc=;
        b=bfVskMFpWtkgrZq8OJyO7W9b48oxOcitj4jvknAxK8CUTjlPlIh+wqprBGxLI/TfWT
         GHvIs+OW7JsVpg/USxoeWF7l1GFCM5bArGNt15Ib7yjeAQ24vay0efoj3jsrL78n74yx
         kkg8eG7PslBAAsJFx8MIbYlYo623HZDia/ACDkKttq3iwm5KHjukasw0ZJ/DqnCJUGAB
         PIYkgqt2RnRfKHDDxt8qLdntes8xAaRUelMEStoUUEinwFzEhczWX6zFbopO5y+6Efbl
         MtaJYmLJJCAFXzMc2r29RIh2HF9708HWa0ALJBu8VHyktp6VU9EAr8JmA2WBuymY9SmQ
         PuLg==
X-Gm-Message-State: AHQUAuYq60xdpRWzCDJ7WVHNIyq+2r/s6GfvybDsINsR+L+3KlWZ/RcG
        NUhfgd2sbzqP+xgOTjwWcdY3DoSfLuR4V4XqsGA=
X-Google-Smtp-Source: AHgI3IZfpWU8UOjAiG2wYUiGk6S3D7wUB9RiTpFO8XHvEHCNZiw6qRt9AV7uLy7CDngabgtTn/kUKwIaCc5tWff3J2M=
X-Received: by 2002:aca:88d:: with SMTP id 135mr1823105oii.84.1550567465621;
 Tue, 19 Feb 2019 01:11:05 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
In-Reply-To: <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Feb 2019 10:10:54 +0100
Message-ID: <CAJZ5v0i7_UuHs_RMrL9GOfEVZPZpCF-uatw3=OwsrTpA=PNfWQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
To:     Len Brown <lenb@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 4:40 AM Len Brown <lenb@kernel.org> wrote:
>
> From: Zhang Rui <rui.zhang@intel.com>
>
> On the new dual-die/package systems, the RAPL MSR becomes die-scope.
> Thus instead of one powercap device per physical package, now there
> should be one powercap device for each unique die on these systems.
>
> This patch introduces intel_rapl driver support for new
> dual-die/package systems.
>
> On the hardwares that do not have multi-die, topology_unique_die_id()
> equals topology_physical_package_id(), thus there is no functional change.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/powercap/intel_rapl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 6057d9695fed..e004707283da 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
>  /* caller to ensure CPU hotplug lock is held */
>  static struct rapl_package *rapl_find_package(int cpu)
>  {
> -       int id = topology_physical_package_id(cpu);
> +       int id = topology_unique_die_id(cpu);
>         struct rapl_package *rp;
>
>         list_for_each_entry(rp, &rapl_packages, plist) {
> @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
>  /* called from CPU hotplug notifier, hotplug lock held */
>  static struct rapl_package *rapl_add_package(int cpu)
>  {
> -       int id = topology_physical_package_id(cpu);
> +       int id = topology_unique_die_id(cpu);
>         struct rapl_package *rp;
>         int ret;
>
> --
> 2.18.0-rc0
>
