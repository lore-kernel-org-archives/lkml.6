Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22853C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD702145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vi69p+M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD702145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbeK3BgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42540 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733126AbeK3BgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATESVi4032804;
        Thu, 29 Nov 2018 14:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Fb60cRjiJegGTCyHdQ/Y2/Ta8h9ZWOr46nYEIt2Y8Ss=;
 b=Vi69p+M9voH3w5p+MjuQ6T7AJQ6zR5Q6bKwqcNxhQrY0TLOfBDBXhFG5z/RYhYIX0pcT
 NOkvocxXrR81/ItlkPhHmaJuHQbNDfjdz2jf8RuAtpM0hr1kAB2qP6qLzABo4kiPQAQq
 aemdwhXFxnYWJnkH0pqmSvA9jvGDHwswd44NxTnLtwep5y5lGBp/oKNc6g3k4qm7k/99
 qCm3BmkEc3Vsp5UJoGGdYXauBW4S+A3P+Bf9hajWYxJ7TJaUekegtmCIKTZt6G7Fr6nb
 0bKQieGdYxwL6VPTYTBl4OmS0VByRzphJ09xXnxhzBm31i93fmA0ne+e+YswGBtPztph gw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nxy9rgemx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:28:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wATESkmJ005650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:28:46 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wATESjoo000609;
        Thu, 29 Nov 2018 14:28:45 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:28:45 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id BB8996A00FB; Thu, 29 Nov 2018 09:28:41 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:28:41 -0500
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
Subject: Re: [patch V2 03/28] x86/speculation: Remove unnecessary ret
 variable in cpu_show_common()
Message-ID: <20181129142841.GD32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185003.783903657@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185003.783903657@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:31PM +0100, Thomas Gleixner wrote:
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> 
> ---
>  arch/x86/kernel/cpu/bugs.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -847,8 +847,6 @@ static ssize_t l1tf_show_state(char *buf
>  static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
>  			       char *buf, unsigned int bug)
>  {
> -	int ret;
> -
>  	if (!boot_cpu_has_bug(bug))
>  		return sprintf(buf, "Not affected\n");
>  
> @@ -866,13 +864,12 @@ static ssize_t cpu_show_common(struct de
>  		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>  
>  	case X86_BUG_SPECTRE_V2:
> -		ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> +		return sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
>  			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
>  			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
>  			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
>  			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
>  			       spectre_v2_module_string());
> -		return ret;
>  
>  	case X86_BUG_SPEC_STORE_BYPASS:
>  		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
> 
> 
