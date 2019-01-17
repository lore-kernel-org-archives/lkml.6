Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49664C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1799720855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3RdSENyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfAQPPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:15:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37284 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQPPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:15:54 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0HF9Isx174018;
        Thu, 17 Jan 2019 15:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qkqPSQNg4zsbw+znhU3KojaG+xQrwKHDVk37adBPqSc=;
 b=3RdSENyYBZ9vQa1/uyvVdgToGUw0YoBM1jfaliaBqMzgGmpnSZ4EzXYznCpJCwkMkgq+
 cq0lFPlR6N0N+6O8r2ZiUpoRoM0V8qxQoo6A33L/uV+s6w0ZfupXONLZPs7C7oy4l6YK
 BtTveS1YBvclUPyx+ERCEdmSSmvZNJthf5YXqzHN8t1UeX9bBYUETUkc7Y77cSWxUrsZ
 TPs4VGoC7XdilDOBpYtxZVDm4Vi/S7urWulW1TDJliP+1CZn+O9c6c+MLDX5H8BEo1dk
 UjzOHmdsEVTymHTRVaxbMMYU9PhCW25oWlp8ii2RxDC0Nl8ZRvGfYlaYxqWtBK6kGNni Gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pybjp0fc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 15:14:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0HFEmpK031295
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 15:14:48 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0HFEiGJ018692;
        Thu, 17 Jan 2019 15:14:44 GMT
Received: from [192.168.1.44] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 07:14:43 -0800
Subject: Re: [RFC PATCH v7 14/16] EXPERIMENTAL: xpfo, mm: optimize spin lock
 usage in xpfo_kmap
To:     Laura Abbott <labbott@redhat.com>, juergh@gmail.com,
        tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, liran.alon@oracle.com,
        keescook@google.com, konrad.wilk@oracle.com
Cc:     deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        "Vasileios P . Kemerlis" <vpk@cs.columbia.edu>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Tycho Andersen <tycho@docker.com>,
        Marco Benatto <marco.antonio.780@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <7e8e17f519ae87a91fc6cbb57b8b27094c96305c.1547153058.git.khalid.aziz@oracle.com>
 <b2ffc4fd-e449-b6da-7070-4f182d44dd5b@redhat.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <1b46e0a5-476b-1eaa-3376-6848caf9e7ab@oracle.com>
Date:   Thu, 17 Jan 2019 08:14:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b2ffc4fd-e449-b6da-7070-4f182d44dd5b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=707
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 5:18 PM, Laura Abbott wrote:
> On 1/10/19 1:09 PM, Khalid Aziz wrote:
>> From: Julian Stecklina <jsteckli@amazon.de>
>>
>> We can reduce spin lock usage in xpfo_kmap to the 0->1 transition of
>> the mapcount. This means that xpfo_kmap() can now race and that we
>> get spurious page faults.
>>
>> The page fault handler helps the system make forward progress by
>> fixing the page table instead of allowing repeated page faults until
>> the right xpfo_kmap went through.
>>
>> Model-checked with up to 4 concurrent callers with Spin.
>>
> 
> This needs the spurious check for arm64 as well. This at
> least gets me booting but could probably use more review:
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 7d9571f4ae3d..8f425848cbb9 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -32,6 +32,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/preempt.h>
>  #include <linux/hugetlb.h>
> +#include <linux/xpfo.h>
>  
>  #include <asm/bug.h>
>  #include <asm/cmpxchg.h>
> @@ -289,6 +290,9 @@ static void __do_kernel_fault(unsigned long addr,
> unsigned int esr,
>         if (!is_el1_instruction_abort(esr) && fixup_exception(regs))
>                 return;
>  
> +       if (xpfo_spurious_fault(addr))
> +               return;
> +
>         if (is_el1_permission_fault(addr, esr, regs)) {
>                 if (esr & ESR_ELx_WNR)
>                         msg = "write to read-only memory";
> 
> 

That makes sense. Thanks for debugging this. I will add this to patch 14
("EXPERIMENTAL: xpfo, mm: optimize spin lock usage in xpfo_kmap").

Thanks,
Khalid
