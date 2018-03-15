Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeCOTPe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:15:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752875AbeCOTPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:15:32 -0400
Subject: Re: [RFC PATCH v2 1/3] ima: extend clone() with IMA namespace support
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
 <20180309201421.6150-2-stefanb@linux.vnet.ibm.com>
 <87vadxfwqj.fsf@xmission.com>
 <c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
 <1521135192.5348.64.camel@HansenPartnership.com>
 <2183a3b4-6270-d2e9-70ad-a7399eb1681c@linux.vnet.ibm.com>
 <1521139535.5348.89.camel@HansenPartnership.com>
 <0dc5b856-8dc6-7b5a-eeac-febd19f6498c@linux.vnet.ibm.com>
 <1521140467.5348.94.camel@HansenPartnership.com>
Cc: mkayaalp@cs.binghamton.edu,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>, sunyuqiong1988@gmail.com,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        david.safford@ge.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 15:15:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1521140467.5348.94.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031519-0056-0000-0000-0000042E4380
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008680; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003521; UDB=6.00510720; IPR=6.00782848;
 MB=3.00020055; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-15 19:15:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031519-0057-0000-0000-000008704557
Message-Id: <056e5b9e-b4d3-1862-baea-06dda4bd0713@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150209
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 03:01 PM, James Bottomley wrote:
> On Thu, 2018-03-15 at 14:51 -0400, Stefan Berger wrote:
>> On 03/15/2018 02:45 PM, James Bottomley wrote:
> [...]
>>>>> going to need some type of keyring namespace and there's
>>>>> already
>>>>> one hanging off the user_ns:
>>>>>
>>>>> commit f36f8c75ae2e7d4da34f4c908cebdb4aa42c977e
>>>>> Author: David Howells <dhowells@redhat.com>
>>>>> Date:   Tue Sep 24 10:35:19 2013 +0100
>>>>>
>>>>>        KEYS: Add per-user_namespace registers for persistent
>>>>> per-UID
>>>>> kerberos caches
>>>> The benefit for IMA would be that this would then tie the keys
>>>> needed for appraising to the IMA namespace's policy.
>>>> However, if you have an appraise policy in your IMA namespace,
>>>> which is now hooked to the user namespace, and you join that user
>>>> namespace but your files don't have signatures, nothing will
>>>> execute anymore. That's now a side effect of joining this user
>>>> namespace unless we have a magic  exception. My feeling is,
>>>> people may not like that...
>>> Agree, but I think the magic might be to populate the ima keyring
>>> with the parent on user_ns creation.  That way the user_ns owner
>>> can delete the parent keys if they don't like them, but by default
>>> the parent appraisal policy should just work.
>> That may add keys to your keyring but doesn't get you signatures on
>> your  files.
> But it doesn't need to.  The only way we'd get a failure is if the file
> is already being appraised and we lose access to the key.  If the

Well, the configuration I talked about above was assuming that we have 
an appraisal policy active in the IMA namespace, which is now tied to 
the user namespace that was just joined.

If we are fine with the side effects of an IMA policy active as part of 
a user namespace then let's go with it. The side effects in case of an 
active IMA appraisal may then be that files cannot be read/accessed, or 
file measurements or IMA auditing may occur.

The alternative is we have an independent IMA namespace. If one joins 
the USER namespace and there are no IMA-related side effects. If one 
joins the IMA namespace its IMA policy should start being enforced. If 
the current active USER namespace has the keys that go with the 
signatures of the filesystem, then we're fine from the appraisal 
perspective. If not, then IMA namespace joining may prevent file accesses.

> parent policy isn't appraisal, entering the IMA NS won't cause

Why parent policy? The policy of the namespace that was joined should be 
the active one, no ?

> appraisal to be turned on unless the owner asks for it, in which case
> it's caveat emptor: As it works today, if as root I add a default
> appraisal policy to IMA without either a key or xattrs, I get an
> unusable system.

    Stefan

>
> James
>
