Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBE823F4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBE823F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeGFIPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:15:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753535AbeGFIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:15:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6689N71092358
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 04:15:36 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k245r9f3b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 04:15:36 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <brueckner@linux.ibm.com>;
        Fri, 6 Jul 2018 09:15:33 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 09:15:29 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w668FSDu34930788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 08:15:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21EDDA405B;
        Fri,  6 Jul 2018 11:15:53 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DBCDA4055;
        Fri,  6 Jul 2018 11:15:53 +0100 (BST)
Received: from lynx.boeblingen.de.ibm.com (unknown [9.152.212.204])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  6 Jul 2018 11:15:53 +0100 (BST)
Received: from brueckh by lynx.boeblingen.de.ibm.com with local (Exim 4.90_1)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1fbLto-0002nl-EQ; Fri, 06 Jul 2018 10:15:28 +0200
Date:   Fri, 6 Jul 2018 10:15:28 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf arm64: Generate system call table from
 asm/unistd.h
References: <20180705181216.0cc737d217d9acda567bd519@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705181216.0cc737d217d9acda567bd519@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070608-0012-0000-0000-000002876220
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070608-0013-0000-0000-000020B8EE10
Message-Id: <20180706081528.GA5120@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

On Thu, Jul 05, 2018 at 06:12:16PM -0500, Kim Phillips wrote:
> This should speed up accessing new system calls introduced with the
> kernel rather than waiting for libaudit updates to include them.
> 
> Using the existing other arch scripts resulted in this error:
> 
> tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: 25: printf: __NR3264_ftruncate: expected numeric value
> 
> because, unlike other arches, asm-generic's unistd.h does things like:
> 
>  #define __NR_ftruncate __NR3264_ftruncate
> 
> Turning the scripts printf's %d into a %s resulted in this in the
> generated syscalls.c file:
> 
>     static const char *syscalltbl_arm64[] = {
>             [__NR3264_ftruncate] = "ftruncate",
> 
> So we use the host C compiler to fold the macros, and print them out
> from within a temporary C program, in order to get the correct output:
> 
>     static const char *syscalltbl_arm64[] = {
>             [46] = "ftruncate",
> 
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> Changes in V2:
>  - added the "sc" and "nr" local variables, for the sake of completion (Hendrik
>    Brueckner)
>  - Removed the unsafe -u from mktemp, added more X's, and now pipe the
>    C code to the $hostcc command, so we now only require a single temp
>    file that is written by gcc. (Hendrik Brueckner)
>  - used cat << EoHEADER instead of echos for the c file header, to make it more
>    readable (Hendrik Brueckner)
>  - $RM -> rm, to be able to run standalone (Hendrik Brueckner)

Many thanks for incorporating the feedback!

>  - moved the rm into the function that makes the file
>  - converted other echos to printf "%s\n" for more portable printing of
>    backslash characters (bash and dash built-in echo commands differ in
>    how many escape backslashes are needed).  The initial "%s\n" is needed
>    in order to keep the external printf command from interpreting the %ds.
> 
>  tools/perf/arch/arm64/Makefile                | 21 +++++++
>  .../arch/arm64/entry/syscalls/mksyscalltbl    | 61 +++++++++++++++++++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> 
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index 91de4860faad..85fdf4949db3 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -4,3 +4,24 @@ PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_JITDUMP := 1
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> +
> +#
> +# Syscall table generation for perf
> +#
> +
> +out    := $(OUTPUT)arch/arm64/include/generated/asm
> +header := $(out)/syscalls.c
> +sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
> +sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
> +systbl := $(sysprf)/mksyscalltbl
> +
> +# Create output directory if not already present
> +_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +
> +$(header): $(sysdef) $(systbl)
> +	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(sysdef) > $@
> +
> +clean::
> +	$(call QUIET_CLEAN, arm64) $(RM) $(header)
> +
> +archheaders: $(header)
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> new file mode 100755
> index 000000000000..f806542eb3cc
> --- /dev/null
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Generate system call table for perf. Derived from
> +# powerpc script.
> +#
> +# Copyright IBM Corp. 2017
> +# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> +# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> +# Changed by: Kim Phillips <kim.phillips@arm.com>
> +
> +gcc=$1
> +hostcc=$2
> +input=$3
> +
> +if ! test -r $input; then
> +	echo "Could not read input file" >&2
> +	exit 1
> +fi
> +
> +create_table_from_c()
> +{
> +	local sc nr last_sc
> +
> +	create_table_exe=`mktemp /tmp/create-table-XXXXXX`
> +
> +	{
> +
> +cat << _EoHEADER
> +#include <stdio.h>
> +#include "$input"
> +int main(int argc, char *argv[])
> +{
> +_EoHEADER

One minor style hint: Using cat <<-_EoHEADER (with a dash) strips any leading
tabs from the what is being concatenated.  With this, using the same indent as
for as the other function statements it possible.  For example,

	cat <<-_EoHEADER
	#include <stdio.h>
	#include "$input"
	int main(int argc, char *argv[])
	{
	_EoHEADER

> +
> +	while read sc nr; do
> +		printf "%s\n" "	printf(\"\\t[%d] = \\\"$sc\\\",\\n\", __NR_$sc);"
> +		last_sc=$sc
> +	done
> +
> +	printf "%s\n" "	printf(\"#define SYSCALLTBL_ARM64_MAX_ID %d\\n\", __NR_$last_sc);"
> +	printf "}\n"
> +
> +	} | $hostcc -o $create_table_exe -x c -
> +
> +	$create_table_exe
> +
> +	rm -f $create_table_exe
> +}
> +
> +create_table()
> +{
> +	echo "static const char *syscalltbl_arm64[] = {"
> +	create_table_from_c
> +	echo "};"
> +}
> +
> +$gcc -E -dM -x c  $input	       \
> +	|sed -ne 's/^#define __NR_//p' \
> +	|sort -t' ' -k2 -nu	       \
> +	|create_table

Overall, this looks good to me.

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

