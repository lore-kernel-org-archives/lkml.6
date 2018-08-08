Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A24BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B6921700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B6921700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHHLno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:43:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727187AbeHHLno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:43:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFBBF40241C3;
        Wed,  8 Aug 2018 09:24:53 +0000 (UTC)
Received: from localhost (ovpn-204-54.brq.redhat.com [10.40.204.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3901A2166BA0;
        Wed,  8 Aug 2018 09:24:52 +0000 (UTC)
Date:   Wed, 8 Aug 2018 11:24:52 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-drivers] mt76x0: Remove VLA usage
Message-ID: <20180808092450.GA25772@redhat.com>
References: <20180807225040.GA2164@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807225040.GA2164@beast>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 09:24:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 09:24:54 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgruszka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 03:50:40PM -0700, Kees Cook wrote:
> Even with "const" variables, the compiler will generate warnings about
> VLA usage. In the quest to remove all VLAs from the kernel[1], this uses
> a #define instead of a const to do the array sizing.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Fixes: e87b5039511a ("mt76x0: eeprom files")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Please include this for the v4.19 merge window. The VLA was introduced
> with the new source file (which I also note is missing a SPDX line), so

I thought SPDX line is needed only if file has no license and eeprom.c
file and other mt76x0 files have specified the license. Is SPDX still
needed in that case ?
 
> +#define MT_MAP_READS	DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16)
>  static int
>  mt76x0_efuse_physical_size_check(struct mt76x0_dev *dev)
>  {
> -	const int map_reads = DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16);
> -	u8 data[map_reads * 16];

Why this is variable length array? DIV_ROUND_UP can not be calculated
at compile time? But if so, macro do not change the situation either.

Thanks
Stanislaw
