Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2B5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CAC21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CAC21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeITNuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:50:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45414 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeITNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:50:32 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 5c80924e66c4be12; Thu, 20 Sep 2018 10:08:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 17/22] ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
Date:   Thu, 20 Sep 2018 10:05:30 +0200
Message-ID: <3017961.RRfiJQt7az@aspire.rjw.lan>
In-Reply-To: <20180919220444.23190-18-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk> <20180919220444.23190-18-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 20, 2018 12:04:39 AM CEST Rasmus Villemoes wrote:
> With coming changes on x86-64, all dynamic debug descriptors in a
> translation unit must have distinct names. The macro _dynamic_func_call
> takes care of that. No functional change.
> 
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/acpi.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index e12d5ef1a054..83bacf9039e9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -977,12 +977,8 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
>  #else
>  #if defined(CONFIG_DYNAMIC_DEBUG)
>  #define acpi_handle_debug(handle, fmt, ...)				\
> -do {									\
> -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
> -	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
> -		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
> -				##__VA_ARGS__);				\
> -} while (0)
> +	_dynamic_func_call(fmt, __acpi_handle_debug,			\
> +			   handle, pr_fmt(fmt), ##__VA_ARGS__)
>  #else
>  #define acpi_handle_debug(handle, fmt, ...)				\
>  ({									\
> 

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


