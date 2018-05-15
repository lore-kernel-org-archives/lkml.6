Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeEOSLh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:11:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56632 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEOSLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:11:35 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH IB/core 2/2] IB/cm: Send authentic pkey in REQ msg and
 check eligibility of the pkeys
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <ab0e1318-8e1a-5822-5484-33e460095830@dev.mellanox.co.il>
Date: Tue, 15 May 2018 20:11:09 +0200
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Don Hiatt <don.hiatt@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <E41BCEAA-0204-448D-8188-ACA03932B3AC@oracle.com>
References: <20180509093020.24503-1-Haakon.Bugge@oracle.com>
 <20180509093020.24503-3-Haakon.Bugge@oracle.com>
 <ab1f16cd-aa60-0c43-841c-aed301fd2a7e@dev.mellanox.co.il>
 <F9802EE9-4420-44EE-93DC-27CC799B427E@oracle.com>
 <3bee76df-49a6-cf3c-6df4-749a6309358e@dev.mellanox.co.il>
 <B3360947-5905-47BD-ABC4-6C4BB32F5DA6@oracle.com>
 <20180514210200.GN21531@ziepe.ca>
 <ab0e1318-8e1a-5822-5484-33e460095830@dev.mellanox.co.il>
To: Hal Rosenstock <hal@dev.mellanox.co.il>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FIBfm0013869



> On 15 May 2018, at 02:38, Hal Rosenstock <hal@dev.mellanox.co.il> wrote:
> 
> On 5/14/2018 5:02 PM, Jason Gunthorpe wrote:
>> On Thu, May 10, 2018 at 05:16:28PM +0200, Håkon Bugge wrote:
>> 
>>> We are talking about two things here. The PKey in the BTH and the
>>> PKey in the CM REQ payload. They differ.
>>> 
>>> I am out of office, but if my memory serves me correct, the PKey in
>>> the BTH in the MAD packet will be the default PKey. Further, we have
>>> per IBTA:
>> 
>> This sounds like a Linux bug.
>> 
>> Linux does not do a PR to get a reversible path dedicated to the GMP> so it always uses the data flow path, thus the GMP path paramenters
>> and those in the REQ should always exactly match.
>> 
>> Where is Linux setting the BTH.PKey and how did it choose to use the
>> default pkey? Lets fix that at least for sure.

Linux isn’t. The BTH.PKey is inserted by the HCA (hw or fw) coming from the P_Key table (10.9.2 in IBTA), selected by a pkey_index associated with the QP.

As per C10-133: Packets sent from the Send Queue of a GSI QP shall attach a P_Key associated with that QP, just as a P_Key is associated with nonmanagement QPs

>> Once that is fixed the rest of the series makes no sense since a REQ
>> with invalid PKey will never arrive.
>> 
>> However...
>> 
>> This series seems inconsistent with the spec.
>> 
>> IIRC the spec doesn't say if a full or limited pkey should be placed
>> in the REQ (Hal?). 
> 
> CM spec for REQ just says partition key without indicating whether this
> means P_Key or just the partition (15 bits) so my read is that either
> full or limited pkey is allowed in REQ.
> 
>> It is designed so that the requestor can get a
>> single reversible path and put that results into the REQ without
>> additional processing, however the PR returns only one PKey and again,
>> it is not really specified if it should be the full or limited pkey
>> (Hal?).
> 
> Correct; it's not specified.
> 
>> Basically this means that any pkey in the REQ could randomly be the
>> full or limited value, and that in-of-itself has not bearing on the
>> connection.
>> 
>> So it is quite wrong to insist that the pkey be limited or full when
>> processing the REQ. The end port is expected to match against the
>> local table.
> 
> Note that there is thorny issue with shared (physical) port
> virtualization. In shared port virtualization, the VF pkey assignment is
> a local matter. Only thing SM knows is the physical port pkeys where
> both full and limited membership of same partition is possible. It is
> conceivable that CM REQ contains limited partition key between 2 limited
> VFs and for that a new REJ reason code appears to be needed.

+1


Håkon

> 
> -- Hal
> 
>> The real answer to your trap problem is to fix the SM to not create
>> paths that are non-functional, that is just flat out broken SM
>> behavior.
>> 
>> Jason
>> 
