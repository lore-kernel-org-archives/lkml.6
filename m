Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B2C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF512086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF512086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeLLMDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:03:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:56860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbeLLMDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:03:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2010AD72;
        Wed, 12 Dec 2018 12:03:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8457DDA7D1; Wed, 12 Dec 2018 13:03:23 +0100 (CET)
Date:   Wed, 12 Dec 2018 13:03:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Yueyi Li <liyueyi@live.com>
Cc:     "markus@oberhumer.com" <markus@oberhumer.com>,
        "w@1wt.eu" <w@1wt.eu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dave.rodgman@arm.com" <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lzo: fix ip overrun during compress.
Message-ID: <20181212120321.GQ23615@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yueyi Li <liyueyi@live.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "w@1wt.eu" <w@1wt.eu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dave.rodgman@arm.com" <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BLUPR13MB0289674CD6079E25C2A17497DFA70@BLUPR13MB0289.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR13MB0289674CD6079E25C2A17497DFA70@BLUPR13MB0289.namprd13.prod.outlook.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 07:03:14AM +0000, Yueyi Li wrote:
> It`s possible ip overrun in lzo1x_1_do_compress() when compressed page is
> point to the end of memory and which virtual address is 0xfffffffffffff000.
> Leading to a NULL pointer access during the get_unaligned_le32(ip).
> 
> ip = x9 = 0x0000000000000009 is overflow.
> 
> @@ -224,8 +224,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
>  
>  	while (l > 20) {
>  		size_t ll = l <= (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
> -		uintptr_t ll_end = (uintptr_t) ip + ll;
> -		if ((ll_end + ((t + ll) >> 5)) <= ll_end)
> +		// check for address space wraparound
> +		if (((uintptr_t) ip + ll + ((t + ll) >> 5)) <= (uintptr_t) ip)
>  			break;

Please use the /* */ comment style and enhance the comment contents to
be more descriptive what overflows and how.

>  		BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
>  		memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
> -- 
> 2.7.4
> 
