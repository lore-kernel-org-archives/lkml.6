Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id azuKKK3cGVs8DQAAmS7hNA
	; Fri, 08 Jun 2018 01:32:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 91D476074D; Fri,  8 Jun 2018 01:32:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 778B0606FA;
	Fri,  8 Jun 2018 01:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 778B0606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeFHBcW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:32:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48398 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752285AbeFHBcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:32:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21CE62308D888;
        Fri,  8 Jun 2018 09:32:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Fri, 8 Jun 2018
 09:32:08 +0800
Subject: Re: [PATCH 3.16 012/410] scsi: libsas: direct call probe and destruct
To: Ben Hutchings <ben@decadent.org.uk>,
        John Garry <john.garry@huawei.com>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <lsq.1528380321.279673399@decadent.org.uk>
 <a0338db1-e901-a2f4-8976-307ceeeadd57@huawei.com>
 <f0545b7ddaa198058c7af360ef12688c359b19f9.camel@decadent.org.uk>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <5B19DC97.505@huawei.com>
Date: Fri, 8 Jun 2018 09:32:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <f0545b7ddaa198058c7af360ef12688c359b19f9.camel@decadent.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/6/8 2:18, Ben Hutchings wrote:
> On Thu, 2018-06-07 at 17:32 +0100, John Garry wrote:
>> On 07/06/2018 15:05, Ben Hutchings wrote:
>>> 3.16.57-rc1 review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>
>> Hi Ben,
>>
>> I noticed that you are looking to backport this patch to 3.16
>>
>> I am wondering why you are taking this libsas patch (and a couple other
>> libsas patches) in isolation, when these patches were part of a series
>> to fix libsas hotplug issues? I'm not sure if cherry-picking certain
>> patches is ok.
>>
>> Maybe Jason (cc'ed) can comment further.
>
> This one apparently fixed a security issue (CVE-2017-18232), though I'm
> certainly not convinced it's a particularly serious one.
>
> But please send objections to the list, not just privately.
>

Hi Ben,

This patch is in the series below. I recommend to backport them 
together. If you really want to do this, I'm happy to help you to 
backport them.

1689c9367bfa scsi: libsas: notify event PORTE_BROADCAST_RCVD in 
sas_enable_revalidation()
0558f33c06bb scsi: libsas: direct call probe and destruct
517e5153d242 scsi: libsas: use flush_workqueue to process disco events 
synchronously
93bdbd06b164 scsi: libsas: Use new workqueue to run sas event and disco 
event
8eea9dd84e45 scsi: libsas: make the event threshold configurable
f12486e06ae8 scsi: libsas: shut down the PHY if events reached the threshold
1c393b970e0f scsi: libsas: Use dynamic alloced work to avoid sas event lost

> Ben.
>
>> Thanks,
>> John
>>
>>> From: Jason Yan <yanaijie@huawei.com>
>>>
>>> commit 0558f33c06bb910e2879e355192227a8e8f0219d upstream.
>>>
>>> In commit 87c8331fcf72 ("[SCSI] libsas: prevent domain rediscovery
>>> competing with ata error handling") introduced disco mutex to prevent
>>> rediscovery competing with ata error handling and put the whole
>>> revalidation in the mutex. But the rphy add/remove needs to wait for the
>>> error handling which also grabs the disco mutex. This may leads to dead
>>> lock.So the probe and destruct event were introduce to do the rphy
>>> add/remove asynchronously and out of the lock.
>>>
>>> The asynchronously processed workers makes the whole discovery process
>>> not atomic, the other events may interrupt the process. For example,
>>> if a loss of signal event inserted before the probe event, the
>>> sas_deform_port() is called and the port will be deleted.
>>>
>>> And sas_port_delete() may run before the destruct event, but the
>>> port-x:x is the top parent of end device or expander. This leads to
>>> a kernel WARNING such as:
>>>
>>> [   82.042979] sysfs group 'power' not found for kobject 'phy-1:0:22'
>>> [   82.042983] ------------[ cut here ]------------
>>> [   82.042986] WARNING: CPU: 54 PID: 1714 at fs/sysfs/group.c:237
>>> sysfs_remove_group+0x94/0xa0
>>> [   82.043059] Call trace:
>>> [   82.043082] [<ffff0000082e7624>] sysfs_remove_group+0x94/0xa0
>>> [   82.043085] [<ffff00000864e320>] dpm_sysfs_remove+0x60/0x70
>>> [   82.043086] [<ffff00000863ee10>] device_del+0x138/0x308
>>> [   82.043089] [<ffff00000869a2d0>] sas_phy_delete+0x38/0x60
>>> [   82.043091] [<ffff00000869a86c>] do_sas_phy_delete+0x6c/0x80
>>> [   82.043093] [<ffff00000863dc20>] device_for_each_child+0x58/0xa0
>>> [   82.043095] [<ffff000008696f80>] sas_remove_children+0x40/0x50
>>> [   82.043100] [<ffff00000869d1bc>] sas_destruct_devices+0x64/0xa0
>>> [   82.043102] [<ffff0000080e93bc>] process_one_work+0x1fc/0x4b0
>>> [   82.043104] [<ffff0000080e96c0>] worker_thread+0x50/0x490
>>> [   82.043105] [<ffff0000080f0364>] kthread+0xfc/0x128
>>> [   82.043107] [<ffff0000080836c0>] ret_from_fork+0x10/0x50
>>>
>>> Make probe and destruct a direct call in the disco and revalidate function,
>>> but put them outside the lock. The whole discovery or revalidate won't
>>> be interrupted by other events. And the DISCE_PROBE and DISCE_DESTRUCT
>>> event are deleted as a result of the direct call.
>>>
>>> Introduce a new list to destruct the sas_port and put the port delete after
>>> the destruct. This makes sure the right order of destroying the sysfs
>>> kobject and fix the warning above.
>>>
>>> In sas_ex_revalidate_domain() have a loop to find all broadcasted
>>> device, and sometimes we have a chance to find the same expander twice.
>>> Because the sas_port will be deleted at the end of the whole revalidate
>>> process, sas_port with the same name cannot be added before this.
>>> Otherwise the sysfs will complain of creating duplicate filename. Since
>>> the LLDD will send broadcast for every device change, we can only
>>> process one expander's revalidation.
>>>
>>> [mkp: kbuild test robot warning]
>>>
>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>> CC: John Garry <john.garry@huawei.com>
>>> CC: Johannes Thumshirn <jthumshirn@suse.de>
>>> CC: Ewan Milne <emilne@redhat.com>
>>> CC: Christoph Hellwig <hch@lst.de>
>>> CC: Tomas Henzl <thenzl@redhat.com>
>>> CC: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>>> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>>> [bwh: Backported to 4.9: adjust context]
>>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>>> ---
>>>   drivers/scsi/libsas/sas_ata.c      |  1 -
>>>   drivers/scsi/libsas/sas_discover.c | 32 +++++++++++++++++-------------
>>>   drivers/scsi/libsas/sas_expander.c |  8 +++-----
>>>   drivers/scsi/libsas/sas_internal.h |  1 +
>>>   drivers/scsi/libsas/sas_port.c     |  3 +++
>>>   include/scsi/libsas.h              |  3 +--
>>>   include/scsi/scsi_transport_sas.h  |  1 +
>>>   7 files changed, 27 insertions(+), 22 deletions(-)
>>>
>>> --- a/drivers/scsi/libsas/sas_ata.c
>>> +++ b/drivers/scsi/libsas/sas_ata.c
>>> @@ -782,7 +782,6 @@ int sas_discover_sata(struct domain_devi
>>>   	if (res)
>>>   		return res;
>>>
>>> -	sas_discover_event(dev->port, DISCE_PROBE);
>>>   	return 0;
>>>   }
>>>
>>> --- a/drivers/scsi/libsas/sas_discover.c
>>> +++ b/drivers/scsi/libsas/sas_discover.c
>>> @@ -212,13 +212,9 @@ void sas_notify_lldd_dev_gone(struct dom
>>>   	}
>>>   }
>>>
>>> -static void sas_probe_devices(struct work_struct *work)
>>> +static void sas_probe_devices(struct asd_sas_port *port)
>>>   {
>>>   	struct domain_device *dev, *n;
>>> -	struct sas_discovery_event *ev = to_sas_discovery_event(work);
>>> -	struct asd_sas_port *port = ev->port;
>>> -
>>> -	clear_bit(DISCE_PROBE, &port->disc.pending);
>>>
>>>   	/* devices must be domain members before link recovery and probe */
>>>   	list_for_each_entry(dev, &port->disco_list, disco_list_node) {
>>> @@ -294,7 +290,6 @@ int sas_discover_end_dev(struct domain_d
>>>   	res = sas_notify_lldd_dev_found(dev);
>>>   	if (res)
>>>   		return res;
>>> -	sas_discover_event(dev->port, DISCE_PROBE);
>>>
>>>   	return 0;
>>>   }
>>> @@ -353,13 +348,9 @@ static void sas_unregister_common_dev(st
>>>   	sas_put_device(dev);
>>>   }
>>>
>>> -static void sas_destruct_devices(struct work_struct *work)
>>> +void sas_destruct_devices(struct asd_sas_port *port)
>>>   {
>>>   	struct domain_device *dev, *n;
>>> -	struct sas_discovery_event *ev = to_sas_discovery_event(work);
>>> -	struct asd_sas_port *port = ev->port;
>>> -
>>> -	clear_bit(DISCE_DESTRUCT, &port->disc.pending);
>>>
>>>   	list_for_each_entry_safe(dev, n, &port->destroy_list, disco_list_node) {
>>>   		list_del_init(&dev->disco_list_node);
>>> @@ -370,6 +361,16 @@ static void sas_destruct_devices(struct
>>>   	}
>>>   }
>>>
>>> +static void sas_destruct_ports(struct asd_sas_port *port)
>>> +{
>>> +	struct sas_port *sas_port, *p;
>>> +
>>> +	list_for_each_entry_safe(sas_port, p, &port->sas_port_del_list, del_list) {
>>> +		list_del_init(&sas_port->del_list);
>>> +		sas_port_delete(sas_port);
>>> +	}
>>> +}
>>> +
>>>   void sas_unregister_dev(struct asd_sas_port *port, struct domain_device *dev)
>>>   {
>>>   	if (!test_bit(SAS_DEV_DESTROY, &dev->state) &&
>>> @@ -384,7 +385,6 @@ void sas_unregister_dev(struct asd_sas_p
>>>   	if (!test_and_set_bit(SAS_DEV_DESTROY, &dev->state)) {
>>>   		sas_rphy_unlink(dev->rphy);
>>>   		list_move_tail(&dev->disco_list_node, &port->destroy_list);
>>> -		sas_discover_event(dev->port, DISCE_DESTRUCT);
>>>   	}
>>>   }
>>>
>>> @@ -490,6 +490,8 @@ static void sas_discover_domain(struct w
>>>   		port->port_dev = NULL;
>>>   	}
>>>
>>> +	sas_probe_devices(port);
>>> +
>>>   	SAS_DPRINTK("DONE DISCOVERY on port %d, pid:%d, result:%d\n", port->id,
>>>   		    task_pid_nr(current), error);
>>>   }
>>> @@ -523,6 +525,10 @@ static void sas_revalidate_domain(struct
>>>   		    port->id, task_pid_nr(current), res);
>>>    out:
>>>   	mutex_unlock(&ha->disco_mutex);
>>> +
>>> +	sas_destruct_devices(port);
>>> +	sas_destruct_ports(port);
>>> +	sas_probe_devices(port);
>>>   }
>>>
>>>   /* ---------- Events ---------- */
>>> @@ -578,10 +584,8 @@ void sas_init_disc(struct sas_discovery
>>>   	static const work_func_t sas_event_fns[DISC_NUM_EVENTS] = {
>>>   		[DISCE_DISCOVER_DOMAIN] = sas_discover_domain,
>>>   		[DISCE_REVALIDATE_DOMAIN] = sas_revalidate_domain,
>>> -		[DISCE_PROBE] = sas_probe_devices,
>>>   		[DISCE_SUSPEND] = sas_suspend_devices,
>>>   		[DISCE_RESUME] = sas_resume_devices,
>>> -		[DISCE_DESTRUCT] = sas_destruct_devices,
>>>   	};
>>>
>>>   	disc->pending = 0;
>>> --- a/drivers/scsi/libsas/sas_expander.c
>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>> @@ -1903,7 +1903,8 @@ static void sas_unregister_devs_sas_addr
>>>   		sas_port_delete_phy(phy->port, phy->phy);
>>>   		sas_device_set_phy(found, phy->port);
>>>   		if (phy->port->num_phys == 0)
>>> -			sas_port_delete(phy->port);
>>> +			list_add_tail(&phy->port->del_list,
>>> +				&parent->port->sas_port_del_list);
>>>   		phy->port = NULL;
>>>   	}
>>>   }
>>> @@ -2111,7 +2112,7 @@ int sas_ex_revalidate_domain(struct doma
>>>   	struct domain_device *dev = NULL;
>>>
>>>   	res = sas_find_bcast_dev(port_dev, &dev);
>>> -	while (res == 0 && dev) {
>>> +	if (res == 0 && dev) {
>>>   		struct expander_device *ex = &dev->ex_dev;
>>>   		int i = 0, phy_id;
>>>
>>> @@ -2123,9 +2124,6 @@ int sas_ex_revalidate_domain(struct doma
>>>   			res = sas_rediscover(dev, phy_id);
>>>   			i = phy_id + 1;
>>>   		} while (i < ex->num_phys);
>>> -
>>> -		dev = NULL;
>>> -		res = sas_find_bcast_dev(port_dev, &dev);
>>>   	}
>>>   	return res;
>>>   }
>>> --- a/drivers/scsi/libsas/sas_internal.h
>>> +++ b/drivers/scsi/libsas/sas_internal.h
>>> @@ -100,6 +100,7 @@ int sas_try_ata_reset(struct asd_sas_phy
>>>   void sas_hae_reset(struct work_struct *work);
>>>
>>>   void sas_free_device(struct kref *kref);
>>> +void sas_destruct_devices(struct asd_sas_port *port);
>>>
>>>   #ifdef CONFIG_SCSI_SAS_HOST_SMP
>>>   extern int sas_smp_host_handler(struct Scsi_Host *shost, struct request *req,
>>> --- a/drivers/scsi/libsas/sas_port.c
>>> +++ b/drivers/scsi/libsas/sas_port.c
>>> @@ -66,6 +66,7 @@ static void sas_resume_port(struct asd_s
>>>   		rc = sas_notify_lldd_dev_found(dev);
>>>   		if (rc) {
>>>   			sas_unregister_dev(port, dev);
>>> +			sas_destruct_devices(port);
>>>   			continue;
>>>   		}
>>>
>>> @@ -219,6 +220,7 @@ void sas_deform_port(struct asd_sas_phy
>>>
>>>   	if (port->num_phys == 1) {
>>>   		sas_unregister_domain_devices(port, gone);
>>> +		sas_destruct_devices(port);
>>>   		sas_port_delete(port->port);
>>>   		port->port = NULL;
>>>   	} else {
>>> @@ -323,6 +325,7 @@ static void sas_init_port(struct asd_sas
>>>   	INIT_LIST_HEAD(&port->dev_list);
>>>   	INIT_LIST_HEAD(&port->disco_list);
>>>   	INIT_LIST_HEAD(&port->destroy_list);
>>> +	INIT_LIST_HEAD(&port->sas_port_del_list);
>>>   	spin_lock_init(&port->phy_list_lock);
>>>   	INIT_LIST_HEAD(&port->phy_list);
>>>   	port->ha = sas_ha;
>>> --- a/include/scsi/libsas.h
>>> +++ b/include/scsi/libsas.h
>>> @@ -87,10 +87,8 @@ enum discover_event {
>>>   	DISCE_DISCOVER_DOMAIN   = 0U,
>>>   	DISCE_REVALIDATE_DOMAIN,
>>>   	DISCE_PORT_GONE,
>>> -	DISCE_PROBE,
>>>   	DISCE_SUSPEND,
>>>   	DISCE_RESUME,
>>> -	DISCE_DESTRUCT,
>>>   	DISC_NUM_EVENTS,
>>>   };
>>>
>>> @@ -274,6 +272,7 @@ struct asd_sas_port {
>>>   	struct list_head dev_list;
>>>   	struct list_head disco_list;
>>>   	struct list_head destroy_list;
>>> +	struct list_head sas_port_del_list;
>>>   	enum   sas_linkrate linkrate;
>>>
>>>   	struct sas_work work;
>>> --- a/include/scsi/scsi_transport_sas.h
>>> +++ b/include/scsi/scsi_transport_sas.h
>>> @@ -145,6 +145,7 @@ struct sas_port {
>>>
>>>   	struct mutex		phy_list_mutex;
>>>   	struct list_head	phy_list;
>>> +	struct list_head	del_list; /* libsas only */
>>>   };
>>>
>>>   #define dev_to_sas_port(d) \
>>>
>>>
>>> .
>>>
>>
>>
