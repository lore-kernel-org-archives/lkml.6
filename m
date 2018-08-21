Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0236C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E50C20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E50C20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeHULcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:32:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36944 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbeHULcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:32:39 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KU4JCLVKIfs5; Tue, 21 Aug 2018 10:13:12 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10DE61EC044B;
        Tue, 21 Aug 2018 10:13:11 +0200 (CEST)
Date:   Tue, 21 Aug 2018 10:13:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        mchehab@kernel.org, mikhail.jin@gmail.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Message-ID: <20180821081331.GC24940@nazgul.tnic>
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:14:58AM +0800, Pu Wen wrote:
> To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
> vendor checking for Hygon by using the code path of AMD 0x17. Add a
> vendor field to struct amd64_pvt and initialize it in per_family_init
> for vendor checking.
> 
> Also Hygon PCI Device ID DF_F0/DF_F6(0x1460/0x1466) of Host bridges
> is needed for edac driver.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/edac/amd64_edac.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/edac/amd64_edac.h |  5 +++++
>  drivers/edac/mce_amd.c    | 15 +++++++++++++-
>  3 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 18aeabb..3cefb25 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -211,7 +211,8 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
>  
>  	scrubval = scrubrates[i].scrubval;
>  
> -	if (pvt->fam == 0x17) {
> +	if (pvt->fam == 0x17 ||
> +	   (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18)) {

Didn't we say that AMD won't do family 0x18 so you don't need the vendor check?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
