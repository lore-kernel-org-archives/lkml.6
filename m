Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAED621908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="W4i4UDLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBGOIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:08:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfBGOIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:08:34 -0500
Received: from zn.tnic (p200300EC2BD18800E4CD802045C674DE.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8800:e4cd:8020:45c6:74de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75B051EC0345;
        Thu,  7 Feb 2019 15:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549548513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GPXR+i8DIouHx7/orKyn1SYg1QBX0ypUnV5YEY3pH1Y=;
        b=W4i4UDLeTSB2KSJz3IC0NqhOUZAdVnV9K6BHjoSgPiavLQ51uWjj43BwVLFqHTW06OQHJi
        Rq68a+giTizK+entxpOKy8nUd5ioYeo3r8C80Hz0vpl5iJsvU02MINQbbBheatu4AcJCr2
        whAFo2zY0s3N+ubLOU+WvSn0XzqTAN8=
Date:   Thu, 7 Feb 2019 15:08:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 2/9] jump_label: Add the jump_label_can_update_check()
 helper
Message-ID: <20190207140819.GF2414@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
 <36237a0ee38d6c98d080d3fee2921501d8788e4d.1549308412.git.bristot@redhat.com>
 <20190205072220.GD21801@zn.tnic>
 <cb65e500-44dd-873c-622f-b49b9336b6a2@redhat.com>
 <20190205211348.GV21801@zn.tnic>
 <30b5ffc9-9794-874b-1544-d05034b55f1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30b5ffc9-9794-874b-1544-d05034b55f1b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:21:09PM +0100, Daniel Bristot de Oliveira wrote:
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 288d630da22d..1e6f4d27e28d 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -374,22 +374,29 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
>  	return enabled ^ branch;
>  }
>  
> +static bool jump_label_can_update(struct jump_entry *entry, bool init)
> +{
> +	/*
> +	 * Cannot update code that was in an init text area.
> +	 */
> +	if (!init || jump_entry_is_init(entry))

Shouldn't this be &&

?

> +		return false;
> +
> +	if (WARN_ONCE(!kernel_text_address(jump_entry_code(entry)),
> +			 "can't patch jump_label at %pS", (void *)jump_entry_code(entry)))
> +		return false;

Yeah, I think that this way of writing it is less readable than:

	if (!kernel_text_address(jump_entry_code(entry))) {
		WARN_ONCE(1, "can't patch jump_label at %pS", (void *)jump_entry_code(entry));
		return false;
	}

> +		if (jump_label_can_update(entry, init)) {
> +			arch_jump_label_transform(entry, jump_label_type(entry));

Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
