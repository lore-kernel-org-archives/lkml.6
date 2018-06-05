Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeFENfH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:35:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751822AbeFENfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:35:05 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 01/10] vfio: ccw: Moving state change out of IRQ
 context
To: Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1527243678-3140-2-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180604155231.42c139ac.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 5 Jun 2018 15:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604155231.42c139ac.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060513-0012-0000-0000-0000027B6119
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060513-0013-0000-0000-000020AC6657
Message-Id: <5330d3e5-4098-e936-de57-5f4cb2d8f564@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=882 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 15:52, Cornelia Huck wrote:
> On Fri, 25 May 2018 12:21:09 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> Let's move the state change from the IRQ routine to the
>> workqueue callback.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c | 20 +++++++-------------
>>   drivers/s390/cio/vfio_ccw_fsm.c | 14 ++++++++------
>>   2 files changed, 15 insertions(+), 19 deletions(-)
> This causes a change in behaviour for devices in the notoper state.
>
> Now:
> - vfio_ccw_sch_irq is called

This should not be done if the subchannel is not operational.

> - via the state machine, disabling the subchannel is (re-)triggered

I removed the fsm_disabled_irq() callback from VFIO_CCW_STATE_NOT_OPER
because the subchannel is not even initialized at that moment.
We have no reference to the subchannel.

In the previous driver NOT_OPER and STANDBY were quite the same.
Now NOT_OPER means "we can not operate on this sub channel"
because we do not have it in a correct state (no ISC, no mediated device,
the probe is not finiched)

Now STANDBY means we have the device ready but is disabled.
In this case the software infrastructure is ready and if an interrupt comes
(what should not happen) we will disable the subchannel again.

>
> With your patch:
> - the work function is queued in any case; eventually, it will change
>    the device's state to idle (unless we don't have an mdev at that
>    point in time)
> - completion is signaled
>
> I'm not sure that's what we want.
>

Yes it is queued in any case but the IRQ is really treated only if the
subchannel is in the right state (STANDBY, BUSY, IDLE and QUIESCING).

In the NOT_OPER state we do not have the mdev not the driver initialized.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
