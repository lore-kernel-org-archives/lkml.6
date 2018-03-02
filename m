Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164014AbeCBBsU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 20:48:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163120AbeCBBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 20:48:17 -0500
To: "jianchao.w.wang\@oracle.com" <jianchao.w.wang@oracle.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb\@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch\@lst.de" <hch@lst.de>
Subject: Re: [PATCH V2] scsi: core: use blk_mq_requeue_request in __scsi_queue_insert
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
        <1519840355.2777.8.camel@wdc.com>
        <624cedc6-9658-7b76-9c63-61c30fdfe6be@oracle.com>
        <1519926225.2675.6.camel@wdc.com>
Date: Thu, 01 Mar 2018 20:43:08 -0500
In-Reply-To: <1519926225.2675.6.camel@wdc.com> (Bart Van Assche's message of
        "Thu, 1 Mar 2018 17:43:46 +0000")
Message-ID: <yq17eqvz1zn.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=873
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020015
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jianchao,

> Yes, the block layer core guarantees that scsi_mq_get_budget() will be
> called before scsi_queue_rq(). I think the full picture is as follows:

> * Before scsi_queue_rq() calls .queuecommand(), get_device() is called for the
>   SCSI device and the device, target and host busy counters are incremented.
> * If the SCSI core decides to requeue a command, scsi_queue_insert() causes
>   __scsi_queue_insert() to call scsi_device_unbusy(). That last function
>   decreases the device, target and host busy counters but not put_device(sdev).
>   Hence the need for a separate put_device() call after requeuing.
>
> It's unfortunate that the SCSI core became so asymmetric. Anyway,
> since I am now convinced that this patch is correct, feel free to add:

Please add something akin to Bart's explanation as a comment and repost.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
