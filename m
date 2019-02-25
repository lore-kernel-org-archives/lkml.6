Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4677C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15E421019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lNszA5h6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfBYApk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 19:45:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52544 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBYApk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 19:45:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1P0jNAW088517;
        Mon, 25 Feb 2019 00:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1UyzmN6PlA6lNPpRtjTq2Mc1IMVKRlpMlMcplmQTU84=;
 b=lNszA5h6t70w9zFrLZ3sLEbbRnCxk1LwiqFgY59aCo90OlDl/gJZUiq/TcV5oKaJBQqw
 qEPILWtWW5ci0/Than6Vi0ciSytGbO0KjVFuuWfocNIoXsAmC2Vr7AwGflMjbY904EWk
 bgeuK4lrHswY9AshAaDbNKFJCKwvor1j+G+R7JTibnHBqu7NhmGlMMc/ODw8t2vG1/F/
 bef4CrQWrw8RPhyefwSdeM0QgK4abKni8MwfzLuAf9H/zSql8D7Am+fHLzPOQTJT6IJz
 /fcXI0ml3AW0uP/6+l2f9t5+kOxLjZdFYB6QTr0pDBM3lTCegsfwVE/jfz2z9BKlKavf iw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qtwktu9qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 00:45:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1P0jHrw023307
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 00:45:17 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1P0jGw7015779;
        Mon, 25 Feb 2019 00:45:16 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Feb 2019 16:45:16 -0800
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, mhocko@kernel.org
Cc:     akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        n-horiguchi@ah.jp.nec.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
Date:   Sun, 24 Feb 2019 16:45:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9177 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902250004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 5:32 PM, Jing Xiangfeng wrote:
> User can change a node specific hugetlb count. i.e.
> /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
> the calculated value of count is a total number of huge pages. It could
> be overflow when a user entering a crazy high value. If so, the total
> number of huge pages could be a small value which is not user expect.
> We can simply fix it by setting count to ULONG_MAX, then it goes on. This
> may be more in line with user's intention of allocating as many huge pages
> as possible.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Thank you.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

> ---
>  mm/hugetlb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index afef616..6688894 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2423,7 +2423,14 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  		 * per node hstate attribute: adjust count to global,
>  		 * but restrict alloc/free to the specified node.
>  		 */
> +		unsigned long old_count = count;
>  		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> +		/*
> +		 * If user specified count causes overflow, set to
> +		 * largest possible value.
> +		 */
> +		if (count < old_count)
> +			count = ULONG_MAX;
>  		init_nodemask_of_node(nodes_allowed, nid);
>  	} else
>  		nodes_allowed = &node_states[N_MEMORY];
> 
