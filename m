Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54328ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004B8208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qUMflpuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004B8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeGPReG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:34:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58786 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeGPReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:34:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GH4QbP170638;
        Mon, 16 Jul 2018 17:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JeAWFoBHujPrj/LK7QeecN9lteDNR8wEEaUxkdNWl1o=;
 b=qUMflpuT5zE6mypALkZrOecwSRfIL7143ZRxpBbW6aL76WQNDeNGPVppNn4uD8S9Bw9w
 tKJEz5c/H7mYzgcrYWQZa0ZJ6oUAtUyBHFCgngtyTBdUBOuF5D5yius+FXPVTw6+UehW
 Xqq/LLi+87bxOd8HJANe/y1DrfXmENuwM7Xtko5PU/NZL+i4C+DIkLQpwQphFQEzAQQ1
 /r7nkp5DMY/PIUScbaZO11NTIMKyxS23JpIeNrUk3ZBZIkCR/ERaRQwq2Vr0WBXeA4j5
 DgJqCpN8v7uo3whY87w3H51vH8uqUcceO63FrVxyooE7FdOXRWBRpbOBgCKf1IusKS/N eA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k7a33wbsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:05:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6GH5d1P012871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:05:39 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6GH5cFs016582;
        Mon, 16 Jul 2018 17:05:38 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 10:05:38 -0700
Subject: Re: [PATCH] mm: don't do zero_resv_unavail if memmap is not allocated
To:     Michal Hocko <mhocko@kernel.org>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org
References: <20180716151630.770-1-pasha.tatashin@oracle.com>
 <20180716160956.GW17280@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <4a4bd630-94f1-ab0b-6516-0955de9b0281@oracle.com>
Date:   Mon, 16 Jul 2018 13:05:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716160956.GW17280@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=761
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/16/2018 12:09 PM, Michal Hocko wrote:
> On Mon 16-07-18 11:16:30, Pavel Tatashin wrote:
>> Moving zero_resv_unavail before memmap_init_zone(), caused a regression on
>> x86-32.
>>
>> The cause is that we access struct pages before they are allocated when
>> CONFIG_FLAT_NODE_MEM_MAP is used.
>>
>> free_area_init_nodes()
>>   zero_resv_unavail()
>>     mm_zero_struct_page(pfn_to_page(pfn)); <- struct page is not alloced
>>   free_area_init_node()
>>     if CONFIG_FLAT_NODE_MEM_MAP
>>       alloc_node_mem_map()
>>         memblock_virt_alloc_node_nopanic() <- struct page alloced here
>>
>> On the other hand memblock_virt_alloc_node_nopanic() zeroes all the memory
>> that it returns, so we do not need to do zero_resv_unavail() here.
> 
> This all is subtle as hell and almost impossible to build a sane code on
> top. Your patch sounds good as a stop gap fix but we really need
> something resembling an actual design rather than ad-hoc hacks piled on
> top of each other.z

I totally agree, I started working on figuring out how to simply and improve memmap_init_zone(). But part of the mess is that we simply have too many memmap layouts. We must start removing some of them. But, that also requires an analysis of how to unify them.

> 
>> Fixes: e181ae0c5db9 ("mm: zero unavailable pages before memmap init")
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Thank you.

Pavel
