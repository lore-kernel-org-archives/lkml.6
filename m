Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD992ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AC92087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K3hpNigf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AC92087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeIQBlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:41:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbeIQBlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:41:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8GKGoOi083620;
        Sun, 16 Sep 2018 20:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=4aBR/M3WX1Dv1Vg2EiesVAiCT7RPPZEYf0MOpXnZXpg=;
 b=K3hpNigfZZIPcbAP9lPNzxRPidcWZbmkxLrv5UuPRUw/Wzqk8aA8qTh2nKQhF/nzMTM1
 7K/qNw12ysUypoyPff3MEUfXim96VTCGauiDW5WHOThmFseIZV8HcWF6/0z8MVaWeTy0
 FUtiO0UPJDzNMHbRKHaLMTxXMXk2Kr6CpNpElmSVdZK/fkeZrviV47Yx1ePEAAw+0Jy5
 VRNCZYwBBIF5vmjbo4ThBrO0r5fD1MZbhJUcYN4d965/8mm4B1FJpww9VzvQRbIV+iql
 DbBo4tyqXP2GWP42nSTBcJJJn7/bRJ22UoZyGxy+mcE1MikfZ3/ZAjAOHntV8k5hVMNo Vw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mgsgtb681-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Sep 2018 20:17:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8GKHdan025498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Sep 2018 20:17:39 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8GKHb5t027469;
        Sun, 16 Sep 2018 20:17:38 GMT
Received: from nat-wireless-guest-reg-153-50.bu.edu (/204.8.153.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 13:17:37 -0700
Subject: Re: [PATCH 1/6] xenbus: prepare data structures and parameter for
 xenwatch multithreading
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <04d7dee9-3011-512a-09b0-0e8dcbdd99d6@oracle.com>
Date:   Sun, 16 Sep 2018 16:17:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=675
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809160218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/18 3:34 AM, Dongli Zhang wrote:

> +
> +struct mtwatch_info {
> +	/*
> +	 * The mtwatch_domain is put on both a hash table and a list.
> +	 * domain_list is used to optimize xenbus_watch un-registration.
> +	 *
> +	 * The mtwatch_domain is removed from domain_hash (with state set
> +	 * to MTWATCH_DOMAIN_DOWN) when its refcnt is zero. However, it is
> +	 * left on domain_list until all events belong to such
> +	 * mtwatch_domain are processed in mtwatch_thread().


Do we really need to keep mwatch_domain on both lists? Why is keeping it 
on, say, only the hash not sufficient?

> +	 *
> +	 * While there may exist two mtwatch_domain with the same domid on
> +	 * domain_list simultaneously,


How is it possible to have two domids on the list at the same time? 
Don't you want to remove it (which IIUIC means moving it to the purge 
list) when domain is destroyed?


-boris


> +      *  all mtwatch_domain on hash_hash
> +	 * should have unique domid.
> +	 */
> +	spinlock_t domain_lock;
> +	struct hlist_head domain_hash[MTWATCH_HASH_SIZE];
> +	struct list_head domain_list;
> +
> +	/*
> +	 * When a per-domU kthread is going to be destroyed, it is put
> +	 * on the purge_list, and will be flushed by purge_work later.
> +	 */
> +	struct work_struct purge_work;
> +	spinlock_t purge_lock;
> +	struct list_head purge_list;
> +};


