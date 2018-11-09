Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234BB20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234BB20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeKJJFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:05:18 -0500
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:36960 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727746AbeKJJFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:05:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 627977817;
        Fri,  9 Nov 2018 23:22:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: verse81_6d337e82fce1b
X-Filterd-Recvd-Size: 2618
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Nov 2018 23:22:30 +0000 (UTC)
Message-ID: <2358250f27022be9eb5c4e6a3d95ee869c3af45f.camel@perches.com>
Subject: Re: [PATCH v3 04/23] linux/net.h: use unique identifier for each
 struct _ddebug
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Fri, 09 Nov 2018 15:22:28 -0800
In-Reply-To: <20181109231021.11658-5-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
         <20181109231021.11658-1-linux@rasmusvillemoes.dk>
         <20181109231021.11658-5-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-10 at 00:10 +0100, Rasmus Villemoes wrote:
> Changes on x86-64 later in this series require that all struct _ddebug
> descriptors in a translation unit uses distinct identifiers. Realize
> that for net_dbg_ratelimited by generating such an identifier via
> __UNIQUE_ID and pass that to an extra level of macros.
> 
> No functional change.

Why does this require an extra indirection _<macro>?

> Cc: netdev@vger.kernel.org
> Acked-by: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/net.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 651fca72286c..397243a25f56 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -260,7 +260,7 @@ do {								\
>  #define net_info_ratelimited(fmt, ...)				\
>  	net_ratelimited_function(pr_info, fmt, ##__VA_ARGS__)
>  #if defined(CONFIG_DYNAMIC_DEBUG)
> -#define net_dbg_ratelimited(fmt, ...)					\
> +#define _net_dbg_ratelimited(descriptor, fmt, ...)			\
>  do {									\
>  	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
>  	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
> @@ -268,6 +268,8 @@ do {									\
>  		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
>  		                   ##__VA_ARGS__);			\
>  } while (0)
> +#define net_dbg_ratelimited(fmt, ...)					\
> +	_net_dbg_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
>  #elif defined(DEBUG)
>  #define net_dbg_ratelimited(fmt, ...)				\
>  	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)

