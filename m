Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C64AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7E7208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9fTMQO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7E7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeLETip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:38:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58212 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLETip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:38:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB5JXv44144904;
        Wed, 5 Dec 2018 19:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=e8hy47dV//26XronhAG0ev1PSKIm7aRevaWciGMuMeM=;
 b=a9fTMQO5uXJpAa275Fe/HlqCT1Txdg3o91gB6VCQgA+eHdAIKKuXQ3JDNUTgCs71bPOP
 5uu52ob1SMjjmOgNappq2bEyUZLC0vaL9df1RYRuIjPDLOCV/AZ8zsswtLLv6UT/wuij
 t368hkmMr2Yq+u0M1h5qsQeCmjhUlIFmjDA//AB8j0oxPWcSI5maSwNhDJ70oJ5rG2EY
 yX9nMBeTKcacTnB9QGHFExGtpkvxMMWTE2PjcTDgLw1RJGgiqGjbUIrbLcuI2QBAZgKL
 b3XRYo3y8J+yNK/59MrfcJRYz9Q9WVWd2PEwbof04e+IuoUvkKJIox9qPL7Z0MUC771H Dw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftf8cs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 19:38:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB5Jc0sH022496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 19:38:01 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB5JbvaN031530;
        Wed, 5 Dec 2018 19:37:57 GMT
Received: from [10.39.220.54] (/10.39.220.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 11:37:57 -0800
Subject: Re: [PATCH] /proc/kpagecount: return 0 for special pages that are
 never mapped
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        sfr@canb.auug.org.au, kirill.shutemov@linux.intel.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        alexander.h.duyck@linux.intel.com, hannes@cmpxchg.org,
        miles.chen@mediatek.com, n-horiguchi@ah.jp.nec.com
References: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
 <20181205004836.GU10377@bombadil.infradead.org>
 <fa5b667d-ccfb-b11a-2aeb-b1007651f9ec@oracle.com>
 <20181205012534.GW10377@bombadil.infradead.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <540f7690-5fcd-04d6-edb3-a44ebd09e70c@oracle.com>
Date:   Wed, 5 Dec 2018 11:40:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205012534.GW10377@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2018 05:25 PM, Matthew Wilcox wrote:
> On Tue, Dec 04, 2018 at 05:18:32PM -0800, anthony.yznaga@oracle.com wrote:
>> On 12/04/2018 04:48 PM, Matthew Wilcox wrote:
>>> On Tue, Dec 04, 2018 at 02:45:26PM -0800, Anthony Yznaga wrote:
>>>> +static inline int page_has_type(struct page *page)
>>>> +{
>>>> +	return (PageType(page, 0) &&
>>>> +	       ((page->page_type & PAGE_TYPE_ALL) != PAGE_TYPE_ALL));
>>>> +}
>>>> +
>>> I think this is a bit complex, and a bit of a pain to update as we add
>>> new page types.  How about this?
>>>
>>> 	return (int)page_type < -128;
>>>
>>> (I'm open to appropriate #defines to make this more obvious that it's ~0x7F)
>> I thought about having this:
>>
>> #define PAGE_TYPE_END    0xffffff80
>>
>> static int inline page_has_type(struct page *page)
>> {
>>     return page->page_type > PAGE_TYPE_BASE &&
>>            page->page_type < PAGE_TYPE_END;
>> }
>>
>> But I opted for the additional complexity to avoid more false-positives from
>> possibly corrupted values.  I'm certainly fine with a simple approach, though.
> The way I'm thinking about this field is that usually it's _mapcount
> which is 0xffffffff to represent 0.  We allow a certain small amount
> of underflow and still treat it as a mapcount.  We also allow for some
> amount of overflow.  So to be utterly precise, what you had there would
> have been fine, but for simplicity, I'd rather just do a signed compare
> against -128.
The signed compare does not allow for mapcount overflow.  Is that acceptable?
False-positives would be benign for /proc/kpagecount though from a debug
perspective it could be helpful to see overflowed mapcounts.  Some future
caller would need separate consideration.



