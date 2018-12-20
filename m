Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C53C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A166C218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IYVJgJ+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeLTTY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:24:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbeLTTY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:24:56 -0500
Received: from zn.tnic (p200300EC2BCCE300F9B895DC726ECF52.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:e300:f9b8:95dc:726e:cf52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF2181EC0AC3;
        Thu, 20 Dec 2018 20:24:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545333894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N3GgOFQHdgqSZ7aMtDkj03r+eYlwixbP/11WQh8eBmw=;
        b=IYVJgJ+wr8DumYt0IOrTz5EfPRa3tDDYNu3QK8NN7ySeX11jZUMasA/R5SMZZ/ILrpRW3P
        Xy4y7e0au7VxQza+E9xDy3ZLK9rbUWWZ1v/ehPGCR1VPpnPtecp6VxZazLnJk+eXo05QXB
        BRqSOiRw8JbMfeNOMUWNFTjPm/c8bzk=
Date:   Thu, 20 Dec 2018 20:24:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     David Arcari <darcari@redhat.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
Message-ID: <20181220192447.GG31403@zn.tnic>
References: <1545238252-79630-1-git-send-email-darcari@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545238252-79630-1-git-send-email-darcari@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ James.

On Wed, Dec 19, 2018 at 11:50:52AM -0500, David Arcari wrote:
> From: Lenny Szubowicz <lszubowi@redhat.com>
> 
> In __ghes_panic() clear the block status in the APEI generic
> error status block for that generic hardware error source before
> calling panic() to prevent a second panic() in the crash kernel
> for exactly the same fatal error.
> 
> Otherwise ghes_probe(), running in the crash kernel, would see
> an unhandled error in the APEI generic error status block and
> panic again, thereby precluding any crash dump.
> 
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 02c6fd9..f008ba7 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -691,6 +691,8 @@ static void __ghes_panic(struct ghes *ghes)
>  {
>  	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
>  
> +	ghes_clear_estatus(ghes);
> +
>  	/* reboot to log the error! */
>  	if (!panic_timeout)
>  		panic_timeout = ghes_panic_timeout;
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
