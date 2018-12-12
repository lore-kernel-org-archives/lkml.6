Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A6C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F720849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mp3eZF66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449F720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeLLV5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:57:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55634 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeLLV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:57:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBCLiQYP144801;
        Wed, 12 Dec 2018 21:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=C1QrmM9rjpbcIlr0tfynvCZk8GesgDAjP/FXPlFuDPQ=;
 b=mp3eZF66Idx3cNH5d5tcD/E4ktXRWL2U7VTNbQiQOyNfavenbDdj5e083zr8YxfXEVtJ
 VNFX3Tg0QqYlOfx/Un6mubL3kL8DaJC17cOL6GZ72sRPZ5cMED3iA9yGS2X+AHxkNIpy
 qL8rTq1lnAbxbWTCbQ+BGLKeDjqouvcITWqMJLUN64kA2hHXG1okecgEe1606E3K1n3/
 eWrIEjQmeCSEMag4PniF5mEW/yr2NH7d26zvNtr0DJRzfShqm7dj1m3F0TAC/dw5Y7Ez
 RoTc0uy45nb09Gyx4bNF0wf3czR2uRxamcoKQFjNa9caaD27TKv1w87P+5nlBqzncVGV zg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pb3n72fmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 21:56:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBCLuK4r024450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 21:56:21 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBCLuJIQ007230;
        Wed, 12 Dec 2018 21:56:19 GMT
Received: from [10.141.199.39] (/10.141.199.39)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 13:56:19 -0800
Subject: Re: [PATCH v9 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        bp@suse.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        mchehab@kernel.org, mingo@redhat.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, hch@infradead.org,
        roger.pau@citrix.com, rkrcmar@redhat.com
References: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
 <20181211131825.GD27375@zn.tnic>
 <5fc083d4-1dbd-f2f9-3059-0e3e8dda9b25@oracle.com>
 <20181212203901.GI6653@zn.tnic>
From:   Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <8483ef47-cd95-8d73-0a2f-2a65d262e2d9@oracle.com>
Date:   Wed, 12 Dec 2018 13:56:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181212203901.GI6653@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=909
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 12:39 PM, Borislav Petkov wrote:
> On Tue, Dec 11, 2018 at 11:29:21AM -0800, Maran Wilson wrote:
>> Is your question about what options you need to provide to Qemu? Or is your
>> question about the SW implementation choices?
>>
>> Assuming the former...
> Yeah, that's what I wanted to know. But looking at it, I'm booting
> bzImage here just as quickly and as flexible so I don't see the
> advantage of this new method for my use case here of booting kernels
> in qemu.
>
> But maybe there's a good use case where firmware is slow and one doesn't
> really wanna noodle through it or when one does start a gazillion VMs
> per second or whatever...

Right, the time saved is not something you would notice while starting a 
VM manually. But it does reduce the time to reach startup_64() in Linux 
by about 50% (going from around 94ms to around 47ms) when booting a VM 
using Qemu+qboot (for example). That time savings becomes pretty 
important when you are trying to use VMs as containers (for instance, as 
is the case with Kata containers) and trying to get the latency for 
launching such a container really low -- to come as close as possible to 
match the latency for launching more traditional containers that don't 
have the additional security/isolation of running within a separate VM.

Thanks,
-Maran

>
> Thx.
>

