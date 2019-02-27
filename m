Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B70C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81242186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gaY26Ndi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfB0WBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:01:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35034 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfB0WBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:01:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1RLs1xM123838;
        Wed, 27 Feb 2019 22:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LQ5rYxmcH3WAzFf0sRvQ3XlMmD9QOhCgoOKYt96kr/E=;
 b=gaY26NdiNElYQFqrnLKZRR0hM5RzzHN3XsCcgmOqE1GfdTdHthzQGn0kiwbqJBA/NPNZ
 pGBiumlOS0qcNZGTSA0B+lbkZ7KQYBRFR6EZhldlbBGVxcIbh7hS1onSFTty9IoAMVB2
 2Hb63htXFBAwEv4iVdXcmS3E41uYMtdciZZGiOAye8/IlT87DGqgHplrHUdvHed2j0O6
 XykeNh/y93s/uW8LMJgmSyNHoyCg+udUPpdVXX/tRxybkIl/7JfmGGARicvrJkKVpoyY
 LnubGmu58CiDnP1qWFTd+6EadHfOhKba9fq/64qGjClCPzk6d1AgeF8GfYbXX/F8jYns fw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qtupeds84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 22:01:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1RM0wGE002947
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 22:00:59 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1RM0w58026884;
        Wed, 27 Feb 2019 22:00:58 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Feb 2019 14:00:58 -0800
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
To:     Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, david@redhat.com
References: <20190221094212.16906-1-osalvador@suse.de>
 <20190227215109.cpiaheyqs2qdbl7p@d104.suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <201cc8d8-953f-f198-bbfe-96470136db68@oracle.com>
Date:   Wed, 27 Feb 2019 14:00:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227215109.cpiaheyqs2qdbl7p@d104.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9180 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902270143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 1:51 PM, Oscar Salvador wrote:
> On Thu, Feb 21, 2019 at 10:42:12AM +0100, Oscar Salvador wrote:
>> [1] https://lore.kernel.org/patchwork/patch/998796/
>>
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Any further comments on this?
> I do have a "concern" I would like to sort out before dropping the RFC:
> 
> It is the fact that unless we have spare gigantic pages in other notes, the
> offlining operation will loop forever (until the customer cancels the operation).
> While I do not really like that, I do think that memory offlining should be done
> with some sanity, and the administrator should know in advance if the system is going
> to be able to keep up with the memory pressure, aka: make sure we got what we need in
> order to make the offlining operation to succeed.
> That translates to be sure that we have spare gigantic pages and other nodes
> can take them.
> 
> Given said that, another thing I thought about is that we could check if we have
> spare gigantic pages at has_unmovable_pages() time.
> Something like checking "h->free_huge_pages - h->resv_huge_pages > 0", and if it
> turns out that we do not have gigantic pages anywhere, just return as we have
> non-movable pages.

Of course, that check would be racy.  Even if there is an available gigantic
page at has_unmovable_pages() time there is no guarantee it will be there when
we want to allocate/use it.  But, you would at least catch 'most' cases of
looping forever.

> But I would rather not convulate has_unmovable_pages() with such checks and "trust"
> the administrator.

Agree
-- 
Mike Kravetz
