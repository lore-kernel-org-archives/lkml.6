Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81238206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y25+lGZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfAKMMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:12:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60360 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfAKMMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:12:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0BC3Utl088081;
        Fri, 11 Jan 2019 12:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=J1loELk5fnUBHMw6fY05PpM1bcIMpaN+f0UufcBRWBw=;
 b=Y25+lGZNW7iXWCujsEHN72Uk1Fy2FlsBKo88+ZXc/0OId4tD4onqD0ZoKxYtxJ/9pjS4
 kP13GozJvMDZ6mw0vSoANPVoB1rW1Bw6LfLjBdruBK29+3cpO2TvQ9sJlp+Ow4iciQ7m
 tpc8EfjbDHxRTE8mLEgMIucsMuA3KA/dmPIMu+Zqi28VzbDAgUvaYJAzk2d8hJNoSRQP
 HZsaYybrRz6UATwlPnh9eJkVmNun1nfc2BdDmNseY6IUfvJ4ZCrrrGC+hXSSoja0dHK7
 CaUr5YKXQ3xUoz8FcHaM4IWZg7xocL3OeJrFnf8tiqq7jQEYey5Ya8ovv5ZaB7l40oel Sg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2ptm0umk8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 12:11:00 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0BCAwRs022996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 12:10:59 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0BCAvWK023346;
        Fri, 11 Jan 2019 12:10:57 GMT
Received: from [10.166.106.34] (/10.166.106.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 04:10:57 -0800
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
 <20190110172004.wuh45xoafynfm2df@treble>
 <20190110123243.3b9e0856@gandalf.local.home>
 <20190110174257.GE16556@linux.intel.com>
 <20190110125757.1c8d2870@gandalf.local.home>
 <20190110180428.GG16556@linux.intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <e5ea3781-336d-7b03-a22e-5012e915affd@oracle.com>
Date:   Fri, 11 Jan 2019 13:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20190110180428.GG16556@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=942
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2019 07:04 PM, Sean Christopherson wrote:
> On Thu, Jan 10, 2019 at 12:57:57PM -0500, Steven Rostedt wrote:
>> On Thu, 10 Jan 2019 09:42:57 -0800
>> Sean Christopherson <sean.j.christopherson@intel.com> wrote:
>>
>>> On Thu, Jan 10, 2019 at 12:32:43PM -0500, Steven Rostedt wrote:
>>>> On Thu, 10 Jan 2019 11:20:04 -0600
>>>> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>>>
>>>>
>>>>>> While I can't find a reason for hypervisors to emulate this instruction,
>>>>>> smarter people might find ways to turn it into a security exploit.
>>>>>
>>>>> Interesting point... but I wonder if it's a realistic concern.  BTW,
>>>>> text_poke_bp() also relies on undocumented behavior.
>>>>
>>>> But we did get an official OK from Intel that it will work. Took a bit
>>>> of arm twisting to get them to do so, but they did. And it really is
>>>> pretty robust.
>>>
>>> Did we (they?) list any caveats for this behavior?  E.g. I'm fairly
>>> certain atomicity guarantees go out the window if WC memtype is used.
>>
>> Note, the text_poke_bp() process was this: (nothing to do with atomic
>> guarantees)
>>
>> add breakpoint (one byte) to instruction.
>>
>> Sync all cores (send an IPI to each one).
>>
>> change the back half of the instruction (the rest of the instruction
>> after the breakpoint).
>>
>> Sync all cores
>>
>> Remove the breakpoint with the new byte of the new instruction.
>>
>>
>> What atomicity guarantee does the above require?
>
> I was asking in the context of static calls.  My understanding is that
> the write to change the imm32 of the CALL needs to be atomic from a
> code fetch perspective so that we don't jump to a junk address.
>

To avoid any issue with live patching the call instruction, what about
toggling between two call instructions: one would be the currently active
call, while the other would currently be inactive but to be used after a
change is made. You can safely patch the inactive call and then toggle
the call flow (using a jump label) between the active and inactive calls.

So instead of having a single call instruction:

	call function

You would have:

	STATIC_JUMP_IF_TRUE label, key
	call function1
	jmp done
label:
	call function2
done:

If the key is set so that function1 is currently called then you can
safely update the call instruction for function2. Once this is done,
just flip the key to make the function2 call active. On a next update,
you would, of course, have to switch and update the call for function1.


alex.
