Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeEPGrt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:47:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbeEPGrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:47:45 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH IB/core 2/2] IB/cm: Send authentic pkey in REQ msg and
 check eligibility of the pkeys
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20180515190424.GL5615@ziepe.ca>
Date: Wed, 16 May 2018 08:47:21 +0200
Cc: Hal Rosenstock <hal@dev.mellanox.co.il>,
        Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <3E15B62F-E705-43BD-8A72-9E74F784D40E@oracle.com>
References: <20180509093020.24503-1-Haakon.Bugge@oracle.com>
 <20180509093020.24503-3-Haakon.Bugge@oracle.com>
 <ab1f16cd-aa60-0c43-841c-aed301fd2a7e@dev.mellanox.co.il>
 <F9802EE9-4420-44EE-93DC-27CC799B427E@oracle.com>
 <3bee76df-49a6-cf3c-6df4-749a6309358e@dev.mellanox.co.il>
 <B3360947-5905-47BD-ABC4-6C4BB32F5DA6@oracle.com>
 <20180514210200.GN21531@ziepe.ca>
 <ab0e1318-8e1a-5822-5484-33e460095830@dev.mellanox.co.il>
 <E41BCEAA-0204-448D-8188-ACA03932B3AC@oracle.com>
 <20180515190424.GL5615@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160069
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G6lriY013549



> On 15 May 2018, at 21:04, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Tue, May 15, 2018 at 08:11:09PM +0200, Håkon Bugge wrote:
>>> On 15 May 2018, at 02:38, Hal Rosenstock <hal@dev.mellanox.co.il> wrote:
>>> 
>>> On 5/14/2018 5:02 PM, Jason Gunthorpe wrote:
>>>> On Thu, May 10, 2018 at 05:16:28PM +0200, Håkon Bugge wrote:
>>>> 
>>>>> We are talking about two things here. The PKey in the BTH and the
>>>>> PKey in the CM REQ payload. They differ.
>>>>> 
>>>>> I am out of office, but if my memory serves me correct, the PKey in
>>>>> the BTH in the MAD packet will be the default PKey. Further, we have
>>>>> per IBTA:
>>>> 
>>>> This sounds like a Linux bug.
>>>> 
>>>> Linux does not do a PR to get a reversible path dedicated to the GMP> so it always uses the data flow path, thus the GMP path paramenters
>>>> and those in the REQ should always exactly match.
>>>> 
>>>> Where is Linux setting the BTH.PKey and how did it choose to use the
>>>> default pkey? Lets fix that at least for sure.
>> 
>> Linux isn’t. The BTH.PKey is inserted by the HCA (hw or fw) coming from the P_Key table (10.9.2 in IBTA), selected by a pkey_index associated with the QP.
>> 
>> As per C10-133: Packets sent from the Send Queue of a GSI QP shall
>> attach a P_Key associated with that QP, just as a P_Key is
>> associated with nonmanagement QPs
> 
> That language doesn't mean the PKey is forced to the default, it says
> the pkey is programmable.
> 
> Linux implemented programmable PKeys for the GSI by using the work
> request, so it deviates from what the spec imagined (which was
> probably one GSI QP per PKey).
> 
> See ib_create_send_mad for instance:
> 
>        mad_send_wr->send_wr.wr.wr_cqe = &mad_send_wr->mad_list.cqe;
>        mad_send_wr->send_wr.wr.sg_list = mad_send_wr->sg_list;
>        mad_send_wr->send_wr.wr.num_sge = 2;
>        mad_send_wr->send_wr.wr.opcode = IB_WR_SEND;
>        mad_send_wr->send_wr.wr.send_flags = IB_SEND_SIGNALED;
>        mad_send_wr->send_wr.remote_qpn = remote_qpn;
>        mad_send_wr->send_wr.remote_qkey = IB_QP_SET_QKEY;
>        mad_send_wr->send_wr.pkey_index = pkey_index;
> 
> The pkey_index associated with the QP1 is ignored:
> 
>                /*
>                 * PKey index for QP1 is irrelevant but
>                 * one is needed for the Reset to Init transition
>                 */
>                attr->qp_state = IB_QPS_INIT;
>                attr->pkey_index = pkey_index;
>                attr->qkey = (qp->qp_num == 0) ? 0 : IB_QP1_QKEY;
>                ret = ib_modify_qp(qp, attr, IB_QP_STATE |
>                                             IB_QP_PKEY_INDEX | IB_QP_QKEY);
> 
> Since is is present in every WR.
> 
>>>> Basically this means that any pkey in the REQ could randomly be the
>>>> full or limited value, and that in-of-itself has not bearing on the
>>>> connection.
>>>> 
>>>> So it is quite wrong to insist that the pkey be limited or full when
>>>> processing the REQ. The end port is expected to match against the
>>>> local table.
>>> 
>>> Note that there is thorny issue with shared (physical) port
>>> virtualization. In shared port virtualization, the VF pkey assignment is
>>> a local matter. Only thing SM knows is the physical port pkeys where
>>> both full and limited membership of same partition is possible. It is
>>> conceivable that CM REQ contains limited partition key between 2 limited
>>> VFs and for that a new REJ reason code appears to be needed.
>> 
>> +1
> 
> This is not a difficult issue.
> 
> If the GMP is properly tagged with the right PKey then it will never
> be delivered to the VM if the VM does not have the PKey in the
> table.

Not quite right. For the shared port model, a GMP will (most probably) be accepted by the physical port, due to:

IBTA 3.9.5: QP1 is a member of all of the port’s partitions (i.e., can accept any packet specifying a P_Key contained in the port’s P_Key table).

and 

C9-42: If the destination QP is QP1, the BTH:P_Key shall be compared to the set of P_Keys associated with the port on which the packet arrived. If the P_Key matches any of the keys associated with the port, it shall be considered valid.

So, if the GMP is destined to VM1, which is a limited member, but we have another VM2 which is a full member of the same partition, the GMP will pass the HCA’s PKey check.

> It is up to the hypervisor to block GMPs that have Pkeys not in
> the virtual PKey table of the VF.

The packet is received by the HCA and stripped from IB headers, in particular the BTH. How can the "hypervisor" block it when its doesn’t have access to the GMP’s BTH.PKey?

> The only time you could need a new REJ code is if the GMP is using a
> PKey different from the REQ - which is a pretty goofy thing to do
> considering this VM case.

Its goofy. In the CX-3 shared port model, the BTH.PKey is the default one and the REQ.PKey is the full one even if the sending VM’s port only is a limited member. This patch series fixes the last issue.

> Remember the SM doesn't know what Pkeys are in the VM, so it is
> basically impossible for the REQ side to reliably select two different
> pkeys and know that they will bothmake it to the VM.

The active side should use the "authentic" PKey in the REQ message. That is the one that would be used in BTH.PKey when communication has been established. This is implemented by this patch series.

Not sure what you mean by "reliably select two different pkeys". The CM REQ message contains one PKey.

> One pkey could be done reliably if it matched ipoib, for instance, but
> two really cannot in the general case.
> 
> So again - the bug here is that the GMP is being sent with the wrong
> pkey. Fix that, then see what is left to fix..

See above, not sure how that could be implemented. And if it is solved by the HCA trapping the GMP due to the PKey check, it doesn’t help me, as the purpose of the series is to avoid (excessive) PKey traps sent to the SM.

> If I recall there were bugs here in mlx drivers, where the driver sent
> with the wrong Pkey. I think this has actually been fixed now, so
> please check the upstream kernel to be sure the Pkey is not what it is
> supposed to be.

Let me get back to you with some ibdumps here.


Håkon
