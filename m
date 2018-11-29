Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCA4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2635F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ejnt8E0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2635F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387959AbeK3BuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:50:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732558AbeK3BuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:50:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEhxOC050421;
        Thu, 29 Nov 2018 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=pQRTRhE4leFWVUUi359adxmWDFpZDGGOx4uesRG53YM=;
 b=Ejnt8E0wNqtXpVFlL+rpAU3sjXT+/sy1IIgAqF4HT4uy9XcWc5EG7Js93v7So+/FqBka
 Npk6sGNJvmRpTeE5uvJpxl16MtyfJ3Rlg0O3j2Fz3Pvt6qHBEDwroE8xyFC4SorGnTym
 jWMgNGiCRT8QmjNzBQFIrvv3V0P3XoDp1/GeyBNEd/NdWS2v3Hp931hpDvZVxCTE7O9R
 9W9c1Oj+6Aqht4IObumHG0/P030GZR8NR5c5wrNltQv35AuCTSZOw7MS5tEj3B0gMjG1
 50UwA7u2HSa04wVaoZYAu2c4bc0rg//LlHzOGqwD8mM0r+b0d+LAZVzh0MA6sRfTG//7 kg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqrhva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:44:06 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATEi5pX012169
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:44:05 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATEi4bB032629;
        Thu, 29 Nov 2018 14:44:04 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:44:04 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 715FE6A00FB; Thu, 29 Nov 2018 09:44:00 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:44:00 -0500
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
Subject: Re: [patch V2 09/28] x86/Kconfig: Select SCHED_SMT if SMP enabled
Message-ID: <20181129144400.GJ32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185004.337452245@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185004.337452245@linutronix.de>
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

On Sun, Nov 25, 2018 at 07:33:37PM +0100, Thomas Gleixner wrote:
> CONFIG_SCHED_SMT is enabled by all distros, so there is not a real point to
> have it configurable. The runtime overhead in the core scheduler code is
> minimal because the actual SMT scheduling parts are conditional on a static
> key.
> 
> This allows to expose the scheduler's SMT state static key to the
> speculation control code. Alternatively the scheduler's static key could be
> made always available when CONFIG_SMP is enabled, but that's just adding an
> unused static key to every other architecture for nothing.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>


> 
> ---
>  arch/x86/Kconfig |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1001,13 +1001,7 @@ config NR_CPUS
>  	  to the kernel image.
>  
>  config SCHED_SMT
> -	bool "SMT (Hyperthreading) scheduler support"
> -	depends on SMP
> -	---help---
> -	  SMT scheduler support improves the CPU scheduler's decision making
> -	  when dealing with Intel Pentium 4 chips with HyperThreading at a
> -	  cost of slightly increased overhead in some places. If unsure say
> -	  N here.
> +	def_bool y if SMP
>  
>  config SCHED_MC
>  	def_bool y
> 
> 
