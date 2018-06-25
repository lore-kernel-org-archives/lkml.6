Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06403C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6B2262B1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GgtYaecb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6B2262B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeFYXZP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:25:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeFYXZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PeMZQUvfUzbFmDayzJrOYU1TpyvbJicBz6oQIbqgi4A=; b=GgtYaecbs8SRAh5BSKMVgNh5m
        o8QfHfZvSQvLmiZATjOq/M7Rok2/0tTXfjFwaPesAGQfFLe9+gF95VKMKmA63y/7yDKOi5n0WDys+
        GrVSuZTNxr22g26RLKtMoasjx69a3Bysnyq7zopJsaLxEHKX33z0AviX6VhcneSV+leJToay2dV2p
        urxN6809l5RpGA28qvnd124UxT6LSDVlLO/SA6TNHXVAMZYRn6ltmHXhCM25e16WzNB9Zu/HUIHNf
        yKGMAAkS9knirlCtmGbJ8ku0ocprNMZ+ceRAtws9n0uBv+i9zSN/X08AON5bDeACsf4vurEEPRmxN
        pOF/+Xlsg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXar5-0006XG-8M; Mon, 25 Jun 2018 23:25:07 +0000
Subject: Re: [PATCH v5 15/27] compiler: Option to default to hidden symbols
To:     Thomas Garnier <thgarnie@google.com>,
        kernel-hardening@lists.openwall.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Li <sparse@chrisli.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org
References: <20180625224014.134829-1-thgarnie@google.com>
 <20180625224014.134829-16-thgarnie@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8486eb8b-e233-4e2f-e976-da7b4cefc673@infradead.org>
Date:   Mon, 25 Jun 2018 16:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625224014.134829-16-thgarnie@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/18 15:39, Thomas Garnier wrote:
> Provide an option to default visibility to hidden except for key
> symbols. This option is disabled by default and will be used by x86_64
> PIE support to remove errors between compilation units.
> 
> The default visibility is also enabled for external symbols that are
> compared as they maybe equals (start/end of sections). In this case,
> older versions of GCC will remove the comparison if the symbols are
> hidden. This issue exists at least on gcc 4.9 and before.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>
> ---

> diff --git a/init/Kconfig b/init/Kconfig
> index 24b60536e26b..d4f90cc38ede 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1718,6 +1718,13 @@ config PROFILING
>  config TRACEPOINTS
>  	bool
>  
> +#
> +# Default to hidden visibility for all symbols.
> +# Useful for Position Independent Code to reduce global references.
> +#
> +config DEFAULT_HIDDEN
> +	bool
> +

I certainly would appreciate a better/more descriptive kconfig symbol name
here.

>  source "arch/Kconfig"
>  
>  endmenu		# General setup


thanks,
-- 
~Randy
