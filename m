Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004BBECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0520873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K8oubajf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB0520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeGMNkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:40:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48354 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeGMNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:40:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DDOoeV093381;
        Fri, 13 Jul 2018 13:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=l3/b+Pvi2ofYgihBFaw4HB+3egkpOR0AmvAi4OKvAbA=;
 b=K8oubajfgI9/lHPIA8gg6WfNNYh5w5Wh4RfDeZ9tG4JxS1H0lHAxUZuj8JZ1rmOjjDqZ
 PC4AWLoHLMmlut1gcLO4p/6imcvCdUZt0b7/r+FKBQOSmlYyq6S48hoB0ZsBIJ1XXIOU
 /OYOY7nzrp+5j+UGR7UPnYwzcSRhetNQ5j+XaEAqYC6fY9r98eWvgf5cUlRfTe97UR0u
 fJYbjODtMl90+HEBmpwvVLswjN4Rm7NHrxenEqsoOFrUL4nahKBm+rfjGPcKyZaYQtU+
 6DDTbc6K4c+8OrQoNDwIXyPJsn5x+UhDDR06j/+K+M+yGLiAYBlk+rUmUFFj2nO1jrgS Iw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7e7u13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 13:24:50 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DDOnFR014613
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 13:24:49 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6DDOloR022855;
        Fri, 13 Jul 2018 13:24:47 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 06:24:47 -0700
Subject: Re: [PATCH v5 1/5] mm/sparse: abstract sparse buffer allocations
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
 <20180712203730.8703-2-pasha.tatashin@oracle.com>
 <20180713131749.GA16765@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <23f6e4e5-6e32-faf6-433d-67e50d2895a2@oracle.com>
Date:   Fri, 13 Jul 2018 09:24:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713131749.GA16765@techadventures.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/13/2018 09:17 AM, Oscar Salvador wrote:
> On Thu, Jul 12, 2018 at 04:37:26PM -0400, Pavel Tatashin wrote:
>> +static void *sparsemap_buf __meminitdata;
>> +static void *sparsemap_buf_end __meminitdata;
>> +
>> +void __init sparse_buffer_init(unsigned long size, int nid)
>> +{
>> +	BUG_ON(sparsemap_buf);
> 
> Why do we need a BUG_ON() here?
> Looking at the code I cannot really see how we can end up with sparsemap_buf being NULL.
> Is it just for over-protection?

This checks that we do not accidentally leak memory by calling sparse_buffer_init() consequently without sparse_buffer_fini() in-between.

> 
>> +	sparsemap_buf =
>> +		memblock_virt_alloc_try_nid_raw(size, PAGE_SIZE,
>> +						__pa(MAX_DMA_ADDRESS),
>> +						BOOTMEM_ALLOC_ACCESSIBLE, nid);
> 
> In your previous version, you didn't pass a required alignment when setting up sparsemap_buf.
> size is already PMD_SIZE aligned, do we need to align it also to PAGE_SIZE?
> 

I decided to add PAGE_SIZE alignment, because the implicit memblock alignment is SMP_CACHE_BYTES which is smaller than page size. While, in practice we will most likely get a page size aligned allocation, it is still possible that some ranges in memblock are not page size aligned if that the way they were passed from BIOS.

Thank you,
Pavel
