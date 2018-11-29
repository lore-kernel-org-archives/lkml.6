Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AD420863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h6/ZuTs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AD420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbeK3BlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:41:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48538 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbeK3BlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:41:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEYFCd037857;
        Thu, 29 Nov 2018 14:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ufsnDxpStVvMCrqZSD2cNUP77nMk4wGNZjgcO+6p1E4=;
 b=h6/ZuTs4SAzotEbpgvc3VgY9GoB80GiHq8mbPvoyVvhggykIVAJUd8/qh93UqnJSotZB
 oyar+LNo+oogTWJnlDvTM5t7ftlVQk6lrZUu1TUKlUSfOLihDjUAUWgS7HuwQa2KejAv
 GA4n8TnktY7KSAVO+5HXG25aqMQPZLsL2pPcjpAKCWof67QE8RnbR19MsjigVqbdY8Sb
 rQIi46IeXfwDyXH+Q7EeR5kjA4RVCfeC7FTz8swrjAlLF9nIkbkzox9x9hJ+WToq62fb
 lF0AYFA6SXwUUQpUZ5ZTT5L03pOP9YHP2CSJjcdb87diFlPOA6HrzwC7YKBh+daygtOx 7w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nxy9rgfxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:35:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATEZEnu016619
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:35:15 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wATEZDVq010016;
        Thu, 29 Nov 2018 14:35:13 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:35:13 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 746B96A00FB; Thu, 29 Nov 2018 09:35:09 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:35:09 -0500
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
Subject: Re: [patch V2 05/28] x86/speculation: Disable STIBP when enhanced
 IBRS is in use
Message-ID: <20181129143509.GF32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185003.966801480@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185003.966801480@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:33PM +0100, Thomas Gleixner wrote:
> If enhanced IBRS is active, STIBP is redundant for mitigating Spectre v2
> user space exploits from hyperthread sibling.
> 
> Disable STIBP when enhanced IBRS is used.
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/kernel/cpu/bugs.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -321,6 +321,10 @@ static bool stibp_needed(void)
>  	if (spectre_v2_enabled == SPECTRE_V2_NONE)
>  		return false;
>  
> +	/* Enhanced IBRS makes using STIBP unnecessary. */
> +	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
> +		return false;
> +
>  	if (!boot_cpu_has(X86_FEATURE_STIBP))
>  		return false;
>  
> @@ -846,6 +850,9 @@ static ssize_t l1tf_show_state(char *buf
>  
>  static char *stibp_state(void)
>  {
> +	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
> +		return "";
> +
>  	if (x86_spec_ctrl_base & SPEC_CTRL_STIBP)
>  		return ", STIBP";
>  	else
> 
> 
