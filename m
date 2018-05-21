Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeEUSEU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:04:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753595AbeEUSEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:04:15 -0400
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
To: Steve Grubb <sgrubb@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
 <20180518155659.porewd6moctumkys@madcap2.tricolour.ca>
 <1526661264.3404.55.camel@linux.vnet.ibm.com> <5705556.pzqfGOkdjC@x2>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 21 May 2018 14:04:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5705556.pzqfGOkdjC@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18052118-0008-0000-0000-000009D37E11
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009062; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035634; UDB=6.00529728; IPR=6.00814762;
 MB=3.00021227; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-21 18:04:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052118-0009-0000-0000-000047621721
Message-Id: <7abd3460-0797-f003-12c7-7329beb0835b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805210214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 01:21 PM, Steve Grubb wrote:
> On Friday, May 18, 2018 12:34:24 PM EDT Mimi Zohar wrote:
>> On Fri, 2018-05-18 at 11:56 -0400, Richard Guy Briggs wrote:
>>> On 2018-05-18 10:39, Mimi Zohar wrote:
>>>> On Fri, 2018-05-18 at 09:54 -0400, Stefan Berger wrote:
>>>>> On 05/18/2018 08:53 AM, Mimi Zohar wrote:
>>>> [..]
>>>>
>>>>>>>>> If so, which ones? We could probably refactor the current
>>>>>>>>> integrity_audit_message() and have ima_parse_rule() call into it
>>>>>>>>> to get
>>>>>>>>> those fields as well. I suppose adding new fields to it wouldn't
>>>>>>>>> be
>>>>>>>>> considered breaking user space?
>>>>>>>> Changing the order of existing fields or inserting fields could
>>>>>>>> break
>>>>>>>> stuff and is strongly discouraged without a good reason, but
>>>>>>>> appending
>>>>>>>> fields is usually the right way to add information.
>>>>>>>>
>>>>>>>> There are exceptions, and in this case, I'd pick the "more
>>>>>>>> standard" of
>>>>>>>> the formats for AUDIT_INTEGRITY_RULE (ima_audit_measurement?) and
>>>>>>>> stick
>>>>>>>> with that, abandoning the other format, renaming the less
>>>>>>>> standard
>>>>>>>> version of the record (ima_parse_rule?) and perhpas adopting that
>>>>>>>> abandonned format for the new record type while using
>>>>>>>> current->audit_context.
>>>>>> This sounds right, other than "type=INTEGRITY_RULE" (1805) for
>>>>>> ima_audit_measurement().  Could we rename type=1805 to be
>>>>> So do we want to change both? I thought that what
>>>>> ima_audit_measurement() produces looks ok but may not have a good
>>>>> name
>>>>> for the 'type'. Now in this case I would not want to 'break user
>>>>> space'.
>>>>> The only change I was going to make was to what ima_parse_rule()
>>>>> produces.
>>>> The only change for now is separating the IMA policy rules from the
>>>> IMA-audit messages.
>>>>
>>>> Richard, when the containerid is appended to the IMA-audit messages,
>>>> would we make the audit type name change then?
>>> No, go ahead and make the change now.  I'm expecting that the
>>> containerid record will just be another auxiliary record and should not
>>> affect you folks.
>> To summarize, we need to disambiguate the 1805, as both
>> ima_parse_rule() and ima_audit_measurement() are using the same number
>> with different formats.  The main usage of 1805 that we are aware of
>> is ima_audit_measurement().  Yet the "type=" name for
>> ima_audit_measurement() should be INTEGRITY_IMA_AUDIT, not
>> INTEGRITY_RULE.
>>
>> option 1: breaks both uses
>> 1805 - INTEGRITY_IMA_AUDIT - ima_audit_measurement()
>> 1806 - INTEGRITY_POLICY_RULE - ima_parse_rule()
>>
>> option 2: breaks the most common usage
>> 1805 - INTEGRITY_RULE - ima_parse_rule()
>> 1806 - INTEGRITY_IMA_AUDIT - ima_audit_measurement()
>>
>> option 3: leaves the most common usage with the wrong name, and breaks
>> the other less common usage
>> 1805 - INTEGRITY_RULE - ima_audit_measurement()
>> 1806 - INTEGRITY_POLICY_RULE - ima_parse_rule()
>>
>> So option 3 is the best option?
>  From a user space perspective, I don't care as long the event is well formed

Are you saying this because of the tools you referred to that require 
proper ordering and all fields need to be available?

> (No unnecessary untrusted string logging) and we have the required fields for
> searching: pid, uid, auid, tty, session, subj, comm, exe, & res. And the
> object is identifiable in the event.

There's at least one documented user that showed the existing format...

https://www.fireeye.com/blog/threat-research/2016/11/extending_linux_exec.html
