Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A17C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656B020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mW0l03HW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfAOLLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:11:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54012 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfAOLLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:11:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0FB9PSt145206;
        Tue, 15 Jan 2019 11:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DVfkuCXhWZJXPdaqCoGkQgjDniREU8xq+05997UEx4s=;
 b=mW0l03HWDWSL/dJ/x7YgLI8vRc+MxNsXgQNt74buLO+vTva2dW2TTlV8eO0Ac9IsNmS4
 V7f/WN+4o1L2aWEtJlid2RJCkWr785El1Oh7MfX9RqgNIrmJToxHIdWHxO4fnNtYaouM
 ZA4M7bOVYvvb8MFrEcoV5AiyKYBT3K0OUPnj/kac1gVM5Qzg8JWQ0VJad1ChQ79qpNmQ
 q2mIOVglFJf9pBWMD3Z5wX8kT9kx/DvQekKqeyD3orYVNPEVIrawORgKtd0+PFICeph+
 FqZ1uv/zHLSZf40VhTGGLGxWfRUeYu0+RfvGtKAiFaAQjfXW04I/sgqSIOHW2OtlCyn6 Lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pybkcb9p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 11:10:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0FBAQlT016587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 11:10:26 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0FBAOHV003183;
        Tue, 15 Jan 2019 11:10:24 GMT
Received: from [10.166.106.34] (/10.166.106.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jan 2019 03:10:24 -0800
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
To:     Josh Poimboeuf <jpoimboe@redhat.com>
References: <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
 <20190110172004.wuh45xoafynfm2df@treble>
 <20190110123243.3b9e0856@gandalf.local.home>
 <20190110174257.GE16556@linux.intel.com>
 <20190110125757.1c8d2870@gandalf.local.home>
 <20190110180428.GG16556@linux.intel.com>
 <e5ea3781-336d-7b03-a22e-5012e915affd@oracle.com>
 <20190111152809.ejutcmqrx4ud3fli@treble>
 <ad6fae93-4122-7854-aa4c-2facd67ca839@oracle.com>
 <20190111165752.z6e2dfktj2caqi4n@treble>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nadav Amit <namit@vmware.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <49f9bb3d-7b65-06e8-b0b3-42cf7f0a82b5@oracle.com>
Date:   Tue, 15 Jan 2019 12:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20190111165752.z6e2dfktj2caqi4n@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9136 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901150095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/11/2019 05:57 PM, Josh Poimboeuf wrote:
> On Fri, Jan 11, 2019 at 05:46:36PM +0100, Alexandre Chartre wrote:
>>
>>
>> On 01/11/2019 04:28 PM, Josh Poimboeuf wrote:
>>> On Fri, Jan 11, 2019 at 01:10:52PM +0100, Alexandre Chartre wrote:
>>>> To avoid any issue with live patching the call instruction, what about
>>>> toggling between two call instructions: one would be the currently active
>>>> call, while the other would currently be inactive but to be used after a
>>>> change is made. You can safely patch the inactive call and then toggle
>>>> the call flow (using a jump label) between the active and inactive calls.
>>>>
>>>> So instead of having a single call instruction:
>>>>
>>>> 	call function
>>>>
>>>> You would have:
>>>>
>>>> 	STATIC_JUMP_IF_TRUE label, key
>>>> 	call function1
>>>> 	jmp done
>>>> label:
>>>> 	call function2
>>>> done:
>>>>
>>>> If the key is set so that function1 is currently called then you can
>>>> safely update the call instruction for function2. Once this is done,
>>>> just flip the key to make the function2 call active. On a next update,
>>>> you would, of course, have to switch and update the call for function1.
>>>
>>> What about the following race?
>>>
>>> CPU1						CPU2
>>> static key is false, doesn't jump
>>> task gets preempted before calling function1
>>> 						change static key to true
>>> 						start patching "call function1"
>>> task resumes, sees inconsistent call instruction
>>>
>>
>> If the function1 call is active then it won't be changed, you will change
>> function2. However, I presume you can still have a race but if the function
>> is changed twice before calling function1:
>>
>> CPU1						CPU2
>> static key is false, doesn't jump
>> task gets preempted before calling function1
>>                                                 -- first function change --
>>                                                 patch "call function2"
>>                                                 change static key to true
>>                                                 -- second function change --
>>                                                 start patching "call function1"
>> task resumes, sees inconsistent call instruction
>>
>> So right, that's a problem.
>
> Right, that's what I meant to say :-)
>

Thinking more about it (and I've probably missed something or I am just being
totally stupid because this seems way too simple), can't we just replace the
"call" with "push+jmp" and patch the jmp instruction?

Instead of having:

     call target

Have:

     push $done
static_call:
     jmp target
done:

Then we can safely patch the "jmp" instruction to jump to a new target
with text_poke_bp(), using the new target as the text_poke_bp() handler:

   new_jmp_code = opcode of "jmp new_target"

   text_poke_bp(static_call, new_jmp_code, new_jmp_code_size, new_target);

Problems come with patching a call instruction, but there's no issue with patching
a jmp, no? (that's what jump labels do).

No change to the int3 handler, no thunk, this seems really too simple... :-)


alex.
