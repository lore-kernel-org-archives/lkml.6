Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934837AbeCHOFD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:05:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755259AbeCHOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:05:00 -0500
Subject: Re: [RFC PATCH 1/5] ima: extend clone() with IMA namespace support
To: "Serge E. Hallyn" <serge@hallyn.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
 <20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
 <20170725175317.GA727@mail.hallyn.com>
 <1501008554.3689.30.camel@HansenPartnership.com>
 <20170725190406.GA1883@mail.hallyn.com>
 <1501009739.3689.33.camel@HansenPartnership.com>
 <1501012082.27413.17.camel@linux.vnet.ibm.com>
 <645db815-7773-e351-5db7-89f38cd88c3d@linux.vnet.ibm.com>
 <20170725204622.GA4969@mail.hallyn.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mehmet Kayaalp <mkayaalp@cs.binghamton.edu>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        Yuqiong Sun <sunyuqiong1988@gmail.com>,
        containers <containers@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Safford <david.safford@ge.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        ima-devel <linux-ima-devel@lists.sourceforge.net>,
        Yuqiong Sun <suny@us.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 8 Mar 2018 09:04:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20170725204622.GA4969@mail.hallyn.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030814-0020-0000-0000-00000D8F93EA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008635; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000063; UDB=6.00508653; IPR=6.00779393;
 MB=3.00019914; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 14:04:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030814-0021-0000-0000-00006069CE10
Message-Id: <97839865-b0ab-8e5d-114e-0603ef2edf6f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2017 04:46 PM, Serge E. Hallyn wrote:
> On Tue, Jul 25, 2017 at 04:11:29PM -0400, Stefan Berger wrote:
>> On 07/25/2017 03:48 PM, Mimi Zohar wrote:
>>> On Tue, 2017-07-25 at 12:08 -0700, James Bottomley wrote:
>>>> On Tue, 2017-07-25 at 14:04 -0500, Serge E. Hallyn wrote:
>>>>> On Tue, Jul 25, 2017 at 11:49:14AM -0700, James Bottomley wrote:
>>>>>> On Tue, 2017-07-25 at 12:53 -0500, Serge E. Hallyn wrote:
>>>>>>> On Thu, Jul 20, 2017 at 06:50:29PM -0400, Mehmet Kayaalp wrote:
>>>>>>>> From: Yuqiong Sun <suny@us.ibm.com>
>>>>>>>>
>>>>>>>> Add new CONFIG_IMA_NS config option.  Let clone() create a new
>>>>>>>> IMA namespace upon CLONE_NEWNS flag. Add ima_ns data structure
>>>>>>>> in nsproxy. ima_ns is allocated and freed upon IMA namespace
>>>>>>>> creation and exit. Currently, the ima_ns contains no useful IMA
>>>>>>>> data but only a dummy interface. This patch creates the
>>>>>>>> framework for namespacing the different aspects of IMA (eg.
>>>>>>>> IMA-audit, IMA-measurement, IMA-appraisal).
>>>>>>>>
>>>>>>>> Signed-off-by: Yuqiong Sun <suny@us.ibm.com>
>>>>>>>>
>>>>>>>> Changelog:
>>>>>>>> * Use CLONE_NEWNS instead of a new CLONE_NEWIMA flag
>>>>>>> Hi,
>>>>>>>
>>>>>>> So this means that every mount namespace clone will clone a new
>>>>>>> IMA namespace.  Is that really ok?
>>>>>> Based on what: space concerns (struct ima_ns is reasonably small)?
>>>>>> or whether tying it to the mount namespace is the correct thing to
>>>>>> do.  On
>>>>> Mostly the latter.  The other would be not so much space concerns as
>>>>> time concerns.  Many things use new mounts namespaces, and we
>>>>> wouldn't want multiple IMA calls on all file accesses by all of
>>>>> those.
>>>>>
>>>>>> the latter, it does seem that this should be a property of either
>>>>>> the mount or user ns rather than its own separate ns.  I could see
>>>>>> a use where even a container might want multiple ima keyrings
>>>>>> within the container (say containerised apache service with
>>>>>> multiple tenants), so instinct tells me that mount ns is the
>>>>>> correct granularity for this.
>>>>> I wonder whether we could use echo 1 > /sys/kernel/security/ima/newns
>>>>> as the trigger for requesting a new ima ns on the next
>>>>> clone(CLONE_NEWNS).
>>>> I could go with that, but what about the trigger being installing or
>>>> updating the keyring?  That's the only operation that needs namespace
>>>> separation, so on mount ns clone, you get a pointer to the old ima_ns
>>>> until you do something that requires a new key, which then triggers the
>>>> copy of the namespace and installing it?
>>> It isn't just the keyrings that need to be namespaced, but the
>>> measurement list and policy as well.
>>>
>>> IMA-measurement, IMA-appraisal and IMA-audit are all policy based.
>>>
>>> As soon as the namespace starts, measurements should be added to the
>>> namespace specific measurement list, not it's parent.
> Shouldn't it be both?
>
> If not, then it seems to me this must be tied to user namespace.
>
>> IMA is about measuring things, logging what was executed, and
>> finally someone looking at the measurement log and detecting
>> 'things'. So at least one attack that needs to be prevented is a
>> malicious person opening an IMA namespace, executing something
>> malicious, and not leaving any trace on the host because all the
>> logs went into the measurement list of the IMA namespace, which
>> disappeared. That said, I am wondering whether there has to be a
>> minimum set of  namespaces (PID, UTS) providing enough 'isolation'
>> that someone  may actually open an IMA namespace and run their code.
>> To avoid leaving no traces one could argue to implement recursive
>> logging, so something that is logged inside the namespace will be
>> detected in all parent containers up to the init_ima_ns (host)
>> because it's logged (and TPM extended) there as well. The challenge
>> with that is that logging costs memory and that can be abused as
>> well until the machine needs a reboot... I guess the solution could
>> be requesting an IMA namespace in one way or another but requiring
>> several other namespace flags in the clone() to actually 'get' it.
>> Jumping namespaces with setns() may have to be restricted as well
>> once there is an IMA namespace.
> Wait.  So if I create a new IMA namespace, the things I run in
> that namespace are not subject to the parent namespace policy?

We'll let an IMA namespace set its own policy and rules in that policy 
will decide whether the child namespaces' measurements will also be 
logged. This is to avoid a potentially huge log on the host. However, 
the activities of root in namespaces may need to be logged independently 
of what the policy rules say so that root's activities in the TCB will 
always be tracked also if he operates in a temporary mount/IMA namespace 
pair (and sharing the rest of the namespaces with the host).

     Stefan

>
> -serge
>
