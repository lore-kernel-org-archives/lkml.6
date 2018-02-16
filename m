Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161654AbeBPQzu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161053AbeBPQzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:55:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFDB217C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 16 Feb 2018 13:55:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/4] perf record: Provide detailed information on s390 CPU
Message-ID: <20180216165543.GE24436@kernel.org>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 13, 2018 at 04:14:16PM +0100, Thomas Richter escreveu:
> When perf record ... is setup to record data, the s390
> cpu information was a fixed string "IBM/S390".
> 
> Replace this string with one containing more information
> about the machine. The information included in the cpuid is
> a comma separated list:
>    manufacturer,type,model-capacity,model[,version,authorization]
> with
> 
> - manufacturer: up to 16 byte name of the manufacturer (IBM).
> - type: a four digit number refering to the machine
>   generation.
> - model-capacitiy: up to 16 characters describing number
>   of cpus etc.
> - model: up to 16 characters describing model.
> - version: the CPU-MF counter facility version number,
>   available on LPARs only, omitted on z/VM guests.
> - authorization: the CPU-MF counter facility authorization level,
>   available on LPARs only, omitted on z/VM guests.
> 
> Before:
> [root@s8360047 perf]# ./perf record -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.001 MB perf.data (4 samples) ]
> [root@s8360047 perf]# ./perf report --header | fgrep cpuid
>  # cpuid : IBM/S390
> [root@s8360047 perf]#


  49    38.13 ubuntu:16.04-x-s390           : FAIL s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609


Humm, this seems to be the one causing this:

  LINK     /tmp/build/perf/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugin_kmem.so
In file included from /usr/s390x-linux-gnu/include/string.h:635:0,
                 from arch/s390/util/header.c:16:
In function 'strncat',
    inlined from 'get_cpuid' at arch/s390/util/header.c:65:5:
/usr/s390x-linux-gnu/include/bits/string3.h:156:10: error: call to __builtin___strncat_chk might overflow destination buffer [-Werror]
   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
          ^
In function 'strncat',
    inlined from 'get_cpuid' at arch/s390/util/header.c:72:5:
/usr/s390x-linux-gnu/include/bits/string3.h:156:10: error: call to __builtin___strncat_chk might overflow destination buffer [-Werror]
   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
          ^
In function 'strncat',
    inlined from 'get_cpuid' at arch/s390/util/header.c:111:5:
/usr/s390x-linux-gnu/include/bits/string3.h:156:10: error: call to __builtin___strncat_chk might overflow destination buffer [-Werror]
   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
          ^
In function 'strncat',
    inlined from 'get_cpuid' at arch/s390/util/header.c:117:5:
