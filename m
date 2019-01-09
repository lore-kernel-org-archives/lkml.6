Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E7BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4059D206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="woh44JVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfAICxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:53:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59058 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfAICxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:53:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x092jIgs174189;
        Wed, 9 Jan 2019 02:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=N0YQAPReHAte+09lMbd1s7XSzhpgrDXVrObhK89UPtw=;
 b=woh44JVvlU7qk115/bRfMrUIX7S8BvML10BioMiUKoeWYZjkJutm5LcokgvuNx5VE19M
 o1vusOuq5VqwlTuH1QkkYR7X+ag2RS6kJMHCc4aLCBAhBeh5j6bbOm+bEkBdgQsSQT2Z
 U2Fm78o/E+oNVrA/UPS0uNiNnySKYkhLuZJ85s0TbVCIGDl0iL8RO+xo78/0KKBxyF9p
 up+vhxuKC1kI04Lvf2z16XckOWYZ65bj8bfVgFQnhWonSYck5D+xQ7HNVUcCvQE1MYAv
 I+ui0dSMyx345AbQXJlPY8Fcic65yUoVg5+Pm+YSrHB0bpKlDhSE7EhvhV183u9oxroH GQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2ptj3dy662-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 02:53:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x092r22L016707
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 02:53:02 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x092r1s9029452;
        Wed, 9 Jan 2019 02:53:02 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 18:53:01 -0800
Subject: Re: [PATCH 1/1] mm/hugetlb.c: teach follow_hugetlb_page() to handle
 FOLL_NOWAIT
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190109020203.26669-1-aarcange@redhat.com>
 <20190109020203.26669-2-aarcange@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c15462f3-f901-a624-8174-400d331c45bc@oracle.com>
Date:   Tue, 8 Jan 2019 18:53:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190109020203.26669-2-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 6:02 PM, Andrea Arcangeli wrote:
> hugetlb needs the same fix as faultin_nopage (which was applied in
> 96312e61282ae3f6537a562625706498cbc75594) or KVM hangs because it
> thinks the mmap_sem was already released by hugetlb_fault() if it
> returned VM_FAULT_RETRY, but it wasn't in the FOLL_NOWAIT case.
> 
> Fixes: ce53053ce378 ("kvm: switch get_user_page_nowait() to get_user_pages_unlocked()")
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Tested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Thanks for fixing this.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e37efd5d8318..b3622d7888c8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4301,7 +4301,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  				break;
>  			}
>  			if (ret & VM_FAULT_RETRY) {
> -				if (nonblocking)
> +				if (nonblocking &&
> +				    !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
>  					*nonblocking = 0;
>  				*nr_pages = 0;
>  				/*
> 
