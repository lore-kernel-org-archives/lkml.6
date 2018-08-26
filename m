Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBE8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B1E208EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nIyra9Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B1E208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeHZRNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:13:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58234 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeHZRNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:13:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7QDU4e3018051;
        Sun, 26 Aug 2018 13:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=POLFm+waYGzqZQtkNMoNDcon9mY6AbTVNA8Ef/g/658=;
 b=nIyra9AutfeoktfEFyz5JX41LERgVwGfzLeS3Ic/0xPWhyXG12G6JmySn9jFc82fPvXn
 leHvkFFgWHoWsU6u9/Q+4Sn5Uyf5h9ih9KcSvOTnTfD7p0cL1ZTejqiKZjatx+45PeQF
 WxPP+AHBmOrycAYAaVFf56r4V/mSjoWIC8q4nOfv3caT7Kpno6W9PeHUaR3GNcut4+62
 KA4vN2oYibNMSawRmY+HH+jyhIIC56qyKsFlDDJLR1A1gWNVaRsW3l6PWeXbuVRwcwyQ
 RENypk440xSSjh1/6N3xZCMCDhjUoq86dmWt4fPBSn7y/M6G+xYED0JbSZg10ix+M5T8 6Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2m2xhtagcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 13:30:46 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7QDUiN6032005
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 13:30:45 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7QDUh5b014018;
        Sun, 26 Aug 2018 13:30:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Aug 2018 06:30:43 -0700
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jeffrey Lien <Jeff.Lien@wdc.com>,
        David Darrington <david.darrington@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Furlong <jeff.furlong@wdc.com>,
        linux-block@vger.kernel.org,
        "open list\:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 4/4] block: Integrity profile init function to trigger module loads
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
        <20180826024006.13800-1-martin.petersen@oracle.com>
        <20180826024006.13800-4-martin.petersen@oracle.com>
        <CAKv+Gu92yj5Cuz36bRS7wz3Lg2srp8OFJC6QVO0UWYSjm8eEeg@mail.gmail.com>
Date:   Sun, 26 Aug 2018 09:30:39 -0400
In-Reply-To: <CAKv+Gu92yj5Cuz36bRS7wz3Lg2srp8OFJC6QVO0UWYSjm8eEeg@mail.gmail.com>
        (Ard Biesheuvel's message of "Sun, 26 Aug 2018 09:22:43 +0100")
Message-ID: <yq1h8jh6yrk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8996 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808260153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ard,

>> However, since the dependency for "crc10dif" is already satisfied,
>> nothing is going to cause the hardware-accelerated kernel modules to
>> get loaded.
>
> This is not true. All accelerated implementations based on SIMD
> polynomial multiplication are tried to the respective CPU features
> bits. This applies to x86, power, ARM and arm64.
>
> E.g., for x86 you have
>
> alias:          cpu:type:x86,ven*fam*mod*:feature:*0081*
>
> which will be matched by udev if /sys/devices/system/cpu/modalias
> contains feature 0081, and so the modules will be loaded automatically
> at boot.

If I can avoid carrying that init callback in the block integrity code
that will definitely make me happy. However, loading crct10dif-pclmul
does not happen automatically for me. crc-t10dif is linked statically
and every user of the CRC goes through that library. So nothing ever
requests the "crct10dif" modalias and no accelerator modules are loaded.

<fresh boot>

# lsmod | grep crc
crc32c_intel           24576  0
crc_ccitt              16384  1 ipv6

# modinfo crc32c_intel | grep cpu:type
alias:          cpu:type:x86,ven*fam*mod*:feature:*0094*

# modinfo crct10dif-pclmul | grep cpu:type
alias:          cpu:type:x86,ven*fam*mod*:feature:*0081*

# egrep -o "0081|0094" /sys/devices/system/cpu/modalias
0081
0094

# modprobe crct10dif
# lsmod | grep crc
crct10dif_pclmul       16384  1
crc32c_intel           24576  0
crc_ccitt              16384  1 ipv6

It's interesting that crc32c_intel is loaded but libcrc32c is not. That
matches your description of how things should work. But crct10dif-pclmul
isn't loaded and neither is crc32_pclmul:

# modprobe crc32
# lsmod | grep crc
crc32_generic          16384  0
crc32_pclmul           16384  0
crc32c_intel           24576  0
crc_ccitt              16384  1 ipv6

-- 
Martin K. Petersen	Oracle Linux Engineering
