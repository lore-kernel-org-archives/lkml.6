Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF26C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA7C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeJEWFB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:05:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbeJEWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:05:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95F4ecO016107
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 11:05:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mx9wr1eur-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:05:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 16:05:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 16:05:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w95F5h3u63897732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 15:05:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D453AE045;
        Fri,  5 Oct 2018 18:04:33 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C216EAE051;
        Fri,  5 Oct 2018 18:04:32 +0100 (BST)
Received: from [9.148.204.169] (unknown [9.148.204.169])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 18:04:32 +0100 (BST)
Date:   Fri, 05 Oct 2018 18:05:01 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com> <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] memblock: stop using implicit alignement to SMP_CACHE_BYTES
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-mm@kvack.org
CC:     linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>,
        linux-ia64@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matt Turner <mattst88@gmail.com>, linux-um@lists.infradead.org,
        linux-m68k@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100515-0020-0000-0000-000002D00A38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100515-0021-0000-0000-0000211E6102
Message-Id: <59C9470E-F718-4A11-BC65-FD68901723AC@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=694 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 5, 2018 6:25:38 AM GMT+03:00, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>On Fri, 2018-10-05 at 00:07 +0300, Mike Rapoport wrote:
>> When a memblock allocation APIs are called with align = 0, the
>alignment is
>> implicitly set to SMP_CACHE_BYTES.
>> 
>> Replace all such uses of memblock APIs with the 'align' parameter
>explicitly
>> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
>> memblock internal allocation functions.
>> 
>> For the case when memblock APIs are used via helper functions, e.g.
>like
>> iommu_arena_new_node() in Alpha, the helper functions were detected
>with
>> Coccinelle's help and then manually examined and updated where
>appropriate.
>> 
>> The direct memblock APIs users were updated using the semantic patch
>below:
>
>What is the purpose of this ? It sounds rather counter-intuitive...

Why?
I think it actually more intuitive to explicitly set alignment to SMP_CACHE_BYTES rather than use align = 0 because deeply inside allocator it will be implicitly reset to SMP_CACHE_BYTES...

>Ben.

-- 
Sincerely yours,
Mike.

