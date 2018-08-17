Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8C0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8A02185B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8A02185B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeHQGdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:33:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbeHQGdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:33:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7H3TFnq148221
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 23:32:13 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kwgnekfj2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 23:32:13 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 16 Aug 2018 23:32:12 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Aug 2018 23:32:09 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7H3W8SR16974174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Aug 2018 03:32:08 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1C2F112062;
        Thu, 16 Aug 2018 23:31:46 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39766112061;
        Thu, 16 Aug 2018 23:31:44 -0400 (EDT)
Received: from [9.102.0.167] (unknown [9.102.0.167])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Aug 2018 23:31:43 -0400 (EDT)
Subject: Re: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common
 to PGD and hugepages
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
 <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Fri, 17 Aug 2018 09:02:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18081703-0072-0000-0000-000003926985
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009558; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074635; UDB=6.00553814; IPR=6.00854593;
 MB=3.00022766; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-17 03:32:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081703-0073-0000-0000-0000491A9664
Message-Id: <6dea8d0c-c4ab-49aa-da26-a729c18fa818@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=421 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808170036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 08:24 PM, Christophe Leroy wrote:
> While implementing TLB miss HW assistance on the 8xx, the following
> warning was encountered:
> 
> [  423.732965] WARNING: CPU: 0 PID: 345 at mm/slub.c:2412 ___slab_alloc.constprop.30+0x26c/0x46c
> [  423.733033] CPU: 0 PID: 345 Comm: mmap Not tainted 4.18.0-rc8-00664-g2dfff9121c55 #671
> [  423.733075] NIP:  c0108f90 LR: c0109ad0 CTR: 00000004
> [  423.733121] REGS: c455bba0 TRAP: 0700   Not tainted  (4.18.0-rc8-00664-g2dfff9121c55)
> [  423.733147] MSR:  00021032 <ME,IR,DR,RI>  CR: 24224848  XER: 20000000
> [  423.733319]
> [  423.733319] GPR00: c0109ad0 c455bc50 c4521910 c60053c0 007080c0 c0011b34 c7fa41e0 c455be30
> [  423.733319] GPR08: 00000001 c00103a0 c7fa41e0 c49afcc4 24282842 10018840 c079b37c 00000040
> [  423.733319] GPR16: 73f00000 00210d00 00000000 00000001 c455a000 00000100 00000200 c455a000
> [  423.733319] GPR24: c60053c0 c0011b34 007080c0 c455a000 c455a000 c7fa41e0 00000000 00009032
> [  423.734190] NIP [c0108f90] ___slab_alloc.constprop.30+0x26c/0x46c
> [  423.734257] LR [c0109ad0] kmem_cache_alloc+0x210/0x23c
> [  423.734283] Call Trace:
> [  423.734326] [c455bc50] [00000100] 0x100 (unreliable)
> [  423.734430] [c455bcc0] [c0109ad0] kmem_cache_alloc+0x210/0x23c
> [  423.734543] [c455bcf0] [c0011b34] huge_pte_alloc+0xc0/0x1dc
> [  423.734633] [c455bd20] [c01044dc] hugetlb_fault+0x408/0x48c
> [  423.734720] [c455bdb0] [c0104b20] follow_hugetlb_page+0x14c/0x44c
> [  423.734826] [c455be10] [c00e8e54] __get_user_pages+0x1c4/0x3dc
> [  423.734919] [c455be80] [c00e9924] __mm_populate+0xac/0x140
> [  423.735020] [c455bec0] [c00db14c] vm_mmap_pgoff+0xb4/0xb8
> [  423.735127] [c455bf00] [c00f27c0] ksys_mmap_pgoff+0xcc/0x1fc
> [  423.735222] [c455bf40] [c000e0f8] ret_from_syscall+0x0/0x38
> [  423.735271] Instruction dump:
> [  423.735321] 7cbf482e 38fd0008 7fa6eb78 7fc4f378 4bfff5dd 7fe3fb78 4bfffe24 81370010
> [  423.735536] 71280004 41a2ff88 4840c571 4bffff80 <0fe00000> 4bfffeb8 81340010 712a0004
> [  423.735757] ---[ end trace e9b222919a470790 ]---
> 
> This warning occurs when calling kmem_cache_zalloc() on a
> cache having a constructor.
> 
> In this case it happens because PGD cache and 512k hugepte cache are
> the same size (4k). While a cache with constructor is created for
> the PGD, hugepages create cache without constructor and uses
> kmem_cache_zalloc(). As both expect a cache with the same size,
> the hugepages reuse the cache created for PGD, hence the conflict.
> 
> In order to avoid this conflict, this patch:
> - modifies pgtable_cache_add() so that a zeroising constructor is
> added for any cache size.
> - replaces calls to kmem_cache_zalloc() by kmem_cache_alloc()
> 

Can't we just do kmem_cache_alloc with gfp flags __GFP_ZERO? and remove 
the constructor completely?


-aneesh

