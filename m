Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D855C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F062077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t3AU7920"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfBVAgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:36:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfBVAgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:36:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1M0Jhe4102989;
        Fri, 22 Feb 2019 00:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tNvvWZu62RaFZarT5xmCp0jGGaa9rpDXTAogXOLKyHY=;
 b=t3AU7920DrRjzEP/WBt0HqqUAPBNYwHKEMudo4A3oMx6XtgSSYU0RbOfiA89NKCTAOhS
 /NHW42wEzsEzTv/nnPj9JzmEbUXN9crObOFasGsM//hinD5J/iDr+3ZHKvFHnKYh4s+F
 qDpYld4TKIscvIDHM3IVwUJqVHivEKDbGzf6WsA81GhnX/FxDY7TfMPa6taHh8vrby0U
 Gh73LtYK++2zSc4LonW5w4eiSGPvdA/iYG/D5NVsjNhhcvfpJJYCU1mlPQeNJNc9BuaK
 u1H1Qwtg9EDwsEmkZBJ6Xjg/5+BIMQJyCFpksLgxMpAzAuZ2GyVAFUdVGsgPjoas8Prm lg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xubmuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 00:36:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1M0aOWf001972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 00:36:24 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1M0aNc3004281;
        Fri, 22 Feb 2019 00:36:23 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 16:36:23 -0800
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <e73e1b19-5418-32c8-584c-823618de67ce@oracle.com>
 <20190221140348.GR32494@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <a7978d52-9d7e-9b64-6092-ec9322d62646@oracle.com>
Date:   Thu, 21 Feb 2019 16:34:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221140348.GR32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/19 6:03 AM, Peter Zijlstra wrote:
> On Wed, Feb 20, 2019 at 06:53:08PM -0800, Subhra Mazumdar wrote:
>> On 2/18/19 9:49 AM, Linus Torvalds wrote:
>>> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>> However; whichever way around you turn this cookie; it is expensive and nasty.
>>> Do you (or anybody else) have numbers for real loads?
>>>
>>> Because performance is all that matters. If performance is bad, then
>>> it's pointless, since just turning off SMT is the answer.
>>>
>>>                     Linus
>> I tested 2 Oracle DB instances running OLTP on a 2 socket 44 cores system.
>> This is on baremetal, no virtualization.
> I'm thinking oracle schedules quite a bit, right? Then you get massive
> overhead (as shown).
>
Out of curiosity I ran the patchset from Amazon with the same setup to see
if performance wise it was any better. But it looks equally bad. At 32
users it performed even worse and the idle time increased much more. Only
good thing about it was it was being fair to both the instances as seen in
the low %stdev

Users  Baseline %stdev  %idle  cosched     %stdev %idle
16     1        2.9     66     0.93(-7%)   1.1 69
24     1        11.3    53     0.87(-13%)  11.2 61
32     1        7       41     0.66(-34%)  5.3     54
