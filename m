Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C569CC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787EE213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZXkXgmkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787EE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbeGKWD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:03:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47896 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389475AbeGKWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:03:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BLrSaQ095363;
        Wed, 11 Jul 2018 21:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=72JwC1o0eJ/EFcoAeisDQIQI80euNhKG7S32svp5iGk=;
 b=ZXkXgmkmvZjp2WXG1eYWrMYDkljt9ZNV5UBm4u3lT1//oj9YREmuxI5eWkx/mjXDBX6p
 I51GJFTM+7nwxSKrmi/17+tfuvWgzVFlZUPjkOpLYfZPFGqvpzE9/owk9vRTixb6D9yH
 B5Q2yeb9Adcah0nm0KEPS/2Rv5YjSeHB2OxKTRmuTqkjWUq3jpgcJCdfX3s5xDJcI0jp
 uIWr9q5EsH+cen3FQYWLCY1mIPM0b1TZyVDoS6VIo13lcTg0gJpsm3XWsZXCjA1mJ026
 Th1bllG29REw4M05JMHlwvMPI0+SNGYZwwcO7AOulDlaGo3MdSaTRJGFBaVjGcU7z5Ol 5w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k2p7601pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 21:56:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6BLuvnj022423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 21:56:57 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6BLutR3020699;
        Wed, 11 Jul 2018 21:56:56 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 14:56:55 -0700
Subject: Re: [PATCH v2] mm: hugetlb: don't zero 1GiB bootmem pages.
To:     Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, dmatlack@google.com,
        gthelen@google.com, mhocko@kernel.org
References: <20180711213313.92481-1-cannonmatthews@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e04f64c8-37d3-bf81-29d2-c495844dd3a5@oracle.com>
Date:   Wed, 11 Jul 2018 14:56:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711213313.92481-1-cannonmatthews@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 02:33 PM, Cannon Matthews wrote:
> When using 1GiB pages during early boot, use the new
> memblock_virt_alloc_try_nid_raw() function to allocate memory without
> zeroing it.  Zeroing out hundreds or thousands of GiB in a single core
> memset() call is very slow, and can make early boot last upwards of
> 20-30 minutes on multi TiB machines.
> 
> The memory does not need to be zero'd as the hugetlb pages are always
> zero'd on page fault.
> 
> Tested: Booted with ~3800 1G pages, and it booted successfully in
> roughly the same amount of time as with 0, as opposed to the 25+
> minutes it would take before.
> 
> Signed-off-by: Cannon Matthews <cannonmatthews@google.com>

Thanks,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> ---
> v2: removed the memset of the huge_bootmem_page area and added
> INIT_LIST_HEAD instead.
> 
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3612fbb32e9d..488330f23f04 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2101,7 +2101,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
>  	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
>  		void *addr;
> 
> -		addr = memblock_virt_alloc_try_nid_nopanic(
> +		addr = memblock_virt_alloc_try_nid_raw(
>  				huge_page_size(h), huge_page_size(h),
>  				0, BOOTMEM_ALLOC_ACCESSIBLE, node);
>  		if (addr) {
> @@ -2119,6 +2119,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
>  found:
>  	BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
>  	/* Put them into a private list first because mem_map is not up yet */
> +	INIT_LIST_HEAD(&m->list);
>  	list_add(&m->list, &huge_boot_pages);
>  	m->hstate = h;
>  	return 1;
> --
> 2.18.0.203.gfac676dfb9-goog
> 
