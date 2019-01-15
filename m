Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D8C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97DF2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gw6MffiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfAOQql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:46:41 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45490 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbfAOQqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:46:39 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0FGiVHv182336;
        Tue, 15 Jan 2019 16:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vYN3Wa4WA3seGNM3yDkDJI2Gg7kd/BkbR5tZIJvZ2/E=;
 b=gw6MffiETgxOnhsICVo8rKjGm13UHsDlE3Ob66AZrOf06RGHAGqs9EPq+69N/GiWA7bU
 AT7Ob33m5Q4EK8t3DrJUhxpiT1POzf+aJwuE2W/cX+aS3jEcbgFvoh4MnS5VWkcb1Jtc
 G0SeTE5omDWYqJT2uAvjXFjY62Z29ANTBS+ij7xU6J76hC7J2Gb/VfusOZjepFXDDwFv
 AO5GZB2NB7pW8bk1qGNzpG7e8YQwR4OIWq+evRAvyFXxTyhpLor5O97Ehxm1Z1tvIowQ
 AW8dvOya07+9bmBdo0aTWbM/wGs8sR9Vvo7MvMkDweFVEpU9AXv+4HRZnH19IYEOolSd 3Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pybjnn0pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 16:45:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0FGjWwn025842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 16:45:33 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0FGjU6H001837;
        Tue, 15 Jan 2019 16:45:31 GMT
Received: from [10.166.106.34] (/10.166.106.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jan 2019 08:45:30 -0800
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
To:     Steven Rostedt <rostedt@goodmis.org>
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
 <49f9bb3d-7b65-06e8-b0b3-42cf7f0a82b5@oracle.com>
 <20190115111922.153240f0@gandalf.local.home>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
Message-ID: <9b409d36-f265-e2d8-eafc-264e7dd0992c@oracle.com>
Date:   Tue, 15 Jan 2019 17:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20190115111922.153240f0@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901150139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/15/2019 05:19 PM, Steven Rostedt wrote:
> On Tue, 15 Jan 2019 12:10:19 +0100
> Alexandre Chartre <alexandre.chartre@oracle.com> wrote:
>
>> Thinking more about it (and I've probably missed something or I am just being
>> totally stupid because this seems way too simple), can't we just replace the
>> "call" with "push+jmp" and patch the jmp instruction?
>>
>> Instead of having:
>>
>>      call target
>>
>> Have:
>>
>>      push $done
>> static_call:
>>      jmp target
>> done:
>
> But how do you implement it? Inline assembly()? Then you need to be
> able to do that for any type of function parameters (there will be
> users that have 13 parameters!)
>
> I believe people have mentioned having a gcc plugin that would do it
> for us, which was one of the suggested solutions.
>

Ah okay, I think I get it now (hopefully; I probably lost track of the
discussion at some point), so Linus' latest proposal avoids the gcc
plugin by keeping the call as is, and deals with it in the int3 handler
+ thunk.

Thanks, and sorry for the noise.

alex.

>>
>> Then we can safely patch the "jmp" instruction to jump to a new target
>> with text_poke_bp(), using the new target as the text_poke_bp() handler:
>>
>>    new_jmp_code = opcode of "jmp new_target"
>>
>>    text_poke_bp(static_call, new_jmp_code, new_jmp_code_size, new_target);
>>
>> Problems come with patching a call instruction, but there's no issue with patching
>> a jmp, no? (that's what jump labels do).
>>
>> No change to the int3 handler, no thunk, this seems really too simple... :-)
>
