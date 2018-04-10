Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeDJKsW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:48:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752323AbeDJKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:48:19 -0400
Subject: Re: [PATCH 4/4] vfio: ccw: add traceponits for interesting error
 paths
To: Cornelia Huck <cohuck@redhat.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
 <20180321020822.86255-5-bjsdjshi@linux.vnet.ibm.com>
 <20180326155902.12bed785.cohuck@redhat.com>
 <20180327075114.GK12194@bjsdjshi@linux.vnet.ibm.com>
 <20180327120723.192f7577.cohuck@redhat.com>
 <20180410021639.GN5428@bjsdjshi@linux.vnet.ibm.com>
 <20180410105540.310ea82a.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Date: Tue, 10 Apr 2018 12:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410105540.310ea82a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041010-0044-0000-0000-0000054580C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041010-0045-0000-0000-00002885B058
Message-Id: <578ce588-b738-4df5-f2d9-7db98a2c0b41@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804100108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2018 10:55 AM, Cornelia Huck wrote:
> On Tue, 10 Apr 2018 10:16:39 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>>   Does the following effect make sense?
>>
>> # tracer: nop
>> #
>> #                              _-----=> irqs-off
>> #                             / _----=> need-resched
>> #                            | / _---=> hardirq/softirq
>> #                            || / _--=> preempt-depth
>> #                            ||| /     delay
>> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>> #              | |       |   ||||       |         |
>>  qemu-system-s39-4252  [006] ....   231.457214: vfio_ccw_cp_prefetch: schid=0.0.013f errno=0
>>  qemu-system-s39-4252  [006] ....   231.457222: vfio_ccw_fsm_io_helper: schid=0.0.013f errno=0
>>  qemu-system-s39-4252  [006] ....   231.457223: vfio_ccw_io_fctl: schid=0.0.013f fctl=4 errno=0
>>   ... ...
> 
> I would likely find this useful for following a code path and making
> sure the right things are called.
> 
> We certainly want error conditions traced as well (although the code
> has been working too well for me to trigger that easily :)
> 

Looks interesting. The approach is to trace (all) exits from selected
functions, or?

It is an interesting approach. Function entry could probably be traced
with the function tracer (if we should ever need that, although relating
the two unambiguously may not be possible -- I don't know).

I'm still not completely in clear how do we want to do error reporting.
Using traces as means of error reporting smells like abuse to me. @Dong
Jia: could you help me get an overview? I'm thinking of something like
a matrix of type:
error | handler | action (propagate as / report / try recover / discard silently)
I'm mostly interested in what gets reported and if there is stuff that
should be reported.

Other than that I'm in favor. And having traces for tracking error
condition is clearly better than having nothing.

Regards,
Halil
