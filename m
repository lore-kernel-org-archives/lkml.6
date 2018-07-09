Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAD72086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jHFHkBn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAD72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeGIWnl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:43:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48582 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGIWng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:43:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69McdWd188612;
        Mon, 9 Jul 2018 22:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=GW7DH3Zu4jXCHY+U8ZCbWbeFZF0CpofADOK3mSrvAXY=;
 b=jHFHkBn3Sj4Oey6tHhRbqlfOMEk3Qko+hoazLVnJkFXco54NtCn1eaS1mS6PLL3U8FLR
 x169veNDAz/WAsnSVCKffYwdi+DAREThBtla7846fw+nRbmyHGFstRuT03+YO2RLeuBW
 gnoQOl8ow14ux1lS+0dReW/GG8hVNGo+DoM73625dgfoBNQHUotbEm5LQN+cEQDplPsW
 0ZIErHq1l+bcWte3g/T6OABERvNFbvx1IEIBMZiQySNzu06FJddm/AVcEgsKqJ3DUHUV
 CpWie39OfWFMad80PGa2+9FN4MyEFXWCj24ZqN6OSOwJupFYfalR+83uMNtR0WIQ7ePH 1A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k2p7v7fhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 22:42:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69Mg01s014479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 22:42:00 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69Mg0N1017190;
        Mon, 9 Jul 2018 22:42:00 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 15:42:00 -0700
Subject: Re: [RFC PATCH] perf/core: don't sample kernel regs upon skid
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>
References: <20180702151250.14536-1-mark.rutland@arm.com>
 <20180702154655.GR2494@hirez.programming.kicks-ass.net>
 <20180702160249.qck45h76galxrckn@lakrids.cambridge.arm.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <ec514ab8-cf18-6fa7-d2b5-5f81e1a70983@oracle.com>
Date:   Mon, 9 Jul 2018 18:42:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702160249.qck45h76galxrckn@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 12:02 PM, Mark Rutland wrote:
> On Mon, Jul 02, 2018 at 05:46:55PM +0200, Peter Zijlstra wrote:
>> On Mon, Jul 02, 2018 at 04:12:50PM +0100, Mark Rutland wrote:
>>> Users can request that general purpose registers, instruction pointer,
>>> etc, are sampled when a perf event counter overflows. To try to avoid
>>> this resulting in kernel state being leaked, unprivileged users are
>>> usually forbidden from opening events which count while the kernel is
>>> running.
>>>
>>> Unfortunately, this is not sufficient to avoid leading kernel state.
>> 'leaking' surely.
>>
>>> For various reasons, there can be a delay between the overflow occurring
>>> and the resulting overflow exception (e.g. an NMI) being taken. During
>>> this window, other instructions may be executed, resulting in skid.
>>>
>>> This skid means that a userspace-only event overflowing may result in an
>>> exception being taken *after* entry to the kernel, allowing kernel
>>> registers to be sampled. Depending on the amount of skid, this may only
>>> leak the PC (breaking KASLR), or it may leak secrets which are currently
>>> live in GPRs.
>>>
>>> Let's avoid this by only sampling from the user registers when an event
>>> is supposed to exclude the kernel, providing the illusion that the
>>> overflow exception is taken from userspace.
>>>
>>> We also have similar cases when sampling a guest, where we get the host
>>> regs in some cases. It's not entirely clear to me how we should handle
>>> these.
>> Would not a similar:
>>
>> 	if ((event->attr.exclude_hv || event->attr.exclude_host) /* WTF both !? */ &&
>> 	    perf_guest_cbs && !perf_guest_cbs->is_in_guest())
>> 		return perf_guest_cbs->guest_pt_regs();
>>
>> work there? 
> Mostly. It's fun if the user also passed exclude_guest -- I have no idea
> what should be sampled there, if anything.
>
> It's easy to get stuck in a rabbit hole looking at this.
>
>> Of course, perf_guest_info_callbacks is currently lacking that
>> guest_pt_regs() thingy..
> Yeah; I started looking at implementing it, but ran away since it wasn't
> clear to me how to build that on most architectures.
>
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Jin Yao <yao.jin@linux.intel.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> ---
>>>  kernel/events/core.c | 28 ++++++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 8f0434a9951a..2ab2548b2e66 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -6361,6 +6361,32 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>>>  	return callchain ?: &__empty_callchain;
>>>  }
>>>  
>>> +static struct pt_regs *perf_get_sample_regs(struct perf_event *event,
>>> +					    struct pt_regs *regs)
>>> +{
>>> +	/*
>>> +	 * Due to interrupt latency (AKA "skid"), we may enter the kernel
>>> +	 * before taking an overflow, even if the PMU is only counting user
>>> +	 * events.
>>> +	 *
>>> +	 * If we're not counting kernel events, always use the user regs when
>>> +	 * sampling.
>>> +	 *
>>> +	 * TODO: what do we do about sampling a guest's registers? The IP is
>>> +	 * special-cased, but for the rest of the regs they'll get the
>>> +	 * user/kernel regs depending on whether exclude_kernel is set, which
>>> +	 * is nonsensical.
>>> +	 *
>>> +	 * We can't get at the full set of regs in all cases (e.g. Xen's PV PMU
>>> +	 * can't provide the GPRs), so should we just zero the GPRs when in a
>>> +	 * guest? Or skip outputting the regs in perf_output_sample?
>> Seems daft Xen cannot provide registers; why is that? Boris?
> The xen_pmu_regs structure simply doesn't have them, so I assume there's
> no API to get them.
>
> Given we don't currently sample the guest regs, I'd be tempted to just
> zero them for now, or skip the sample at output time (if that doesn't
> break some other case).

(Was out on vacation, couldn't respond earlier)

Yes, PV guests only get a limited set of registers passed to the handler
by the hypervisor. GPRs are not part of this set.

I think we need do

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 7d00d4a..95997e6 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -478,7 +478,7 @@ static void xen_convert_regs(const struct
xen_pmu_regs *xen_regs,
 irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id)
 {
        int err, ret = IRQ_NONE;
-       struct pt_regs regs;
+       struct pt_regs regs = {0};
        const struct xen_pmu_data *xenpmu_data = get_xenpmu_data();
        uint8_t xenpmu_flags = get_xenpmu_flags();


Do you want me to submit a separate patch or can you make this part of
yours?

Thanks.
-boris

