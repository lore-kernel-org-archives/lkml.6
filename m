Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03642C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4882146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3hS5xDlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBUCzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:55:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39186 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBUCzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 21:55:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1L2nDGd002699;
        Thu, 21 Feb 2019 02:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uiDp4t+EQswvCO5nmYj4R3W/t+QWzPqm8VF7HmrzOO0=;
 b=3hS5xDlLotOHvyCqqNPG6Dl95ggabCezCKU/uhDIjRdiDZ28gsmNTexyAc0eCjr/ABtG
 DHejBZdSmaOzQxisg0kfLQaW2yaDv6uUY2skU/mkNNEKsHhjTXfH1rlfuXi8vm5VbxxJ
 XTUbZEmyPSvKQ/rgNJIY65wjQJR8MPe3OUkXHVzNwHkROc4H6MSzTqN6wd32xYd6wu9g
 IRTykZusO75HV82yAguetNXHy31qjXjSJu0kBqZ61SZtXPuAC2KX4atKC8U0I71r97B0
 w8qp7L5hTxJ7RiMC5jfPaJSh7mfDmHgJQspe4Dtzi24m0J0prtWNZwGO8VhuA8mpbgGr eg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qpb5rn9bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 02:55:20 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1L2tIZQ009546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 02:55:19 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1L2tHuQ000668;
        Thu, 21 Feb 2019 02:55:17 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 18:55:17 -0800
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <e73e1b19-5418-32c8-584c-823618de67ce@oracle.com>
Date:   Wed, 20 Feb 2019 18:53:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/18/19 9:49 AM, Linus Torvalds wrote:
> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> However; whichever way around you turn this cookie; it is expensive and nasty.
> Do you (or anybody else) have numbers for real loads?
>
> Because performance is all that matters. If performance is bad, then
> it's pointless, since just turning off SMT is the answer.
>
>                    Linus
I tested 2 Oracle DB instances running OLTP on a 2 socket 44 cores system.
This is on baremetal, no virtualization.  In all cases I put each DB
instance in separate cpu cgroup. Following are the avg throughput numbers
of the 2 instances. %stdev is the standard deviation between the 2
instances.

Baseline = build w/o CONFIG_SCHED_CORE
core_sched = build w/ CONFIG_SCHED_CORE
HT_disable = offlined sibling HT with baseline

Users  Baseline  %stdev  core_sched     %stdev HT_disable       %stdev
16     997768    3.28    808193(-19%)   34 1053888(+5.6%)   2.9
24     1157314   9.4     974555(-15.8%) 40.5 1197904(+3.5%)   4.6
32     1693644   6.4     1237195(-27%)  42.8 1308180(-22.8%)  5.3

The regressions are substantial. Also noticed one of the DB instances was
having much less throughput than the other with core scheduling which
brought down the avg and also reflected in the very high %stdev. Disabling
HT has effect at 32 users but still better than core scheduling both in
terms of avg and %stdev. There are some issue with the DB setup for which
I couldn't go beyond 32 users.
