Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520527141; cv=none;
        d=google.com; s=arc-20160816;
        b=MZF//XIY+DFKt+cVP4iSlYwFBEP2AxP+/aDhgpBdXwg6tZAvX5Ewr4hxjk9aXJem12
         ixMsTtJ2VGIx1Fyu9FrhnvY60pH6Am9CyID8tKnZSLSc9S+sU2nnBlTo5TYhNMCyh+Aj
         +/Uu6viERRG3GKOqr96rsuMSy+TsefCC47P5AbO4ZX2ATAzqA/UB21F8VVBEyDlpRZgL
         IUGNPXWYBk1KMjwbS254+BxpWPpv/qA1Z45zwzYQEOuEEkhy8s3iPUE+iuczNrzLI0Ik
         FLvRkfkgsvywsx1zgoiPRvmGDDk1xox/S5dUYvhQTvAK76F2HnRQYUqZCMJdkUI3cUpM
         XDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yispfl+P3pKaLW+62G3itH1qv4LeY5Ju8q86UjR0H6o=;
        b=oufVriow0wyT3QmQB89HvDXOcA9vffkx3WJHAihwkpervwMIhrcmXaMrgnk/2oT/im
         UPXFnTx8f9lNuvgbEwz3JYvw3WrXgHWQBGhOYvPpe0hRWWoXkfWGMSNKM9pbG0WOXEKl
         S/cTQeEj+C2KTkDQA6QB1A0Mom6KzZjblOirJtd55FEWrmuknKllO1Nrxakl/nQcP7n9
         iRsB8MgmadaBgJMSazibFuONMiKQC7wBLdWzdcxfEwERPG5khcdWQMYt8OoZpwstdZcO
         FyBKxKMBPeT/UR+4jECnQMa8Qa0NLkWTlU6xKMvgbVQRfjKSy7AFw/wuipxGkM1QZ48x
         lg5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CCDeld81;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CCDeld81;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuLtyXcjf32HR+UtIp+i51r6tixD2bNNEQ387CnvXbS960/3sRLJ4ZRzoRWqjl47CGF9iBa8320MpwoJJOjQcQ=
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-6-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com> <20180228220619.6992-6-jeremy.linton@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 8 Mar 2018 16:39:00 +0000
Message-ID: <CAKv+Gu9LHHwWNcQdNwDvY70+whxH1VDoGNkMhM0E67hE0LDMDA@mail.gmail.com>
Subject: Re: [PATCH v7 05/13] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
	Catalin Marinas <catalin.marinas@arm.com>, palmer@sifive.com,
	Will Deacon <will.deacon@arm.com>, linux-riscv@lists.infradead.org,
	morten.rasmussen@arm.com, vkilari@codeaurora.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <ahs3@redhat.com>, Len Brown <lenb@kernel.org>,
	John Garry <john.garry@huawei.com>, wangxiongfeng2@huawei.com, dietmar.eggemann@arm.com,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684148891338280?=
X-GMAIL-MSGID: =?utf-8?q?1594388267470807002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28 February 2018 at 22:06, Jeremy Linton <jeremy.linton@arm.com> wrote:
> ACPI 6.2 adds a new table, which describes how processing units
> are related to each other in tree like fashion. Caches are
> also sprinkled throughout the tree and describe the properties
> of the caches in relation to other caches and processing units.
>
> Add the code to parse the cache hierarchy and report the total
> number of levels of cache for a given core using
> acpi_find_last_cache_level() as well as fill out the individual
> cores cache information with cache_setup_acpi() once the
> cpu_cacheinfo structure has been populated by the arch specific
> code.
>
> An additional patch later in the set adds the ability to report
> peers in the topology using find_acpi_cpu_topology()
> to report a unique ID for each processing unit at a given level
> in the tree. These unique id's can then be used to match related
> processing units which exist as threads, COD (clusters
> on die), within a given package, etc.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c | 488 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 488 insertions(+)
>  create mode 100644 drivers/acpi/pptt.c
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> new file mode 100644
> index 000000000000..883e4318c6cd
> --- /dev/null
> +++ b/drivers/acpi/pptt.c
...
> +/* total number of attributes checked by the properties code */
> +#define PPTT_CHECKED_ATTRIBUTES 4
> +
> +/*
> + * The ACPI spec implies that the fields in the cache structures are used to
> + * extend and correct the information probed from the hardware. Lets only
> + * set fields that we determine are VALID.
> + */
> +static void update_cache_properties(struct cacheinfo *this_leaf,
> +                                   struct acpi_pptt_cache *found_cache,
> +                                   struct acpi_pptt_processor *cpu_node)
> +{
> +       int valid_flags = 0;
> +
> +       if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
> +               this_leaf->size = found_cache->size;
> +               valid_flags++;
> +       }
> +       if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID) {
> +               this_leaf->coherency_line_size = found_cache->line_size;
> +               valid_flags++;
> +       }
> +       if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID) {
> +               this_leaf->number_of_sets = found_cache->number_of_sets;
> +               valid_flags++;
> +       }
> +       if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID) {
> +               this_leaf->ways_of_associativity = found_cache->associativity;
> +               valid_flags++;
> +       }
> +       if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID) {
> +               switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
> +               case ACPI_PPTT_CACHE_POLICY_WT:
> +                       this_leaf->attributes = CACHE_WRITE_THROUGH;
> +                       break;
> +               case ACPI_PPTT_CACHE_POLICY_WB:
> +                       this_leaf->attributes = CACHE_WRITE_BACK;
> +                       break;
> +               }
> +       }
> +       if (found_cache->flags & ACPI_PPTT_ALLOCATION_TYPE_VALID) {
> +               switch (found_cache->attributes & ACPI_PPTT_MASK_ALLOCATION_TYPE) {
> +               case ACPI_PPTT_CACHE_READ_ALLOCATE:
> +                       this_leaf->attributes |= CACHE_READ_ALLOCATE;
> +                       break;
> +               case ACPI_PPTT_CACHE_WRITE_ALLOCATE:
> +                       this_leaf->attributes |= CACHE_WRITE_ALLOCATE;
> +                       break;
> +               case ACPI_PPTT_CACHE_RW_ALLOCATE:
> +               case ACPI_PPTT_CACHE_RW_ALLOCATE_ALT:
> +                       this_leaf->attributes |=
> +                               CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE;
> +                       break;
> +               }
> +       }
> +       /*
> +        * If the above flags are valid, and the cache type is NOCACHE
> +        * update the cache type as well.
> +        */
> +       if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
> +           (valid_flags == PPTT_CHECKED_ATTRIBUTES))
> +               this_leaf->type = CACHE_TYPE_UNIFIED;

