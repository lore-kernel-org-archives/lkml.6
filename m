Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEROwq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:52:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752060AbeEROwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:52:41 -0400
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com,
        sgrubb@redhat.com
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
 <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
 <1520259854.10396.313.camel@linux.vnet.ibm.com>
 <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
 <efb6c164-febe-67bb-43a9-795476c4902f@linux.vnet.ibm.com>
 <20180517213001.62caslkjwv575xgl@madcap2.tricolour.ca>
 <86df5c2c-9db3-21b9-b91b-30a4f53f9504@linux.vnet.ibm.com>
 <1526647996.3632.164.camel@linux.vnet.ibm.com>
 <ef567d60-42f7-0a87-8597-1ef381e15be0@linux.vnet.ibm.com>
 <1526654395.3632.196.camel@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 10:52:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526654395.3632.196.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18051814-0028-0000-0000-000009A48071
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009047; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01034130; UDB=6.00528830; IPR=6.00813258;
 MB=3.00021186; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-18 14:52:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051814-0029-0000-0000-00003AE27A65
Message-Id: <1347e0c5-40c9-34a4-9c54-60bd2917b2d7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 10:39 AM, Mimi Zohar wrote:
> On Fri, 2018-05-18 at 09:54 -0400, Stefan Berger wrote:
>> On 05/18/2018 08:53 AM, Mimi Zohar wrote:
> [..]
>
>>>>>> If so, which ones? We could probably refactor the current
>>>>>> integrity_audit_message() and have ima_parse_rule() call into it to get
>>>>>> those fields as well. I suppose adding new fields to it wouldn't be
>>>>>> considered breaking user space?
>>>>> Changing the order of existing fields or inserting fields could break
>>>>> stuff and is strongly discouraged without a good reason, but appending
>>>>> fields is usually the right way to add information.
>>>>>
>>>>> There are exceptions, and in this case, I'd pick the "more standard" of
>>>>> the formats for AUDIT_INTEGRITY_RULE (ima_audit_measurement?) and stick
>>>>> with that, abandoning the other format, renaming the less standard
>>>>> version of the record (ima_parse_rule?) and perhpas adopting that
>>>>> abandonned format for the new record type while using
>>>>> current->audit_context.
>>> This sounds right, other than "type=INTEGRITY_RULE" (1805) for
>>> ima_audit_measurement().  Could we rename type=1805 to be
>> So do we want to change both? I thought that what
>> ima_audit_measurement() produces looks ok but may not have a good name
>> for the 'type'. Now in this case I would not want to 'break user space'.
>> The only change I was going to make was to what ima_parse_rule() produces.
> The only change for now is separating the IMA policy rules from the
> IMA-audit messages.
>
> Richard, when the containerid is appended to the IMA-audit messages,
> would we make the audit type name change then?
>
>>> INTEGRITY_AUDIT or INTEGRITY_IMA_AUDIT?  The new type=1806 audit
>>> message could be named INTEGRITY_RULE or, if that would be confusing,
>>> INTEGRITY_POLICY_RULE.
>> For 1806, as we would use it in ima_parse_rule(), we could change that
>> in your patch to INTEGRITY_POLICY_RULE. IMA_POLICY_RULE may be better
>> for IMA to produce but that's inconsistent then.
> Ok

One other question is whether IMA's audit calls should all adhere to 
CONFIG_INTEGRITY_AUDIT. Most do but those two that currently use 
AUDIT_INTEGRITY_RULE do not. Should that be changed as well?

     Stefan
