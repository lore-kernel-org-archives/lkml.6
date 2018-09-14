Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6101AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B916D20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gK34HtwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B916D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeINTY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:24:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41564 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeINTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:24:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EE8vuJ076666;
        Fri, 14 Sep 2018 14:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bV3gYQ+1KbT569/eYbLTP+lOdrk4DX5LwqDaXJ6HnpQ=;
 b=gK34HtwZE7tLNAlE72hWZGpOZP7LUPzxsElrTjsWsHCwIAApWGXg0pIo/9GOjVBHpR3s
 Hwkbb23iKYMmUgJnaMOgHnG4UKTYDytY+HJa4LrRBigB59iYoVL0BME+NvhGmVG6EvcM
 nyPVyuUc4MocYbEQxJ35VlAHg6blNDKXAlsRtLSe5u0NIRTCEBGnAGMITm9VC8ivA76X
 ScVk5xEyOegBqjhHNtTOjtVVi0MWC8qRagOqxl3A3Vj0OP3reO0QRylmKImJ3BGc87EJ
 q/ICswiuYC02aKcUxayFRXC0RlOJOJr7vhJNdYa/gPF/IJZKzXZKlc9JqZd2DqdfBanE 3w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mc6cq7b6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 14:10:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8EEA875022331
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 14:10:08 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8EEA893018985;
        Fri, 14 Sep 2018 14:10:08 GMT
