Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A34C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBC424B1C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CcwaFfB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBC424B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbeGCOMn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:12:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45300 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeGCOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:12:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63E9VZC059207;
        Tue, 3 Jul 2018 14:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=uqoqxYy2M2Rbua0d4x7TdBEpBZu1cu5lQeqqn1Lmyw0=;
 b=CcwaFfB/usMIkazRKPt1YQeKa+pCHRnQ/kQfc/Oo5M/W0xpf9+PJfsY9ZlWFzBLbFCzW
 dvQOlDrRt40FQEV5avwt4AfJM5EQIxVL5QbHdEjTMdb6Eq73nZccHfqMdfzrXSRid/Dp
 dA5nKndcPbFzgIDYmcRzhIt+MBPM2/6GwrmuzWDQmG8oh+LNzw518U9iRPtTnKKbUSw8
 lkYmfmcGuZVEWAWT2seiTtMFNkzw0DwC9v8/Vl/yt6X33Iyh1YCvxqK0T+jZDTnRpnfV
 v6WfH9wRhA3R5Lindh303v/L15U6W+92vc+YVgLI04bJUfOxIoywd+22H2r9oG8ljGBQ Bg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jwyccrvjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 14:12:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w63ECDeo016819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:12:13 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w63ECD65030234;
        Tue, 3 Jul 2018 14:12:13 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 07:12:13 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 240AC6A00E3; Tue,  3 Jul 2018 10:12:12 -0400 (EDT)
Date:   Tue, 3 Jul 2018 10:12:12 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 2/2] x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR
Message-ID: <20180703141212.GK8404@char.us.oracle.com>
References: <20180702213543.29202.79104.stgit@tlendack-t1.amdoffice.net>
 <20180702213602.29202.33151.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702213602.29202.33151.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 04:36:02PM -0500, Tom Lendacky wrote:
> On AMD, the presence of the MSR_SPEC_CTRL feature does not imply that the
> SSBD mitigation support should use the SPEC_CTRL MSR. Other features could
> have caused the MSR_SPEC_CTRL feature to be set, while a different SSBD
> mitigation option is in place.
> 
> Update the SSBD support to check for the actual SSBD features that will
> use the SPEC_CTRL MSR.
> 
> Fixes: 6ac2f49edb1e ("x86/bugs: Add AMD's SPEC_CTRL MSR usage")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  arch/x86/kernel/cpu/bugs.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 404df26..5c0ea39 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -155,7 +155,8 @@ enum spectre_v2_mitigation_cmd {
>  		guestval |= guest_spec_ctrl & x86_spec_ctrl_mask;
>  
>  		/* SSBD controlled in MSR_SPEC_CTRL */
> -		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
> +		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
> +		    static_cpu_has(X86_FEATURE_AMD_SSBD))
>  			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
>  
>  		if (hostval != guestval) {
> @@ -533,9 +534,10 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
>  		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
>  		 * use a completely different MSR and bit dependent on family.
>  		 */
> -		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> +		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) &&
> +		    !static_cpu_has(X86_FEATURE_AMD_SSBD)) {
>  			x86_amd_ssb_disable();
> -		else {
> +		} else {
>  			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
>  			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
>  			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> 