Why do we need the associativity and #sets attributes to be valid in
order to set the cache type?

I see how size and line size are rather fundamental properties, but
for a system cache, the geometry doesn't really matter.

> +}
> +
> +/*
> + * Update the kernel cache information for each level of cache
> + * associated with the given acpi cpu.
> + */
> +static void cache_setup_acpi_cpu(struct acpi_table_header *table,
> +                                unsigned int cpu)
> +{
> +       struct acpi_pptt_cache *found_cache;
> +       struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +       struct cacheinfo *this_leaf;
> +       unsigned int index = 0;
> +       struct acpi_pptt_processor *cpu_node = NULL;
> +
> +       while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
> +               this_leaf = this_cpu_ci->info_list + index;
> +               found_cache = acpi_find_cache_node(table, acpi_cpu_id,
> +                                                  this_leaf->type,
> +                                                  this_leaf->level,
> +                                                  &cpu_node);
> +               pr_debug("found = %p %p\n", found_cache, cpu_node);
> +               if (found_cache)
> +                       update_cache_properties(this_leaf,
> +                                               found_cache,
> +                                               cpu_node);
> +
> +               index++;
> +       }
> +}
> +
> +/**
> + * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
> + * @cpu: Kernel logical cpu number
> + *
> + * Given a logical cpu number, returns the number of levels of cache represented
> + * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
> + * indicating we didn't find any cache levels.
> + *
> + * Return: Cache levels visible to this core.
> + */
> +int acpi_find_last_cache_level(unsigned int cpu)
> +{
> +       u32 acpi_cpu_id;
> +       struct acpi_table_header *table;
> +       int number_of_levels = 0;
> +       acpi_status status;
> +
> +       pr_debug("Cache Setup find last level cpu=%d\n", cpu);
> +
> +       acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> +       if (ACPI_FAILURE(status)) {
> +               pr_err_once("No PPTT table found, cache topology may be inaccurate\n");
> +       } else {
> +               number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
> +               acpi_put_table(table);
> +       }
> +       pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
> +
> +       return number_of_levels;
> +}
> +
> +/**
> + * cache_setup_acpi() - Override CPU cache topology with data from the PPTT
> + * @cpu: Kernel logical cpu number
> + *
> + * Updates the global cache info provided by cpu_get_cacheinfo()
> + * when there are valid properties in the acpi_pptt_cache nodes. A
> + * successful parse may not result in any updates if none of the
> + * cache levels have any valid flags set.  Futher, a unique value is
> + * associated with each known CPU cache entry. This unique value
> + * can be used to determine whether caches are shared between cpus.
> + *
> + * Return: -ENOENT on failure to find table, or 0 on success
> + */
> +int cache_setup_acpi(unsigned int cpu)
> +{
> +       struct acpi_table_header *table;
> +       acpi_status status;
> +
> +       pr_debug("Cache Setup ACPI cpu %d\n", cpu);
> +
> +       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> +       if (ACPI_FAILURE(status)) {
> +               pr_err_once("No PPTT table found, cache topology may be inaccurate\n");
> +               return -ENOENT;
> +       }
> +
> +       cache_setup_acpi_cpu(table, cpu);
> +       acpi_put_table(table);
> +
> +       return status;
> +}
> --
> 2.13.6
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
