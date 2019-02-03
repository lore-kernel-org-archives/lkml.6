Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0E6C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB82218A6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oq2lRR/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfBCMWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:22:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54412 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfBCMWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:22:06 -0500
Received: from zn.tnic (p200300EC2BE66900B8BDA23C6BF58743.dip0.t-ipconnect.de [IPv6:2003:ec:2be6:6900:b8bd:a23c:6bf5:8743])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2F191EC0586;
        Sun,  3 Feb 2019 13:22:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549196524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XNRUCp0Pb4aNjkxkbxsLeOnZlRGCZjXoja95mczlHPg=;
        b=oq2lRR/mpiRBuj7hdQhEhEH3hCCyzrpMCpD/uUSsakRs2TXcJTtJZj+MhdE4yvBcHkA+nV
        DSxov8MXrVvr+mg5OAludGRZOuOsJUOTvzbGyIkkzfmdqceCImXOh+YCid7kMp/xtqxzfF
        92vb1zdRegFjPHH7hmKlg9qCep/C6w4=
Date:   Sun, 3 Feb 2019 13:21:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/5] EDAC, mce_amd: Print ExtErrorCode and description on
 a single line
Message-ID: <20190203122158.GA21750@zn.tnic>
References: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
 <20190201225534.8177-6-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201225534.8177-6-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:55:54PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Save a log line by printing the extended error code and the description
> on a single line. This is similar to how errors are printed in other
> subsystems, e.g. "#, description". If we don't have a valid description
> then only the number/code is printed.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/mce_amd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 7e29ceabdf6f..f286b880f981 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -965,13 +965,12 @@ static void decode_smca_error(struct mce *m)
>  
>  	ip_name = smca_get_long_name(bank_type);
>  
> -	pr_emerg(HW_ERR "%s Extended Error Code: %d\n", ip_name, xec);
> +	pr_emerg(HW_ERR "%s Ext. Error Code: %d", ip_name, xec);
>  
>  	/* Only print the decode of valid error codes */
>  	if (xec < smca_mce_descs[bank_type].num_descs &&
>  			(hwid->xec_bitmap & BIT_ULL(xec))) {
> -		pr_emerg(HW_ERR "%s Error: ", ip_name);
> -		pr_cont("%s.\n", smca_mce_descs[bank_type].descs[xec]);
> +		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);

If the if-condition doesn't hit, we never print the \n

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
