Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A0320676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A0320676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeIXKAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:00:09 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:34000
        "EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbeIXKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:00:09 -0400
Received: from [172.20.2.189] ([50.227.211.198])
        by :SMTPAUTH: with ESMTPSA
        id 4I2VgpvGU5FoM4I2Vg8P9O; Sun, 23 Sep 2018 21:00:04 -0700
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
 <699de6ba-201a-fd4f-bcac-234e13f33afc@talpey.com>
 <f9c791af-28d0-5107-e41a-31eee03cbda0@samba.org>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <de042465-e9b9-3782-00ce-38943053c7b6@talpey.com>
Date:   Sun, 23 Sep 2018 21:00:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f9c791af-28d0-5107-e41a-31eee03cbda0@samba.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHTKu28keoM1hNFG83iqXMF0hu10sX2VgZIohaxos2hMN1hfflEF9zFGazBXlso3OrjwJY74sqk0HIBfnzjbnOSsWEPbBsJ33B3uQx9OKfzaK8prO7ho
 qynBKFrRyPgwgdRXMv6VmNzfGkMeszs3iEXCHOdtNKcmGqz1c1QsabviWeYSWnzrEpt8MqwU1Z3yhy0kyMzECJJXHRmu2QnvTBVlPquXLAcEcMDDeStbNu2h
 FIOTB1A9x5nN/KTe0tMzt3poDXSwjvCAuYJiomx60zyJE4AwDvF0L5O+Hwx607fcsEl0d9c+mIgIqkmXNH0d6yKmw8V09/K0W9+aH/cToZ0QUGUVssgQ9yRn
 75hAW+qke/rr6QQZixl1ChMpo4TnPpFKb3XB05DXrmoJssA6YuzvL/oZVGUtrKk6Y9C0zfvgxgVTY+cqyC+iiyHd9KZX7Dzu2cv2BoSRBYQaE4LJFp0GIwUm
 nRgihVK7ueg+Wee5mHqLYGeLEeEetOlDt5TWCvzeUCPOEdnRan8ZRNaTm0g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/2018 2:24 PM, Stefan Metzmacher wrote:
> Hi Tom,
> 
>>> I just tested that setting:
>>>
>>> mr->iova &= (PAGE_SIZE - 1);
>>> mr->iova |= 0xFFFFFFFF00000000;
>>>
>>> after the ib_map_mr_sg() and before doing the IB_WR_REG_MR, seems to
>>> work.
>>
>> Good! As you know, we were concerned about it after seeing that
>> the ib_dma_map_sg() code was unconditionally setting it to the
>> dma_mapped address. By salting those FFFF's with varying data,
>> this should give your FRWR regions stronger integrity in addition
>> to not leaking kernel "addresses" to the wire.
> 
> Just wondering... Isn't the thing we use called FRMR?

They're basically the same concept, it's a subtle difference.

FRMR = Fast Register Memory Region
FRWR = Fast Register Work Request

The memory region is the mr itself, this is created early on.

The work request is built when actually binding the physical
pages to the region, and setting the offset, length, etc, which
is what's happening in the routine that I made the comment on.

So, for this discussion I chose to say FRWR. Sorry for any
confusion!

Tom.
