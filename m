Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA1FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE16206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE16206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIER4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:56:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbeIER4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:56:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85DNMu3043521
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 09:26:28 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mag0204jy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 09:26:27 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 5 Sep 2018 07:26:27 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 07:26:24 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85DQNnl51118116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 06:26:23 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A88A2BE05F;
        Wed,  5 Sep 2018 07:26:23 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6843CBE056;
        Wed,  5 Sep 2018 07:26:21 -0600 (MDT)
Received: from [9.199.40.212] (unknown [9.199.40.212])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 07:26:20 -0600 (MDT)
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
 <20180905130440.GA3729@bombadil.infradead.org>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Wed, 5 Sep 2018 18:56:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905130440.GA3729@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090513-0020-0000-0000-00000E5EF1D1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01083902; UDB=6.00559399; IPR=6.00863902;
 MB=3.00023125; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-05 13:26:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090513-0021-0000-0000-000062EC435F
Message-Id: <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=481 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 06:34 PM, Matthew Wilcox wrote:
> On Wed, Sep 05, 2018 at 04:53:41PM +0530, Aneesh Kumar K.V wrote:
>>   inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> 
> How do you go from "can be taken in softirq context" problem report to
> "must disable hard interrupts" solution?  Please explain why spin_lock_bh()
> is not a sufficient fix.
> 
>>   swapper/68/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
>>   0000000052a030a7 (hugetlb_lock){+.?.}, at: free_huge_page+0x9c/0x340
>>   {SOFTIRQ-ON-W} state was registered at:
>>     lock_acquire+0xd4/0x230
>>     _raw_spin_lock+0x44/0x70
>>     set_max_huge_pages+0x4c/0x360
>>     hugetlb_sysctl_handler_common+0x108/0x160
>>     proc_sys_call_handler+0x134/0x190
>>     __vfs_write+0x3c/0x1f0
>>     vfs_write+0xd8/0x220
> 
> Also, this only seems to trigger here.  Is it possible we _already_
> have softirqs disabled through every other code path, and it's just this
> one sysctl handler that needs to disable softirqs?  Rather than every
> lock access?

Are you asking whether I looked at moving that put_page to a worker 
thread? I didn't. The reason I looked at current patch is to enable the 
usage of put_page() from irq context. We do allow that for non hugetlb 
pages. So was not sure adding that additional restriction for hugetlb
is really needed. Further the conversion to irqsave/irqrestore was
straightforward.

Now with respect to making sure we don't have irq already disabled in 
those code paths, I did check that. But let me know if you find anything 
I missed.

> I'm not seeing any analysis in this patch description, just a kneejerk
> "lockdep complained, must disable interrupts".
> 

-aneesh

