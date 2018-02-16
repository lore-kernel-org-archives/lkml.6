Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754991AbeBPSRI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:17:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbeBPSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:17:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEFE217C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 16 Feb 2018 15:17:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/4] perf record: Provide detailed information on s390 CPU
Message-ID: <20180216181702.GD16919@kernel.org>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
 <20180216165543.GE24436@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216165543.GE24436@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 16, 2018 at 01:55:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Feb 13, 2018 at 04:14:16PM +0100, Thomas Richter escreveu:
> 
> 
>   49    38.13 ubuntu:16.04-x-s390           : FAIL s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
> 
> 
> Humm, this seems to be the one causing this:
> 
>   LINK     /tmp/build/perf/plugin_hrtimer.so
>   LINK     /tmp/build/perf/plugin_kmem.so
> In file included from /usr/s390x-linux-gnu/include/string.h:635:0,
>                  from arch/s390/util/header.c:16:
> In function 'strncat',
>     inlined from 'get_cpuid' at arch/s390/util/header.c:65:5:
> /usr/s390x-linux-gnu/include/bits/string3.h:156:10: error: call to __builtin___strncat_chk might overflow destination buffer [-Werror]
>    return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));

Ok, now I can build it:

[acme@seventh perf]$ file ../tmp/perf
../tmp/perf: ELF 64-bit MSB shared object, IBM S/390, version 1 (SYSV), dynamically linked, interpreter /lib/ld64.so.1, for GNU/Linux 3.2.0, BuildID[sha1]=82a8ff9eb04082acd1630a0f4ff3816d68982eb7, with debug_info, not stripped
[acme@seventh perf]$

With the following patch, using scnprintf (snprintf also has issues),
please try applying this on top of yours and checking that the end
result is sane.

- Arnaldo

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 3d29ba47edce..a78064c25ced 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -32,6 +32,7 @@ int get_cpuid(char *buffer, size_t sz)
 {
 	char *cp, *line = NULL, *line2;
 	char type[8], model[33], version[8], manufacturer[32], authorization[8];
+	int tpsize = 0, mdsize = 0, vssize = 0, mfsize = 0, atsize = 0;
 	int read;
 	unsigned long line_sz;
 	size_t nbytes;
@@ -61,25 +62,27 @@ int get_cpuid(char *buffer, size_t sz)
 		if (!strncmp(line, SYSINFO_MANU, strlen(SYSINFO_MANU))) {
 			line2 = line + strlen(SYSINFO_MANU);
 
-			while ((cp = strtok_r(line2, "\n ", &line2)))
-				strncat(manufacturer, cp, sizeof(manufacturer));
+			while ((cp = strtok_r(line2, "\n ", &line2))) {
+				mfsize += scnprintf(manufacturer + mfsize,
+						    sizeof(manufacturer) - mfsize, "%s", cp);
+			}
 		}
 
 		if (!strncmp(line, SYSINFO_TYPE, strlen(SYSINFO_TYPE))) {
 			line2 = line + strlen(SYSINFO_TYPE);
 
-			while ((cp = strtok_r(line2, "\n ", &line2)))
-				strncat(type, cp, sizeof(type));
+			while ((cp = strtok_r(line2, "\n ", &line2))) {
+				tpsize += scnprintf(type + tpsize,
+						    sizeof(type) - tpsize, "%s", cp);
+			}
 		}
 
 		if (!strncmp(line, SYSINFO_MODEL, strlen(SYSINFO_MODEL))) {
 			line2 = line + strlen(SYSINFO_MODEL);
 
 			while ((cp = strtok_r(line2, "\n ", &line2))) {
-				if (model[0])
-					strcat(model, ",");
-				if (strlen(model) + strlen(cp) < sizeof(model))
-					strncat(model, cp, strlen(cp));
+				mdsize += scnprintf(model + mdsize, sizeof(type) - mdsize,
+						    "%s%s", model[0] ? "," : "", cp);
 			}
 			break;
 		}
@@ -108,14 +111,15 @@ int get_cpuid(char *buffer, size_t sz)
 				     strlen(SRVLVL_VERSION))) {
 				char *sep = strchr(cp, '=');
 
-				strncat(version, sep + 1, sizeof(version));
+				vssize += scnprintf(version + vssize,
+						    sizeof(version) - vssize, "%s", sep + 1);
 			}
 			if (!strncmp(cp, SRVLVL_AUTHORIZATION,
 				     strlen(SRVLVL_AUTHORIZATION))) {
 				char *sep = strchr(cp, '=');
 
-				strncat(authorization, sep + 1,
-					sizeof(authorization));
+				atsize += scnprintf(authorization + atsize,
+						    sizeof(authorization) - atsize, "%s", sep + 1);
 			}
 		}
 	}
