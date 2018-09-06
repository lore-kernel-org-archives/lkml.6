Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC62C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8673120844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u+GPaK9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8673120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbeIFSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:54:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbeIFSyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:54:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w86EEMvH140035;
        Thu, 6 Sep 2018 14:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2wV4y7NwXNDqXL49flRa59c6LmzUXXxP9FMySXyiiDk=;
 b=u+GPaK9HNcuzMDec853d6xywhIUamiefsNZJW2u75fTtGqv5MiMf+YUowjxnqlGa4Nzx
 DyKXsN/uZE1hEtWR9egNRszu8NpvI1OnNxXq+jkOY5EAcYC985qKopUHb0G5yylJdNxa
 N7wURD86z2fhH7V05+84Gr1jRyH4BV8rI5BN+WMuAC1tiRcHcLJYnPhOw54A6+jsHTU3
 95nUiDq55goIPzy9aHTUcynsdL5WAAD/36PTctIxQg6kFnoI+a25lhoA9vCi1uBm+zop
 xAXrtBkU0dqy3kBq5HDRTz9ETrxrn+tTZnXRd0OKdb/7nIEs78qwwCqDkvVMuPurwG9w RQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m7jqpve6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 14:18:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w86EIbQC018257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 14:18:37 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w86EIaEc031870;
        Thu, 6 Sep 2018 14:18:36 GMT
Received: from [10.191.31.201] (/10.191.31.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Sep 2018 07:18:36 -0700
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
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <165989bc-949f-570e-c1d2-0ee1f0d4472a@oracle.com>
Date:   Thu, 6 Sep 2018 22:19:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906130715.GB31250@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 09:07 PM, Ming Lei wrote:
> On Thu, Sep 06, 2018 at 09:28:46AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 09/06/2018 06:09 AM, Ming Lei wrote:
>>> nvme_dev_add() still may call freeze & unfreeze queue, so your patch
>>> can't avoid draining queue completely here.
>>
>> Yes, I know this. We still need to freeze queue when update nr_hw_queues.
>> But we move forward a step at least. :)
>> We don't need to drain request queue in normal case of nvme_reset_work.
> 
> It is hard to say who is the normal case. In case of CPU hotplug, it is quite
> easy to trigger updating nr_hw_queues.
> 
>>
>> As for updating nr_hw_queues, we could try some other method on it next.
> 
> The thing is that draining queue may be inevitable inside reset work
> function because of updating nr_hw_queues, that means the approach in
> this patchset is just a partial solution
> 
> Or it may not make sense to do that because we may never remove the draining
> queue in the code path of updating nr_hw_queues.
> 
> Given they belong to same issue, I suggest to solve them all.

I still think if just prevent new IO, freeze queue is over-kill.

With respect to update nr_hw_queues, we could try to take the bios down from the
queued requests as the blk_steal_bios. Then re-issue these bios after updating the
nr_hw_queues.

Thanks
Jianchao

> 
> Thanks,
> Ming
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=cybJ83konrbKh9jtodiaZRmNrKAo1YtEI_oyaNIbuvk&s=EBhkv_XTOQb3K3-4esnkBrs_ErKuNzXDqZwrIzEA0ig&e=
> 
