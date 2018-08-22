Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C7CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238E0217BE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ub+BhGDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238E0217BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeHVFsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 01:48:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeHVFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 01:48:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7M2K1xU055269;
        Wed, 22 Aug 2018 02:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ueLyfLmMW2DD8ShyywQRRSZ54NHKZkZAcO2EBHAB0jU=;
 b=ub+BhGDiFshYzn/AgbozuzvHKf8rJyO62X/2OhfVugbJ/HkIKWp7atj4iJFJsPqySZk/
 UnsG1YQ6RWBWrLIWUgapXGaK7cH9fMCNryABN1yl8N1Zd3vzc/buE0VNfxNljwgnVYkn
 g1jl+3YGlrzYZ4tuaZE2y2uYDMvEEHJce6abdihU9dLPeqUA5+dgHayfOCMkQVXcTNdl
 ZEIyhd9JLEcdNrEdEc48gc1TxgZ/kpL6imO/O5Hrl1WpqZ5dF7J8m5Qiwzf/bpnH4Bjm
 /kgbaQjo/KglQhl3t6gkOSZKRPF4N80hph+IzZuuGkd8suXhLWFebSYxVzHTqUecj/78 jg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kxavtr0c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 02:25:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7M2PGXA025196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 02:25:16 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7M2PFgv007715;
        Wed, 22 Aug 2018 02:25:15 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 19:25:15 -0700
Subject: Re: [PATCH v2 0/2] mm: soft-offline: fix race against page allocation
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180815154334.f3eecd1029a153421631413a@linux-foundation.org>
 <20180822013748.GA10343@hori1.linux.bs1.fc.nec.co.jp>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c692fd0b-d282-f2e7-b42f-b3204ad35938@oracle.com>
Date:   Tue, 21 Aug 2018 19:25:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822013748.GA10343@hori1.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8992 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 06:37 PM, Naoya Horiguchi wrote:
> On Wed, Aug 15, 2018 at 03:43:34PM -0700, Andrew Morton wrote:
>> On Tue, 17 Jul 2018 14:32:30 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:
>>
>>> I've updated the patchset based on feedbacks:
>>>
>>> - updated comments (from Andrew),
>>> - moved calling set_hwpoison_free_buddy_page() from mm/migrate.c to mm/memory-failure.c,
>>>   which is necessary to check the return code of set_hwpoison_free_buddy_page(),
>>> - lkp bot reported a build error when only 1/2 is applied.
>>>
>>>   >    mm/memory-failure.c: In function 'soft_offline_huge_page':
>>>   > >> mm/memory-failure.c:1610:8: error: implicit declaration of function
>>>   > 'set_hwpoison_free_buddy_page'; did you mean 'is_free_buddy_page'?
>>>   > [-Werror=implicit-function-declaration]
>>>   >        if (set_hwpoison_free_buddy_page(page))
>>>   >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>   >            is_free_buddy_page
>>>   >    cc1: some warnings being treated as errors
>>>
>>>   set_hwpoison_free_buddy_page() is defined in 2/2, so we can't use it
>>>   in 1/2. Simply doing s/set_hwpoison_free_buddy_page/!TestSetPageHWPoison/
>>>   will fix this.
>>>
>>> v1: https://lkml.org/lkml/2018/7/12/968
>>>
>>
>> Quite a bit of discussion on these two, but no actual acks or
>> review-by's?
> 
> Really sorry for late response.
> Xishi provided feedback on previous version, but no final ack/reviewed-by.
> This fix should work on the reported issue, but rewriting soft-offlining
> without PageHWPoison flag would be the better fix (no actual patch yet.)
> I'm not sure this patch should go to mainline immediately.

FWIW - The 'migration of huge PMD shared pages' issue I am working was
originally triggered via soft-offline.  While working the issue, I tried
to exercise huge page soft-offline really hard to recreate the issue and
validate a fix.  However, I was more likely to hit the soft-offline race(s)
your patches address.  Therefore, I applied your patches to focus my testing
and validation on the migration of huge PMD shared pages issue.  That is sort
of a Tested-by :).

Just wanted to point out that it was pretty easy to hit this issue.  It
was easier than the issue I am working.  And, the issue I am trying to
address was seen in a real customer environment.  So, I would not be
surprised to see this issue in real customer environments as well.

If you (or others) think we should go forward with these patches, I can
spend some time doing a review.  Already did a 'quick look' some time back.
-- 
Mike Kravetz
