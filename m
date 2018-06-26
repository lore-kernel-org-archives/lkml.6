Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9663FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B6226AFE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B6226AFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965338AbeFZNRB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:17:01 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:47602
        "EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965304AbeFZNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:16:56 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id Xnq2fknBhyBWgXnq3f2mtc; Tue, 26 Jun 2018 06:16:55 -0700
Subject: Re: [Patch v2 06/15] CIFS: Introduce helper function to get page
 offset and length in smb_rqst
To:     Long Li <longli@microsoft.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-7-longli@linuxonhyperv.com>
 <a6613388-0dc5-7646-b71f-75b8bec4e4d9@talpey.com>
 <CY4PR2101MB0722840106EDFEFBBA42D45FCE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <33a2f951-10fd-fa94-4fb1-cade7f72cd77@talpey.com>
Date:   Tue, 26 Jun 2018 09:16:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR2101MB0722840106EDFEFBBA42D45FCE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNwr7X7DWhnC0/pI1g8snIX6t/gGxm3+GmdBCb9nRy9tZB34WwV5l53P01q5Wrcvm+qv7PV09RXjNgdTAPZcCTQRKHfykgyZp4+MLkc7bP1Yz0bzbgaM
 pFmLoJhfL4kPAljAW5CBpK9dEGwEXOCsaDps+6GThwve6Q6/q/dPUklv2cRYHkfVITYJU+wqvQVgQiqIov/vITSgKqD6r4DBU+xK1H1s5zo0+5sleUfhuDfM
 WU4TTCy7l+ppGRMct2KyT618ajQvYErnNCkENzw2b4dYS8TryLNPIp5nloPEOznSwASP12lVaMByKggbe2HZhQwv4G4pEQabDx2fRkcHzJ68kpeKYqEb2pUc
 Awm65xyx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2018 5:14 PM, Long Li wrote:
>> Subject: Re: [Patch v2 06/15] CIFS: Introduce helper function to get page
>> offset and length in smb_rqst
>>
>> On 5/30/2018 3:47 PM, Long Li wrote:
>>> From: Long Li <longli@microsoft.com>
>>>
>>> Introduce a function rqst_page_get_length to return the page offset
>>> and length for a given page in smb_rqst. This function is to be used
>>> by following patches.
>>>
>>> Signed-off-by: Long Li <longli@microsoft.com>
>>> ---
>>>    fs/cifs/cifsproto.h |  3 +++
>>>    fs/cifs/misc.c      | 17 +++++++++++++++++
>>>    2 files changed, 20 insertions(+)
>>>
>>> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h index
>>> 7933c5f..89dda14 100644
>>> --- a/fs/cifs/cifsproto.h
>>> +++ b/fs/cifs/cifsproto.h
>>> @@ -557,4 +557,7 @@ int cifs_alloc_hash(const char *name, struct
>> crypto_shash **shash,
>>>    		    struct sdesc **sdesc);
>>>    void cifs_free_hash(struct crypto_shash **shash, struct sdesc
>>> **sdesc);
>>>
>>> +extern void rqst_page_get_length(struct smb_rqst *rqst, unsigned int
>> page,
>>> +				unsigned int *len, unsigned int *offset);
>>> +
>>>    #endif			/* _CIFSPROTO_H */
>>> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c index 96849b5..e951417
>>> 100644
>>> --- a/fs/cifs/misc.c
>>> +++ b/fs/cifs/misc.c
>>> @@ -905,3 +905,20 @@ cifs_free_hash(struct crypto_shash **shash,
>> struct sdesc **sdesc)
>>>    		crypto_free_shash(*shash);
>>>    	*shash = NULL;
>>>    }
>>> +
>>> +/**
>>> + * rqst_page_get_length - obtain the length and offset for a page in
>>> +smb_rqst
>>> + * Input: rqst - a smb_rqst, page - a page index for rqst
>>> + * Output: *len - the length for this page, *offset - the offset for
>>> +this page  */ void rqst_page_get_length(struct smb_rqst *rqst,
>>> +unsigned int page,
>>> +				unsigned int *len, unsigned int *offset) {
>>> +	*len = rqst->rq_pagesz;
>>> +	*offset = (page == 0) ? rqst->rq_offset : 0;
>>
>> Really? Page 0 always has a zero offset??
> 
> I think you are misreading this line. The offset for page 0 is rq_offset, the offset for all subsequent pages are 0.

Ah, yes, sorry I did read it incorrectly.
>>> +
>>> +	if (rqst->rq_npages == 1 || page == rqst->rq_npages-1)
>>> +		*len = rqst->rq_tailsz;
>>> +	else if (page == 0)
>>> +		*len = rqst->rq_pagesz - rqst->rq_offset; }
>>>
>>
>> This subroutine does what patch 5 does inline. Why not push this patch up in
>> the sequence and use the helper?
> 
> This is actually a little different. This function returns the length and offset for a given page in the request. There might be multiple pages in a request.

Ok, but I still think there is quite a bit of inline computation of
this stuff that would more clearly and more robustly be done in a set
of common functions. If someone ever touches the code to support a
new upper layer, or even integrate with more complex compounding,
things will get ugly fast.

> The other function calculates the total length of all the pages in a request.

Again, a great candidate for a common set of subroutines, IMO.

Tom.
