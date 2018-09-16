Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0C5ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 21:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992A42086E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 21:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="daS5wwZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992A42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeIQCol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 22:44:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeIQCol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 22:44:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8GLK3dX119363;
        Sun, 16 Sep 2018 21:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ETwqVvGswvdT+adpxWr3sKjbjSiLWbb1+ZaN+EhkIeo=;
 b=daS5wwZf04llqQs4xtvd8gg9XE7cDGH632362iC4HcR+67DA4f1Orpk5tIaqfznC3iRM
 7e4uu8UBJu0ogkwZKOXylmaOmv1ZZ7ULZQG7ZxJOaoYk2O5DQ27o5nPGuqFPrih9LPBT
 XjXZJzA/E1/IT4mB5wZbCQTUaGSiFWRdOb8qt2c47iH7D84+LoHTQBNzMCoryBfGupLX
 Q2R3t11umeEQPjhjjWXJ8RnnC5vWcPRTnto2QsEPuKyr2jV/N2qajNGAS+Ic4eDRlJSO
 oWXhZzOhJwjHL0OZCi0MnjUhEHfUSGQqf7TNqQXNp7pvaWM4YZKk8qtc8FyqDFhGbgxA jA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mgsgtb7u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Sep 2018 21:20:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8GLK9Pk000697
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Sep 2018 21:20:09 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8GLK7en012201;
        Sun, 16 Sep 2018 21:20:07 GMT
Received: from nat-wireless-guest-reg-153-50.bu.edu (/204.8.153.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 14:20:07 -0700
Subject: Re: [PATCH 2/6] xenbus: implement the xenwatch multithreading
 framework
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-3-git-send-email-dongli.zhang@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <affabca4-0683-f088-7b25-d239ff882fa0@oracle.com>
Date:   Sun, 16 Sep 2018 17:20:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536910456-13337-3-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809160229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/18 3:34 AM, Dongli Zhang wrote:
>
> +
> +/* Running in the context of default xenwatch kthread. */
> +void mtwatch_create_domain(domid_t domid)
> +{
> +	struct mtwatch_domain *domain;
> +
> +	if (!domid) {
> +		pr_err("Default xenwatch thread is for dom0\n");
> +		return;
> +	}
> +
> +	spin_lock(&mtwatch_info->domain_lock);
> +
> +	domain = mtwatch_find_domain(domid);
> +	if (domain) {
> +		atomic_inc(&domain->refcnt);
> +		spin_unlock(&mtwatch_info->domain_lock);
> +		return;
> +	}
> +
> +	domain = kzalloc(sizeof(*domain), GFP_ATOMIC);

Is there a reason (besides this being done under spinlock) for using 
GFP_ATOMIC? If domain_lock is the only reason I'd probably drop the lock 
and do GFP_KERNEL.


> +	if (!domain) {
> +		spin_unlock(&mtwatch_info->domain_lock);
> +		pr_err("Failed to allocate memory for mtwatch thread %d\n",
> +		       domid);
> +		return;

This needs to return an error code, I think. Or do you want to fall back 
to shared xenwatch thread?


> +	}
> +
> +	domain->domid = domid;
> +	atomic_set(&domain->refcnt, 1);
> +	mutex_init(&domain->domain_mutex);
> +	INIT_LIST_HEAD(&domain->purge_node);
> +
> +	init_waitqueue_head(&domain->events_wq);
> +	spin_lock_init(&domain->events_lock);
> +	INIT_LIST_HEAD(&domain->events);
> +
> +	list_add_tail_rcu(&domain->list_node, &mtwatch_info->domain_list);
> +
> +	hlist_add_head_rcu(&domain->hash_node,
> +			   &mtwatch_info->domain_hash[MTWATCH_HASH(domid)]);
> +
> +	spin_unlock(&mtwatch_info->domain_lock);
> +
> +	domain->task = kthread_run(mtwatch_thread, domain,
> +				   "xen-mtwatch-%d", domid);
> +
> +	if (!domain->task) {
> +		pr_err("mtwatch kthread creation is failed\n");
> +		domain->state = MTWATCH_DOMAIN_DOWN;


Why not clean up right here?

> +
> +		return;
> +	}
> +
> +	domain->state = MTWATCH_DOMAIN_UP;
> +}
> +


> +
>   void unregister_xenbus_watch(struct xenbus_watch *watch)
>   {
>   	struct xs_watch_event *event, *tmp;
> @@ -831,6 +1100,9 @@ void unregister_xenbus_watch(struct xenbus_watch *watch)
>   
>   	if (current->pid != xenwatch_pid)
>   		mutex_unlock(&xenwatch_mutex);
> +
> +	if (xen_mtwatch && watch->get_domid)
> +		unregister_mtwatch(watch);


I may not be understanding the logic flow here, but if we successfully 
removed/unregistered/purged the watch from mtwatch lists, do we still 
need to try removing it from watch_events list below?


-boris

