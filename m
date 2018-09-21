Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5772086B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5772086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391473AbeIVCPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:15:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391279AbeIVCPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:15:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LKOFXL132559
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:25:14 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mn6a6b74m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:25:13 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 21 Sep 2018 14:25:12 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 14:25:09 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LKP8TQ29491402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 13:25:09 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDC2BC6055;
        Fri, 21 Sep 2018 14:25:08 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D760C6059;
        Fri, 21 Sep 2018 14:25:08 -0600 (MDT)
Received: from localhost (unknown [9.80.102.110])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Sep 2018 14:25:07 -0600 (MDT)
Date:   Fri, 21 Sep 2018 17:25:05 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/3] powerpc/process: fix interleaved output in
 show_user_instructions()
References: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
 <8f4de3aa04f00d67fdb5aaf90f41242197310d4d.1536327756.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4de3aa04f00d67fdb5aaf90f41242197310d4d.1536327756.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18092120-8235-0000-0000-00000E04331F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009747; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091681; UDB=6.00564082; IPR=6.00871706;
 MB=3.00023441; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 20:25:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092120-8236-0000-0000-000042B9A72E
Message-Id: <20180921202505.GB19940@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:47:31PM +0000, Christophe Leroy wrote:
> When two processes crash at the same time, we sometimes encounter
> interleaving in the middle of a line:
> 
> [    4.365317] init[1]: segfault (11) at 0 nip 0 lr 0 code 1
> [    4.370452] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.372042] init[74]: segfault (11) at 10a74 nip 1000c198 lr 100078c8 code 1 in sh[10000000+14000]
> [    4.386829] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.391542] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.400863] init[74]: code: 90010024 bf61000c 91490a7c 3fa01002 3be00000 7d3e4b78 3bbd0c20 3b600000
> [    4.409867] init[74]: code: 3b9d0040 7c7fe02e 2f830000 419e0028 <89230000> 2f890000 41be001c 4b7f6e79
> 
> This patch fixes it by preparing complete lines in a buffer and
> printing it at once.
> 
> Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  v3: no change
>  v2: Using seq_buf and reworked the loop to avoid redundant prints.
> 
>  arch/powerpc/kernel/process.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index e108e1ef2b85..2a39f7aca846 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -43,6 +43,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/elf-randomize.h>
>  #include <linux/pkeys.h>
> +#include <linux/seq_buf.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
> @@ -1303,33 +1304,33 @@ static void show_instructions(struct pt_regs *regs)
>  void show_user_instructions(struct pt_regs *regs)
>  {
>  	unsigned long pc;
> -	int i;
> +	int n = instructions_to_print;
> +	struct seq_buf s;
> +	char buf[96]; /* enough for 8 times 9 + 2 chars */
>  
>  	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
>  
> -	pr_info("%s[%d]: code: ", current->comm, current->pid);
> +	seq_buf_init(&s, buf, sizeof(buf));
>  
> -	for (i = 0; i < instructions_to_print; i++) {
> -		int instr;
> +	while (n) {
> +		int i;
>  
> -		if (!(i % 8) && (i > 0)) {
> -			pr_cont("\n");
> -			pr_info("%s[%d]: code: ", current->comm, current->pid);
> -		}
> +		seq_buf_clear(&s);
>  
> -		if (probe_kernel_address((const void *)pc, instr)) {
> -			pr_cont("XXXXXXXX ");
> -		} else {
> -			if (regs->nip == pc)
> -				pr_cont("<%08x> ", instr);
> -			else
> -				pr_cont("%08x ", instr);
> +		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
> +			int instr;
> +
> +			if (probe_kernel_address((const void *)pc, instr)) {
> +				seq_buf_puts(&s, "XXXXXXXX ");
> +				continue;
> +			}
> +			seq_buf_printf(&s, regs->nip == pc ? "<%08x> " : "%08x ", instr);
>  		}
>  
> -		pc += sizeof(int);
> +		if (!seq_buf_has_overflowed(&s))
> +			pr_info("%s[%d]: code: %s\n", current->comm,
> +				current->pid, s.buffer);
>  	}
> -
> -	pr_cont("\n");
>  }
>  
>  struct regbit {
> -- 
> 2.13.3
> 

-- 
Murilo

