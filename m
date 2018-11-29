Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E5B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WG1gqnOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E5B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbeK3Bea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbeK3Be2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEPq9v033583;
        Thu, 29 Nov 2018 14:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GkhZYFDuybPMZ17QFYIiq1vAmVu9mpuyW8URuQqs/K4=;
 b=WG1gqnOltLTQbUQTdnIKY2sEIVVOLZxiOyazKmNucQlpYkvUqvN7FRLTyD2L7YbPn344
 TFBCY5EqdyQXrFjXhiVU5bfOa0DM+9/5Susn8NbqGmkpto4g2dfgwpIna6UwE5MarFCZ
 b6xR8zeFYcMCafm4xptwKbIfLl1dVgsNEPEutGjclI7nwctBr/KZkCJn1se9Gzu09VUV
 JCFzQYWKA+BO290vcm5SYyXOXyhNAH+9j+1b6PrUxCivuZHQOeKDnjHqYow9x/EV5Phh
 32PZOS7bfMcUcn7jjQ9On5tcko6mcXNYJmgFRPfCDnNPAuIzhR6hlULshmOexcvkl/U+ Vw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqreqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:28:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATESJSH021901
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:28:19 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wATESIVt000377;
        Thu, 29 Nov 2018 14:28:18 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:28:17 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id E82B26A00FB; Thu, 29 Nov 2018 09:28:13 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:28:13 -0500
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
Subject: Re: [patch V2 02/28] x86/speculation: Clean up
 spectre_v2_parse_cmdline()
Message-ID: <20181129142813.GC32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185003.688010903@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185003.688010903@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:30PM +0100, Thomas Gleixner wrote:
> Remove the unnecessary 'else' statement in spectre_v2_parse_cmdline()
> to save an indentation level.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> 
> ---
>  arch/x86/kernel/cpu/bugs.c |   27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -276,22 +276,21 @@ static enum spectre_v2_mitigation_cmd __
>  
>  	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
>  		return SPECTRE_V2_CMD_NONE;
> -	else {
> -		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
> -		if (ret < 0)
> -			return SPECTRE_V2_CMD_AUTO;
>  
> -		for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
> -			if (!match_option(arg, ret, mitigation_options[i].option))
> -				continue;
> -			cmd = mitigation_options[i].cmd;
> -			break;
> -		}
> +	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
> +	if (ret < 0)
> +		return SPECTRE_V2_CMD_AUTO;
>  
> -		if (i >= ARRAY_SIZE(mitigation_options)) {
> -			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
> -			return SPECTRE_V2_CMD_AUTO;
> -		}
> +	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
> +		if (!match_option(arg, ret, mitigation_options[i].option))
> +			continue;
> +		cmd = mitigation_options[i].cmd;
> +		break;
> +	}
> +
> +	if (i >= ARRAY_SIZE(mitigation_options)) {
> +		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
> +		return SPECTRE_V2_CMD_AUTO;
>  	}
>  
>  	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
> 
> 
