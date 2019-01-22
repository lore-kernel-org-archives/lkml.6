Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F8EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A9920823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c7X/3k9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfAVQGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:06:22 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37800 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfAVQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:06:21 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0MG68ra063504;
        Tue, 22 Jan 2019 10:06:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548173168;
        bh=nFzfox6An/m9F8EVq7d4aic6Y/jnq7Kdkyz3QzsmXwA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=c7X/3k9jH+JMTs9H6NUn9P9LZKkbyL1ZTnx2yunOgqVGdfyM96HJJDsiqGwlmZsBR
         bGe3PxB6gsBhwDhlzV4dpnr3Hnb5454d042iW9Wu0s9X9Tjg8cWa5ZzMKuMaIv5xCO
         /qX2Yy5bCPN1oy/XDODw5j2p0UVFBVuX4cVEHCcg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0MG68CN088669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 10:06:08 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 22
 Jan 2019 10:06:08 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 22 Jan 2019 10:06:08 -0600
Received: from [172.22.102.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0MG67Cn027553;
        Tue, 22 Jan 2019 10:06:07 -0600
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
To:     Liam Mark <lmark@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Laura Abbott <labbott@redhat.com>, <sumit.semwal@linaro.org>,
        <arve@android.com>, <tkjos@android.com>, <maco@android.com>,
        <joel@joelfernandes.org>, <christian@brauner.io>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
 <20190119102527.GA17723@infradead.org>
 <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com>
 <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com>
 <20190121212947.GA28620@infradead.org>
 <alpine.DEB.2.10.1901211357140.11004@lmark-linux.qualcomm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <8d87ffa0-0710-fc82-ef87-50843fe3a4ee@ti.com>
Date:   Tue, 22 Jan 2019 10:06:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1901211357140.11004@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 4:12 PM, Liam Mark wrote:
> On Mon, 21 Jan 2019, Christoph Hellwig wrote:
> 
>> On Mon, Jan 21, 2019 at 11:44:10AM -0800, Liam Mark wrote:
>>> The main use case is for allowing clients to pass in 
>>> DMA_ATTR_SKIP_CPU_SYNC in order to skip the default cache maintenance 
>>> which happens in dma_buf_map_attachment and dma_buf_unmap_attachment. In 
>>> ION the buffers aren't usually accessed from the CPU so this allows 
>>> clients to often avoid doing unnecessary cache maintenance.
>>
>> This can't work.  The cpu can still easily speculate into this area.
> 
> Can you provide more detail on your concern here.
> The use case I am thinking about here is a cached buffer which is accessed 
> by a non IO-coherent device (quite a common use case for ION).
> 
> Guessing on your concern:
> The speculative access can be an issue if you are going to access the 
> buffer from the CPU after the device has written to it, however if you 
> know you aren't going to do any CPU access before the buffer is again 
> returned to the device then I don't think the speculative access is a 
> concern.
> 
>> Moreover in general these operations should be cheap if the addresses
>> aren't cached.
>>
> 
> I am thinking of use cases with cached buffers here, so CMO isn't cheap.
> 

These buffers are cacheable, not cached, if you haven't written anything
the data wont actually be in cache. And in the case of speculative cache
filling the lines are marked clean. In either case the only cost is the
little 7 instruction loop calling the clean/invalidate instruction (dc
civac for ARMv8) for the cache-lines. Unless that is the cost you are
trying to avoid?

In that case if you are mapping and unmapping so much that the little
CMO here is hurting performance then I would argue your usage is broken
and needs to be re-worked a bit.

Andrew

> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
