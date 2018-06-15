Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC366C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834A520891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="OjNhgUfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834A520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966093AbeFOT3P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:29:15 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:50272 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964930AbeFOT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:29:13 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5FJQhoU022997;
        Fri, 15 Jun 2018 20:28:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=1B/B0H0Na3LOpLlj8j9enTCTqpHsWwr6gwAtXAGNg9k=;
 b=OjNhgUfY4W3fxoIm8xHaFJ52vkd0EOf6pj9GfgDApUUhZX6dWBnltEMiYycBeOnagrea
 dZkamAMcYyDzYZSRh5XBc3W4LpgBlzgrUz1CGc7Z1T3/P1OoDw1C3whcFm/NZ1ByrVnH
 /s5MhgXJw3YJ1PmX/i4ybfJPaV0ZpE9yOnq+FWqMr7GTtM7zNKJR3Ax8UKu09g3rF+xI
 39419N/8gPDwjPPGfMNKBdwcyPB+rNgdVcH6fDwC9d1szQDMddHsAB0VA4PillKr1PTn
 bFZo0iQQV/wiMp2GcXXXmK5iMFnK8Oy//Q0EzPbr3dR+J5ez67bFnGTAtqdwCG1SLj8x Ag== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
        by mx0a-00190b01.pphosted.com with ESMTP id 2jknw3caqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jun 2018 20:28:58 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w5FJPVQH012648;
        Fri, 15 Jun 2018 15:28:57 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2jmdfm1n4e-1;
        Fri, 15 Jun 2018 15:28:57 -0400
Received: from [172.28.13.175] (bos-lpjec.kendall.corp.akamai.com [172.28.13.175])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 2C6311FC76;
        Fri, 15 Jun 2018 19:28:57 +0000 (GMT)
Subject: Re: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is
 MLOCK_ONFAULT
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-api@vger.kernel.org, emunson@mgebm.net
References: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
 <20180611072005.GC13364@dhcp22.suse.cz>
 <4c4de46d-c55a-99a8-469f-e1e634fb8525@akamai.com>
 <20180611150330.GQ13364@dhcp22.suse.cz>
 <775adf2d-140c-1460-857f-2de7b24bafe7@akamai.com>
 <20180612074646.GS13364@dhcp22.suse.cz>
 <5a9398f4-453c-5cb5-6bbc-f20c3affc96a@akamai.com>
 <20180613091355.GI13364@dhcp22.suse.cz>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <44e46470-ba0f-8270-ae69-dfb87fbd5a0a@akamai.com>
Date:   Fri, 15 Jun 2018 15:28:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180613091355.GI13364@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=651
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=633 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806150207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2018 05:13 AM, Michal Hocko wrote:
> On Tue 12-06-18 10:11:33, Jason Baron wrote:
> [...]
>> Ok, I share the concern that there is a chance that userspace is relying
>> on MADV_DONTNEED not free'ing locked memory. In that case, what if we
>> introduce a MADV_DONTNEED_FORCE, which does everything that
>> MADV_DONTNEED currently does but in addition will also free mlock areas.
> 
> What about other types of vmas that are not allowed to MADV_DONTNEED?
> _FORCE suggests that the user of the API know what he is doing so why
> shouldn't we allow unmapping hugetlb pages or special PFNMAPS? Or do we
> want to add MADV_DONTNEED_FORCE_FOR_REAL when somebody comes with
> another usecase?
> 
> I agree with Vlastimil that adding new madvise mode for niche case
> sounds like a bad idea so we should better be sure that a new flag has
> a reasonable semantic. Just allow mlocked pages is more of a tweak than
> a proper semantic. So making it force for real requires to analyze what
> that would mean for other vmas which are excluded now.
> 

If its a new flag, I agree it makes sense to look at hugetlb and
pfnmaps. pfnmaps might be more work, since it may require callbacks to
do driver specific actions...

I was able to do something very close to the original requirement of
free'ing mlock'd pages, via using a tmpfs mmap that is mlock'd. And then
using fallocate(FALLOC_FL_PUNCH_HOLE) to free the locked pages. I think
the tmpfs is sufficient for my needs, I wonder if there is any other
interest in this feature?

Thanks,

-Jason
