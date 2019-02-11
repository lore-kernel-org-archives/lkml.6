Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAD9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ADB206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b6CbU5av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBKJIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:08:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43008 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBKJIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:08:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1B93gHO141318;
        Mon, 11 Feb 2019 09:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RU4olNSJmvY43YkaAxWmPPK2DkywSpbTFjZVCTdxYDE=;
 b=b6CbU5av25hMKNMVyUclBc8FasgU+0uvl/QHzs5kth0krpjBCQRG2O+HaaYRTwumfb1H
 l4IqBvvocJ4DbMFufu1snhjsJL93oVM1PSeQ56FsLXtpARFeaG/SlwcMkeq+WglpDn4k
 d1FTbBnTcGXOiT7ORfGHrgAE7Z3kSlSjeE8iHBR7dQ2ij8qkRo/hupbCCp96qibLQyac
 5jLUJG9QbI6AS/+wRw9kCtQ+7XPIM5SlEJaduB3kM+ApCYQWwupR2rpwgzokI5qjeie3
 xoqDtFa/E/rwiaHIdSgRGTyXjLwAlRV9ih1hV1OFgV6nBL05Xvvr1+Yb4sLDcRj9iBS1 /g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhrek4ebx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 09:08:22 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1B98Fbt031585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 09:08:15 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1B98ETG026814;
        Mon, 11 Feb 2019 09:08:14 GMT
Received: from [10.166.106.34] (/10.166.106.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Feb 2019 01:08:13 -0800
Subject: Re: [PATCH] x86/alternatives: check int3 breakpoint physical
 addresses
To:     Thomas Gleixner <tglx@linutronix.de>
References: <1548428249-8258-1-git-send-email-alexandre.chartre@oracle.com>
 <alpine.DEB.2.21.1902102221500.8784@nanos.tec.linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <8995b3b4-b805-c8c7-95a8-a39ab000f289@oracle.com>
Date:   Mon, 11 Feb 2019 10:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902102221500.8784@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=884 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/10/2019 10:23 PM, Thomas Gleixner wrote:
> On Fri, 25 Jan 2019, Alexandre Chartre wrote:
>> Note that this issue has been observed and reproduced with a custom kernel
>> with some code mapped to different virtual addresses and using jump labels
>> As jump labels use text_poke_bp(), crashes were sometimes observed when
>> updating jump labels.
>
> Rightfully so. text_poke_bp() pokes at the kernels text mapping which is
> very well defined and unique. Why would you map the same text to different
> virtual addresses and then use a randomly chosen one to poke at it?
>

As an example, we used to have per-CPU SYSCALL entry trampoline [1] where the
entry_SYSCALL_64_trampoline function was mapped to a different virtual address
for each CPU. So, a syscall would execute entry_SYSCALL_64_trampoline() from a
different virtual address depending on the CPU being used. With that code,
adding a jump label in entry_SYSCALL_64_trampoline() causes the described issue.

This mapping was eventually removed [2]. I don't know if any other code like this
is currently present in the kernel (I couldn't find any, but I might not have
covered everything). But, as this past commit have shown, this is definitively
something that can happen.

Thanks,

alex.

---
[1] 3386bc8aed82 ("x86/entry/64: Create a per-CPU SYSCALL entry trampoline")
     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3386bc8aed82

[2] bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bf904d2762ee
