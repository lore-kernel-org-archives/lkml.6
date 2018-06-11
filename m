Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1/TnDAmhHls0PgAAmS7hNA
	; Mon, 11 Jun 2018 16:24:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CC7C460791; Mon, 11 Jun 2018 16:24:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="gaLubl+R"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 52F7460351;
	Mon, 11 Jun 2018 16:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52F7460351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbeFKQYQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:24:16 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:54648 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933136AbeFKQYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:24:14 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.22/8.16.0.22) with SMTP id w5BGGqHZ030820;
        Mon, 11 Jun 2018 17:24:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=AmJHJ1ujGBOT2mGYqN2O2LNXDRTTfyilRK8kKBzwvG8=;
 b=gaLubl+RxtfAQqPYsBloULcFFm6RZKqTqQ8VplKJhiKIeudcw033Bu5o2Idf9a9d4cH6
 LXhvFTrE70731tbj694cJOcidgUXMl6uQKZW+y1p1FBDR1AOfqeJ9WYHshJSjgk3OLYb
 mPiRROQHqgVqEKpn4HtZBUKSv81Cqfs+VfcR25PQuVt6cNhB6wcBN05jh1VBSFHvITiZ
 +IiyVEn40IwXM/996DyI9ulaAuJkkYbJQo3Ctd9TYMyzB/X5mCN+RiEZQlNX+GizKrBF
 /VKtUyaczREs4wfZXmhvQxTPG629dWjKQJ/H96E6WbPUK0mAwqN0YS14csLtZ83A2hiN +w==
Received: from prod-mail-ppoint4 (a96-6-114-87.deploy.static.akamaitechnologies.com [96.6.114.87] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2jg3ycy7hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jun 2018 17:24:00 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w5BGGX88005934;
        Mon, 11 Jun 2018 12:23:59 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2jga7ve721-1;
        Mon, 11 Jun 2018 12:23:59 -0400
Received: from [172.28.13.175] (bos-lpjec.kendall.corp.akamai.com [172.28.13.175])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id D53EB811D9;
        Mon, 11 Jun 2018 16:23:58 +0000 (GMT)
Subject: Re: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is
 MLOCK_ONFAULT
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-api@vger.kernel.org, emunson@mgebm.net
References: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
 <20180611072005.GC13364@dhcp22.suse.cz>
 <4c4de46d-c55a-99a8-469f-e1e634fb8525@akamai.com>
 <20180611150330.GQ13364@dhcp22.suse.cz>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <775adf2d-140c-1460-857f-2de7b24bafe7@akamai.com>
Date: Mon, 11 Jun 2018 12:23:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180611150330.GQ13364@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806110187
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806110187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2018 11:03 AM, Michal Hocko wrote:
> On Mon 11-06-18 10:51:44, Jason Baron wrote:
>> On 06/11/2018 03:20 AM, Michal Hocko wrote:
>>> [CCing linux-api - please make sure to CC this mailing list anytime you
>>>  are touching user visible apis]
>>>
>>> On Fri 08-06-18 14:56:52, Jason Baron wrote:
>>>> In order to free memory that is marked MLOCK_ONFAULT, the memory region
>>>> needs to be first unlocked, before calling MADV_DONTNEED. And if the region
>>>> is to be reused as MLOCK_ONFAULT, we require another call to mlock2() with
>>>> the MLOCK_ONFAULT flag.
>>>>
>>>> Let's simplify freeing memory that is set MLOCK_ONFAULT, by allowing
>>>> MADV_DONTNEED to work directly for memory that is set MLOCK_ONFAULT.
>>>
>>> I do not understand the point here. How is MLOCK_ONFAULT any different
>>> from the regular mlock here? If you want to free mlocked memory then
>>> fine but the behavior should be consistent. MLOCK_ONFAULT is just a way
>>> to say that we do not want to pre-populate the mlocked area and do that
>>> lazily on the page fault time. madvise should make any difference here.
>>>
>>
>> The difference for me is after the page has been freed, MLOCK_ONFAULT
>> will re-populate the range if its accessed again. Whereas with regular
>> mlock I don't think it will because its normally done at mlock() or
>> mmap() time.
> 
> The vma would still be locked so we would effectively turn it into
> ONFAULT IIRC.
>

Indeed. I just tried allowing MADV_DONTNEED against regular mlock() and
in my brief testing it seemed to work as expected against both anonymous
and file back pages. I am certainly not against allowing it for regular
mlock() as well, if you think that makes it more consistent.


>> In any case, the state of a region being locked with
>> regular mlock and pages not present does not currently exist, whereas it
>> does for MLOCK_ONFAULT, so it seems more natural to do it only for
>> MLOCK_ONFAULT. Finally, the use-case we had for this, didn't need
>> regular mlock().
> 
> So can we start discussing whether we want to allow MADV_DONTNEED on
> mlocked areas and what downsides it might have? Sure it would turn the
> strong mlock guarantee to have the whole vma resident but is this
> acceptable for something that is an explicit request from the owner of
> the memory?
> 

If its being explicity requested by the owner it makes sense to me. I
guess there could be a concern about this breaking some userspace that
relied on MADV_DONTNEED not freeing locked memory?

Thanks,

-Jason
