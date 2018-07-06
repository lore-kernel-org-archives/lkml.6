Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17197208A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17197208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeGFKF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:05:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:32282 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753586AbeGFKD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:03:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 03:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,315,1526367600"; 
   d="scan'208";a="70125523"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2018 03:03:51 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Andy Gospodarek <gospo@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] bitops: Introduce BITS_PER_TYPE
In-Reply-To: <20180706094458.14116-1-chris@chris-wilson.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180706094458.14116-1-chris@chris-wilson.co.uk>
Date:   Fri, 06 Jul 2018 13:03:35 +0300
Message-ID: <87muv4n0js.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> net_dim.h has a rather useful extension to BITS_PER_BYTE to compute the
> number of bits in a type (BITS_PER_BYTE * sizeof(T)), so promote the
> macro to bitops.h, alongside BITS_PER_BYTE, for wider usage.
>
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Andy Gospodarek <gospo@broadcom.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  include/linux/bitops.h  | 3 ++-
>  include/linux/net_dim.h | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 4cac4e1a72ff..091cb17d1a9b 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -11,7 +11,8 @@
>  #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
>  #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
>  #define BITS_PER_BYTE		8
> -#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> +#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
> +#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  #endif
>  
>  /*
> diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
> index 29ed8fd6379a..14f1734e740a 100644
> --- a/include/linux/net_dim.h
> +++ b/include/linux/net_dim.h
> @@ -326,7 +326,6 @@ static inline void net_dim_sample(u16 event_ctr,
>  }
>  
>  #define NET_DIM_NEVENTS 64
> -#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
>  #define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
>  
>  static inline void net_dim_calc_stats(struct net_dim_sample *start,

-- 
Jani Nikula, Intel Open Source Graphics Center
