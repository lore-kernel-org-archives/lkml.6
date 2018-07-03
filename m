Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E155B24B1C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fmsOC8DB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E155B24B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeGCOMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:12:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45256 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeGCOMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:12:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63E99xN058688;
        Tue, 3 Jul 2018 14:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=colEYvsEFiV5UDydMhWAGtXdBbv8yYG/WAHinSYiVso=;
 b=fmsOC8DBfbAu/KMkB6/jksgU0hydpukTFUUXbpDgI3Q+hjTe3ZV/lbOb7IIzRcxxAcLw
 gquuKAXRAslRDQjHnT8dFJggk3ekVydEn7EygMawNOl3hX75KzdnTjPOveu3n1lhyfhB
 Jh8ujddG60LwW8v35u6vUcVz4VJFtXEksref6smDB4soTeaxao6xEqZ45zcbl5k7jqZ+
 OiGHsRrJ5sZaUn6/BJV8oq0chFHv93qzHM/Q02TO6RdIEfdtSW9WvpCtKv+dPczFJNR+
 M1mcB3anRuqdx7AaW2uQlS8YtZZyvVvsd3o6d6JHHLvhxIqRFbvwB999byt88XApGICX aw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jwyccrvjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 14:12:06 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w63EC50Z016377
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:12:06 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w63EC5oB023580;
        Tue, 3 Jul 2018 14:12:05 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 07:12:05 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id E6E5B6A00E3; Tue,  3 Jul 2018 10:12:03 -0400 (EDT)
Date:   Tue, 3 Jul 2018 10:12:03 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 1/2] x86/bugs: Update when to check for the LS_CFG SSBD
 mitigation
Message-ID: <20180703141203.GJ8404@char.us.oracle.com>
References: <20180702213543.29202.79104.stgit@tlendack-t1.amdoffice.net>
 <20180702213553.29202.21089.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702213553.29202.21089.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=950
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 04:35:53PM -0500, Tom Lendacky wrote:
> If either the X86_FEATURE_AMD_SSBD or X86_FEATURE_VIRT_SSBD features are
> present, then there is no need to perform the check for the LS_CFG SSBD
> mitigation support.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

> ---
>  arch/x86/kernel/cpu/amd.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 082d787..38915fb 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -543,7 +543,9 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>  		nodes_per_socket = ((value >> 3) & 7) + 1;
>  	}
>  
> -	if (c->x86 >= 0x15 && c->x86 <= 0x17) {
> +	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
> +	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
> +	    c->x86 >= 0x15 && c->x86 <= 0x17) {
>  		unsigned int bit;
>  
>  		switch (c->x86) {
> 
