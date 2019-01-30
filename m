Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6898C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876F0218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="SKBf2Fcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfA3Kdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:33:37 -0500
Received: from www.scalemp.com ([169.44.78.149]:41229 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbfA3Kdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=woIhQhcHdMvE7zVXG2WxVNo2R5BUawbaMTGgZIzP08U=; b=SKBf2FcfbbPs3qfxjLBLv2F69l
        /RlpMmpwNHeU911VjnC/nnm2xrJWjoNSGiY30jTb/TMvIFMHVhvTq6wj9MVyPkENWPLCrriyFZ9/q
        wepnPFP+bvrLcOxgQbKJ9sJrU/LdKICp4vmMxIvmG2ml31mWr1s9BhvQ/HzXRFw55z9s=;
Received: from bzq-80-45-146.static.bezeqint.net ([82.80.45.146]:22572 helo=[10.100.0.120])
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <eial@scalemp.com>)
        id 1gonBW-000dIL-Kx; Wed, 30 Jan 2019 05:33:34 -0500
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
To:     linux-kernel@vger.kernel.org
Cc:     Shai Fultheim <shai@scalemp.com>, Oren Twaig <oren@scalemp.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
From:   Eial Czerwacki <eial@scalemp.com>
Organization: ScaleMP
Message-ID: <902b2b1d-e6bd-bded-dc72-ea792f807d18@scalemp.com>
Date:   Wed, 30 Jan 2019 12:33:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548071251-1849-1-git-send-email-eial@scalemp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: eial@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: eial@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On 1/21/19 1:47 PM, Eial Czerwacki wrote:
> as reported in bug #201339 (https://bugzilla.kernel.org/show_bug.cgi?id=201339)
> by enabling X86_VSMP, INTERNODE_CACHE_BYTES's definition differs from the default one
> causing the struct size to exceed the size ok 8KB.
> 
> in order to avoid such issue, increse PERCPU_MODULE_RESERVE to 64KB if CONFIG_X86_VSMP is set.
> 
> the value was caculated on linux 4.20.3, make allmodconfig all and the following oneliner:
> for f in `find -name *.ko`; do echo $f; readelf -S $f  |grep perc; done |grep data..percpu -B 1 |grep ko |while read r; do echo -n "$r: "; objdump --syms --section=.data..percpu $r|grep data |sort -n  |awk '{c++; d=strtonum("0x" $1) + strtonum("0x" $5); if (m < d) m = d;} END {printf("%d vars-> last addr 0x%x ( %d )\n", c, m, m)}' ; done |column -t |sort -k 8 -n | awk '{print $8}'| paste -sd+ | bc
> 
> Signed-off-by: Eial Czerwacki <eial@scalemp.com>
> Signed-off-by: Shai Fultheim <shai@scalemp.com>
> Signed-off-by: Oren Twaig <oren@scalemp.com>
> ---
>  include/linux/percpu.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 70b7123..6b79693 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -14,7 +14,11 @@
>  
>  /* enough to cover all DEFINE_PER_CPUs in modules */
>  #ifdef CONFIG_MODULES
> +#ifdef X86_VSMP
> +#define PERCPU_MODULE_RESERVE		(1 << 16)
> +#else
>  #define PERCPU_MODULE_RESERVE		(8 << 10)
> +#endif
>  #else
>  #define PERCPU_MODULE_RESERVE		0
>  #endif
> 
is it possible to push this patch to mainline?
it seems like no objections/comment regarding it exists.
we'd like to fix the bug mentioned above.
