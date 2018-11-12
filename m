Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F54C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE89A20869
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnqdKo+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE89A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbeKLX0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbeKLX0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:26:02 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E5120869;
        Mon, 12 Nov 2018 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542029564;
        bh=UUdYIfU8IPLaJ0KANgLWI2q0Hl1LCY+aTtQTtVUZgAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnqdKo+brJdPn84dN3FcbyuTLWeH4sk0S+gPAAlKNglkjqHrDIhc/aIZcAn6o24j8
         mNnxnWkdEK5fGSn/HvVwjuaj2WO0KH5NjzgsYJdNUUcRonLss/236uok6JSz89RZ2G
         wstoAClv9HabzHQ+V1NUhqAyA0vb8iKm6EqLDyYw=
Date:   Mon, 12 Nov 2018 05:32:43 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.4 07/32] cpupower: Fix coredump on VMWare
Message-ID: <20181112133243.GA22022@kroah.com>
References: <20181031231137.29429-1-sashal@kernel.org>
 <20181031231137.29429-7-sashal@kernel.org>
 <a5f213e5-a671-d587-5329-5b919965134e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5f213e5-a671-d587-5329-5b919965134e@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:29:27AM -0200, Rafael David Tinoco wrote:
> On 10/31/18 9:11 PM, Sasha Levin wrote:
> > From: Prarit Bhargava <prarit@redhat.com>
> > 
> > [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]
> > 
> > cpupower crashes on VMWare guests.  The guests have the AMD PStateDef MSR
> > (0xC0010064 + state number) set to zero.  As a result fid and did are zero
> > and the crash occurs because of a divide by zero (cof = fid/did).  This
> > can be prevented by checking the enable bit in the PStateDef MSR before
> > calculating cof.  By doing this the value of pstate[i] remains zero and
> > the value can be tested before displaying the active Pstates.
> > 
> > Check the enable bit in the PstateDef register for all supported families
> > and only print out enabled Pstates.
> > 
> > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   tools/power/cpupower/utils/cpufreq-info.c | 2 ++
> >   tools/power/cpupower/utils/helpers/amd.c  | 5 +++++
> >   2 files changed, 7 insertions(+)
> > 
> > diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> > index 0e6764330241..f9b064ac8d94 100644
> > --- a/tools/power/cpupower/utils/cpufreq-info.c
> > +++ b/tools/power/cpupower/utils/cpufreq-info.c
> > @@ -200,6 +200,8 @@ static int get_boost_mode(unsigned int cpu)
> >   		printf(_("    Boost States: %d\n"), b_states);
> >   		printf(_("    Total States: %d\n"), pstate_no);
> >   		for (i = 0; i < pstate_no; i++) {
> > +			if (!pstates[i])
> > +				continue;
> >   			if (i < b_states)
> >   				printf(_("    Pstate-Pb%d: %luMHz (boost state)"
> >   					 "\n"), i, pstates[i]);
> > diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> > index 6437ef39aeea..82adfb33d7a5 100644
> > --- a/tools/power/cpupower/utils/helpers/amd.c
> > +++ b/tools/power/cpupower/utils/helpers/amd.c
> > @@ -103,6 +103,11 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
> >   		}
> >   		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
> >   			return -1;
> > +		if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
> > +			continue;
> > +		else if (!pstate.bits.en)
> > +			continue;
> > +
> >   		pstates[i] = get_cof(cpu_family, pstate);
> >   	}
> >   	*no = i;
> > 
> 
> Sasha,
> 
> This commit is causing:
> 
> $ make V=1 -C tools/power/cpupower all
> 
> gcc -fPIC -DVERSION=\"4.4.163.99.g0d9e7b\" -DPACKAGE=\"cpupower\"
> -DPACKAGE_BUGREPORT=\"linux-pm@vger.kernel.org\" -D_GNU_SOURCE -pipe -DNLS
> -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare -Wno-pointer-sign
> -Wdeclaration-after-statement -Wshadow -O1 -g -DDEBUG -I./lib -I ./utils -o
> utils/helpers/amd.o -c utils/helpers/amd.c
> utils/helpers/amd.c: In function ‘decode_pstates’:
> utils/helpers/amd.c:106:39: error: ‘union msr_pstate’ has no member named
> ‘fam17h_bits’
>    if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
> 
> I think it should be dropped from v4.4 and v4.9 RCs, since this is a fix for
> a CPU that isn't supported for those 2.

Now dropped from both queues now.  Thanks for testing and finding these.

greg k-h
