Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C82DC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9B821529
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ij1l7UEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9B821529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeHXVD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:03:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXVDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ikNoK2E3hR/v1Ib5B/8wQlmaRPV+lj3E92YcGv1r9PQ=; b=Ij1l7UEOqImqK+BbobNGdxv6J
        cqzdQC4bCaaEpMx3E3yPNqItLxpqDySGT5D2c3YFc/HUQw4fyRim6YE0HdnR/VSO77yj0YQNwLQyl
        /EQp1aNHSHDsOwYeWGeW/dLZ+E5s7s7ZjHGqV6tUYUV0NHK9yWXGwXOlSdR7MVsnDWtmIEd+WtZJm
        7npjBTyZyJpqJHxYerV6Fj/s6W+1e2SF8o7J9q8+NKim7hhxsHGmKBsinnsfy1iWohw1ypi1+A8t8
        n2x/uKZREZh3b/7g3OhX8pDogjxB1FhZ1+ZPK2L5WXVzn0TG+3kKlq+lg4fiwFSmrYJHxnFi/iX8a
        /eC0HIzAw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftFsf-0000xt-AZ; Fri, 24 Aug 2018 17:28:17 +0000
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI, and Kconfig
To:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <224dccfa-8ce2-8bfd-ffd3-4684b6bc7448@infradead.org>
Date:   Fri, 24 Aug 2018 10:28:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824161642.1144-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 09:16 AM, Eric Biggers wrote:
> +/* ========== Ioctls ========== */
> +
> +struct fsverity_digest {
> +	__u16 digest_algorithm;
> +	__u16 digest_size; /* input/output */
> +	__u8 digest[];
> +};
> +
> +#define FS_IOC_ENABLE_VERITY	_IO('f', 133)
> +#define FS_IOC_MEASURE_VERITY	_IOWR('f', 134, struct fsverity_digest)

Hi,

Please update Documentation/ioctl/ioctl-number.txt also.

thanks,
-- 
~Randy
