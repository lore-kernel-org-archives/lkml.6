Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeCZLZm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:25:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751107AbeCZLZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:25:39 -0400
Subject: Re: [PATCH 0/4] vfio: ccw: error handling fixes and improvements
To: Cornelia Huck <cohuck@redhat.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
 <20180326110224.1af0ad13.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 26 Mar 2018 13:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326110224.1af0ad13.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032611-0044-0000-0000-0000053FE458
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032611-0045-0000-0000-0000287EFAC5
Message-Id: <f9ab140d-871a-f284-f10a-62e608db10df@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803260125
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/26/2018 11:02 AM, Cornelia Huck wrote:
> On Wed, 21 Mar 2018 03:08:18 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> Hi Conny,
>>
>> Halil reported a host crash when using vfio-ccw. The root cause of the problem
>> is that vfio_pin_pages fails with EINVAL for reasons unknown. He has
>> experienced such failures after online-ing a dasd in the guest (the dasd has 3
>> partitions, hat may or may not have any significance). The problem isn't
>> experienced on every attempt to online the dasd, and breaking at css_do_ssch
>> seems to make things work.
>>
>> One thing is sure: the host kernel should not crash under the described
>> circumstances.
>>
>> To fix the problem, the first patch of this series fixes the cleanup when
>> cp_prefetch fails in the higher level. The 2nd and the 3rd patches provide
>> correctness and denfensive actions for the interfaces in the lower level.
> 
> So, is the first patch stable material?

I think it should be.

> 
>>
>> The 4th patch is trying to add tracepoints for vfio-ccw, so that we can debug
>> such issue easier in future.
> 
> Tracepoints are nice :)
> 
>>
>> For details see the commit message portions of the inividual patches.
> 
> Still digging through the post-vacation mail pile, will do more looking
> later.
> 
> 
>> Thanks.
>>
>> Dong Jia Shi (2):
>>   vfio: ccw: refactor and improve pfn_array_alloc_pin()
>>   vfio: ccw: set ccw->cda to NULL defensively
>>
>> Halil Pasic (2):
>>   vfio: ccw: fix cleanup if cp_prefetch fails
>>   vfio: ccw: add traceponits for interesting error paths
>>
>>  drivers/s390/cio/Makefile         |   1 +
>>  drivers/s390/cio/vfio_ccw_cp.c    | 121 ++++++++++++++++++++------------------
>>  drivers/s390/cio/vfio_ccw_fsm.c   |  13 ++++
>>  drivers/s390/cio/vfio_ccw_trace.h |  86 +++++++++++++++++++++++++++
>>  4 files changed, 163 insertions(+), 58 deletions(-)
>>  create mode 100644 drivers/s390/cio/vfio_ccw_trace.h
>>
> 
