Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBD2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D34A2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KUbYzcxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D34A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbeK3Bfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43758 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbeK3Bfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEScut072581;
        Thu, 29 Nov 2018 14:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vliJNNQJQMYJrBI8wL4TdBK55SsKde5/Gwxud7wir+E=;
 b=KUbYzcxHus30wa7wT3cIcI+uq8q3l3Hc+obcwMA+vcBwIPLtGmlUmRfDVHWbkDHCvSDp
 lE/ABaBOs41V0p75G5lQiMWpydCaodbtBMuKrM/Cyd41Hzu8IZUfQVcS0bHhS3eRLJv6
 QJQndggZy5vpYUCQde5KMNgf7c3QTETp9O9dVUBS23DvMoDS6kdhpk9lo8CCG+cpiVqo
 dPV1Q9YLKCQqKQkQrIz2jhkuBdkAKgtp4DFN8tyNKlgew81QTez6BlaoWmpwFRQNMfGp
 WCKmpGsveGvI6ISGBnc5cuMIHvJX6e+8UkZKqBzA077Nu2HCQhUkTDuLxRyNRits4NAU AA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nxx2ugh19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:29:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATETRJs025210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:29:27 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATETPtN029792;
        Thu, 29 Nov 2018 14:29:25 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:29:25 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C3C3E6A00FB; Thu, 29 Nov 2018 09:29:23 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:29:23 -0500
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
Subject: Re: [patch V2 04/28] x86/speculation: Reorganize cpu_show_common()
Message-ID: <20181129142923.GE32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185003.874479208@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185003.874479208@linutronix.de>
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

On Sun, Nov 25, 2018 at 07:33:32PM +0100, Thomas Gleixner wrote:
> The Spectre V2 printout in cpu_show_common() handles conditionals for the
> various mitigation methods directly in the sprintf() argument list. That's
> hard to read and will become unreadable if more complex decisions need to
> be made for a particular method.
> 
> Move the conditionals for STIBP and IBPB string selection into helper
> functions, so they can be extended later on.
> 

Yeeey!


Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/kernel/cpu/bugs.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -844,6 +844,22 @@ static ssize_t l1tf_show_state(char *buf
>  }
>  #endif
>  
> +static char *stibp_state(void)
> +{
> +	if (x86_spec_ctrl_base & SPEC_CTRL_STIBP)
> +		return ", STIBP";
> +	else
> +		return "";
> +}
> +
> +static char *ibpb_state(void)
> +{
> +	if (boot_cpu_has(X86_FEATURE_USE_IBPB))
> +		return ", IBPB";
> +	else
> +		return "";
> +}
> +
>  static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
>  			       char *buf, unsigned int bug)
>  {
> @@ -865,9 +881,9 @@ static ssize_t cpu_show_common(struct de
>  
>  	case X86_BUG_SPECTRE_V2:
>  		return sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> -			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
> +			       ibpb_state(),
>  			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
> -			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
> +			       stibp_state(),
>  			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
>  			       spectre_v2_module_string());
>  
> 
> 
