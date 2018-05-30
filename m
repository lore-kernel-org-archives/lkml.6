Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935894AbeE3Hcb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:32:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50204 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935179AbeE3Hc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:32:28 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] IB/mad: Use ID allocator routines to allocate agent
 number
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20180529164032.GB18457@ziepe.ca>
Date: Wed, 30 May 2018 09:32:02 +0200
Cc: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <0E56560E-F577-43A6-9F18-B7AC7B5DB213@oracle.com>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
 <20180529154922.GA18457@ziepe.ca>
 <A470D739-D0CD-42EE-9196-8E7610B6DAF4@oracle.com>
 <20180529164032.GB18457@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8908 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=15 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300087
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4U7WsU5028295



> On 29 May 2018, at 18:40, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Tue, May 29, 2018 at 06:16:14PM +0200, Håkon Bugge wrote:
>> 
>>> On 29 May 2018, at 17:49, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>> 
>>> On Tue, May 29, 2018 at 09:38:08AM +0200, Hans Westgaard Ry wrote:
>>>> The agent TID is a 64 bit value split in two dwords.  The least
>>>> significant dword is the TID running counter. The most significant
>>>> dword is the agent number. In the CX-3 shared port model, the mlx4
>>>> driver uses the most significant byte of the agent number to store the
>>>> slave number, making agent numbers greater and equal to 2^24 (3 bytes)
>>>> unusable.
>>> 
>>> There is no reason for this to be an ida, just do something like
>>> 
>>> mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id) & mad_agent_priv->ib_dev->tid_mask;
>>> 
>>> And have the driver set tid_mask to 3 bytes of 0xFF
>> 
>> The issue is that some of the mad agents are long-lived, so you will
>> wrap and use the same TID twice.
> 
> We already have that problem, and using ida is problematic because we
> need to maximize the time between TID re-use, which ida isn't doing.

Initially, I thought that too, but consulted the spec which states:

C13-18.1.1: When initiating a new operation, MADHeader:TransactionID
shall be set to such a value that within that MAD the combination of TID,
SGID, and MgmtClass is different from that of any other currently executing
operation. []

"currently executing operation" that is.

But if timeouts etc. leads to MAD floating around in the fabric, its of course more robust to maximize the time between reuse.

Then idr_alloc_cyclic() can be used.

> Preventing re-use seems like a seperate issue from limiting the range
> to be compatible with mlx4.

Yes. But a v2 of Hans' patch using idr_alloc_cyclic() solves both issues.


Thxs, Håkon

> 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
