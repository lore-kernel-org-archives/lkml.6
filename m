Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeFEPAl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:00:41 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35985 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeFEPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:00:39 -0400
X-Google-Smtp-Source: ADUXVKJLho+BnlM41r3fsH95L5B1MgwkRaFOykDT3//17thw2w9NzSXtrv6whhsXno8oQPrnQSPEgHJcHR9JBItgCWU=
MIME-Version: 1.0
In-Reply-To: <1528209304-3280-2-git-send-email-sudeep.holla@arm.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com> <1528209304-3280-2-git-send-email-sudeep.holla@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Jun 2018 17:00:33 +0200
X-Google-Sender-Auth: Fwm0p_OttUN0sZ2A6yXkacLA1-s
Message-ID: <CAJZ5v0gqQNHCuaeduQ8oQtGNUQcZxK171nDfyMNi1VVfnVsMqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI / PPTT: fix build when CONFIG_ACPI_PPTT is
 not enabled
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 4:35 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Though CONFIG_ACPI_PPTT is selected by platforms and nor user visible,
> it may be useful to support the build with CONFIG_ACPI_PPTT disabled.
>
> This patch adds the missing dummy/boiler plate implementation to fix
> the build.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  include/linux/acpi.h      | 15 +++++++++++++++
>  include/linux/cacheinfo.h |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> Hi Rafael,
>
> If you are fine with this, can you provide Ack, so that we route this
> through ARM64 tree where most of the ACPI PPTT support is present.
>
> Regards,
> Sudeep
>
> v1->v2:
>         - removed duplicate definition for acpi_find_last_cache_level
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 8f2cdb0eca71..4b35a66383f9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1299,8 +1299,23 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  }
>  #endif
>
> +#ifdef CONFIG_ACPI_PPTT
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
>  int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
> +#else
> +static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
> +{
> +       return -EINVAL;

Why -EINVAL?

> +}
> +static inline int find_acpi_cpu_topology_package(unsigned int cpu)
> +{
> +       return -EINVAL;
> +}
> +static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
> +{
> +       return -EINVAL;
> +}
> +#endif
>
>  #endif /*_LINUX_ACPI_H*/
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 89397e30e269..70e19bc6cc9f 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -98,7 +98,7 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>  int init_cache_level(unsigned int cpu);
>  int populate_cache_leaves(unsigned int cpu);
>  int cache_setup_acpi(unsigned int cpu);
> -#ifndef CONFIG_ACPI
> +#ifndef CONFIG_ACPI_PPTT
>  /*
>   * acpi_find_last_cache_level is only called on ACPI enabled
>   * platforms using the PPTT for topology. This means that if
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
