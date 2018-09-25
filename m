Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC066C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE1D2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jxgMxBX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE1D2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeIYWsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:48:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeIYWsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:48:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8PGcxcN049236;
        Tue, 25 Sep 2018 16:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LsArnAG5z7+QgUDiESkVt/C2FuZW8MZfKKF+5JQX8gc=;
 b=jxgMxBX3kv0yR8S/b/GjhKuK00STujRoaNycnwDPugIfh1Ci5OC05pFqJXSB0YsJeMFC
 4Dc0qSApOLFkB8q56xEkHPM0+0fr64RUv6SB4pGRuOogTU6cIzM6oG5cD/eqFlBG/34c
 kLUafOi++dgNLHfAVgc8/xlMi5MCAxTHJnKV0DkH2aqzLQDrbAxeWBSa/crFDWcvE10w
 0vFGpHoQoi3VO1O33a68tHKNO+/6SBhbelgW4GWTaoT8z5RSjBJfSoCguFEQdbclJ4DK
 Adl2Skp2aQtmkCd1Ihx6z09uUN3fIGOd6GdQxOCCXX9g83qxfYSRzLE49itzPtsST8TY dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mndppddc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Sep 2018 16:39:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8PGda9c029855
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Sep 2018 16:39:37 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8PGdZAY019906;
        Tue, 25 Sep 2018 16:39:36 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 09:39:35 -0700
Subject: Re: [PATCH V2] mm/hugetlb: Add mmap() encodings for 32MB and 512MB
 page sizes
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     mhocko@kernel.org, punit.agrawal@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org
References: <1537797985-2406-1-git-send-email-anshuman.khandual@arm.com>
 <1537841300-6979-1-git-send-email-anshuman.khandual@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f395fc79-4a64-8534-cd31-7a36bfb50cd1@oracle.com>
Date:   Tue, 25 Sep 2018 09:39:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537841300-6979-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9026 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809250165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 7:08 PM, Anshuman Khandual wrote:
> ARM64 architecture also supports 32MB and 512MB HugeTLB page sizes.
> This just adds mmap() system call argument encoding for them.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> 
> Changes in V2:
> - Updated SHM and MFD definitions per Mike

Thanks Anshuman,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
>  include/uapi/asm-generic/hugetlb_encode.h | 2 ++
>  include/uapi/linux/memfd.h                | 2 ++
>  include/uapi/linux/mman.h                 | 2 ++
>  include/uapi/linux/shm.h                  | 2 ++
>  4 files changed, 8 insertions(+)
> 
> diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
> index e4732d3..b0f8e87 100644
> --- a/include/uapi/asm-generic/hugetlb_encode.h
> +++ b/include/uapi/asm-generic/hugetlb_encode.h
> @@ -26,7 +26,9 @@
>  #define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
> diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> index 015a4c0..7a8a267 100644
> --- a/include/uapi/linux/memfd.h
> +++ b/include/uapi/linux/memfd.h
> @@ -25,7 +25,9 @@
>  #define MFD_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
>  #define MFD_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
>  #define MFD_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
> +#define MFD_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
>  #define MFD_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
> +#define MFD_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
>  #define MFD_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
>  #define MFD_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MFD_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index bfd5938..d0f515d 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -28,7 +28,9 @@
>  #define MAP_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
>  #define MAP_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
>  #define MAP_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
> +#define MAP_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
>  #define MAP_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
> +#define MAP_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
>  #define MAP_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
>  #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
> diff --git a/include/uapi/linux/shm.h b/include/uapi/linux/shm.h
> index dde1344..6507ad0 100644
> --- a/include/uapi/linux/shm.h
> +++ b/include/uapi/linux/shm.h
> @@ -65,7 +65,9 @@ struct shmid_ds {
>  #define SHM_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
>  #define SHM_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
>  #define SHM_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
> +#define SHM_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
>  #define SHM_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
> +#define SHM_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
>  #define SHM_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
>  #define SHM_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define SHM_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
> 
