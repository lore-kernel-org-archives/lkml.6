Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAB7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC5D214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="hkJBrV7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC5D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbeKVA1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:27:24 -0500
Received: from mail.servus.at ([193.170.194.20]:33822 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbeKVA1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:27:24 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 19:27:23 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id 5953D3000677;
        Wed, 21 Nov 2018 14:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1542807891; x=1544622292; bh=aAphKOCgmy46W7vOMqmhSKzSpxRPSKLfWvc
        mCIk0FdU=; b=hkJBrV7CtmzEMQGR6+Nmgiss1sfE+AqUBYCEEzpoR1EdRJVq6XE
        rUWezZL4HJEVWZxxykryGlle7TcMsGeYYyXyjesqSF8hLzwOS47a9YZXSwonnfxk
        kepAnxf2+NnMyiYpIc9Ih26pjHUcJxtI7nt2If8aYohFcKHPuXcHRkcM=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nklUh_TOA-HP; Wed, 21 Nov 2018 14:44:51 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id B077E3000676;
        Wed, 21 Nov 2018 14:44:49 +0100 (CET)
Subject: Re: [PATCH 0/6] lib/lzo: performance improvements
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR0802MB25289788BFADB136CE08AADA8FDA0@VI1PR0802MB2528.eurprd08.prod.outlook.com>
Cc:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        Sonny Rao <sonnyrao@google.com>
From:   "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
Message-ID: <5BF56151.5090201@oberhumer.com>
Date:   Wed, 21 Nov 2018 14:44:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0802MB25289788BFADB136CE08AADA8FDA0@VI1PR0802MB2528.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

thanks for your patch set. Just some initial comments:


I think the three patches

  [PATCH 2/6] lib/lzo: enable 64-bit CTZ on Arm
  [PATCH 3/6] lib/lzo: 64-bit CTZ on Arm aarch64
  [PATCH 4/6] lib/lzo: fast 8-byte copy on arm64

should be applied in any case - could you please make an extra
pull request out of these and try to get them merged as fast
as possible. Thanks.


The first patch

  [PATCH 1/6] lib/lzo: clean-up by introducing COPY16

does not really affect the resulting code at the moment, but please
note that in one case the actual copy unit is not allowed to
be greater 8 bytes (which might be implied by the name "COPY16").
So this needs more work like an extra COPY16_BY_8() macro.


As for your your "lzo-rle" improvements I'll have a look.

Please note that the first byte value 17 is actually valid when using
external dictionaries ("lzo1x_decompress_dict_safe()" in the LZO source
code). While this functionality is not present in the Linux kernel at
the moment it might be worrisome wrt future enhancements.

Finally I'm wondering if your chart comparisions just compares the "lzo-rle"
patch or also includes the ARM64 improvments - I cannot understand where a
20% speedup should come from if you have 0% zeros.

Cheers,
Markus



On 2018-11-21 13:06, Dave Rodgman wrote:
> This patch series introduces performance improvements for lzo.
> 
> The improvements fall into two categories: general Arm-specific optimisations
> (e.g., more efficient memory access); and the introduction of a special case 
> for handling runs of zeros (which is a common case for zram) using run-length
> encoding.
> 
> The introduction of RLE modifies the bitstream such that it can't be decoded
> by old versions of lzo (the new lzo-rle can correctly decode old bitstreams).
> To avoid possible issues where data is persisted on disk (e.g., squashfs), the 
> final patch in this series separates lzo-rle into a separate algorithm
> alongside lzo, so that the new lzo-rle is (by default) only used for zram and
> must be explicitly selected for other use-cases. This final patch could be
> omitted if the consensus is that we'd rather avoid proliferation of lzo
> variants.
> 
> Overall, performance is improved by around 1.1 - 4.8x (data-dependent: data
> with many zero runs shows higher improvement). Under real-world testing with
> zram, time spent in (de)compression during swapping is reduced by around 27%.
> The graph below shows the weighted round-trip throughput of lzo, lz4 and
> lzo-rle, for randomly generated 4k chunks of data with varying levels of
> entropy. (To calculate weighted round-trip throughput, compression performance
> is emphasised to reflect the fact that zram does around 2.25x more compression
> than decompression. (Results and overall trends are fairly similar for
> unweighted).
> 
> https://drive.google.com/file/d/18GU4pgRVCLNN7wXxynz-8R2ygrY2IdyE/view
> 
> Contributors:
> Dave Rodgman <dave.rodgman@arm.com>
> Matt Sealey <matt.sealey@arm.com>
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
