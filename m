Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeEVPKz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:10:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751277AbeEVPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:10:52 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-3-cohuck@redhat.com>
 <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
 <20180515181006.0cb1dfc2.cohuck@redhat.com>
 <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
 <20180522145208.310143ea.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 22 May 2018 17:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522145208.310143ea.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18052215-0044-0000-0000-00000555398B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052215-0045-0000-0000-00002896C828
Message-Id: <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220172
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2018 14:52, Cornelia Huck wrote:
> On Wed, 16 May 2018 15:32:48 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 15/05/2018 18:10, Cornelia Huck wrote:
>>> On Fri, 11 May 2018 11:33:35 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>   
>>>> On 09/05/2018 17:48, Cornelia Huck wrote:
>>>>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>>>>     
>>>>>     	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>>>>>     
>>>>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>>>>> +	/*
>>>>> +	 * Start processing with the clear function, then halt, then start.
>>>>> +	 * We may still be start pending when the caller wants to clean
>>>>> +	 * up things via halt/clear.
>>>>> +	 */
>>>> hum. The scsw here does not reflect the hardware state but the
>>>> command passed from the user interface.
>>>> Can we and should we authorize multiple commands in one call?
>>>>
>>>> If not, the comment is not appropriate and a switch on cmd.fctl
>>>> would be a clearer.
>>> There may be multiple functions specified, but we need to process them
>>> in precedence order (and clear wins over the others, so to speak).
>>> Would adding a sentence like "we always process just one function" help?
>> Why should we allow multiple commands in a single call ?
>> It brings no added value.
>> Is there a use case?
>> Currently QEMU does not do this and since we only have the SCSH there
>> is no difference having the bit set alone or not alone.
> I found this to be a very easy way to implement halt/clear. This still
> holds true if we switch to some kind of capabilities for this (did not
> have time to look at this further, though).
>
> As we have the fctl field anyway, I'm in favour of processing this all
> in one function.
>

Sorry, I do not understand if we agree or not.

I agree we have the fctl field and we must continue to use it
for backward compatibility.

I do not understand the "processing all in one function".

Since yo already have 3 function to process these three instructions.

Do you mean the if .. else if .. else if ?

Then I come back to what you said earlier on the precedence of the clear 
instruction:

1) do we have a use case to have more than one bit set in the fctl field?

- if no, there is no need for precedence

- if yes, why should clear have precedence ?
   How do QEMU set more than one bit in fctl?
   why should we alter the order of the instructions given by the guest?
   How can we know this order if there are multiple instructions at once?


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
