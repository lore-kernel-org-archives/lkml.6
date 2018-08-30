Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50DAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67065205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67065205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeH3S2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:28:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50336 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbeH3S2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:28:40 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvNtf-0005LV-Cq; Thu, 30 Aug 2018 16:26:07 +0200
Date:   Thu, 30 Aug 2018 16:26:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Prarit Bhargava <prarit@redhat.com>
cc:     linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] console: Add console=spcr option
In-Reply-To: <20180829155618.32359-1-prarit@redhat.com>
Message-ID: <alpine.DEB.2.21.1808301542560.1210@nanos.tec.linutronix.de>
References: <20180829155618.32359-1-prarit@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Prarit Bhargava wrote:
> +
> +void __init arch_console_setup(void)
> +{
> +	int ret;
> +
> +	ret = acpi_parse_spcr(false, true);
> +	if (ret)
> +		pr_err(PREFIX "ERROR: SPCR console is not enabled (%d)\n", ret);
> +}

Why does this require yet another arch/weak function?

>  /*
>   * Set up a console.  Called via do_early_param() in init/main.c
>   * for each "console=" parameter in the boot command line.
> @@ -2107,6 +2112,11 @@ static int __init console_setup(char *str)
>  	char *s, *options, *brl_options = NULL;
>  	int idx;
>  
> +	if (!strcmp(str, "spcr")) {
> +		arch_console_setup();
> +		return 1;

And this gets added to everything and the world whether it's
needed/supported or not.

Why can't we simply register the SPCR console as we do with any other
console when it is detected?

If we can't for some real good reason then there is no need to invoke
acpi_parse_spcr() twice. We simply can store the fact that it got selected
and use that information in acpi_boot_init().

Thanks,

	tglx





