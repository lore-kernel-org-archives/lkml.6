Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8BDC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A86A2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g0LziTC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A86A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeJXHuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:50:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51314 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeJXHuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:50:16 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NNOceZ005455;
        Tue, 23 Oct 2018 18:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540337078;
        bh=OAPiWTpaAeEd+JGAXzPLx0jY0DwDwmFw2pyyrv+iw94=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=g0LziTC26czXgr2sYCNrfVX/ApzY0GUjZ3iod1pBkn7RQ7UIqpB6isUxG1RlzWWsZ
         ymD5qxKviu4dORmmWrmd4clhYD8qLJUp+OOM5n5P6plmzxbsedfHs6NozeXfvEdBBP
         QvNYCOV+uYboPefsE2cAoP7Hy6rtK4z9oDuBHIbU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NNOcmn001734;
        Tue, 23 Oct 2018 18:24:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 18:24:38 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 18:24:38 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NNOcam008289;
        Tue, 23 Oct 2018 18:24:38 -0500
Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
 centralized carveout allocator
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-13-git-send-email-loic.pallardy@st.com>
 <20181010053206.GA20016@builder>
 <89f3d4bbbc484c5fb5d85f03b1325103@SFHDAG7NODE2.st.com>
 <20181015064040.GT12063@builder>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <6d2a42f0-d981-fac5-e4a9-fa7b8fdaef73@ti.com>
Date:   Tue, 23 Oct 2018 18:24:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181015064040.GT12063@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Loic,

On 10/15/18 1:40 AM, Bjorn Andersson wrote:

> On Wed 10 Oct 11:58 PDT 2018, Loic PALLARDY wrote:
> 
>>
>>
>>> -----Original Message-----
>>> From: Bjorn Andersson [mailto:bjorn.andersson@linaro.org]
>>> Sent: mercredi 10 octobre 2018 07:32
>>> To: Loic PALLARDY <loic.pallardy@st.com>
>>> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
>>> benjamin.gaignard@linaro.org; s-anna@ti.com
>>> Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
>>> centralized carveout allocator
>>>
>>> On Fri 27 Jul 06:14 PDT 2018, Loic Pallardy wrote:
>>>>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>>>> diff --git a/drivers/remoteproc/remoteproc_virtio.c
>>> b/drivers/remoteproc/remoteproc_virtio.c
>>> [..]
>>>> @@ -114,6 +122,10 @@ static struct virtqueue *rp_find_vq(struct
>>> virtio_device *vdev,
>>>>  	rvring->vq = vq;
>>>>  	vq->priv = rvring;
>>>>
>>>> +	/* Update vring in resource table */
>>>> +	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
>>>> +	rsc->vring[id].da = mem->da;
>>>> +
>>>
>>> This would now happen after we've started the remoteproc. Don't we need
>>> to do this in-between allocating the carveouts and booting the
>>> remoteproc?
>>
>> Yes da is updated after coprocessor boot, but before vdev status in resource table is set to DRIVER_OK and kick.
>> Coprocessor should not parse this resource before as vrings not initialized yet.
>> If coprocessor needs to get some information about vring carveout at boot time, carveout resources named vdev"x"vring"y" should be added to firmware resource table.
>> In that case information will be filled before coprocessor boot.
>>
> 
> Makes sense, thanks for clarifying. Applied.

Unfortunately, our current firmwares are not doing this, and so this
patch is breaking the IPC functionality in our platform drivers. We do
wait for the vdev status before actually attempting any Tx from the
remote side.

Our newer platforms will definitely be leveraging this before the vring
inits to account for early-boot of rprocs in bootloaders and
late-attach/ipc-only modes in kernel.

regards
Suman

> 
> Regards,
> Bjorn
> 

