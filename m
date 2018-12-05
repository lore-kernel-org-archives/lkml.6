Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C8FC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992720834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kXwZRL4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6992720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeLEBQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:16:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58624 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeLEBQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:16:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB519IEW063573;
        Wed, 5 Dec 2018 01:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0aXiIvgY0Uh6JraVuiK9RzsJTErkcfI8NN7T6LaBhfo=;
 b=kXwZRL4x6H/O1eRgwdNlg85W15Ri/k8zm/uHxuAXsRXczr52Zn2UmzuqJ2Muyz+Jxejn
 0yQmssSIVlGfKs+g+bZ4dPQD1lrF4oum967H6uQYDLegmIcAC8gkBeOZX1Iqn7yELRNB
 KOwN9qfgigsLijNwDmHMvrOBoc0IBpjAE4ggGH8oA42fxG463/EIGhmOuMgJzUHpTVc5
 yqOHpLjeJqMx0UOSspJEMKaMMu9RY+s53hh+9mFYF7ghYg4IxN7hQssrDPW92D3c07/X
 0W81JIuuZTPyu4HsReNAMt3ks1KZq0R3jL5W+cf89AFmqOWfmKa4NGbHSjyMIbjorjtm JQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2p3ftf3mta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 01:15:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB51Fiaa030611
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 01:15:44 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB51FhcR028012;
        Wed, 5 Dec 2018 01:15:44 GMT
Received: from [10.39.243.186] (/10.39.243.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 17:15:43 -0800
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
From:   anthony.yznaga@oracle.com
Organization: Oracle Corporation
Message-ID: <fa5b667d-ccfb-b11a-2aeb-b1007651f9ec@oracle.com>
Date:   Tue, 4 Dec 2018 17:18:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205004836.GU10377@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2018 04:48 PM, Matthew Wilcox wrote:
> On Tue, Dec 04, 2018 at 02:45:26PM -0800, Anthony Yznaga wrote:
>> Certain pages that are never mapped to userspace have a type
>> indicated in the page_type field of their struct pages (e.g. PG_buddy).
>> page_type overlaps with _mapcount so set the count to 0 and avoid
>> calling page_mapcount() for these pages.
>>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>  fs/proc/page.c             | 2 +-
>>  include/linux/page-flags.h | 7 +++++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index 6c517b11acf8..40b05e0d4274 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -46,7 +46,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>  			ppage = pfn_to_page(pfn);
>>  		else
>>  			ppage = NULL;
>> -		if (!ppage || PageSlab(ppage))
>> +		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
>>  			pcount = 0;
>>  		else
>>  			pcount = page_mapcount(ppage);
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 50ce1bddaf56..f9a1c50ccefc 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -673,10 +673,17 @@ static inline int TestClearPageDoubleMap(struct page *page)
>>  #define PG_balloon	0x00000100
>>  #define PG_kmemcg	0x00000200
>>  #define PG_table	0x00000400
>> +#define PAGE_TYPE_ALL	(PG_buddy | PG_balloon | PG_kmemcg | PG_table)
>>  
>>  #define PageType(page, flag)						\
>>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>>  
>> +static inline int page_has_type(struct page *page)
>> +{
>> +	return (PageType(page, 0) &&
>> +	       ((page->page_type & PAGE_TYPE_ALL) != PAGE_TYPE_ALL));
>> +}
>> +
>>  #define PAGE_TYPE_OPS(uname, lname)					\
> I think this is a bit complex, and a bit of a pain to update as we add
> new page types.  How about this?
>
> 	return (int)page_type < -128;
>
> (I'm open to appropriate #defines to make this more obvious that it's ~0x7F)


I thought about having this:

#define PAGE_TYPE_END    0xffffff80

static int inline page_has_type(struct page *page)
{
    return page->page_type > PAGE_TYPE_BASE &&
           page->page_type < PAGE_TYPE_END;
}

But I opted for the additional complexity to avoid more false-positives from
possibly corrupted values.  I'm certainly fine with a simple approach, though.


