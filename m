Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884F5223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884F5223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeKOEen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:34:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43732 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbeKOEen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:34:43 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9uY0O-aNJexL; Wed, 14 Nov 2018 19:30:23 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 041521EC037D;
        Wed, 14 Nov 2018 19:30:22 +0100 (CET)
Date:   Wed, 14 Nov 2018 19:30:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181114183016.GI13926@zn.tnic>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
 <20181112174343.mvjri2okwboew2nw@gabell>
 <20181113021218.GD7453@localhost.localdomain>
 <20181113161111.6jwm36fpxk5xjtn5@gabell>
 <20181113175413.GL10502@zn.tnic>
 <20181113200615.7dypqvhimxzlloek@gabell>
 <20181113215156.GP10502@zn.tnic>
 <20181114061215.GC2875@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114061215.GC2875@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 02:12:16PM +0800, Chao Fan wrote:
> But isdigit() would be redefine, so:
> 
> diff --git a/include/linux/ctype.h b/include/linux/ctype.h
> index 363b004426db..aba01c385232 100644
> --- a/include/linux/ctype.h
> +++ b/include/linux/ctype.h
> @@ -23,10 +23,12 @@ extern const unsigned char _ctype[];
>  #define isalnum(c)     ((__ismask(c)&(_U|_L|_D)) != 0)
>  #define isalpha(c)     ((__ismask(c)&(_U|_L)) != 0)
>  #define iscntrl(c)     ((__ismask(c)&(_C)) != 0)
> +#ifndef BOOT_STRING
>  static inline int isdigit(int c)
>  {
>         return '0' <= c && c <= '9';
>  }
> +#endif
>  #define isgraph(c)     ((__ismask(c)&(_P|_U|_L|_D)) != 0)
>  #define islower(c)     ((__ismask(c)&(_L)) != 0)
>  #define isprint(c)     ((__ismask(c)&(_P|_U|_L|_D|_SP)) != 0)
> 
> Now I can make it.
> I wonder whether this is OK to cover isdigit() with 'BOOT_STRING' tag.

See the beginning of arch/x86/boot/compressed/kaslr.c for a possible way
to disable boot/ctype.h

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
