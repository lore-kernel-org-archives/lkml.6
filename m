Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DC0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2AD27909
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="cH9BxpzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2AD27909
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965925AbeF1UVQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:21:16 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:48678 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936003AbeF1UVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:21:13 -0400
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.22/8.16.0.22) with SMTP id w5SKGrtc012464;
        Thu, 28 Jun 2018 21:20:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=5okqtiUpCyF7aevGNAslI9aAhykJQLHC2mmVDgDfns8=;
 b=cH9BxpzKkMIzd4y0dDg7kbcnQtpQZTZHEO2HlyvAUQVhrFGdmrWIcpxHnMiZH9uhf+49
 dlx6sRLlaWFHNc3UFlXN0OglGPVi5+8evrsbvLsqW2ccr4QRTMKq2o689A9flGqU23AK
 PHcNU/f+qLeVUk9GvM+pMuO83IZXdmFDZffs0IXbcfEJhIfCiNV1hyC0aZT/XZ1HJNB2
 pvxHTGZZmBWITWXxjDFb+oClns8lmy2sTv/cJ6BIo28SSX9I7GL9HxGgJrfyIS1x7KTO
 T0rtkUIlfRPMu+xJvmqj0KC0zfiAu9l9pZ68rGkD2aYEZ7rpgLUswJf2PZWB6hCRrhh4 Lg== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
        by m0050095.ppops.net-00190b01. with ESMTP id 2jvk1hu3rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jun 2018 21:20:56 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w5SKKagw024031;
        Thu, 28 Jun 2018 16:20:54 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2ju9cagbn9-1;
        Thu, 28 Jun 2018 16:20:54 -0400
Received: from [172.28.13.175] (bos-lpjec.kendall.corp.akamai.com [172.28.13.175])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 4A3DE32A82;
        Thu, 28 Jun 2018 20:20:54 +0000 (GMT)
Subject: Re: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is
 MLOCK_ONFAULT
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
 <0daccb7c-f642-c5ce-ca7a-3b3e69025a1e@suse.cz>
 <20180613071552.GD13364@dhcp22.suse.cz>
 <7a671035-92dc-f9c0-aa7b-ff916d556e82@akamai.com>
 <20180620110022.GK13685@dhcp22.suse.cz>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <4ab6d77a-3032-3ffb-d556-b736f6b983e6@akamai.com>
Date:   Thu, 28 Jun 2018 16:20:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180620110022.GK13685@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=742
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280224
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=720 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1806210000
 definitions=main-1806280224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 07:00 AM, Michal Hocko wrote:
> On Fri 15-06-18 15:36:07, Jason Baron wrote:
>>
>>
>> On 06/13/2018 03:15 AM, Michal Hocko wrote:
>>> On Wed 13-06-18 08:32:19, Vlastimil Babka wrote:
> [...]
>>>> BTW I didn't get why we should allow this for MADV_DONTNEED but not
>>>> MADV_FREE. Can you expand on that?
>>>
>>> Well, I wanted to bring this up as well. I guess this would require some
>>> more hacks to handle the reclaim path correctly because we do rely on
>>> VM_LOCK at many places for the lazy mlock pages culling.
>>>
>>
>> The point of not allowing MADV_FREE on mlock'd pages for me was that
>> with mlock and even MLOCK_ON_FAULT, one can always can always determine
>> if a page is present or not (and thus avoid the major fault). Allowing
>> MADV_FREE on lock'd pages breaks that assumption.
> 
> But once you have called MADV_FREE you cannot assume anything about the
> content until you touch the memory again. So you can safely assume a
> major fault for the worst case. Btw. why knowing whether you major fault
> is important in the first place? What is an application going to do
> about that information?
> 

Fair enough, I think that means you end up with a MADV_FREE_FORCE to
support that case? As I said I worked around this by using tmpfs and
fallocate(FALLOC_FL_PUNCH_HOLE). However, I still think there is a
use-case for doing this for anonymous memory, to avoid the unlock() calls.

The use-case I had in mind was simply an application that has a fast
path for when it knows that the requested item is locked in memory.

Thanks,

-Jason
