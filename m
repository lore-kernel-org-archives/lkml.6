Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B40FC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6381C2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBTmaOSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6381C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJXLx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:53:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60690 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zy2K2F53CAySisxVSbuPTYkyH7omh33CXz0Q8cfK5Bk=; b=GBTmaOSKz8/YDkvow2wdP5lv+h
        8buucDgjgAYU08f2K7BLQApXv4+do+w7TpHWqZqucNnUuTzzcMdw+r1A0KuruvQrEqG/zLNP5sEs6
        EFyc8DjtyH6R/WQ+6NLMHdXOejE8gC/4YXyhzQH56PY8fz4pHlAdZvSNJbdlBvUS8LSfuQh+fIQhR
        pXGWrw9/X7yEQSXZMx4ZBwI8Nfu33V7ZDptGUxno5x/X4tY/6l1N8bQzj+Dggt8/c+FK+9UlSrGpI
        U2b//WB32MtA/LBmpa7VzttDfNUonly5cZLUXRmJewazEbJvLPovGZXtpn0PymkfKXJTeGz4cBlOX
        MaV35JkA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gF9p7-0005cA-SN; Wed, 24 Oct 2018 03:27:10 +0000
Subject: Re: [PATCH 06/17] prmem: test cases for memory protection
To:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-7-igor.stoppa@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6c74bb1-bd0c-ed8a-1dd3-b04f2e3c78d4@infradead.org>
Date:   Tue, 23 Oct 2018 20:27:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181023213504.28905-7-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/18 2:34 PM, Igor Stoppa wrote:
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 9a7b8b049d04..57de5b3c0bae 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -94,3 +94,12 @@ config DEBUG_RODATA_TEST
>      depends on STRICT_KERNEL_RWX
>      ---help---
>        This option enables a testcase for the setting rodata read-only.
> +
> +config DEBUG_PRMEM_TEST
> +    tristate "Run self test for protected memory"
> +    depends on STRICT_KERNEL_RWX
> +    select PRMEM
> +    default n
> +    help
> +      Tries to verify that the memory protection works correctly and that
> +      the memory is effectively protected.

Hi,

a. It seems backwards (or upside down) to have a test case select a feature (PRMEM)
instead of depending on that feature.

b. Since PRMEM depends on MMU (in patch 04/17), the "select" here could try to
enabled PRMEM even when MMU is not enabled.

Changing this to "depends on PRMEM" would solve both of these issues.

c. Don't use "default n".  That is already the default.


thanks,
-- 
~Randy
