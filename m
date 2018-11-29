Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A280C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC3E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IBYLD9zM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC3E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbeK3Buq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:50:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59060 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbeK3Buq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:50:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEi5mR047297;
        Thu, 29 Nov 2018 14:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=F92bRlEb61Q3pwcRtc6+V2AqdzNg8d7Uy6KvtZg0aT4=;
 b=IBYLD9zMit8lt6sLhwR2dcnfP4RC+9MvrhPu/Ijsd0ebbzfBCfosYCurJSgypxXTogTz
 TJ6HMke6uKtUrTJFvWcPIJB8i8BaO38FfMQnxQk10ttT3YfbARGfS1fClilDGRpfkRIb
 kuSac3g2d7BCmVBAjpTbhn/h4GvjmMrJu2TDI03QjCUgqS+UnTNaz7coQLhGd65YuVar
 h3WGeDpCUMkbUS1corbpGM2pb3SJ2Z9xL3mJKHPLX8iEPMWyqEn8FhO35mQgekR7we6o
 JRl4He404VUKImcxTcfjAXSKxasHB5XJdu5UU8U4Abdp1fwrTJpYWAc9L71QANU066on xg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9rghtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:44:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wATEia8t017338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:44:36 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wATEiZbL009560;
        Thu, 29 Nov 2018 14:44:35 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:44:34 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id E9AA26A00FB; Thu, 29 Nov 2018 09:44:30 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:44:30 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 10/28] sched/smt: Expose sched_smt_present static key
Message-ID: <20181129144430.GK32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185004.430168326@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185004.430168326@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:38PM +0100, Thomas Gleixner wrote:
> Make the scheduler's 'sched_smt_present' static key globaly available, so
> it can be used in the x86 speculation control code.
> 
> Provide a query function and a stub for the CONFIG_SMP=n case.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

> ---
> 
> v1 -> v2: Move SMT stuff to separate header. Unbreaks ia64 build
> 
> ---
>  include/linux/sched/smt.h |   18 ++++++++++++++++++
>  kernel/sched/sched.h      |    4 +---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> --- /dev/null
> +++ b/include/linux/sched/smt.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SCHED_SMT_H
> +#define _LINUX_SCHED_SMT_H
> +
> +#include <linux/static_key.h>
> +
> +#ifdef CONFIG_SCHED_SMT
> +extern struct static_key_false sched_smt_present;
> +
> +static __always_inline bool sched_smt_active(void)
> +{
> +	return static_branch_likely(&sched_smt_present);
> +}
> +#else
> +static inline bool sched_smt_active(void) { return false; }
> +#endif
> +
> +#endif
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -23,6 +23,7 @@
>  #include <linux/sched/prio.h>
>  #include <linux/sched/rt.h>
>  #include <linux/sched/signal.h>
> +#include <linux/sched/smt.h>
>  #include <linux/sched/stat.h>
>  #include <linux/sched/sysctl.h>
>  #include <linux/sched/task.h>
> @@ -936,9 +937,6 @@ static inline int cpu_of(struct rq *rq)
>  
>  
>  #ifdef CONFIG_SCHED_SMT
> -
> -extern struct static_key_false sched_smt_present;
> -
>  extern void __update_idle_core(struct rq *rq);
>  
>  static inline void update_idle_core(struct rq *rq)
> 
> 
