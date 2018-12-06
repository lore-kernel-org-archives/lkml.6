Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6AFC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52E020878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wPSbugRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52E020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeLFAnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:43:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35266 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeLFAnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:43:20 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB60fXHp179245;
        Thu, 6 Dec 2018 00:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XKXm8OFlPvLcqZIfRK0PU6aioyaaA/H5ibZEpafmhgU=;
 b=wPSbugRWHFu0R3bXQBYU9mvhG0fXdGg6IISGOdeyAV0xi55TFfJd+Ig72Rp3XIcTT/bs
 XtJWhf+/nrYBbqQ6cLBlx8xzrdqLZtnNa7bY5YsbEz3ydhSB/E2/NMwymhFP0rOYh/BF
 JKuBys3PhmtWn94CZ2+2843CWXLb4MET2BgBIP0/HkaULJPpnSsgFAEBS3BeFOpk026U
 23T6uNkdUZhiLc83d0YgdAcNwkTBE3Vuo3h3Tje45ctesQLLQ0tWtLpwWL9NHun1aTGS
 oFqM9RBUAIfD/4+XjkLR+FWTvq8Q/x2diLQTp4qGNmQFTWflCTMHVD71ZJs4uiEmVPE4 PQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p3ftf9h1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 00:41:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB60fRXL029591
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 00:41:27 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB60fMZW032466;
        Thu, 6 Dec 2018 00:41:22 GMT
Received: from [10.39.220.54] (/10.39.220.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 16:41:21 -0800
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
 <540f7690-5fcd-04d6-edb3-a44ebd09e70c@oracle.com>
 <20181205194409.GB11646@bombadil.infradead.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <d9fa0325-690d-47cc-fc49-2606855f6a4f@oracle.com>
Date:   Wed, 5 Dec 2018 16:44:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205194409.GB11646@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2018 11:44 AM, Matthew Wilcox wrote:
> On Wed, Dec 05, 2018 at 11:40:51AM -0800, Anthony Yznaga wrote:
>> On 12/04/2018 05:25 PM, Matthew Wilcox wrote:
>>> On Tue, Dec 04, 2018 at 05:18:32PM -0800, anthony.yznaga@oracle.com wrote:
>>>> On 12/04/2018 04:48 PM, Matthew Wilcox wrote:
>>>>> On Tue, Dec 04, 2018 at 02:45:26PM -0800, Anthony Yznaga wrote:
>>>>>> +static inline int page_has_type(struct page *page)
>>>>>> +{
>>>>>> +	return (PageType(page, 0) &&
>>>>>> +	       ((page->page_type & PAGE_TYPE_ALL) != PAGE_TYPE_ALL));
>>>>>> +}
>>>>>> +
>>>>> I think this is a bit complex, and a bit of a pain to update as we add
>>>>> new page types.  How about this?
>>>>>
>>>>> 	return (int)page_type < -128;
>>>>>
>>>>> (I'm open to appropriate #defines to make this more obvious that it's ~0x7F)
>>>> I thought about having this:
>>>>
>>>> #define PAGE_TYPE_END    0xffffff80
>>>>
>>>> static int inline page_has_type(struct page *page)
>>>> {
>>>>     return page->page_type > PAGE_TYPE_BASE &&
>>>>            page->page_type < PAGE_TYPE_END;
>>>> }
>>>>
>>>> But I opted for the additional complexity to avoid more false-positives from
>>>> possibly corrupted values.  I'm certainly fine with a simple approach, though.
>>> The way I'm thinking about this field is that usually it's _mapcount
>>> which is 0xffffffff to represent 0.  We allow a certain small amount
>>> of underflow and still treat it as a mapcount.  We also allow for some
>>> amount of overflow.  So to be utterly precise, what you had there would
>>> have been fine, but for simplicity, I'd rather just do a signed compare
>>> against -128.
>> The signed compare does not allow for mapcount overflow.  Is that acceptable?
>> False-positives would be benign for /proc/kpagecount though from a debug
>> perspective it could be helpful to see overflowed mapcounts.  Some future
>> caller would need separate consideration.
> Nobody seems terribly interested in mapcount overflows.  I got no response
> to https://lkml.org/lkml/2018/3/2/991

Okay.  Thanks for the background.

How about this, then:

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 50ce1bddaf56..39b4494e29f1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -669,6 +669,7 @@ static inline int TestClearPageDoubleMap(struct page *page)
 
 #define PAGE_TYPE_BASE    0xf0000000
 /* Reserve        0x0000007f to catch underflows of page_mapcount */
+#define PAGE_MAPCOUNT_RESERVE    -128
 #define PG_buddy    0x00000080
 #define PG_balloon    0x00000100
 #define PG_kmemcg    0x00000200
@@ -677,6 +678,11 @@ static inline int TestClearPageDoubleMap(struct page *page)
 #define PageType(page, flag)                        \
     ((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
+static inline int page_has_type(struct page *page)
+{
+    return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
+}
+
 #define PAGE_TYPE_OPS(uname, lname)                    \
 static __always_inline int Page##uname(struct page *page)        \
 {                                    \

