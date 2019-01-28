Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A85A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JsrI9Aox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfA1I10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:27:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39774 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1I1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:27:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0S8O1fH038278;
        Mon, 28 Jan 2019 08:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ai7blyowJ2j+dSzy/4760bLhpzysP1SImAKTnUQ7Pqs=;
 b=JsrI9AoxbrD1sE06sBNKwigX7sFC2w6tR+Fc9lFqcYqeTLUHZte0HmBdteGAIWYxraPU
 l2MQ7uuDa0w6TSezG2EUNBSrTI9SibNuVZv3hgUZvHTZJDxg1g199VpbwtpgzfzqCtqw
 aKJxnRPKZM9S9Fc4BzA7uE5f5nlPj+3Hj/ax1ZZt21m+CZRMPxh0Se5zmKRbvnCRHok2
 chwIj10AFPyJVgi91nAKsDCYozov0Yf+/LEsNifO2lU07KKH0e7EUb+FzN2kuFHfdpQ8
 Ec86UJWymo+x+l1iIN1p3kKTPJgUetLh7iz7VuhfbTw5HKM009p/bSgZe3dYe/VSwt0s Hg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2q8g6qvhn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 08:26:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0S8Qtul011364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 08:26:55 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0S8Qsg0026129;
        Mon, 28 Jan 2019 08:26:54 GMT
Received: from [192.168.0.118] (/171.117.190.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 00:26:54 -0800
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] x86/speculation: Update TIF_SPEC_IB before ibpb barrier
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, srinivas.eeda@oracle.com,
        bp@suse.de, tim.c.chen@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com
References: <48a105d3-fa32-40e4-9775-37d49f42eac0@default>
 <alpine.DEB.2.21.1901231335570.1628@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901251637480.1622@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901251858280.1622@nanos.tec.linutronix.de>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <0aa09e77-1454-9eaf-ef67-b00518e6f2d2@oracle.com>
Date:   Mon, 28 Jan 2019 16:28:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901251858280.1622@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9149 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=499
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/26 2:03, Thomas Gleixner wrote:
> On Fri, 25 Jan 2019, Thomas Gleixner wrote:
>> On Wed, 23 Jan 2019, Thomas Gleixner wrote:
>>
>>> On Fri, 18 Jan 2019, Zhenzhong Duan wrote:
>>>
>>>> When a task is set for updating TIF_SPEC_IB throuth SECCOMP by others
>>>> and it's scheduled in the first time, a stale TIF_SPEC_IB value is
>>>> picked in cond_ibpb(). This is due to TIF_SPEC_IB is updated later at
>>>> __switch_to_xtra().
>>>>
>>>> Add an extra call to speculation_ctrl_update_tif() to update it before
>>>> IBPB barrier.
>>>
>>> Errm. No. It adds that call to speculation_ctrl_update_tif() for every
>>> mm switch, most of the time for nothing.
>>>
>>> If at all, and we discussed that before and decided not to worry about it
>>> (because it gets fixed up on the next context switch), then you want to
>>> handle ibpb() from there:
>>
>> Actually we need to do that. It's not only the scheduled in first
>> problem. That whole thing might become completely stale in either
>> direction. Care to whip up a patch?
> 
> Bah, nonsense. Brain was clearly still out for lunch and I confused IBPB
> and STIBP for a moment. cond_ibpb() is the thing issues in switch_mm() and
> that is not leaving a stale MSR around because we only write to it when we
> need the barrier. The bit is not stale because the barrier is only issued
> with the write. The bit has not to be cleared.
> 
> So the only 'issue' what happens is that switch_to() either issues a
> barrier too much or misses one. That's really not a problem.

Ok, yes, the purpose of this patch is to avoid the one missed barrier.
Thanks for your reply.

Zhenzhong