/usr/s390x-linux-gnu/include/bits/string3.h:156:10: error: call to __builtin___strncat_chk might overflow destination buffer [-Werror]
   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
          ^
  LINK     /tmp/build/perf/plugin_kvm.so
  MKDIR    /tmp/build/perf/arch/s390/util/
  LINK     /tmp/build/perf/plugin_mac80211.so
  CC       /tmp/build/perf/arch/s390/util/kvm-stat.o
  LINK     /tmp/build/perf/plugin_sched_switch.so
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/arch/s390/util/.header.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/arch/s390/util/header.o' failed
make[6]: *** [/tmp/build/perf/arch/s390/util/header.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  LINK     /tmp/build/perf/plugin_function.so

 
> After:
> [root@s35lp76 perf]# ./perf report --header|fgrep cpuid
>  # cpuid : IBM,3906,704,M03,3.5,002f
> [root@s35lp76 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/s390/util/header.c | 126 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 121 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
> index 9fa6c3e5782c..3d29ba47edce 100644
> --- a/tools/perf/arch/s390/util/header.c
> +++ b/tools/perf/arch/s390/util/header.c
> @@ -1,8 +1,9 @@
>  /*
>   * Implementation of get_cpuid().
>   *
> - * Copyright 2014 IBM Corp.
> + * Copyright IBM Corp. 2014, 2018
>   * Author(s): Alexander Yarygin <yarygin@linux.vnet.ibm.com>
> + *	      Thomas Richter <tmricht@linux.vnet.ibm.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License (version 2 only)
> @@ -13,16 +14,131 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <string.h>
> +#include <ctype.h>
>  
>  #include "../../util/header.h"
> +#include "../../util/util.h"
> +
> +#define SYSINFO_MANU	"Manufacturer:"
> +#define SYSINFO_TYPE	"Type:"
> +#define SYSINFO_MODEL	"Model:"
> +#define SRVLVL_CPUMF	"CPU-MF:"
> +#define SRVLVL_VERSION	"version="
> +#define SRVLVL_AUTHORIZATION	"authorization="
> +#define SYSINFO		"/proc/sysinfo"
> +#define SRVLVL		"/proc/service_levels"
>  
>  int get_cpuid(char *buffer, size_t sz)
>  {
> -	const char *cpuid = "IBM/S390";
> +	char *cp, *line = NULL, *line2;
> +	char type[8], model[33], version[8], manufacturer[32], authorization[8];
> +	int read;
> +	unsigned long line_sz;
> +	size_t nbytes;
> +	FILE *sysinfo;
> +
> +	/*
> +	 * Scan /proc/sysinfo line by line and read out values for
> +	 * Manufacturer:, Type: and Model:, for example:
> +	 * Manufacturer:    IBM
> +	 * Type:            2964
> +	 * Model:           702              N96
> +	 * The first word is the Model Capacity and the second word is
> +	 * Model (can be omitted). Both words have a maximum size of 16
> +	 * bytes.
> +	 */
> +	memset(manufacturer, 0, sizeof(manufacturer));
> +	memset(type, 0, sizeof(type));
> +	memset(model, 0, sizeof(model));
> +	memset(version, 0, sizeof(version));
> +	memset(authorization, 0, sizeof(authorization));
> +
> +	sysinfo = fopen(SYSINFO, "r");
> +	if (sysinfo == NULL)
> +		return -1;
> +
> +	while ((read = getline(&line, &line_sz, sysinfo)) != -1) {
> +		if (!strncmp(line, SYSINFO_MANU, strlen(SYSINFO_MANU))) {
> +			line2 = line + strlen(SYSINFO_MANU);
> +
> +			while ((cp = strtok_r(line2, "\n ", &line2)))
> +				strncat(manufacturer, cp, sizeof(manufacturer));
> +		}
> +
> +		if (!strncmp(line, SYSINFO_TYPE, strlen(SYSINFO_TYPE))) {
> +			line2 = line + strlen(SYSINFO_TYPE);
> +
> +			while ((cp = strtok_r(line2, "\n ", &line2)))
> +				strncat(type, cp, sizeof(type));
> +		}
> +
> +		if (!strncmp(line, SYSINFO_MODEL, strlen(SYSINFO_MODEL))) {
> +			line2 = line + strlen(SYSINFO_MODEL);
> +
> +			while ((cp = strtok_r(line2, "\n ", &line2))) {
> +				if (model[0])
> +					strcat(model, ",");
> +				if (strlen(model) + strlen(cp) < sizeof(model))
> +					strncat(model, cp, strlen(cp));
> +			}
> +			break;
> +		}
> +	}
> +	fclose(sysinfo);
>  
> -	if (strlen(cpuid) + 1 > sz)
> +	/* Missing manufacturer, type or model information should not happen */
> +	if (!manufacturer[0] || !type[0] || !model[0])
>  		return -1;
>  
> -	strcpy(buffer, cpuid);
> -	return 0;
> +	/*
> +	 * Scan /proc/service_levels and return the CPU-MF counter facility
> +	 * version number and authorization level.
> +	 * Optional, does not exist on z/VM guests.
> +	 */
> +	sysinfo = fopen(SRVLVL, "r");
> +	if (sysinfo == NULL)
> +		goto skip_sysinfo;
> +	while ((read = getline(&line, &line_sz, sysinfo)) != -1) {
> +		if (strncmp(line, SRVLVL_CPUMF, strlen(SRVLVL_CPUMF)))
> +			continue;
> +
> +		line2 = line + strlen(SRVLVL_CPUMF);
> +		while ((cp = strtok_r(line2, "\n ", &line2))) {
> +			if (!strncmp(cp, SRVLVL_VERSION,
> +				     strlen(SRVLVL_VERSION))) {
> +				char *sep = strchr(cp, '=');
> +
> +				strncat(version, sep + 1, sizeof(version));
> +			}
> +			if (!strncmp(cp, SRVLVL_AUTHORIZATION,
> +				     strlen(SRVLVL_AUTHORIZATION))) {
> +				char *sep = strchr(cp, '=');
> +
> +				strncat(authorization, sep + 1,
> +					sizeof(authorization));
> +			}
> +		}
> +	}
> +	fclose(sysinfo);
> +
> +skip_sysinfo:
> +	free(line);
> +
> +	if (version[0] && authorization[0] )
> +		nbytes = snprintf(buffer, sz, "%s,%s,%s,%s,%s",
> +				  manufacturer, type, model, version,
> +				  authorization);
> +	else
> +		nbytes = snprintf(buffer, sz, "%s,%s,%s", manufacturer, type,
> +				  model);
> +	return (nbytes >= sz) ? -1 : 0;
> +}
> +
> +char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> +{
> +	char *buf = malloc(128);
> +
> +	if (buf && get_cpuid(buf, 128) < 0)
> +		zfree(&buf);
> +	return buf;
>  }
> -- 
> 2.14.3
