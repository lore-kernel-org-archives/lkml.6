Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A551C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430F3206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="st4fOjB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430F3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeIJIWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:22:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeIJIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:22:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8A1nKj0152301;
        Mon, 10 Sep 2018 01:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1TG4jx4Zm5kJAOqL3kuJRojVjuzboUSBhxHqtFJvOUg=;
 b=st4fOjB6AmcvPsbDlwoKkYgRczg3XMniEFsPRmtWNuUCEV/ezZnmGCm/XxVyXPvKq2ZH
 ngwBD6DJzy9ndMl/11JVyEfD1/XIEMh96rlaMKzQdF3HuWmShbimOjEYWIol3+kaTdHV
 2lIYXlbutsrhidkE19S76OoMTZHQI76cy89h1gm4pHRUN7TLdpgMRaqDBcxuqenX8CBF
 g7pEa5fCzUMwoJywMMuUvvehQlsUP4bzgE4AOGU0cz8mXGOnmIhmvHRSEtNv30gAfOwD
 HU54roFT3P2i3yJZ1pfoU7k55AJp+KbrRvOQCcySmQ50N0ttSaam4hh8yscS0rKqzJYH GA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mc5ut3ars-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 01:49:44 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8A1nhqg000372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Sep 2018 01:49:43 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8A1ng1h023162;
        Mon, 10 Sep 2018 01:49:42 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Sep 2018 18:49:42 -0700
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, keith.busch@intel.com, jsmart2021@gmail.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        jthumshirn@suse.de, bart.vanassche@wdc.com
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
 <20180905220910.GC21352@ming.t460p>
 <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
 <20180906130715.GB31250@ming.t460p>
 <165989bc-949f-570e-c1d2-0ee1f0d4472a@oracle.com>
 <20180907162331.GB9056@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b50cc2a3-bf3b-4f5a-97e6-dc2bfd29c99c@oracle.com>
Date:   Mon, 10 Sep 2018 09:49:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907162331.GB9056@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9011 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809100017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2018 12:23 AM, Ming Lei wrote:
> On Thu, Sep 06, 2018 at 10:19:27PM +0800, jianchao.wang wrote:
>>
>>
>> On 09/06/2018 09:07 PM, Ming Lei wrote:
>>> On Thu, Sep 06, 2018 at 09:28:46AM +0800, jianchao.wang wrote:
>>>> Hi Ming
>>>>
>>>> On 09/06/2018 06:09 AM, Ming Lei wrote:
>>>>> nvme_dev_add() still may call freeze & unfreeze queue, so your patch
>>>>> can't avoid draining queue completely here.
>>>>
>>>> Yes, I know this. We still need to freeze queue when update nr_hw_queues.
>>>> But we move forward a step at least. :)
>>>> We don't need to drain request queue in normal case of nvme_reset_work.
>>>
>>> It is hard to say who is the normal case. In case of CPU hotplug, it is quite
>>> easy to trigger updating nr_hw_queues.
>>>
>>>>
>>>> As for updating nr_hw_queues, we could try some other method on it next.
>>>
>>> The thing is that draining queue may be inevitable inside reset work
>>> function because of updating nr_hw_queues, that means the approach in
>>> this patchset is just a partial solution
>>>
>>> Or it may not make sense to do that because we may never remove the draining
>>> queue in the code path of updating nr_hw_queues.
>>>
>>> Given they belong to same issue, I suggest to solve them all.
>>
>> I still think if just prevent new IO, freeze queue is over-kill.
>>
>> With respect to update nr_hw_queues, we could try to take the bios down from the
>> queued requests as the blk_steal_bios. Then re-issue these bios after updating the
>> nr_hw_queues.
> 
> It is always easier to say than done, :-)
> 
> Please go ahead and post patches, and I am happy to review.
> 

Yes, I'm trying it and will post it when complete. :)

Thanks
Jianchao

> 
> Thanks,
> Ming
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=8v99qftJpifVTL4l7Od8_RT0UZCUN1aIotRsKWugz28&s=Z56o8mcARcWcRHe1yOr8Hu2a7djUCM6hKtrDTHuA9Qc&e=
> 
