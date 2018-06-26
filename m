Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76696C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9FF26D14
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9FF26D14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeFZPVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:21:07 -0400
Received: from p3plsmtpa09-08.prod.phx3.secureserver.net ([173.201.193.237]:40021
        "EHLO p3plsmtpa09-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751064AbeFZPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:21:06 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 11:21:06 EDT
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id Xpf8fXXAL7uxWXpf8fZJdV; Tue, 26 Jun 2018 08:13:47 -0700
Subject: Re: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-3-longli@linuxonhyperv.com>
 <67b8afe7-f5e0-b36a-fcc1-87f1ae08eaa4@talpey.com>
 <20180625210132.GB5381@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <f940d126-237c-963f-f64e-e1eb1e8c6c85@talpey.com>
Date:   Tue, 26 Jun 2018 11:13:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625210132.GB5381@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG2/Ww9P3v893Mr9eyBWDVuapw1SeB6b2FJndLZg0MtHtRXByrThdunB3FEkJT/1FrRpEpVEv0ku2qHry8iG3+WWlgONZ/DzxSOt3EKQ6OPwPxVKbe/P
 YrNsuaw5aLNfy2buWXPmxb2E0vK4sPw1dQc8z2KXoO+gpV3Lk4iJGT3lOdvg+OWxcme5y4o+WcML7M9GUZ7RP4FwmSq0JEygSk9DZ1rYDOKpuDTYqFdUlWAt
 Rl7lSTrqwqWnapiRTd9yG3vQnzvxTf+q8wfFBNrtkGomf1MfYkYUqt8fT75lqNTqZF+mBgQJDUncLgMsGMBZ3PF4RH/mc9IvnLqT1QzT6ABMsaASeK8Yag1q
 BU7l1ah9mfdsXc/j0LW9kSpJp4gXzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2018 5:01 PM, Jason Gunthorpe wrote:
> On Sat, Jun 23, 2018 at 09:50:20PM -0400, Tom Talpey wrote:
>> On 5/30/2018 3:47 PM, Long Li wrote:
>>> From: Long Li <longli@microsoft.com>
>>>
>>> Add a function to allocate rdata without allocating pages for data
>>> transfer. This gives the caller an option to pass a number of pages
>>> that point to the data buffer.
>>>
>>> rdata is still reponsible for free those pages after it's done.
>>
>> "Caller" is still responsible? Or is the rdata somehow freeing itself
>> via another mechanism?
>>
>>>
>>> Signed-off-by: Long Li <longli@microsoft.com>
>>>   fs/cifs/cifsglob.h |  2 +-
>>>   fs/cifs/file.c     | 23 ++++++++++++++++++++---
>>>   2 files changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
>>> index 8d16c3e..56864a87 100644
>>> +++ b/fs/cifs/cifsglob.h
>>> @@ -1179,7 +1179,7 @@ struct cifs_readdata {
>>>   	unsigned int			tailsz;
>>>   	unsigned int			credits;
>>>   	unsigned int			nr_pages;
>>> -	struct page			*pages[];
>>> +	struct page			**pages;
>>
>> Technically speaking, these are syntactically equivalent. It may not
>> be worth changing this historic definition.
> 
> [] is a C99 'flex array', it has a different allocation behavior than
> ** and is not interchangeable..

In that case, it's an even better reason to not change the declaration.

Tom.

