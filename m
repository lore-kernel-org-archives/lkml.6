Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96402ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A567208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eV+PXiXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A567208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeIQHNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 03:13:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeIQHNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 03:13:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8H1jGWp097288;
        Mon, 17 Sep 2018 01:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nVDAIKKz+EZq3o+y3gXgLTp0ywp/xBSejYN224f8l5k=;
 b=eV+PXiXMIggzec91gSumh1U9sxNwynyfQPaY/55PO6RWMhADXXF40HL3iFm/7m5wp85B
 WQjsdOYQVUrmC1WFI+IDSv+y7LQZ0/zPkBMgWVpMF7ByHq5/IVfo5u/Jy7n/S20noq1i
 OiP1fq0aNoieljaM4MusnWFbIZ3+bvBspcyn3oMjVySV3+k26ndM0Zimmzzoe//7MoCh
 yoM0fsYt/M0XD8UCKspw+gYKEd1DK6eOB+6/ayzJzJyYBBnhRjfzRaNt8+qoft9CAt8b
 V8iWPz30FyTGl1gvbd//LAU7MKlod59LQjioRXf3cmmPLeTxc5GmPGBKWOn5mEiiWtNw og== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mgt1pbgrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 01:48:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8H1mAFF025726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 01:48:10 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8H1mAhe002701;
        Mon, 17 Sep 2018 01:48:10 GMT
Received: from [10.182.70.168] (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 18:48:09 -0700
Subject: Re: [Xen-devel] [PATCH 2/6] xenbus: implement the xenwatch
 multithreading framework
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-3-git-send-email-dongli.zhang@oracle.com>
 <affabca4-0683-f088-7b25-d239ff882fa0@oracle.com>
Cc:     jgross@suse.com, wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, paul.durrant@citrix.com,
        roger.pau@citrix.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <1443a6e8-0a94-6081-b1c6-1f426bbaea38@oracle.com>
Date:   Mon, 17 Sep 2018 09:48:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <affabca4-0683-f088-7b25-d239ff882fa0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 09/17/2018 05:20 AM, Boris Ostrovsky wrote:
> 
> 
> On 9/14/18 3:34 AM, Dongli Zhang wrote:
>>
>> +
>> +/* Running in the context of default xenwatch kthread. */
>> +void mtwatch_create_domain(domid_t domid)
>> +{
>> +    struct mtwatch_domain *domain;
>> +
>> +    if (!domid) {
>> +        pr_err("Default xenwatch thread is for dom0\n");
>> +        return;
>> +    }
>> +
>> +    spin_lock(&mtwatch_info->domain_lock);
>> +
>> +    domain = mtwatch_find_domain(domid);
>> +    if (domain) {
>> +        atomic_inc(&domain->refcnt);
>> +        spin_unlock(&mtwatch_info->domain_lock);
>> +        return;
>> +    }
>> +
>> +    domain = kzalloc(sizeof(*domain), GFP_ATOMIC);
> 
> Is there a reason (besides this being done under spinlock) for using GFP_ATOMIC?
> If domain_lock is the only reason I'd probably drop the lock and do GFP_KERNEL.

spin_lock is the reason.

Would you like to switch to a mutex here?

> 
> 
>> +    if (!domain) {
>> +        spin_unlock(&mtwatch_info->domain_lock);
>> +        pr_err("Failed to allocate memory for mtwatch thread %d\n",
>> +               domid);
>> +        return;
> 
> This needs to return an error code, I think. Or do you want to fall back to
> shared xenwatch thread?

We would fall back to the shared default xenwatch thread. As in [PATCH 3/6], the
event is dispatched to the shared xenwatch thread if the per-domU one is not
available.

> 
> 
>> +    }
>> +
>> +    domain->domid = domid;
>> +    atomic_set(&domain->refcnt, 1);
>> +    mutex_init(&domain->domain_mutex);
>> +    INIT_LIST_HEAD(&domain->purge_node);
>> +
>> +    init_waitqueue_head(&domain->events_wq);
>> +    spin_lock_init(&domain->events_lock);
>> +    INIT_LIST_HEAD(&domain->events);
>> +
>> +    list_add_tail_rcu(&domain->list_node, &mtwatch_info->domain_list);
>> +
>> +    hlist_add_head_rcu(&domain->hash_node,
>> +               &mtwatch_info->domain_hash[MTWATCH_HASH(domid)]);
>> +
>> +    spin_unlock(&mtwatch_info->domain_lock);
>> +
>> +    domain->task = kthread_run(mtwatch_thread, domain,
>> +                   "xen-mtwatch-%d", domid);
>> +
>> +    if (!domain->task) {
>> +        pr_err("mtwatch kthread creation is failed\n");
>> +        domain->state = MTWATCH_DOMAIN_DOWN;
> 
> 
> Why not clean up right here?

I used to think there might be a race between mtwatch_create_domain() and
mtwatch_put_domain().

Just realized the race is impossible. I will clean up here.

> 
>> +
>> +        return;
>> +    }
>> +
>> +    domain->state = MTWATCH_DOMAIN_UP;
>> +}
>> +
> 
> 
>> +
>>   void unregister_xenbus_watch(struct xenbus_watch *watch)
>>   {
>>       struct xs_watch_event *event, *tmp;
>> @@ -831,6 +1100,9 @@ void unregister_xenbus_watch(struct xenbus_watch *watch)
>>         if (current->pid != xenwatch_pid)
>>           mutex_unlock(&xenwatch_mutex);
>> +
>> +    if (xen_mtwatch && watch->get_domid)
>> +        unregister_mtwatch(watch);
> 
> 
> I may not be understanding the logic flow here, but if we successfully
> removed/unregistered/purged the watch from mtwatch lists, do we still need to
> try removing it from watch_events list below?

Part of original unregister_xenbus_watch() has already removed the pending
events from watch_events before the above added lines of code.


Dongli Zhang

> 
> 
> -boris
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
