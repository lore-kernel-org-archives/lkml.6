Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D556C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD24021855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xArrTRjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfAWRJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:09:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57238 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:09:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0NH9COD121219;
        Wed, 23 Jan 2019 11:09:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548263352;
        bh=N3rMetUdTo4sFfyoFxABiDvjHajQT07HtXRmJ2kVnRY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xArrTRjxNBKSV7hM8nklqyADMFsbM8/yhYyHFPWv0Qxq03FHPGnH24hstrvkoc5nc
         dBPLBkYKhwy+/20aG3ia8zTTe+C1Vmm0PeiFY5QuUPl6Ajg3NMyaFVW3rfYg5HLIME
         E47ILDIk1r9LhaEfcuXFUiwK4dkxGEci45ioekwk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0NH9COd093922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 11:09:12 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 23
 Jan 2019 11:09:12 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 23 Jan 2019 11:09:12 -0600
Received: from [172.22.97.60] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0NH9BUX005473;
        Wed, 23 Jan 2019 11:09:11 -0600
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
To:     Sumit Semwal <sumit.semwal@linaro.org>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
 <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com>
 <f53987d5-b7c1-61f4-de44-3d7b4a3c68fe@ti.com>
 <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
 <4a5d4147-765d-711f-af98-9022d0253b3b@ti.com>
 <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com>
 <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com>
 <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com>
 <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
 <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
 <b89df12e-00bc-5484-6458-f7c85a362b42@ti.com>
 <CAO_48GHZPkE8Or_dB6CVMi5Jv5eufE_Z36MT7ztJwTqTzkTpKA@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <84d0fe2e-029c-a7a1-839c-e720efbcc3f9@ti.com>
Date:   Wed, 23 Jan 2019 11:09:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAO_48GHZPkE8Or_dB6CVMi5Jv5eufE_Z36MT7ztJwTqTzkTpKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 9:23 PM, Sumit Semwal wrote:
> Hello everyone,
> 
> (Thanks to Dan for letting me know my last email got corrupted :/ -
> resending it here)
> 

Hmm, this one seems a bit messed up also (Thunderbird doesn't seem to
like it at least).

[snip]

> - from dma-buf PoV, ION is an exporter of dma-buf buffers, for its users
> that have specific requirements.
> 

This is what I'm hoping to change up a little bit, Ion shouldn't be the
exporter, its heaps should be the exporters (manage the dma_buf_ops),
Ion would only do advertising of available heaps and allow allocating
DMA-BUFs from them.

IMO that would clear up the other discussions going on right now about
how Ion should handle different dma-buf syncing tasks, it simply
wouldn't :). Plus Ion core gets slimmed down, maybe even enough for
destaging..

>> I haven't either, which is a shame as it allows for some really useful
>> management strategies for shared memory resources. I'm working on one
>> such case right now, maybe I'll get to be the first to upstream one :)
>>
> Yes, it would, and great that you're looking to be the first one to do it :)
> 
>> > I wasn't aware that CPU access before first device access was
>> > considered an abuse of the API - it seems like a valid thing to want
>> > to do.
>> >
>>
>> That's just it, I don't know if it is an abuse of API, I'm trying to get
>> some clarity on that. If we do want to allow early CPU access then that
>> seems to be in contrast to the idea of deferred allocation until first
>> device map, what is supposed to backing the buffer if no devices have
>> attached or mapped yet? Just some system memory followed by migration on
>> the first attach to the proper backing? Seems too time wasteful to be
>> have a valid use.
>>
>> Maybe it should be up to the exporter if early CPU access is allowed?
>>
>> I'm hoping someone with authority over the DMA-BUF framework can clarify
>> original intentions here.
>>
> 
> I suppose dma-buf as a framework can't know or decide what the exporter
> wants or can do - whether the exporter wants to use it for 'only
> zero-copy', or do some intelligent things behind the scene, I think
> should be best left to the exporter.
> 
> Hope this helps,

Yes, these inputs are very helpful, thanks,
Andrew

> Sumit.
> 
