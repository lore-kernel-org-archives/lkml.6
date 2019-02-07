Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EFDC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C31121904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lfstqk5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfBGKZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:25:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfBGKZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:25:58 -0500
Received: from zn.tnic (p200300EC2BD18800483314F7A1363799.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8800:4833:14f7:a136:3799])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBE521EC023E;
        Thu,  7 Feb 2019 11:25:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549535157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=D36Yel9nOuRRADOfjzKN7SeXb+TFwx0YgFkMo7kfLu4=;
        b=Lfstqk5oct6JtzlqvH+ydIzhjG1LBBJNODHrJeO58FgtMTS8hzmlfephDfRHo/IIzVt+se
        AolLK/QGTog0tp1hDfZP+OobDVSzVXtJMC2lfSrMd84QQM6wcb6uvoOZzNYpHXZoq3OBS6
        MjOxbyYA8DkJK1jVm1j8zshrBTqzP00=
Date:   Thu, 7 Feb 2019 11:25:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Derek Robson <robsonde@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aout: incorrct use of strncpy fixed.
Message-ID: <20190207102545.GB2414@zn.tnic>
References: <20190202005512.3144-1-robsonde@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190202005512.3144-1-robsonde@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 01:55:12PM +1300, Derek Robson wrote:
> Found a bug with the source / dest length
> updated to have size limit as the size of dest not size or source.
> 
> Signed-off-by: Derek Robson <robsonde@gmail.com>
> ---
>  arch/x86/ia32/ia32_aout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
> index f65b78d32f5e..1e7f71723ee0 100644
> --- a/arch/x86/ia32/ia32_aout.c
> +++ b/arch/x86/ia32/ia32_aout.c
> @@ -157,7 +157,7 @@ static int aout_core_dump(struct coredump_params *cprm)
>  	fs = get_fs();
>  	set_fs(KERNEL_DS);
>  	has_dumped = 1;
> -	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
> +	strncpy(dump.u_comm, current->comm, sizeof(dump.u_comm));

Are you sure this is correct?

From looking at this, I think there's something else wrong with this
code though.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
