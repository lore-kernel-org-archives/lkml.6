Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1466220671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1466220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeKTEgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:36:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbeKTEgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:36:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DCABC059B78;
        Mon, 19 Nov 2018 18:11:55 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5FC45D76C;
        Mon, 19 Nov 2018 18:11:54 +0000 (UTC)
Subject: Re: [PATCH 3.18 16/90] cpupower: Fix coredump on VMWare
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
References: <20181119162620.585061184@linuxfoundation.org>
 <20181119162623.516060898@linuxfoundation.org>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <c2d0d4ab-a9e5-cc7b-55d9-f99754beff55@redhat.com>
Date:   Mon, 19 Nov 2018 13:11:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181119162623.516060898@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 19 Nov 2018 18:11:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/2018 11:28 AM, Greg Kroah-Hartman wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Prarit Bhargava <prarit@redhat.com>
> 
> [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]

Greg, as previously mentioned to Sasha, this patch also needs 8c22e2f69592
("cpupower: Fix AMD Family 0x17 msr_pstate size").  I did not see a message
indicating that 8c22e2f69592 was also being backported to 3.18-stable.  My
apologies if I missed it.

P.


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
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  tools/power/cpupower/utils/cpufreq-info.c |    2 ++
>  tools/power/cpupower/utils/helpers/amd.c  |    5 +++++
>  2 files changed, 7 insertions(+)
> 
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -200,6 +200,8 @@ static int get_boost_mode(unsigned int c
>  		printf(_("    Boost States: %d\n"), b_states);
>  		printf(_("    Total States: %d\n"), pstate_no);
>  		for (i = 0; i < pstate_no; i++) {
> +			if (!pstates[i])
> +				continue;
>  			if (i < b_states)
>  				printf(_("    Pstate-Pb%d: %luMHz (boost state)"
>  					 "\n"), i, pstates[i]);
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -103,6 +103,11 @@ int decode_pstates(unsigned int cpu, uns
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
> 
