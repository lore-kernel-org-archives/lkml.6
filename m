Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFACECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F247621476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yGsuSRB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F247621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJSMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:55:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38794 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:55:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J4nSoa123883;
        Fri, 19 Oct 2018 04:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ec7+RTVoJYbqQVCRZrQcgdnPZBjRyQ/FghvY/Fq6Dss=;
 b=yGsuSRB4cp3dtCvttvh2QxIDzKnCYXyIVwxgdtg0P027X7NQQciXYUzTvF9Pv7Ob9P8I
 aXOh3qEk3Mu/4eYAdhq3iqayZD7aRJ3+xeDchKok3vZN7d/s+PIl4HroC09W09Gb1vdN
 6yPuYuri23Yz1KxP9zHy4vqiXjqo9A/AC1vcaHK8PVu3z+ngtwLvXw4n55/hfrHhFBs/
 CMLAZ4Sw2Twdh2/H5YF04zQj7FUe8dEwNB0ftYrjeNym5qlBfpeAUhlRf57+m6Tjm+cm
 as7iKBRqBoFn21fpzHef+idkr72hg5HdhwqXVyFKvXytTNEViKou91ZGsOrsFDTJ+1t2 Ww== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n39brswjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 04:50:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9J4oZP7030436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 04:50:35 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9J4oXIQ026396;
        Fri, 19 Oct 2018 04:50:33 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 21:50:33 -0700
Subject: Re: [PATCH] hugetlbfs: dirty pages as they are added to pagecache
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
References: <20181018041022.4529-1-mike.kravetz@oracle.com>
 <20181018160827.0cb656d594ffb2f0f069326c@linux-foundation.org>
 <6d6e4733-39aa-a958-c0a2-c5a47cdcc7d0@oracle.com>
 <20181019004621.GA30067@redhat.com>
 <20181018184726.fb8da5c733da5e0c6a235101@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9eb7cf71-5bc8-5cd4-9f3e-95375d40060b@oracle.com>
Date:   Thu, 18 Oct 2018 21:50:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018184726.fb8da5c733da5e0c6a235101@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 6:47 PM, Andrew Morton wrote:
> On Thu, 18 Oct 2018 20:46:21 -0400 Andrea Arcangeli <aarcange@redhat.com> wrote:
> 
>> On Thu, Oct 18, 2018 at 04:16:40PM -0700, Mike Kravetz wrote:
>>> I was not sure about this, and expected someone could come up with
>>> something better.  It just seems there are filesystems like huegtlbfs,
>>> where it makes no sense wasting cycles traversing the filesystem.  So,
>>> let's not even try.
>>>
>>> Hoping someone can come up with a better method than hard coding as
>>> I have done above.
>>
>> It's not strictly required after marking the pages dirty though. The
>> real fix is the other one? Could we just drop the hardcoding and let
>> it run after the real fix is applied?

Yeah.  The other part of the patch is the real fix.  This drop_caches
part is not necessary.

>> The performance of drop_caches doesn't seem critical, especially with
>> gigapages. tmpfs doesn't seem to be optimized away from drop_caches
>> and the gain would be bigger for tmpfs if THP is not enabled in the
>> mount, so I'm not sure if we should worry about hugetlbfs first.
> 
> I guess so.  I can't immediately see a clean way of expressing this so
> perhaps it would need a new BDI_CAP_NO_BACKING_STORE.  Such a
> thing hardly seems worthwhile for drop_caches.
> 
> And drop_caches really shouldn't be there anyway.  It's a standing
> workaround for ongoing suckage in pagecache and metadata reclaim
> behaviour :(

I'm OK with dropping the other part.  It just seemed like there was no
real reason to try and drop_caches for hugetlbfs (and perhaps others).

Andrew, would you like another version?  Or can you just drop the
fs/drop_caches.c part?

-- 
Mike Kravetz
