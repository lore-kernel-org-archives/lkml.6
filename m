Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481A0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DE72083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GyZUoNke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DE72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeFTF1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:27:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43644 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeFTF07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:26:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K5OXWU169881;
        Wed, 20 Jun 2018 05:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=2O8wWFA0wU3gYpnGZIdhmhPDPhoH34PaxroYR36+u/w=;
 b=GyZUoNked3gKoD1BaEMAi69ZavHXHEYjgTA8LbKc0jAHyt3Yzf7lEpjGh2cmnex5Lqdv
 4fUK/O4tVP3zsNM0+8xHtPdtp+ySVPZ0uZEIa3H967EwX1TGZRo4i+y03++HlRYvJAFK
 rYL1dWtF6z+KFJQAamvfo5Lln/b3dZVDXw07k08JP2InumdW8nRoCDAwPec3KgB3RFeW
 c7T5g5IHcpRoJcm1kTxmM6AJgTKFAEuTsPjEgnQkbI+wN4hxsnx0eMX8SIr1tPrNwyV1
 fd9slc3yxk14o4mnE+croJJdmgGbReXlb5qftmyH96slit7A8UoYvC+Ynljp/FUc6aXX dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jmtgwtuu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 05:26:20 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5K5QIca021754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 05:26:19 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K5QH8K005865;
        Wed, 20 Jun 2018 05:26:17 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 22:26:17 -0700
Subject: Re: [PATCH] nvme-pci: not invoke nvme_remove_dead_ctrl when change
 state fails
To:     Keith Busch <keith.busch@linux.intel.com>
Cc:     axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
References: <1529397050-7524-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180619163952.GE19922@localhost.localdomain>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <7d2d346b-91f0-adad-1e11-e5ff660fb984@oracle.com>
Date:   Wed, 20 Jun 2018 13:26:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619163952.GE19922@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

On 06/20/2018 12:39 AM, Keith Busch wrote:
> On Tue, Jun 19, 2018 at 04:30:50PM +0800, Jianchao Wang wrote:
>> There is race between nvme_remove and nvme_reset_work that can
>> lead to io hang.
>>
>> nvme_remove                    nvme_reset_work
>> -> change state to DELETING
>>                                -> fail to change state to LIVE
>>                                -> nvme_remove_dead_ctrl
>>                                  -> nvme_dev_disable
>>                                    -> quiesce request_queue
>>                                  -> queue remove_work
>> -> cancel_work_sync reset_work
>> -> nvme_remove_namespaces
>>   -> splice ctrl->namespaces
>>                                nvme_remove_dead_ctrl_work
>>                                -> nvme_kill_queues
>>   -> nvme_ns_remove               do nothing
>>     -> blk_cleanup_queue
>>       -> blk_freeze_queue
>> Finally, the request_queue is quiesced state when wait freeze,
>> we will get io hang here.
>>
>> In fact, when fails to change state in nvme_reset_work, the only
>> reason is someone has changed state to DELETING. So it is not
>> necessary to invoke nvme_remove_dead_ctrl in that case.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> 
> Good catch. I think the fix should either have the nvme_dev_disable set
> shutdown to true to indicate the controller isn't coming back online, or
> move the nvme_kill_queues inside nvme_remove_dead_ctrl.

Yes,just not invoking  nvme_remove_dead_ctrl when change state fails couldn't fix the hole completely.
I prefer to move nvme_kill_queues from nvme_remove_dead_ctrl_work to nvme_remove_dead_ctrl.
Will post the V2 version based on this.


Thanks
Jianchao

