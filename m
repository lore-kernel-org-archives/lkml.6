Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7677C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B100F20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1zeoLaw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbfAKQrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:47:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40044 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfAKQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:47:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0BGXuBU070269;
        Fri, 11 Jan 2019 16:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XszuSG1fZq1SXekI14e2rK2zFUxdJHScohOeqKdhnfs=;
 b=1zeoLaw7c6/MLbA/kJDN2XFmA7I43N2NbFhQZ9NerxKsi754M5kMNkr1PDqIG5WRdWzu
 XDL2Tn5OGaI4RQDbldoCIN+BIYYoa6IFaCacqNdicNWshBrh3S+1pI2vtpYkuzyRPy66
 6+G9gCqM32JF5cUgpYE/IGZA4OHCXwh6iE9gHMhbNM83qJVNkvqFhRuSS57S8qNWwPss
 3nmaUaDB2Yykb1KRG0k9Lqwck7ggpxSqhTYBNS/3DDEhOD44YzXMJFy6QW5jbBtfA/vk
 m9hnYN+dMhQaaTNdHZfI+B0XNVSbBMwdDYLLEpVRetVW1yXTMOw5d2TqhaZzTuoBK8/l 5A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ptj3ee6m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 16:46:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0BGkhCD010795
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 16:46:43 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0BGkfw0030830;
        Fri, 11 Jan 2019 16:46:41 GMT
Received: from [10.166.106.34] (/10.166.106.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 08:46:40 -0800
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
To:     Josh Poimboeuf <jpoimboe@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
 <20190110172004.wuh45xoafynfm2df@treble>
 <20190110123243.3b9e0856@gandalf.local.home>
 <20190110174257.GE16556@linux.intel.com>
 <20190110125757.1c8d2870@gandalf.local.home>
 <20190110180428.GG16556@linux.intel.com>
 <e5ea3781-336d-7b03-a22e-5012e915affd@oracle.com>
 <20190111152809.ejutcmqrx4ud3fli@treble>
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
Message-ID: <ad6fae93-4122-7854-aa4c-2facd67ca839@oracle.com>
Date:   Fri, 11 Jan 2019 17:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20190111152809.ejutcmqrx4ud3fli@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=731
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/2019 04:28 PM, Josh Poimboeuf wrote:
> On Fri, Jan 11, 2019 at 01:10:52PM +0100, Alexandre Chartre wrote:
>> To avoid any issue with live patching the call instruction, what about
>> toggling between two call instructions: one would be the currently active
>> call, while the other would currently be inactive but to be used after a
>> change is made. You can safely patch the inactive call and then toggle
>> the call flow (using a jump label) between the active and inactive calls.
>>
>> So instead of having a single call instruction:
>>
>> 	call function
>>
>> You would have:
>>
>> 	STATIC_JUMP_IF_TRUE label, key
>> 	call function1
>> 	jmp done
>> label:
>> 	call function2
>> done:
>>
>> If the key is set so that function1 is currently called then you can
>> safely update the call instruction for function2. Once this is done,
>> just flip the key to make the function2 call active. On a next update,
>> you would, of course, have to switch and update the call for function1.
>
> What about the following race?
>
> CPU1						CPU2
> static key is false, doesn't jump
> task gets preempted before calling function1
> 						change static key to true
> 						start patching "call function1"
> task resumes, sees inconsistent call instruction
>

If the function1 call is active then it won't be changed, you will change
function2. However, I presume you can still have a race but if the function
is changed twice before calling function1:

CPU1						CPU2
static key is false, doesn't jump
task gets preempted before calling function1
                                                 -- first function change --
                                                 patch "call function2"
                                                 change static key to true
                                                 -- second function change --
                                                 start patching "call function1"
task resumes, sees inconsistent call instruction

So right, that's a problem.

alex.
