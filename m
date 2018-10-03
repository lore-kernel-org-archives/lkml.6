Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C027C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C52E20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C52E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeJCTPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:15:49 -0400
Received: from foss.arm.com ([217.140.101.70]:50622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeJCTPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:15:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1C5A18A;
        Wed,  3 Oct 2018 05:27:36 -0700 (PDT)
Received: from [10.1.31.205] (desktop-vlo843j.cambridge.arm.com [10.1.31.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B663F5B7;
        Wed,  3 Oct 2018 05:27:34 -0700 (PDT)
Subject: Re: [PATCH v2 08/22] soc/fsl/qbman_portals: add APIs to retrieve the
 probing status
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Roy Pledge <roy.pledge@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        David Miller <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
 <20180926132247.10971-9-laurentiu.tudor@nxp.com>
 <CADRPPNTD=SNpSqz=zoLyGP1tvh_xDr5E1NDHF_P0bcSPyx9X1A@mail.gmail.com>
 <c4ff9977-c730-be48-8046-97da663c5a23@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <37ad85d7-6540-60de-6d47-66f57fa3473a@arm.com>
Date:   Wed, 3 Oct 2018 13:27:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c4ff9977-c730-be48-8046-97da663c5a23@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-03 11:50 AM, Laurentiu Tudor wrote:
> Hi Leo,
> 
> On 27.09.2018 23:03, Li Yang wrote:
>> On Wed, Sep 26, 2018 at 8:26 AM <laurentiu.tudor@nxp.com> wrote:
>>>
>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>
>>> Add a couple of new APIs to check the probing status of the required
>>> cpu bound qman and bman portals:
>>>    'int bman_portals_probed()' and 'int qman_portals_probed()'.
>>> They return the following values.
>>>    *  1 if qman/bman portals were all probed correctly
>>>    *  0 if qman/bman portals were not yet probed
>>>    * -1 if probing of qman/bman portals failed
>>> Drivers that use qman/bman portal driver services are required to use
>>> these APIs before calling any functions exported by these drivers or
>>> otherwise they will crash the kernel.
>>> First user will be the dpaa1 ethernet driver, coming in a subsequent
>>> patch.
>>>
>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>> ---
>>>    drivers/soc/fsl/qbman/bman_portal.c | 10 ++++++++++
>>>    drivers/soc/fsl/qbman/qman_portal.c | 10 ++++++++++
>>>    include/soc/fsl/bman.h              |  8 ++++++++
>>>    include/soc/fsl/qman.h              |  9 +++++++++
>>>    4 files changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
>>> index f9edd28894fd..8048d35de8a2 100644
>>> --- a/drivers/soc/fsl/qbman/bman_portal.c
>>> +++ b/drivers/soc/fsl/qbman/bman_portal.c
>>> @@ -32,6 +32,7 @@
>>>
>>>    static struct bman_portal *affine_bportals[NR_CPUS];
>>>    static struct cpumask portal_cpus;
>>> +static int __bman_portals_probed;
>>>    /* protect bman global registers and global data shared among portals */
>>>    static DEFINE_SPINLOCK(bman_lock);
>>>
>>> @@ -85,6 +86,12 @@ static int bman_online_cpu(unsigned int cpu)
>>>           return 0;
>>>    }
>>>
>>> +int bman_portals_probed(void)
>>> +{
>>> +       return __bman_portals_probed;
>>> +}
>>> +EXPORT_SYMBOL_GPL(bman_portals_probed);
>>> +
>>>    static int bman_portal_probe(struct platform_device *pdev)
>>>    {
>>>           struct device *dev = &pdev->dev;
>>> @@ -148,6 +155,7 @@ static int bman_portal_probe(struct platform_device *pdev)
>>>           spin_lock(&bman_lock);
>>>           cpu = cpumask_next_zero(-1, &portal_cpus);
>>>           if (cpu >= nr_cpu_ids) {
>>> +               __bman_portals_probed = 1;
>>
>> What if the last CPU is not used for portals?  Is there a hard
>> requirement that all CPUs need to be used for portal?
> 
> As far as I know, in the current driver design a portal is required for
> each CPU.
> 
>> What happens if the last CPU is offline?
> 
> Can this happen at probe time?

As I understand things, yes - if you boot with "maxcpus=1", only the 
boot CPU will be onlined by the kernel, but the others can still be 
brought up manually by userspace later.

Robin.

> Anyway, I'm not sure that the driver is even aware of cpu hotplug but
> I'll let Roy comment on this one.
> 
>>
>>>                   /* unassigned portal, skip init */
>>>                   spin_unlock(&bman_lock);
>>>                   return 0;
>>> @@ -173,6 +181,8 @@ static int bman_portal_probe(struct platform_device *pdev)
>>>    err_ioremap2:
>>>           memunmap(pcfg->addr_virt_ce);
>>>    err_ioremap1:
>>> +        __bman_portals_probed = 1;
>>> +
>>
>> There are other error paths that not covered.
> 
> Right, thanks for pointing. On top of that, the assigned value here
> should be -1 to signal error (instead of 1 which signals success).
> 
> ---
> Best Regards, Laurentiu
> 
