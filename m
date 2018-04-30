Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeD3OOc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:14:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752312AbeD3OO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:14:29 -0400
Subject: Re: [PATCH v2 5/5] vfio: ccw: add traceponits for interesting error
 paths
To: Cornelia Huck <cohuck@redhat.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pmorel@linux.ibm.com
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
 <20180423110113.59385-6-bjsdjshi@linux.vnet.ibm.com>
 <20180427121353.4453bdc2.cohuck@redhat.com>
 <20180428055023.GS5428@bjsdjshi@linux.vnet.ibm.com>
 <20180430135153.1d108675.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 30 Apr 2018 16:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180430135153.1d108675.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18043014-0020-0000-0000-000004177BFA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18043014-0021-0000-0000-000042AC909E
Message-Id: <ca160353-696e-86f6-8a37-dd6a2f7fae8d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804300136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2018 01:51 PM, Cornelia Huck wrote:
> On Sat, 28 Apr 2018 13:50:23 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> * Cornelia Huck <cohuck@redhat.com> [2018-04-27 12:13:53 +0200]:
>>
>>> On Mon, 23 Apr 2018 13:01:13 +0200
>>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>>
>>> typo in subject: s/traceponits/tracepoints/
>>>    
>>>> From: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>
>>>> Add some tracepoints so we can inspect what is not working as is should.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>>> ---
>>>>   drivers/s390/cio/Makefile         |  1 +
>>>>   drivers/s390/cio/vfio_ccw_fsm.c   | 16 +++++++-
>>>>   drivers/s390/cio/vfio_ccw_trace.h | 77 +++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 93 insertions(+), 1 deletion(-)
>>>>   create mode 100644 drivers/s390/cio/vfio_ccw_trace.h
>>>
>>>    
>>>> @@ -135,6 +142,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>>>   			goto err_out;
>>>>   
>>>>   		io_region->ret_code = cp_prefetch(&private->cp);
>>>> +		trace_vfio_ccw_cp_prefetch(get_schid(private),
>>>> +					   io_region->ret_code);
>>>>   		if (io_region->ret_code) {
>>>>   			cp_free(&private->cp);
>>>>   			goto err_out;
>>>> @@ -142,11 +151,13 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>>>   
>>>>   		/* Start channel program and wait for I/O interrupt. */
>>>>   		io_region->ret_code = fsm_io_helper(private);
>>>> +		trace_vfio_ccw_fsm_io_helper(get_schid(private),
>>>> +					     io_region->ret_code);
>>>>   		if (io_region->ret_code) {
>>>>   			cp_free(&private->cp);
>>>>   			goto err_out;
>>>>   		}
>>>> -		return;
>>>> +		goto out;
>>>>   	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
>>>>   		/* XXX: Handle halt. */
>>>>   		io_region->ret_code = -EOPNOTSUPP;
>>>> @@ -159,6 +170,9 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>>>   
>>>>   err_out:
>>>>   	private->state = VFIO_CCW_STATE_IDLE;
>>>> +out:
>>>> +	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, get_schid(private),
>>>> +			       io_region->ret_code);
>>>>   }
>>>>   
>>>>   /*
>>>
>>> I really don't want to bikeshed, especially as some tracepoints are
>>> better than no tracepoints, but...
>>>
>>> We now trace fctl/schid/ret_code unconditionally (good).
>>>
>>> We trace the outcome of cp_prefetch() and fsm_io_helper()
>>> unconditionally. We don't, however, trace all things that may go wrong.
>>> We have the tracepoint at the end, but it cannot tell us where the
>>> error came from. Should we have tracepoints in every place (in this
>>> function) that may generate an error? Only if there is an actual error?
>>> Are the two enough for common debug scenarios?
>> Trace actual error sounds like a better idea than trace unconditionally
>> of these two functions.
>> These two are not enough for common debug scenarios. For example, we
>> cann't tell if a -EOPNOTSUPP is a orb->tm.b problem, or error code
>> returned by cp_init().
>>
>> Idea to improve:
>> 1. Trace actual error.
>> 2. Define a trace event and add error trace for cp_init().
> 
> Hm. Going from what I have done in the past when doing printk debugging:
> 
> - stick in a message that is always hit, with some information about
>    parameters, if it makes sense
> - stick in a message "foo happened!" in the error branches
>     - or, alternatively, trace the called functions
> 
> So tracing on failure only might be more useful? Have all failure paths
> under a common knob to turn on/off?
> 
>>> Opinions? We can just go ahead with this and improve things later
>>> on, I guess.
>>>    
>> I think it's also fine to do this - better something than nothing. We
>> could at least have a code base to be improved to make everybody
>> happier in future.
> 
> Maybe keep the patch as it is now, except trace the errors only
> (keeping the fctl trace point)?

What do you mean by this sentence. Get rid of vfio_ccw_io_fctl or get
rid of vfio_ccw_cp_prefetch and vfio_ccw_fsm_io_helper, or get don't
get rid of any, but make some conditional (!errno)?

> 
> Halil, as you wrote the patch (and I presume you found it helpful):
> What is your opinion?
> 

I'm in favor of this patch (as previously stated here
https://patchwork.kernel.org/patch/10298305/). And regarding the
questions under discussion I'm mostly fine either way.

I think the naming of this fctl thing is a bit cryptic,
but if we don't see this as ABI I'm fine with it -- can be improved.
What would be a better name? I was thinking along the lines accept_request.
(Bad error code would mean that the request did not get accepted. Good
code does not mean the requested function was performed successfully.)

Also I think vfio_ccw_io_fctl with no zero error code would make sense
as dev_warn. If I were an admin looking into a problem I would very much
appreciate seeing something in the messages log (and not having to enable
tracing first). This point seems to be a good one for high level 'request gone
bad' kind of report. Opinions?

Regards,
Halil
