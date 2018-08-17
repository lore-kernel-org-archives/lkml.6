Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C3AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657B52188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657B52188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeHQPiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:38:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbeHQPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:38:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7HCY83x053542
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:34:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kwwjkj7ky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:34:49 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 17 Aug 2018 06:34:48 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Aug 2018 06:34:46 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7HCYjOa5439776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Aug 2018 05:34:45 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F6C6BE058;
        Fri, 17 Aug 2018 06:34:45 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70EC1BE056;
        Fri, 17 Aug 2018 06:34:44 -0600 (MDT)
Received: from localhost (unknown [9.80.100.14])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Aug 2018 06:34:44 -0600 (MDT)
Date:   Fri, 17 Aug 2018 09:34:41 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/process: fix nested output in
 show_user_instructions()
References: <718cc9c9bd1d4bb2b4c2596f1a7ee00334e77055.1534192631.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <718cc9c9bd1d4bb2b4c2596f1a7ee00334e77055.1534192631.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18081712-8235-0000-0000-00000DEC009F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009560; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074816; UDB=6.00553923; IPR=6.00854774;
 MB=3.00022773; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-17 12:34:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081712-8236-0000-0000-0000424EB64A
Message-Id: <20180817123441.GA7458@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808170138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Tue, Aug 14, 2018 at 08:59:18AM +0000, Christophe Leroy wrote:
> When two processes crash at the same time, we sometimes encounter
> nesting in the middle of a line:
> 
> [    4.365317] init[1]: segfault (11) at 0 nip 0 lr 0 code 1
> [    4.370452] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.372042] init[74]: segfault (11) at 10a74 nip 1000c198 lr 100078c8 code 1 in sh[10000000+14000]
> [    4.386829] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.391542] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.400863] init[74]: code: 90010024 bf61000c 91490a7c 3fa01002 3be00000 7d3e4b78 3bbd0c20 3b600000
> [    4.409867] init[74]: code: 3b9d0040 7c7fe02e 2f830000 419e0028 <89230000> 2f890000 41be001c 4b7f6e79

My smoke test passed with the two patches.

Perhaps adding an output sample of how messages would look like after your patch
could be an enhancement to the commit message.

Otherwise:

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> This patch fixes it by preparing complete lines in a buffer and
> printing it at once.
> 
> Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/process.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 913c5725cdb2..c722ce4ca1c0 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1303,32 +1303,33 @@ void show_user_instructions(struct pt_regs *regs)
>  {
>  	unsigned long pc;
>  	int i;
> +	char buf[96]; /* enough for 8 times 9 + 2 chars */
> +	int l = 0;
>  
>  	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
>  
> -	pr_info("%s[%d]: code: ", current->comm, current->pid);
> -
>  	for (i = 0; i < instructions_to_print; i++) {
>  		int instr;
>  
>  		if (!(i % 8) && (i > 0)) {
> -			pr_cont("\n");
> -			pr_info("%s[%d]: code: ", current->comm, current->pid);
> +			pr_info("%s[%d]: code: %s\n", current->comm, current->pid, buf);
> +			l = 0;
>  		}
>  
>  		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
> -			pr_cont("XXXXXXXX ");
> +			l += sprintf(buf + l, "XXXXXXXX ");
>  		} else {
>  			if (regs->nip == pc)
> -				pr_cont("<%08x> ", instr);
> +				l += sprintf(buf + l, "<%08x> ", instr);
>  			else
> -				pr_cont("%08x ", instr);
> +				l += sprintf(buf + l, "%08x ", instr);
>  		}
>  
>  		pc += sizeof(int);
>  	}
>  
> -	pr_cont("\n");
> +	if (l)
> +		pr_info("%s[%d]: code: %s\n", current->comm, current->pid, buf);
>  }
>  
>  struct regbit {
> -- 
> 2.13.3
> 

-- 
Murilo

