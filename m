Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC33C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B0320827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1oUjRwmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B0320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeKJEvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:51:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJEvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:51:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA9J46kr180604;
        Fri, 9 Nov 2018 19:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0WaWR8gIBeRbcmv6zOXJNTzvAuMriPI5IYpKB0K/xFI=;
 b=1oUjRwmP2OgNNRCxuzGY7g4I2MNbQgEs7zWkNi0Ytle5iHCuNrP6acsOmr29Ke/wB/SW
 hPtC2pCWw00qHqYZP02KyOvG7aTYDN5wfz+BClrLBXaLiGKp1yHlR1t7lhE9Fdbwdomx
 8t2ekebyIamzyd/SL7X5M+YxWn/EH0T5+W5FmVY86DzhWgar78Op8JDMwrXSqSQj2qUh
 HP5Phq7MSXDYsmHKt2vd3PZnVy+umHpC7wk6clYqTxTxHUtmzEboF9w3FdJnORM9sCnw
 vmsYlCtpODErJnBBjqU9fR9lDZHmh9CjcAW3nT7n2saZ5AOcq25qM6ZfB1tv9KZtq4Pr 9A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nh4ar8pa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 19:09:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA9J8xvR017743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 19:08:59 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA9J8vd3019775;
        Fri, 9 Nov 2018 19:08:58 GMT
Received: from [10.211.47.62] (/10.211.47.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 11:08:57 -0800
Subject: Re: [Xen-devel] [PATCH v2] xen-blkfront: fix kernel panic with
 blkfront_remove()
To:     Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     axboe@kernel.dk, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <1541725843-2019-1-git-send-email-manjunath.b.patil@oracle.com>
 <9414b993-15f6-941a-fc2b-e96147e4fb26@suse.com>
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
Organization: Oracle Corporation
Message-ID: <28e89b14-add7-348d-f054-975af74bdf52@oracle.com>
Date:   Fri, 9 Nov 2018 11:08:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9414b993-15f6-941a-fc2b-e96147e4fb26@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9072 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=991
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oops! sorry for not noticing this.

-Manjunath

On 11/8/2018 10:16 PM, Juergen Gross wrote:
> On 09/11/2018 02:10, Manjunath Patil wrote:
>> When we try to detach the device, blkfront_remove() tries to access
>> blkfront_info leading to kernel panic.
>>
>> Typical call stack involving panic -
>>   #10 page_fault at ffffffff816f25df
>>       [exception RIP: blkif_free+46]
>>   #11 blkfront_remove at ffffffffa004de47 [xen_blkfront]
>>   #12 xenbus_dev_remove at ffffffff813faa4c
>>   #13 __device_release_driver at ffffffff814769aa
>>   #14 device_release_driver at ffffffff81476a63
>>   #15 bus_remove_device at ffffffff814762eb
>>   #16 device_del at ffffffff81472684
>>   #17 device_unregister at ffffffff814727e2
>>   #18 xenbus_dev_changed at ffffffff813fa89f
>>   #19 frontend_changed at ffffffff813fca19
>>   #20 xenwatch_thread at ffffffff813f88f9
>>   #21 kthread at ffffffff810a486b
>>   #22 ret_from_fork at ffffffff816ed2a8
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> Commit f92898e7f32e3 already added that.
>
>
> Juergen

