Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1D4D8C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4472089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4472089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeFLD6S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:58:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933182AbeFLD6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:58:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C3reVl036841
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 23:58:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jj5a32mvc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 23:58:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 12 Jun 2018 04:58:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 04:58:13 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C3wB3I10027188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 03:58:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 789734C044;
        Tue, 12 Jun 2018 04:49:23 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3657F4C046;
        Tue, 12 Jun 2018 04:49:22 +0100 (BST)
Received: from [9.124.31.199] (unknown [9.124.31.199])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 04:49:22 +0100 (BST)
Subject: Re: [PATCH] perf report powerpc: Fix crash if callchain is empty
To:     Sandipan Das <sandipan@linux.ibm.com>, acme@kernel.org
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180611104049.11048-1-sandipan@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 12 Jun 2018 09:28:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611104049.11048-1-sandipan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061203-4275-0000-0000-0000028CAFB5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061203-4276-0000-0000-00003793D1BF
Message-Id: <7fe2c26e-a5a7-3141-870e-c93558bb082b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2018 04:10 PM, Sandipan Das wrote:
> For some cases, the callchain provided by the kernel may be
> empty. So, the callchain ip filtering code will cause a crash
> if we do not check whether the struct ip_callchain pointer is
> NULL before accessing any members.
> 
> This can be observed on a powerpc64le system running Fedora 27
> as shown below.
> 
>   # perf record -b -e cycles:u ls
> 
> Before applying this patch:
> 
>   # perf report --branch-history
> 
>   perf: Segmentation fault
>   -------- backtrace --------
>   perf[0x1027615c]
>   linux-vdso64.so.1(__kernel_sigtramp_rt64+0x0)[0x7fff856304d8]
>   perf(arch_skip_callchain_idx+0x44)[0x10257c58]
>   perf[0x1017f2e4]
>   perf(thread__resolve_callchain+0x124)[0x1017ff5c]
>   perf(sample__resolve_callchain+0xf0)[0x10172788]
>   ...
> 
> After applying this patch:
> 
>   # perf report --branch-history
> 
>   Samples: 25  of event 'cycles:u', Event count (approx.): 2306870
>     Overhead  Source:Line            Symbol                   Shared Object
>   +   11.60%  _init+35736            [.] _init                ls
>   +    9.84%  strcoll_l.c:137        [.] __strcoll_l          libc-2.26.so
>   +    9.16%  memcpy.S:175           [.] __memcpy_power7      libc-2.26.so
>   +    9.01%  gconv_charset.h:54     [.] _nl_find_locale      libc-2.26.so
>   +    8.87%  dl-addr.c:52           [.] _dl_addr             libc-2.26.so
>   +    8.83%  _init+236              [.] _init                ls
>   ...
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>


Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

