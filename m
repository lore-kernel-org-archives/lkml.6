Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA2ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7870E21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7870E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJRRPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:15:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:10561 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeJRRPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:15:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 02:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,395,1534834800"; 
   d="scan'208";a="100261340"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2018 02:15:11 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-doc\@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kernel-doc: fix declaration type determination
In-Reply-To: <640b26f4-a6fa-ffbc-c866-ea03de4f79a5@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <640b26f4-a6fa-ffbc-c866-ea03de4f79a5@infradead.org>
Date:   Thu, 18 Oct 2018 12:14:53 +0300
Message-ID: <87va5zipki.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Make declaration type determination more robust.
>
> When scripts/kernel-doc is deciding if some kernel-doc notation
> contains an enum, a struct, a union, a typedef, or a function,
> it does a pattern match on the beginning of the string, looking
> for a match with one of "struct", "union", "enum", or "typedef",
> and otherwise defaults to a function declaration type.
> However, if a function or a function-like macro has a name that
> begins with "struct" (e.g., struct_size()), then kernel-doc
> incorrectly decides that this is a struct declaration.
>
> Fix this by looking for the declaration type keywords having an
> ending word boundary (\b), so that "struct_size" will not match
> a struct declaration.

My perl is all cargo cult, so can't really review, but based on the
description this is what should be done,

Acked-by: Jani Nikula <jani.nikula@intel.com>

> I compared lots of html before/after output from core-api, driver-api,
> and networking.  There were no differences in any of the files that
> I checked.

I used to do diff -r on pre and post change clean documentation builds
to verify this type of stuff.

BR,
Jani.

>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Kees Cook <keescook@chromium.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  scripts/kernel-doc |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- lnx-419-rc8.orig/scripts/kernel-doc
> +++ lnx-419-rc8/scripts/kernel-doc
> @@ -1904,13 +1904,13 @@ sub process_name($$) {
>  	    ++$warnings;
>  	}
>  
> -	if ($identifier =~ m/^struct/) {
> +	if ($identifier =~ m/^struct\b/) {
>  	    $decl_type = 'struct';
> -	} elsif ($identifier =~ m/^union/) {
> +	} elsif ($identifier =~ m/^union\b/) {
>  	    $decl_type = 'union';
> -	} elsif ($identifier =~ m/^enum/) {
> +	} elsif ($identifier =~ m/^enum\b/) {
>  	    $decl_type = 'enum';
> -	} elsif ($identifier =~ m/^typedef/) {
> +	} elsif ($identifier =~ m/^typedef\b/) {
>  	    $decl_type = 'typedef';
>  	} else {
>  	    $decl_type = 'function';
>
>

-- 
Jani Nikula, Intel Open Source Graphics Center
