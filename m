Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1954ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A40C20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oXW8DiAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A40C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbeGWTY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:24:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60560 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbeGWTYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:24:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6NIJ6MJ015995;
        Mon, 23 Jul 2018 18:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LM3ihZfel0kKZyTpIpMPiw+pwXGBn7a1frJbkvNryPw=;
 b=oXW8DiAWlTpt1WtfVdDy0a+Y0rwpelslj4DV8tnwNtF/VirBwls5QCOpRwSCXdUMgveI
 E+Qh+7G1ZhHWskKe8Sx/hk2bnKWC29U8nreY36ua1NkST3vVZ7g66+inWgRV25Xmy3OO
 3oZoSQW8aDmLkjRVwjxC1UEaaU+YSt03s4KaoKnXKajyLiK8tvgq9xzXoXfH1Es0BEW/
 CjlZMMy/pPJ06gPYoJFlVfHtNMmyCs8ah8/uVjBb7WemVY5kEUNnk12ELPjpy+fXwb8a
 0qi/m1S1XynlauEYzSqNvOJtDozYTqFixpBsRcwmbkJ4GBsbCCo7UcK521BFw6kMHiKi ZA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2kbtbcnwm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 18:21:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6NILagC032240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 18:21:36 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6NILZ22001841;
        Mon, 23 Jul 2018 18:21:35 GMT
Received: from [192.168.1.250] (/76.253.0.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Jul 2018 11:21:35 -0700
Subject: Re: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same devices
 repeatedly
To:     Daniel Jurgens <danielj@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>,
        Parav Pandit <parav@mellanox.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, gerald.gibson@oracle.com,
        Sharon Liu <sharon.s.liu@oracle.com>
References: <20180713235021.18141-1-qing.huang@oracle.com>
 <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
 <dc4d502c-bc3c-46e3-a984-41271951a5f7@mellanox.com>
 <556984ea-c35f-197d-0e45-16272da3f604@oracle.com>
 <f2a5d82c-f65c-152d-5545-0d50a4e5e150@mellanox.com>
From:   Qing Huang <qing.huang@oracle.com>
Message-ID: <175e7c33-c12b-7c37-c5b9-127804e599b5@oracle.com>
Date:   Mon, 23 Jul 2018 11:21:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f2a5d82c-f65c-152d-5545-0d50a4e5e150@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8963 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807230203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


On 7/23/2018 11:11 AM, Daniel Jurgens wrote:
>
> On 7/23/2018 10:36 AM, Qing Huang wrote:
>> Hi Daniel/Parav,
>>
>> Have you got a chance to review this patch? Thanks!
> Hi Qing, sorry for the delay, I just got back to the office today. I don't agree with the proposed fix, I provided an alternative suggestion below.
>>>> Or.
>>>>
>>>>> Reported-by: Gerald Gibson <gerald.gibson@oracle.com>
>>>>> Signed-off-by: Qing Huang <qing.huang@oracle.com>
>>>>> ---
>>>>>    drivers/infiniband/hw/mlx5/main.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
>>>>> index b3ba9a2..1ddd1d3 100644
>>>>> --- a/drivers/infiniband/hw/mlx5/main.c
>>>>> +++ b/drivers/infiniband/hw/mlx5/main.c
>>>>> @@ -6068,7 +6068,8 @@ static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev, u8 port_num)
>>>>>
>>>>>           mutex_lock(&mlx5_ib_multiport_mutex);
>>>>>           list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
>>>>> -               if (dev->sys_image_guid == mpi->sys_image_guid)
>>>>> +               if (dev->sys_image_guid == mpi->sys_image_guid &&
>>>>> +                   !dev->port[mlx5_core_native_port_num(mdev) - 1].mp.mpi)
> You shouldn't check the mpi field that without holding the lock in the mp structure. Prefer you change the print from a warning in mlx5_ib_bind_slave_port to a debug message.
Thanks for the review. That works for us too. Will resend the patch.

Regards,
Qing

>
>>>>>                           bound = mlx5_ib_bind_slave_port(dev, mpi);
>>>>>
>>>>>                   if (bound) {
>>>>> -- 
>>>>> 2.9.3
>>>>>
>>>>> -- 
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

