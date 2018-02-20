Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeBTVry (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:47:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51912 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeBTVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:47:51 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1519161268.3737.12.camel@wdc.com>
Date: Tue, 20 Feb 2018 16:47:31 -0500
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Message-Id: <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
X-Mailer: Apple Mail (2.3445.5.20)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802200259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1KLlw34002538



> On Feb 20, 2018, at 4:14 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> 
> On Tue, 2018-02-20 at 21:59 +0100, Arnd Bergmann wrote:
>> /* # of WCs to poll for with a single call to ib_poll_cq */
>> -#define IB_POLL_BATCH			16
>> +#define IB_POLL_BATCH			8
> 
> The purpose of batch polling is to minimize contention on the cq spinlock.
> Reducing the IB_POLL_BATCH constant may affect performance negatively. Has
> the performance impact of this change been verified for all affected drivers
> (ib_srp, ib_srpt, ib_iser, ib_isert, NVMeOF, NVMeOF target, SMB Direct, NFS
> over RDMA, ...)?

Only the users of the DIRECT polling method use an on-stack
array of ib_wc's. This is only the SRP drivers.

The other two modes have use of a dynamically allocated array
of ib_wc's that hangs off the ib_cq. These shouldn't need any
reduction in the size of this array, and they are the common
case.

IMO a better solution would be to change ib_process_cq_direct
to use a smaller on-stack array, and leave IB_POLL_BATCH alone.

--
Chuck Lever
