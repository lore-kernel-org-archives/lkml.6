Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA097C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CF120857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WmblPu4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CF120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbeG0BLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:11:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50646 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbeG0BK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:10:59 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6QNpn6T029096;
        Thu, 26 Jul 2018 18:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532649109;
        bh=HYg35fqdeMdmJ8bw9fCRi9BqMDSGHA6iTny+de1kspw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WmblPu4AV4jpgu7VkwZ78yp9Wg1YXa40DdC4ESQOU1656Ve2r+Zbeg6AzmG/H4vpQ
         SEfKYZYlL/sVWCzPw2WqtDx9IRioC3dstVUalSz/XJdKanRw6FMXDddaO4is+hd5dg
         x4rMGkc+f22SqKMp2NxE67lIOzVy4of3LymVminM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6QNpmlu005594;
        Thu, 26 Jul 2018 18:51:49 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 26
 Jul 2018 18:51:48 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 26 Jul 2018 18:51:48 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6QNplnf025657;
        Thu, 26 Jul 2018 18:51:47 -0500
Subject: Re: [PATCH v2 1/1] remoteproc: correct rproc_free_vring() to avoid
 invalid kernel paging
To:     Loic PALLARDY <loic.pallardy@st.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1530863212-16584-1-git-send-email-loic.pallardy@st.com>
 <ee64ddf7-e9c6-0b77-8a4e-44f77d264fe0@ti.com>
 <8e943f4d2a1b4e10a8a0756c737d53a8@SFHDAG7NODE2.st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <56aeb569-cd4d-3769-fdad-ee3d4dbdc19b@ti.com>
Date:   Thu, 26 Jul 2018 18:51:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8e943f4d2a1b4e10a8a0756c737d53a8@SFHDAG7NODE2.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 07/26/2018 02:48 AM, Loic PALLARDY wrote:
> Hi Suman,
>>
>> Hi Loic,
>>
>> On 07/06/2018 02:46 AM, Loic Pallardy wrote:
>>> If rproc_start() failed, rproc_resource_cleanup() is called to clean
>>> debugfs entries, then associated iommu mappings, carveouts and vdev.
>>> Issue occurs when rproc_free_vring() is trying to reset vring resource
>>> table entry.
>>> At this time, table_ptr is pointing on loaded resource table and carveouts
>>> already released, so access to loaded resource table is generating a kernel
>>> paging error:
>>
>> Are you using a device specific CMA pool or carveout, and if so, where
>> the pool is? If not, where is the default CMA pool? I am trying to
>> reproduce the issue on my platform with the start failure as you
>> suggested, but haven't seen it so far. That said, I have seen the exact
>> same crash when using HighMEM CMA pools on my downstream kernel
>> when
>> stopping the processor, and the root cause is essentially the same as
>> what you summarized here. The issue was present with LowMem pools as
>> well, but got masked because of the kernel linear mapping.
> 
> I have a carveout declared in firmware resource table for co-processor code and data, and st driver has a specific 
> reserved memory region to fit fix address space requested by co-processor.
> So CPU access to code and loaded resource table area is granted thanks to allocation done by rproc_handle_carveout().

Where are the vrings getting allocated from?

In anycase, I prefer that we should actually reset the table_ptr in
rproc_start() in failure cases (undo the operation essentially) as we
don't call rproc_stop() in those cases. This will result in symmetric
code. We already have the reset handled in rproc_stop() added recently
in commit 0a8b81cb2e41 ("remoteproc: Reset table_ptr on stop"). Let me
know what you think, I can send a quick patch.

regards
Suman

> 
>>
>>>
>>> [   12.696535] Unable to handle kernel paging request at virtual address
>> f0f357cc
>>> [   12.696540] pgd = (ptrval)
>>> [   12.696542] [f0f357cc] *pgd=6d2d0811, *pte=00000000, *ppte=00000000
>>> [   12.696558] Internal error: Oops: 807 [#1] SMP ARM
>>> [   12.696563] Modules linked in: rpmsg_core v4l2_mem2mem
>> videobuf2_dma_contig sti_drm v4l2_common vida
>>> [   12.696598] CPU: 1 PID: 48 Comm: kworker/1:1 Tainted: G        W
>> 4.18.0-rc2-00018-g3170fdd-8
>>> [   12.696602] Hardware name: STi SoC with Flattened Device Tree
>>> [   12.696625] Workqueue: events request_firmware_work_func
>>> [   12.696659] PC is at rproc_free_vring+0x84/0xbc [remoteproc]
>>> [   12.696667] LR is at rproc_free_vring+0x70/0xbc [remoteproc]
>>>
>>> This patch proposes to simply remove reset of resource table vring entries,
>>> as firmware and resource table are reloaded at each rproc boot.
>>> rproc_trigger_recovery() not impacted as resources not touched during
>> recovery
>>> procedure.
>>
>> And error recovery doesn't work for me after the rproc_start, stop got
>> introduced.
> Recovery no available on B2260, but I'll test it on another platform this week
> 
> Regards,
> Loic
>>
>> regards
>> Suman
>>
>>>
>>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>>> ---
>>> Changes from V1: typo fixes in commit message
>>>
>>>  drivers/remoteproc/remoteproc_core.c | 6 ------
>>>  1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>> b/drivers/remoteproc/remoteproc_core.c
>>> index a9609d9..9a8b47c 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -289,16 +289,10 @@ void rproc_free_vring(struct rproc_vring *rvring)
>>>  {
>>>  	int size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
>>>  	struct rproc *rproc = rvring->rvdev->rproc;
>>> -	int idx = rvring->rvdev->vring - rvring;
>>> -	struct fw_rsc_vdev *rsc;
>>>
>>>  	dma_free_coherent(rproc->dev.parent, size, rvring->va, rvring-
>>> dma);
>>>  	idr_remove(&rproc->notifyids, rvring->notifyid);
>>>
>>> -	/* reset resource entry info */
>>> -	rsc = (void *)rproc->table_ptr + rvring->rvdev->rsc_offset;
>>> -	rsc->vring[idx].da = 0;
>>> -	rsc->vring[idx].notifyid = -1;
>>>  }
>>>
>>>  static int rproc_vdev_do_probe(struct rproc_subdev *subdev)
>>>
> 

