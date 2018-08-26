Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71429208E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWBezzzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71429208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeHZRc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:32:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39670 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeHZRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:32:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7QDmx16028857;
        Sun, 26 Aug 2018 13:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=lK9yUHTzU/v4puZ0P9dxGENxX79J/NiOdDmSKjXJheg=;
 b=GWBezzzmbhwDvbirmFvVVn3nuY57FJYpLBIkvc+Q6n48dfs9AjyLAaxIzQp8j9MTYhQ7
 698LYfyar92du/jlHKymEBG8R1LewxrFnCrUEENX1XYsroBZgLxIRMGUcKyHIsV5ZMzi
 N5w35XoAySPtxJYiztQ4jAOxbMz7YQcsD/6ryMi+28FyCqa0HgrF3XHYm3JE5qmmjSjO
 V+HcafzxaTS975nkmqnqBqYcWTpQruGaP7UtlgwNL3rs16f/DvHSfkLbYoutzYqX0BIM
 ZACgDcH6YPnNGuq+flG7NzXe+k3aU5uxL4Pof9tPAar6PTudkLDWc1ZdWxeG7mtFdyn7 8A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m2xhtagym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 13:48:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7QDmw5D004935
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 13:48:58 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7QDmw8B021569;
        Sun, 26 Aug 2018 13:48:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Aug 2018 06:48:57 -0700
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
        <yq1h8jh6yrk.fsf@oracle.com>
        <CAKv+Gu88A8OmVGV3-9YGkgNKOtCRmN70Ys2WL+F7au=NB4vydQ@mail.gmail.com>
Date:   Sun, 26 Aug 2018 09:48:55 -0400
In-Reply-To: <CAKv+Gu88A8OmVGV3-9YGkgNKOtCRmN70Ys2WL+F7au=NB4vydQ@mail.gmail.com>
        (Ard Biesheuvel's message of "Sun, 26 Aug 2018 15:44:31 +0200")
Message-ID: <yq1d0u56xx4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8996 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=849
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808260156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ard,

> That is odd. On my Ubuntu system, both crct10dif_pclmul and
> crc32_pclmul get loaded automatically.

Just checked my Fedora box and they are loaded there too. Peculiar. I'll
keep digging...

(crc32c-intel is brought in by dracut on RHEL/OL/Fedora, fwiw)

-- 
Martin K. Petersen	Oracle Linux Engineering
