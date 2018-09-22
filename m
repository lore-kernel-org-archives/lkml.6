Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7ECC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748FA208D9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 17:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748FA208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeIVXS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 19:18:28 -0400
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:57577
        "EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbeIVXS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 19:18:28 -0400
Received: from [172.20.1.95] ([50.235.29.67])
        by :SMTPAUTH: with ESMTPSA
        id 3lWVg9XsWfWu43lWWgdUpV; Sat, 22 Sep 2018 10:16:52 -0700
Subject: Re: [Patch v7 21/22] CIFS: SMBD: Upper layer performs SMB read via
 RDMA write through memory registration
To:     Stefan Metzmacher <metze@samba.org>,
        Long Li <longli@exchange.microsoft.com>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Tom Talpey <ttalpey@microsoft.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
References: <20171107085514.12693-1-longli@exchange.microsoft.com>
 <20171107085514.12693-22-longli@exchange.microsoft.com>
 <9b02dadb-d21b-7a8d-7803-910041f66047@talpey.com>
 <a7680efb-6ecf-0f70-2fde-55c2b69b534b@samba.org>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <699de6ba-201a-fd4f-bcac-234e13f33afc@talpey.com>
Date:   Sat, 22 Sep 2018 10:16:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a7680efb-6ecf-0f70-2fde-55c2b69b534b@samba.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJx/4KRrN3emlbEKSKH7hpYkbtBsDe9gE775D7rxDKHYGjQubuhH99fs3mgwnQydpczHHzKdb/4CRx2b4X+sk5J1sJnmT4ZOMyQ8asI2KC0x2KDoRgJk
 mLLGlIgZzcoCQJjgFEHCTU8Yy7Ynw1WlOoED8tDMbZxIgl/v0hPWUXzjJ4xHzWhR99Q2EXtBjyjGFAQroIi+VM+S8JcEK5vascrZ69W8xswuZnGAL5SIJL/N
 ibP8Y9BMBUyl0hlKfEBOH/DWS89839eWmlt5jP3zVIcUjmf+uKO0CScGpYVgwioW7wJgDxWg673dpqkMO26/Y9xwr5xLEjI5aT9ceX8+xekutOoMZ7LIcql5
 Gh7BvkuJfrzPCcQ084sPulT5lj5m5h5O/SnqwMjccG9vIRGq7fKoTpj5KQ2UAq8rWHu6KPlv4IeRZwSVNM5eRJOtkVQ+B9Q7FnqhIMgRRIzO9m7625aySQJn
 85cP+7Y07KwR82wjU3TINcivswyNfHyxS21e7TynUcGH/Wvf7nrRYrzXVwg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2018 8:56 PM, Stefan Metzmacher wrote:
> Hi,
> 
>>> +        req->Channel = SMB2_CHANNEL_RDMA_V1_INVALIDATE;
>>> +        if (need_invalidate)
>>> +            req->Channel = SMB2_CHANNEL_RDMA_V1;
>>> +        req->ReadChannelInfoOffset =
>>> +            offsetof(struct smb2_read_plain_req, Buffer);
>>> +        req->ReadChannelInfoLength =
>>> +            sizeof(struct smbd_buffer_descriptor_v1);
>>> +        v1 = (struct smbd_buffer_descriptor_v1 *) &req->Buffer[0];
>>> +        v1->offset = rdata->mr->mr->iova;
>>
>> It's unnecessary, and possibly leaking kernel information, to use
>> the IOVA as the offset of a memory region which is registered using
>> an FRWR. Because such regions are based on the exact bytes targeted
>> by the memory handle, the offset can be set to any value, typically
>> zero, but nearly arbitrary. As long as the (offset + length) does
>> not wrap or otherwise overflow, offset can be set to anything
>> convenient.
>>
>> Since SMB reads and writes range up to 8MB, I'd suggest zeroing the
>> least significant 23 bits, which should guarantee it. The other 41
>> bits, party on. You could randomize them, pass some clever identifier
>> such as MID sequence, whatever.
> 
> I just tested that setting:
> 
> mr->iova &= (PAGE_SIZE - 1);
> mr->iova |= 0xFFFFFFFF00000000;
> 
> after the ib_map_mr_sg() and before doing the IB_WR_REG_MR, seems to work.

Good! As you know, we were concerned about it after seeing that
the ib_dma_map_sg() code was unconditionally setting it to the
dma_mapped address. By salting those FFFF's with varying data,
this should give your FRWR regions stronger integrity in addition
to not leaking kernel "addresses" to the wire.

Tom.
