Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A2C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265F8204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265F8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeKAUqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:46:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbeKAUqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:46:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 315F231256CB;
        Thu,  1 Nov 2018 11:43:36 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90AB61054FBB;
        Thu,  1 Nov 2018 11:43:35 +0000 (UTC)
Subject: Re: [PATCH AUTOSEL 4.19 022/146] cpupower: Fix coredump on VMWare
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Stafford Horne <shorne@gmail.com>
References: <20181031230541.28822-1-sashal@kernel.org>
 <20181031230541.28822-22-sashal@kernel.org>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <7c08983b-a8c5-0dbc-c8aa-2c6a6799e1ee@redhat.com>
Date:   Thu, 1 Nov 2018 07:43:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031230541.28822-22-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 01 Nov 2018 11:43:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2018 07:03 PM, Sasha Levin wrote:
> From: Prarit Bhargava <prarit@redhat.com>
> 
> [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]
> 
> cpupower crashes on VMWare guests.  The guests have the AMD PStateDef MSR
> (0xC0010064 + state number) set to zero.  As a result fid and did are zero
> and the crash occurs because of a divide by zero (cof = fid/did).  This
> can be prevented by checking the enable bit in the PStateDef MSR before
> calculating cof.  By doing this the value of pstate[i] remains zero and
> the value can be tested before displaying the active Pstates.
> 
> Check the enable bit in the PstateDef register for all supported families
> and only print out enabled Pstates.
> 

Hi Sasha,

This patch, f69ffc5d3db8, depends on 8c22e2f69592 ("cpupower: Fix AMD Family
0x17 msr_pstate size").  Without 8c22e2f69592 the patch below will always read a
value of "0" and not output the correct data.

8c22e2f69592 must be applied to any stable branch that f69ffc5d3db8 is applied to.

P.


> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/power/cpupower/utils/cpufreq-info.c | 2 ++
>  tools/power/cpupower/utils/helpers/amd.c  | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index df43cd45d810..ccd08dd00996 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -200,6 +200,8 @@ static int get_boost_mode(unsigned int cpu)
>  		printf(_("    Boost States: %d\n"), b_states);
>  		printf(_("    Total States: %d\n"), pstate_no);
>  		for (i = 0; i < pstate_no; i++) {
> +			if (!pstates[i])
> +				continue;
>  			if (i < b_states)
>  				printf(_("    Pstate-Pb%d: %luMHz (boost state)"
>  					 "\n"), i, pstates[i]);
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index bb41cdd0df6b..58d23997424d 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -119,6 +119,11 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
>  		}
>  		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
>  			return -1;
> +		if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
> +			continue;
> +		else if (!pstate.bits.en)
> +			continue;
> +
>  		pstates[i] = get_cof(cpu_family, pstate);
>  	}
>  	*no = i;
> 
