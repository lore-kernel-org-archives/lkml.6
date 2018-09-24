Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3F0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116F620883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116F620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeIXQd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:33:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728107AbeIXQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:33:28 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OAU3bO145490
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 06:32:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mpu70qa0g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 06:32:03 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 24 Sep 2018 11:32:00 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 11:31:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OAVqiI53739770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 10:31:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBD2811C058;
        Mon, 24 Sep 2018 13:31:34 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70CBB11C04C;
        Mon, 24 Sep 2018 13:31:32 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.170])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 24 Sep 2018 13:31:32 +0100 (BST)
Date:   Mon, 24 Sep 2018 13:31:45 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 2/4] mm: move is_kernel_rodata() to
 asm-generic/sections.h
References: <20180924101150.23349-1-brgl@bgdev.pl>
 <20180924101150.23349-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924101150.23349-3-brgl@bgdev.pl>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092410-0028-0000-0000-000002FDC894
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092410-0029-0000-0000-000023B7D754
Message-Id: <20180924103144.GB6264@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:11:48PM +0200, Bartosz Golaszewski wrote:
> Export this routine so that we can use it later in devm_kstrdup_const()
> and devm_kfree_const().
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

> ---
>  include/asm-generic/sections.h | 14 ++++++++++++++
>  mm/util.c                      |  7 -------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 849cd8eb5ca0..d79abca81a52 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -141,4 +141,18 @@ static inline bool init_section_intersects(void *virt, size_t size)
>  	return memory_intersects(__init_begin, __init_end, virt, size);
>  }
> 
> +/**
> + * is_kernel_rodata - checks if the pointer address is located in the
> + *                    .rodata section
> + *
> + * @addr: address to check
> + *
> + * Returns: true if the address is located in .rodata, false otherwise.
> + */
> +static inline bool is_kernel_rodata(unsigned long addr)
> +{
> +	return addr >= (unsigned long)__start_rodata &&
> +	       addr < (unsigned long)__end_rodata;
> +}
> +
>  #endif /* _ASM_GENERIC_SECTIONS_H_ */
> diff --git a/mm/util.c b/mm/util.c
> index 9e3ebd2ef65f..470f5cd80b64 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -15,17 +15,10 @@
>  #include <linux/vmalloc.h>
>  #include <linux/userfaultfd_k.h>
> 
> -#include <asm/sections.h>
>  #include <linux/uaccess.h>
> 
>  #include "internal.h"
> 
> -static inline int is_kernel_rodata(unsigned long addr)
> -{
> -	return addr >= (unsigned long)__start_rodata &&
> -		addr < (unsigned long)__end_rodata;
> -}
> -
>  /**
>   * kfree_const - conditionally free memory
>   * @x: pointer to the memory
> -- 
> 2.18.0
> 

-- 
Sincerely yours,
Mike.

