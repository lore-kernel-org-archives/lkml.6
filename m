Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E159AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nvAqrrpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B0220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbeGWQiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:38:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbeGWQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:38:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6NFXwGw054559;
        Mon, 23 Jul 2018 15:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=V0j57WpW3DcoLfnmhsZninfMKyvPIi+GSnIrvq3Pqzw=;
 b=nvAqrrpkNO962zjodp+75Liu2dlILKyj++kUgj+bd8CW5Qx57uEw/v1WaE8rNzpwLw5e
 ex0o+hH53C509VqiPBhuhzmVSzRcalvZMdzDldTsJ4fn2DS4ImVC0XHxrqopumUYObch
 WWmo51kvX0+Qj5wSrKdfy68wrstNONFQeVi2BrndU7FVLJe/X/Ye0XFfCIOXYyOrnCkw
 lfaAuRrwDPlZXcj9WNkq1XsFXUcrLea/Uo2zWr88GtUzQWAWl6dT6BKS108uzD8nbkTu
 QIBmKk/K8NT0NLm1TpYimcHLZ4JrGAnGQ1TNERCIH4DNBo0RqxY+0FoCJPvtgy3wi2pT qg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kbwfpn2w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 15:36:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6NFaCiK030305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 15:36:13 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6NFaBLm022165;
        Mon, 23 Jul 2018 15:36:11 GMT
Received: from [192.168.1.250] (/76.253.0.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Jul 2018 08:36:11 -0700
Subject: Re: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same devices
 repeatedly
To:     Daniel Jurgens <danielj@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>,
        Parav Pandit <parav@mellanox.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, gerald.gibson@oracle.com
References: <20180713235021.18141-1-qing.huang@oracle.com>
 <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
 <dc4d502c-bc3c-46e3-a984-41271951a5f7@mellanox.com>
From:   Qing Huang <qing.huang@oracle.com>
Message-ID: <556984ea-c35f-197d-0e45-16272da3f604@oracle.com>
Date:   Mon, 23 Jul 2018 08:36:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dc4d502c-bc3c-46e3-a984-41271951a5f7@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8963 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807230177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2018 12:48 PM, Daniel Jurgens wrote:
> On 7/14/2018 10:57 AM, Or Gerlitz wrote:
>> On Sat, Jul 14, 2018 at 2:50 AM, Qing Huang <qing.huang@oracle.com> wrote:
>>> When a CX5 device is configured in dual-port RoCE mode, after creating
>>> many VFs against port 1, creating the same number of VFs against port 2
>>> will flood kernel/syslog with something like
>>> "mlx5_*:mlx5_ib_bind_slave_port:4266:(pid 5269): port 2 already
>>> affiliated."
>>>
>>> So basically, when traversing mlx5_ib_dev_list, mlx5_ib_add_slave_port()
>>> shouldn't repeatedly attempt to bind the new mpi data unit to every device
>>> on the list until it finds an unbound device.
>> Daniel,
>>
>> What is mpi data unit?
> It's a structure to keep track affiliated port info in dual port RoCE mode, mpi meaning multi-port info. Parav can review this it my absence, otherwise I can take a closer look when I return to the office.
Hi Daniel/Parav,

Have you got a chance to review this patch? Thanks!

>> Or.
>>
>>> Reported-by: Gerald Gibson <gerald.gibson@oracle.com>
>>> Signed-off-by: Qing Huang <qing.huang@oracle.com>
>>> ---
>>>   drivers/infiniband/hw/mlx5/main.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
>>> index b3ba9a2..1ddd1d3 100644
>>> --- a/drivers/infiniband/hw/mlx5/main.c
>>> +++ b/drivers/infiniband/hw/mlx5/main.c
>>> @@ -6068,7 +6068,8 @@ static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev, u8 port_num)
>>>
>>>          mutex_lock(&mlx5_ib_multiport_mutex);
>>>          list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
>>> -               if (dev->sys_image_guid == mpi->sys_image_guid)
>>> +               if (dev->sys_image_guid == mpi->sys_image_guid &&
>>> +                   !dev->port[mlx5_core_native_port_num(mdev) - 1].mp.mpi)
>>>                          bound = mlx5_ib_bind_slave_port(dev, mpi);
>>>
>>>                  if (bound) {
>>> --
>>> 2.9.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

