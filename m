Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C86C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4652220863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i5vXaPuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfBKJ5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:57:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40334 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfBKJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:57:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1B9s6dE195955;
        Mon, 11 Feb 2019 09:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tx/hGOLAYb9A20Lmx0DM4rIi+oXEvDwXVwumj9JR+7g=;
 b=i5vXaPuOf83Xzvb6iIkoYfKEtQ3eE+wPAT/y1uhfJdujyGZ36vZk7Il8cftQQvqlqEZK
 8UqJW0/HyMQfajgn+puz7RY/EXv8SAOUr5tD3wJMZWWhgF6rfMhzNYibVmeROmPPpsob
 nj/4Zloi40BiIKICXs/W+wM5Atc70IG60Cx6IkwI9krzk7ovxrpBl+Em5IrpbYXF6Ww3
 JaWf/KNZQ9nI6eXZ6r/vo5nJZfI0wzQQjlGfEzDsjW5T4+ZxOpOX4qyFhukxbOMeB6fG
 iN5W18XbMQd2MEPAdDJqSKcMFcLAkMz8ZtlGwjRvLvDL+lDWN4pI3ka3MxS1Md3L3PEl vQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qhredmref-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 09:57:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1B9vQIP019058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 09:57:26 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1B9vPw2018438;
        Mon, 11 Feb 2019 09:57:25 GMT
Received: from [10.166.106.34] (/10.166.106.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Feb 2019 01:57:25 -0800
Subject: Re: [PATCH] x86/alternatives: check int3 breakpoint physical
 addresses
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1548428249-8258-1-git-send-email-alexandre.chartre@oracle.com>
 <alpine.DEB.2.21.1902102221500.8784@nanos.tec.linutronix.de>
 <8995b3b4-b805-c8c7-95a8-a39ab000f289@oracle.com>
 <alpine.DEB.2.21.1902111012130.1728@nanos.tec.linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <771b5877-4cb6-203b-fd95-ed63f9736373@oracle.com>
Date:   Mon, 11 Feb 2019 10:57:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902111012130.1728@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/11/2019 10:15 AM, Thomas Gleixner wrote:
> On Mon, 11 Feb 2019, Alexandre Chartre wrote:
>> On 02/10/2019 10:23 PM, Thomas Gleixner wrote:
>>> On Fri, 25 Jan 2019, Alexandre Chartre wrote:
>>>> Note that this issue has been observed and reproduced with a custom kernel
>>>> with some code mapped to different virtual addresses and using jump labels
>>>> As jump labels use text_poke_bp(), crashes were sometimes observed when
>>>> updating jump labels.
>>>
>>> Rightfully so. text_poke_bp() pokes at the kernels text mapping which is
>>> very well defined and unique. Why would you map the same text to different
>>> virtual addresses and then use a randomly chosen one to poke at it?
>>>
>>
>> As an example, we used to have per-CPU SYSCALL entry trampoline [1] where the
>> entry_SYSCALL_64_trampoline function was mapped to a different virtual address
>> for each CPU. So, a syscall would execute entry_SYSCALL_64_trampoline() from a
>> different virtual address depending on the CPU being used. With that code,
>> adding a jump label in entry_SYSCALL_64_trampoline() causes the described
>> issue.
>
> Right, but we knew that and there was no reason to put a jump label into
> that. AFAICT we don't have anything like this in the kernel.

In our particular case, we have introduced a jump label in JMP_NOSPEC (which
is used by entry_SYSCALL_64_trampoline()) to have the option to dynamically
enable/disable retpoline at runtime. So that's when we faced this issue.

> That said, I'm not opposed to apply the patch as is, I just wanted to get a
> better understanding about the background.

Sure. I am aware this is a corner case, and I was precisely looking for feedback
to check if it is worth fixing that issue. So I appreciate your reply, and I would
understand if the patch is rejected because that's a case that we are just not
expecting to happen.

Thanks,

alex.
