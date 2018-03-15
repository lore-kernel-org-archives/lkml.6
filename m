Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeCOTtL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:49:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751970AbeCOTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:49:09 -0400
Subject: Re: [RFC PATCH v2 1/3] ima: extend clone() with IMA namespace support
To: "Eric W. Biederman" <ebiederm@xmission.com>
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
 <20180309201421.6150-2-stefanb@linux.vnet.ibm.com>
 <87vadxfwqj.fsf@xmission.com>
 <c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
 <1521135192.5348.64.camel@HansenPartnership.com>
 <2183a3b4-6270-d2e9-70ad-a7399eb1681c@linux.vnet.ibm.com>
 <1521139535.5348.89.camel@HansenPartnership.com>
 <0dc5b856-8dc6-7b5a-eeac-febd19f6498c@linux.vnet.ibm.com>
 <1521140467.5348.94.camel@HansenPartnership.com>
 <056e5b9e-b4d3-1862-baea-06dda4bd0713@linux.vnet.ibm.com>
 <87sh915eo0.fsf@xmission.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        mkayaalp@cs.binghamton.edu,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>, sunyuqiong1988@gmail.com,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        david.safford@ge.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 15:49:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <87sh915eo0.fsf@xmission.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031519-8235-0000-0000-00000D2AB11A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008680; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003532; UDB=6.00510728; IPR=6.00782859;
 MB=3.00020055; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-15 19:49:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031519-8236-0000-0000-00004013651D
Message-Id: <19ecc296-b584-4e1a-5369-30090fbc7880@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 03:20 PM, Eric W. Biederman wrote:
> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
>
>> On 03/15/2018 03:01 PM, James Bottomley wrote:
>>> On Thu, 2018-03-15 at 14:51 -0400, Stefan Berger wrote:
>>>> On 03/15/2018 02:45 PM, James Bottomley wrote:
>>> [...]
>>>>>>> going to need some type of keyring namespace and there's
>>>>>>> already
>>>>>>> one hanging off the user_ns:
>>>>>>>
>>>>>>> commit f36f8c75ae2e7d4da34f4c908cebdb4aa42c977e
>>>>>>> Author: David Howells <dhowells@redhat.com>
>>>>>>> Date:   Tue Sep 24 10:35:19 2013 +0100
>>>>>>>
>>>>>>>         KEYS: Add per-user_namespace registers for persistent
>>>>>>> per-UID
>>>>>>> kerberos caches
>>>>>> The benefit for IMA would be that this would then tie the keys
>>>>>> needed for appraising to the IMA namespace's policy.
>>>>>> However, if you have an appraise policy in your IMA namespace,
>>>>>> which is now hooked to the user namespace, and you join that user
>>>>>> namespace but your files don't have signatures, nothing will
>>>>>> execute anymore. That's now a side effect of joining this user
>>>>>> namespace unless we have a magic  exception. My feeling is,
>>>>>> people may not like that...
>>>>> Agree, but I think the magic might be to populate the ima keyring
>>>>> with the parent on user_ns creation.  That way the user_ns owner
>>>>> can delete the parent keys if they don't like them, but by default
>>>>> the parent appraisal policy should just work.
>>>> That may add keys to your keyring but doesn't get you signatures on
>>>> your  files.
>>> But it doesn't need to.  The only way we'd get a failure is if the file
>>> is already being appraised and we lose access to the key.  If the
>> Well, the configuration I talked about above was assuming that we have
>> an appraisal policy active in the IMA namespace, which is now tied to
>> the user namespace that was just joined.
>>
>> If we are fine with the side effects of an IMA policy active as part
>> of a user namespace then let's go with it. The side effects in case of
>> an active IMA appraisal may then be that files cannot be
>> read/accessed, or file measurements or IMA auditing may occur.
>>
>> The alternative is we have an independent IMA namespace. If one joins
>> the USER namespace and there are no IMA-related side effects. If one
>> joins the IMA namespace its IMA policy should start being enforced. If
>> the current active USER namespace has the keys that go with the
>> signatures of the filesystem, then we're fine from the appraisal
>> perspective. If not, then IMA namespace joining may prevent file
>> accesses.
>>
>>> parent policy isn't appraisal, entering the IMA NS won't cause
>> Why parent policy? The policy of the namespace that was joined should
>> be the active one, no ?
> Unless I am completely blind we should never stop enforcing the parent's
> polciy.  We should only add policy to enforce for the scope of a
> container.

What we want is an independent policy for each IMA namespace.

What we don't want is that root can abuse his power to spawn new 
namespaces and circumvent a file appraisal policy on the host (in 
init_ima_ns). Because of that root's activities are subject to the IMA 
policy of the currently active IMA namespace and the one of init_ima_ns 
(and possibly all the ones in between). If root is working in a child 
IMA namespace and file appraisal fails due to the policy in init_ima_ns 
and keys found in .ima or _ima keyrings attached to init_user_ns, the 
file access will be denied.

Besides that root's activities will always be measured and audited 
following the policy in init_ima_ns. This tries to prevent that root 
spawns an IMA namespace with a NULL policy and does things in the TCB 
and tries to escape the logging.

>
> In practice this is just the containers policy as the container is most
> likely a do whatever you want to in the parent policy.  But not always
> and not explicitly.
>
> Mount namespaces are not hierarchical, user namespaces are.  Which makes
> them much more appropriate for being part of nested policy enforcement.

We don't want additive or hierarchical policies - at least I don't. They 
should be independent. Only exception are activities of root that are 
always iteratively evaluated against policies of the current IMA NS and 
the init_ima_ns and possibly all the ones in between.

>
>  From previous conversations I remember that there is a legitimate
> bootstrap problem for IMA.  That needs to be looked at, and I am not
> seeing that mentioned.

IMA's log should not have a gap. So ideally we shouldn't have to write 
something into sysfs to spawn a new IMA namespace so that we don't miss 
whatever setup may have happened to get there, including the writing 
into procfs. IMA should be there right from the start. So a clone flag 
would be ideal for that.

>
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
