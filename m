Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 728F6C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F134208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="hEqsSloV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F134208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933858AbeFLOMD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:12:03 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:38596 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933295AbeFLOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:12:01 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.22/8.16.0.22) with SMTP id w5CE8G5h015957;
        Tue, 12 Jun 2018 15:11:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=vZ5MWyz6ykOI9wXryWSebvS2vxhdCvpMBYH/djm1OOY=;
 b=hEqsSloVU6IswfPlZd8Cv4TCId5t9Vc/qr33X74MYius2mWw5yAuNFWdF316dzdbs/5a
 vRdrkWg6Qav/RToSK/iY3fFfusABoWAVNvPpSGeUY9IddE9uFNl/vVPWxccBW2AEY9Qk
 jJDj7sbXXeq21sa3mmb8LwyVqu6OooSwwD6LujvhW0IrO4s88VUq3fJ+Egk2YuPXtD7x
 36M/NdtxKoSTxaPPoP0OMGXB/f9pHsuXKJ4iUNKy4u3bMPcVwMb8r+iGiycbPbVDVXiI
 43J9nV+TNn0ytxHX6mQSxPRdoGU0wpPMNyHkJk6F4N+nwX7DRMvPWPfe/cyKahoCMUtk yQ== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
        by m0050093.ppops.net-00190b01. with ESMTP id 2jg65ns5ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jun 2018 15:11:35 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w5CEBIaD030217;
        Tue, 12 Jun 2018 10:11:34 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2jga7uy2d5-1;
        Tue, 12 Jun 2018 10:11:33 -0400
Received: from [172.28.13.175] (bos-lpjec.kendall.corp.akamai.com [172.28.13.175])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id B787D1FC6E;
        Tue, 12 Jun 2018 14:11:33 +0000 (GMT)
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
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <5a9398f4-453c-5cb5-6bbc-f20c3affc96a@akamai.com>
Date:   Tue, 12 Jun 2018 10:11:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180612074646.GS13364@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=724
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120162
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=706 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806120161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 03:46 AM, Michal Hocko wrote:
> On Mon 11-06-18 12:23:58, Jason Baron wrote:
>> On 06/11/2018 11:03 AM, Michal Hocko wrote:
>>> So can we start discussing whether we want to allow MADV_DONTNEED on
>>> mlocked areas and what downsides it might have? Sure it would turn the
>>> strong mlock guarantee to have the whole vma resident but is this
>>> acceptable for something that is an explicit request from the owner of
>>> the memory?
>>>
>>
>> If its being explicity requested by the owner it makes sense to me. I
>> guess there could be a concern about this breaking some userspace that
>> relied on MADV_DONTNEED not freeing locked memory?
> 
> Yes, this is always the fear when changing user visible behavior.  I can
> imagine that a userspace allocator calling MADV_DONTNEED on free could
> break. The same would apply to MLOCK_ONFAULT/MCL_ONFAULT though. We
> have the new flag much shorter so the probability is smaller but the
> problem is very same. So I _think_ we should treat both the same because
> semantically they are indistinguishable from the MADV_DONTNEED POV. Both
> remove faulted and mlocked pages. Mlock, once applied, should guarantee
> no later major fault and MADV_DONTNEED breaks that obviously.
> 
> So the more I think about it the more I am worried about this but I am
> more and more convinced that making ONFAULT special is just a wrong way
> around this.
> 

Ok, I share the concern that there is a chance that userspace is relying
on MADV_DONTNEED not free'ing locked memory. In that case, what if we
introduce a MADV_DONTNEED_FORCE, which does everything that
MADV_DONTNEED currently does but in addition will also free mlock areas.
That way there is no concern about breaking something.

Thanks,

-Jason