Received: from [10.191.8.88] (/10.191.8.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:10:07 -0700
Subject: Re: [Xen-devel] [PATCH 2/6] xenbus: implement the xenwatch
 multithreading framework
To:     Paul Durrant <Paul.Durrant@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-3-git-send-email-dongli.zhang@oracle.com>
 <b91c5619ab594a5c977a4f8e7f03096e@AMSPEX02CL03.citrite.net>
Cc:     "jgross@suse.com" <jgross@suse.com>, Wei Liu <wei.liu2@citrix.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "srinivas.eeda@oracle.com" <srinivas.eeda@oracle.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <5a795263-f9a1-015b-685d-bda61c6bcdc5@oracle.com>
Date:   Fri, 14 Sep 2018 22:09:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <b91c5619ab594a5c977a4f8e7f03096e@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/2018 04:45 PM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Dongli Zhang [mailto:dongli.zhang@oracle.com]
>> Sent: 14 September 2018 08:34
>> To: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org
>> Cc: boris.ostrovsky@oracle.com; jgross@suse.com; Paul Durrant
>> <Paul.Durrant@citrix.com>; Wei Liu <wei.liu2@citrix.com>;
>> konrad.wilk@oracle.com; Roger Pau Monne <roger.pau@citrix.com>;
>> srinivas.eeda@oracle.com
>> Subject: [PATCH 2/6] xenbus: implement the xenwatch multithreading
>> framework
>>
>> This is the 2nd patch of a (6-patch) patch set.
>>
>> This patch implements the xenwatch multithreading framework to create or
>> destroy the per-domU xenwatch thread. The xenwatch thread is created or
>> destroyed during xenbus device probing or removing (that is,
>> xenbus_dev_probe() or xenbus_dev_remove()) if the corresponding pv driver
>> has xenwatch multithreading feature enabled. As there is only one single
>> per-domU xenwatch thread for each domid, probing the xenbus device for the
>> same domid again would not create the thread for the same domid again, but
>> only increment the reference count of the thread's mtwatch domain. When a
>> xenbus device is removed, the reference count is decremented. The per-domU
>> xenwatch thread is destroyed when the reference count of its mtwatch
>> domain
>> is zero, that is, al xenbus devices (whose mtwatch feature is enabled) of
>> such mtwatch domain are removed.
>>
>> Therefore, a domid has its own per-domU xenwatch thread only when it is
>> attached with dom0 backend xenbus device whose pv driver has the feature
>> enabled. The domid would not have its own xenwatch thread when it is not
>> running any mtwatch-enabled xenbus device.
>>
>> When a watch (with xenwatch multithreading enabled) is unregistered, we
>> will generally traverse all mtwatch domains to remove all inflight pending
>> events fired by such watch. However, one optimization in this patch is we
>> only need to remove pending events from a specific mtwatch domain when the
>> watch is registered for a specific domid, that is, when its owner_id field
>> is non-zero.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  drivers/xen/xenbus/xenbus_probe.c |   6 +
>>  drivers/xen/xenbus/xenbus_xs.c    | 273
>> ++++++++++++++++++++++++++++++++++++++
>>  include/xen/xenbus.h              |   3 +
>>  3 files changed, 282 insertions(+)
>>
>> diff --git a/drivers/xen/xenbus/xenbus_probe.c
>> b/drivers/xen/xenbus/xenbus_probe.c
>> index 5b47188..5755596 100644
>> --- a/drivers/xen/xenbus/xenbus_probe.c
>> +++ b/drivers/xen/xenbus/xenbus_probe.c
>> @@ -236,6 +236,9 @@ int xenbus_dev_probe(struct device *_dev)
>>  	if (err)
>>  		goto fail;
>>
>> +	if (xen_mtwatch && drv->use_mtwatch)
>> +		mtwatch_create_domain(dev->otherend_id);
> 
> mtwatch_get_domain()? (Since you have mtwatch_put_domain() below).
> 
>> +
>>  	err = watch_otherend(dev);
>>  	if (err) {
>>  		dev_warn(&dev->dev, "watch_otherend on %s failed.\n",
>> @@ -263,6 +266,9 @@ int xenbus_dev_remove(struct device *_dev)
>>  	if (drv->remove)
>>  		drv->remove(dev);
>>
>> +	if (xen_mtwatch && drv->use_mtwatch)
>> +		mtwatch_put_domain(dev->otherend_id);
>> +
>>  	free_otherend_details(dev);
>>
>>  	xenbus_switch_state(dev, XenbusStateClosed);
>> diff --git a/drivers/xen/xenbus/xenbus_xs.c
>> b/drivers/xen/xenbus/xenbus_xs.c
>> index 3f137d2..741dc54 100644
>> --- a/drivers/xen/xenbus/xenbus_xs.c
>> +++ b/drivers/xen/xenbus/xenbus_xs.c
>> @@ -108,6 +108,201 @@ static __init int xen_parse_mtwatch(char *arg)
>>  }
>>  early_param("xen_mtwatch", xen_parse_mtwatch);
>>
>> +struct mtwatch_domain *mtwatch_find_domain(domid_t domid)
>> +{
>> +	struct mtwatch_domain *domain;
>> +	int hash = MTWATCH_HASH(domid);
>> +	struct hlist_head *hash_head = &mtwatch_info->domain_hash[hash];
>> +
>> +	hlist_for_each_entry_rcu(domain, hash_head, hash_node) {
>> +		if (domain->domid == domid)
>> +			return domain;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/* per-domU thread for xenwatch multithreading. */
>> +static int mtwatch_thread(void *arg)
>> +{
>> +	struct mtwatch_domain *domain = (struct mtwatch_domain *) arg;
>> +	struct list_head *ent;
>> +	struct xs_watch_event *event;
>> +
>> +	domain->pid = current->pid;
>> +
>> +	for (;;) {
>> +		wait_event_interruptible(domain->events_wq,
>> +					 !list_empty(&domain->events) ||
>> +					 domain->state == MTWATCH_DOMAIN_DOWN);
>> +
>> +		if (domain->state == MTWATCH_DOMAIN_DOWN &&
>> +		    list_empty(&domain->events))
>> +			break;
>> +
>> +		mutex_lock(&domain->domain_mutex);
>> +
>> +		spin_lock(&domain->events_lock);
>> +		ent = domain->events.next;
>> +		if (ent != &domain->events)
>> +			list_del(ent);
>> +		spin_unlock(&domain->events_lock);
>> +
>> +		if (ent != &domain->events) {
>> +			event = list_entry(ent, struct xs_watch_event, list);
>> +			event->handle->callback(event->handle, event->path,
>> +						event->token);
>> +			kfree(event);
>> +		}
>> +
>> +		mutex_unlock(&domain->domain_mutex);
>> +	}
>> +
>> +	/*
>> +	 * domain->state is already set to MTWATCH_DOMAIN_DOWN (to avoid
>> +	 * new event to domain->events) when above for loop breaks, so
>> +	 * that there is no requirement to cleanup domain->events again.
>> +	 */
>> +
>> +	spin_lock(&mtwatch_info->domain_lock);
>> +	list_del_rcu(&domain->list_node);
>> +	spin_unlock(&mtwatch_info->domain_lock);
>> +
>> +	spin_lock(&mtwatch_info->purge_lock);
>> +	list_add(&domain->purge_node, &mtwatch_info->purge_list);
>> +	spin_unlock(&mtwatch_info->purge_lock);
>> +
>> +	schedule_work(&mtwatch_info->purge_work);
>> +
>> +	return 0;
>> +}
>> +
>> +static void delayed_destroy_domain(struct rcu_head *head)
>> +{
>> +	struct mtwatch_domain *domain;
>> +
>> +	domain = container_of(head, struct mtwatch_domain, rcu);
>> +	kfree(domain);
>> +}
>> +
>> +static void xen_mtwatch_purge_domain(struct work_struct *work)
>> +{
>> +	struct mtwatch_domain *domain;
>> +	struct list_head *node;
>> +
>> +	while (!list_empty(&mtwatch_info->purge_list)) {
>> +
>> +		spin_lock(&mtwatch_info->purge_lock);
>> +		node = mtwatch_info->purge_list.next;
>> +		if (node != &mtwatch_info->purge_list)
>> +			list_del(node);
>> +		spin_unlock(&mtwatch_info->purge_lock);
>> +
>> +		if (node != &mtwatch_info->purge_list) {
>> +			domain = list_entry(node, struct mtwatch_domain,
>> +					    purge_node);
>> +			kthread_stop(domain->task);
>> +
>> +			call_rcu(&domain->rcu, delayed_destroy_domain);
>> +		}
>> +	}
>> +}
>> +
>> +/* Running in the context of default xenwatch kthread. */
>> +void mtwatch_create_domain(domid_t domid)
>> +{
>> +	struct mtwatch_domain *domain;
>> +
>> +	if (!domid) {
>> +		pr_err("Default xenwatch thread is for dom0\n");
>> +		return;
>> +	}
>> +
>> +	spin_lock(&mtwatch_info->domain_lock);
>> +
>> +	domain = mtwatch_find_domain(domid);
>> +	if (domain) {
>> +		atomic_inc(&domain->refcnt);
>> +		spin_unlock(&mtwatch_info->domain_lock);
>> +		return;
>> +	}
>> +
>> +	domain = kzalloc(sizeof(*domain), GFP_ATOMIC);
>> +	if (!domain) {
>> +		spin_unlock(&mtwatch_info->domain_lock);
>> +		pr_err("Failed to allocate memory for mtwatch thread %d\n",
>> +		       domid);
>> +		return;
>> +	}
>> +
>> +	domain->domid = domid;
>> +	atomic_set(&domain->refcnt, 1);
>> +	mutex_init(&domain->domain_mutex);
>> +	INIT_LIST_HEAD(&domain->purge_node);
>> +
>> +	init_waitqueue_head(&domain->events_wq);
>> +	spin_lock_init(&domain->events_lock);
>> +	INIT_LIST_HEAD(&domain->events);
>> +
>> +	list_add_tail_rcu(&domain->list_node, &mtwatch_info->domain_list);
>> +
>> +	hlist_add_head_rcu(&domain->hash_node,
>> +			   &mtwatch_info->domain_hash[MTWATCH_HASH(domid)]);
>> +
>> +	spin_unlock(&mtwatch_info->domain_lock);
>> +
>> +	domain->task = kthread_run(mtwatch_thread, domain,
>> +				   "xen-mtwatch-%d", domid);
>> +
>> +	if (!domain->task) {
>> +		pr_err("mtwatch kthread creation is failed\n");
>> +		domain->state = MTWATCH_DOMAIN_DOWN;
>> +
>> +		return;
>> +	}
>> +
>> +	domain->state = MTWATCH_DOMAIN_UP;
>> +}
>> +
>> +/* Running in the context of default xenwatch kthread. */
>> +void mtwatch_put_domain(domid_t domid)
>> +{
>> +	struct mtwatch_domain *domain;
>> +
>> +	spin_lock(&mtwatch_info->domain_lock);
>> +
>> +	domain = mtwatch_find_domain(domid);
>> +	if (!domain) {
>> +		spin_unlock(&mtwatch_info->domain_lock);
>> +		pr_err("mtwatch kthread for domid=%d does not exist\n",
>> +		       domid);
>> +		return;
>> +	}
>> +
>> +	if (atomic_dec_and_test(&domain->refcnt)) {
>> +
>> +		hlist_del_rcu(&domain->hash_node);
>> +
>> +		if (!domain->task) {
>> +			/*
>> +			 * As the task is failed to initialize during
>> +			 * mtwatch_create_domain(), we do not need to wait
>> +			 * for the kernel thread to complete.
>> +			 */
>> +			list_del_rcu(&domain->list_node);
>> +			call_rcu(&domain->rcu, delayed_destroy_domain);
>> +		} else {
>> +			spin_lock(&domain->events_lock);
>> +			domain->state = MTWATCH_DOMAIN_DOWN;
>> +			spin_unlock(&domain->events_lock);
>> +
>> +			wake_up(&domain->events_wq);
>> +		}
>> +	}
>> +
>> +	spin_unlock(&mtwatch_info->domain_lock);
>> +}
>> +
>>  static void xs_suspend_enter(void)
>>  {
>>  	spin_lock(&xs_state_lock);
>> @@ -793,6 +988,80 @@ int register_xenbus_watch(struct xenbus_watch *watch)
>>  }
>>  EXPORT_SYMBOL_GPL(register_xenbus_watch);
>>
>> +static void __unregister_single_mtwatch(struct xenbus_watch *watch,
>> +					struct mtwatch_domain *domain)
>> +{
>> +	struct xs_watch_event *event, *tmp;
>> +
>> +	if (current->pid != domain->pid)
>> +		mutex_lock(&domain->domain_mutex);
> 
> Since you avoid the lock here, what's to stop another thread with a different pid now racing with this?
> 
>   Paul


Here  I copy the code from unregister_xenbus_watch(). I think we can assume the
caller would not unregister the same xenbus_watch twice (otherwise, the default
unregister_xenbus_watch() would hit this issue as well)?

When a watch is unregistered, it is processed either in the context of a
xenwatch thread or any other thread/context.

When we avoid the lock here, it indicatew the watch un-registration is processed
by a specific xenwatch thread and no one would race with it.

Dongli Zhang


> 
>> +
>> +	spin_lock(&domain->events_lock);
>> +	list_for_each_entry_safe(event, tmp,
>> +				 &domain->events, list) {
>> +		if (event->handle != watch)
>> +			continue;
>> +		list_del(&event->list);
>> +		kfree(event);
>> +	}
>> +	spin_unlock(&domain->events_lock);
>> +
>> +	if (current->pid != domain->pid)
>> +		mutex_unlock(&domain->domain_mutex);
>> +}
>> +
>> +static void unregister_single_mtwatch(struct xenbus_watch *watch,
>> +				      domid_t domid)
>> +{
>> +	struct mtwatch_domain *domain;
>> +	bool found = false;
>> +
>> +	rcu_read_lock();
>> +
>> +	list_for_each_entry_rcu(domain, &mtwatch_info->domain_list,
>> +				list_node) {
>> +		if (domain->domid == domid) {
>> +			found = true;
>> +			__unregister_single_mtwatch(watch, domain);
>> +		}
>> +	}
>> +
>> +	WARN_ON_ONCE(unlikely(!found));
>> +
>> +	rcu_read_unlock();
>> +}
>> +
>> +static void unregister_all_mtwatch(struct xenbus_watch *watch)
>> +{
>> +	struct mtwatch_domain *domain;
>> +
>> +	rcu_read_lock();
>> +
>> +	list_for_each_entry_rcu(domain, &mtwatch_info->domain_list,
>> +				list_node) {
>> +		__unregister_single_mtwatch(watch, domain);
>> +	}
>> +
>> +	rcu_read_unlock();
>> +}
>> +
>> +static void unregister_mtwatch(struct xenbus_watch *watch)
>> +{
>> +	/*
>> +	 * Generally, to unregister a watch. we need to traverse all
>> +	 * mtwatch domains to remove all inflight pending watch events for
>> +	 * such watch.
>> +	 *
>> +	 * One exception is we only need to remove pending watch events
>> +	 * from a single mtwatch domain when the watch is registered for a
>> +	 * specific domid.
>> +	 */
>> +	if (watch->owner_id)
>> +		unregister_single_mtwatch(watch, watch->owner_id);
>> +	else
>> +		unregister_all_mtwatch(watch);
>> +}
>> +
>>  void unregister_xenbus_watch(struct xenbus_watch *watch)
>>  {
>>  	struct xs_watch_event *event, *tmp;
>> @@ -831,6 +1100,9 @@ void unregister_xenbus_watch(struct xenbus_watch
>> *watch)
>>
>>  	if (current->pid != xenwatch_pid)
>>  		mutex_unlock(&xenwatch_mutex);
>> +
>> +	if (xen_mtwatch && watch->get_domid)
>> +		unregister_mtwatch(watch);
>>  }
>>  EXPORT_SYMBOL_GPL(unregister_xenbus_watch);
>>
>> @@ -954,6 +1226,7 @@ int xs_init(void)
>>
>>  		spin_lock_init(&mtwatch_info->purge_lock);
>>  		INIT_LIST_HEAD(&mtwatch_info->purge_list);
>> +		INIT_WORK(&mtwatch_info->purge_work,
>> xen_mtwatch_purge_domain);
>>
>>  		xen_mtwatch = true;
>>
>> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
>> index e807114..4ac2cee 100644
>> --- a/include/xen/xenbus.h
>> +++ b/include/xen/xenbus.h
>> @@ -241,6 +241,9 @@ extern const struct file_operations xen_xenbus_fops;
>>  extern struct xenstore_domain_interface *xen_store_interface;
>>  extern int xen_store_evtchn;
>>
>> +void mtwatch_create_domain(domid_t domid);
>> +void mtwatch_put_domain(domid_t domid);
>> +
>>  extern bool xen_mtwatch;
>>
>>  #define MTWATCH_HASH_SIZE 256
>> --
>> 2.7.4
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
