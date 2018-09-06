Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C968C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D172083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D172083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIFIdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:33:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbeIFIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:33:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w863sdHV056213
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 00:00:11 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mavb3gvgw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 00:00:11 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 5 Sep 2018 22:00:10 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 22:00:07 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86406sC35061854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 21:00:06 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA6097805C;
        Wed,  5 Sep 2018 22:00:05 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D4B178064;
        Wed,  5 Sep 2018 22:00:03 -0600 (MDT)
Received: from [9.102.0.183] (unknown [9.102.0.183])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 22:00:03 -0600 (MDT)
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
 <20180905130440.GA3729@bombadil.infradead.org>
 <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
 <20180905134848.GB3729@bombadil.infradead.org>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Thu, 6 Sep 2018 09:30:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905134848.GB3729@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090604-0004-0000-0000-00001484D2DF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01084192; UDB=6.00559575; IPR=6.00864192;
 MB=3.00023137; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-06 04:00:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090604-0005-0000-0000-000088B6DF5D
Message-Id: <95b9a5d9-1e46-b969-4188-14c0a6efb215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=481 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 07:18 PM, Matthew Wilcox wrote:
> On Wed, Sep 05, 2018 at 06:56:19PM +0530, Aneesh Kumar K.V wrote:
>> On 09/05/2018 06:34 PM, Matthew Wilcox wrote:
>>> On Wed, Sep 05, 2018 at 04:53:41PM +0530, Aneesh Kumar K.V wrote:
>>>>    inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>>>
>>> How do you go from "can be taken in softirq context" problem report to
>>> "must disable hard interrupts" solution?  Please explain why spin_lock_bh()
>>> is not a sufficient fix.
>>>
>>>>    swapper/68/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
>>>>    0000000052a030a7 (hugetlb_lock){+.?.}, at: free_huge_page+0x9c/0x340
>>>>    {SOFTIRQ-ON-W} state was registered at:
>>>>      lock_acquire+0xd4/0x230
>>>>      _raw_spin_lock+0x44/0x70
>>>>      set_max_huge_pages+0x4c/0x360
>>>>      hugetlb_sysctl_handler_common+0x108/0x160
>>>>      proc_sys_call_handler+0x134/0x190
>>>>      __vfs_write+0x3c/0x1f0
>>>>      vfs_write+0xd8/0x220
>>>
>>> Also, this only seems to trigger here.  Is it possible we _already_
>>> have softirqs disabled through every other code path, and it's just this
>>> one sysctl handler that needs to disable softirqs?  Rather than every
>>> lock access?
>>
>> Are you asking whether I looked at moving that put_page to a worker thread?
> 
> No.  I'm asking "why not disable softirqs in the sysctl handler".  Or
> perhaps equivalently, just replace spin_lock() with spin_lock_bh() in
> set_max_huge_pages().
> 

Disabling only in sysctl handler is not enough right? Every usage of 
locks taken by the page destructor need to be converted to disable 
softirqs right?


>> I didn't. The reason I looked at current patch is to enable the usage of
>> put_page() from irq context. We do allow that for non hugetlb pages. So was
>> not sure adding that additional restriction for hugetlb
>> is really needed. Further the conversion to irqsave/irqrestore was
>> straightforward.
> 
> straightforward, sure.  but is it the right thing to do?  do we want to
> be able to put_page() a hugetlb page from hardirq context?
> 

-aneesh

