Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeECMG7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:06:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750999AbeECMG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:06:58 -0400
Subject: Re: [PATCH 04/10] vfio: ccw: replace IO_REQ event with SSCH_REQ event
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180425104138.1337aff5.cohuck@redhat.com>
 <24f638e4-2f7e-00e1-1efb-ff3fe524bca0@linux.vnet.ibm.com>
 <20180430173028.0dca976c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 14:06:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430173028.0dca976c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050312-0020-0000-0000-0000041889E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050312-0021-0000-0000-000042ADAB85
Message-Id: <3c5a0677-4ed2-9bde-e6d8-d02ab69e0c2c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030110
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2018 17:30, Cornelia Huck wrote:
> On Wed, 25 Apr 2018 15:52:19 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 25/04/2018 10:41, Cornelia Huck wrote:
>>> On Thu, 19 Apr 2018 16:48:07 +0200
>>> Pierre Morel<pmorel@linux.vnet.ibm.com>  wrote:
>>>> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
>>>> index 3284e64..93aab87 100644
>>>> --- a/drivers/s390/cio/vfio_ccw_private.h
>>>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>>>> @@ -76,7 +76,7 @@ enum vfio_ccw_state {
>>>>     */
>>>>    enum vfio_ccw_event {
>>>>    	VFIO_CCW_EVENT_NOT_OPER,
>>>> -	VFIO_CCW_EVENT_IO_REQ,
>>>> +	VFIO_CCW_EVENT_SSCH_REQ,
>>>>    	VFIO_CCW_EVENT_INTERRUPT,
>>>>    	VFIO_CCW_EVENT_SCH_EVENT,
>>>>    	/* last element! */
>>> I don't think we should separate the ssch handling. The major
>>> difference to halt/clear is that it needs channel program translation.
>>> Everything else (issuing the instruction and processing the interrupt)
>>> are basically the same. If we just throw everything at the hardware
>>> and let the host's channel subsystem figure it out, we already should
>>> be fine with regard to most of the races.
>> We must test at a moment or another the kind of request we do,
>> cancel, halt and clear only need the subchannel id in register 1 and as
>> you said are much more direct to implement.
>>
>> If we do not separate them here, we need a switch in the "do_io_request"
>> function.
>> Is it what you mean?
> Yes. Most of the handling should be the same for any function.

I really don't know, the 4 functions are quite different.

- SSCH uses an ORB, and has a quite long kernel execution time for VFIO
- there is a race between SSCH and the others instructions
- XSCH makes subchannel no longer start pending, also reset the busy 
indications
- CSCH cancels both SSCH and HSCH instruction, and perform path management
- HSCH has different busy (entry) conditions

But since they are not implemented today, I can keep the old name.



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
