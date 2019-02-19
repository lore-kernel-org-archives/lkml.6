Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FB6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F3A21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550567512;
	bh=tAZMzLnQ6xXzJoTuJ37rq2LuYKXsPxAgt26tQ8u1zCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2F0yVCNHYWgZuN6b8/AN439t2sainxXVIUauWAINgKmrWIHHaM5HNecIGs8os8DOJ
	 2eEg8f3x5tzIDMW4Up6eyB9MzigbPaMUSgFkp0BdtvYirGJO6Lrs7cYP/cN5rGxatB
	 TmTViKlIzgibnH2cZ6flmPDI2HuEagcjIDmfAUzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfBSJLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:11:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42641 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:11:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so32954989oto.9;
        Tue, 19 Feb 2019 01:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpZqX8ZhanD8VsrfzSWpgGhHEmCBLY3UZTMgd9EGn4k=;
        b=d0YTGPGd+w9Qi1yWlHvQF5dg9Hg+MGt1fh25hUb7TVtcKic19MYg37t63WmlYBLNY+
         pRR0PGHbfxAkysy6OQ5UvhJJKm2w174ZHIA8ujVw5+hX8rRxxvhfpKDwacS/Zr+6ldm5
         TMTil2yE6m6038hv12tGt2CG+meglUavZuHKMXZjMm1VrsGnu/n+DXa2Bkdvc2jV4+9n
         sqS55Uc9aNg3Y6hN7oopoxVmF/Dhi1juQqYLFb0BDUmimWAPN9hI6RFvNhxKWMr+3EgB
         O/+G8ZC/KS37ipb+1XJc5D98/PNkRx1omFhlow4OMzhDHCAWWcoLz+j5l9RzKV46vQM6
         66zA==
X-Gm-Message-State: AHQUAuaWj6SA0CaoKbK2z+GgWrsYGZ4QuQMzmXF82QHeZ6vASZPZn5t1
        9GTbVhaNAkkdMR+VBVIKhWwYhSCv8k9MA3mFY1Cpldrw
X-Google-Smtp-Source: AHgI3IYECn6r7H1BcwY0gnpZmY4QGmW6WWym3C7rTdcMhs1oXgDGFJPQKAcnl2ZtYjS2qsuax7Rj/7+9yfN2nQrJFJA=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr17626418otl.343.1550567508944;
 Tue, 19 Feb 2019 01:11:48 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <c21fb21e1cd476b2806d5f88c96e8cc54d3fd08a.1550545163.git.len.brown@intel.com>
In-Reply-To: <c21fb21e1cd476b2806d5f88c96e8cc54d3fd08a.1550545163.git.len.brown@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Feb 2019 10:11:37 +0100
Message-ID: <CAJZ5v0i1LigqFyg3tFrcOyJRehJyKJOyn7CSePOok=q+3zewpg@mail.gmail.com>
Subject: Re: [PATCH 07/11] powercap/intel_rapl: simplify rapl_find_package()
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

On Tue, Feb 19, 2019 at 4:41 AM Len Brown <lenb@kernel.org> wrote:
>
> From: Zhang Rui <rui.zhang@intel.com>
>
> Simplify how the code to discover a package is called.
> Rename find_package_by_id() to rapl_find_package()
>
> No functional change.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/powercap/intel_rapl.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 6cdb2c14eee4..6057d9695fed 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -264,8 +264,9 @@ static struct powercap_control_type *control_type; /* PowerCap Controller */
>  static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
>
>  /* caller to ensure CPU hotplug lock is held */
> -static struct rapl_package *find_package_by_id(int id)
> +static struct rapl_package *rapl_find_package(int cpu)
>  {
> +       int id = topology_physical_package_id(cpu);
>         struct rapl_package *rp;
>
>         list_for_each_entry(rp, &rapl_packages, plist) {
> @@ -1298,7 +1299,7 @@ static int __init rapl_register_psys(void)
>         rd->rpl[0].name = pl1_name;
>         rd->rpl[1].prim_id = PL2_ENABLE;
>         rd->rpl[1].name = pl2_name;
> -       rd->rp = find_package_by_id(0);
> +       rd->rp = rapl_find_package(0);
>
>         power_zone = powercap_register_zone(&rd->power_zone, control_type,
>                                             "psys", NULL,
> @@ -1454,8 +1455,9 @@ static void rapl_remove_package(struct rapl_package *rp)
>  }
>
>  /* called from CPU hotplug notifier, hotplug lock held */
> -static struct rapl_package *rapl_add_package(int cpu, int pkgid)
> +static struct rapl_package *rapl_add_package(int cpu)
>  {
> +       int id = topology_physical_package_id(cpu);
>         struct rapl_package *rp;
>         int ret;
>
> @@ -1464,7 +1466,7 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
>                 return ERR_PTR(-ENOMEM);
>
>         /* add the new package to the list */
> -       rp->id = pkgid;
> +       rp->id = id;
>         rp->lead_cpu = cpu;
>
>         /* check if the package contains valid domains */
> @@ -1495,12 +1497,11 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
>   */
>  static int rapl_cpu_online(unsigned int cpu)
>  {
> -       int pkgid = topology_physical_package_id(cpu);
>         struct rapl_package *rp;
>
> -       rp = find_package_by_id(pkgid);
> +       rp = rapl_find_package(cpu);
>         if (!rp) {
> -               rp = rapl_add_package(cpu, pkgid);
> +               rp = rapl_add_package(cpu);
>                 if (IS_ERR(rp))
>                         return PTR_ERR(rp);
>         }
> @@ -1510,11 +1511,10 @@ static int rapl_cpu_online(unsigned int cpu)
>
>  static int rapl_cpu_down_prep(unsigned int cpu)
>  {
> -       int pkgid = topology_physical_package_id(cpu);
>         struct rapl_package *rp;
>         int lead_cpu;
>
> -       rp = find_package_by_id(pkgid);
> +       rp = rapl_find_package(cpu);
>         if (!rp)
>                 return 0;
>
> --
> 2.18.0-rc0
>
