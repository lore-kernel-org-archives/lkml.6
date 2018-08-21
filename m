Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A97C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B779A208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B779A208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeHUPU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:20:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:36829 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeHUPU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:20:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 05:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,269,1531810800"; 
   d="scan'208";a="226420258"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2018 05:00:59 -0700
Message-ID: <1fa46100c44abe54d5e66658ae69f3ba71522883.camel@linux.intel.com>
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date:   Tue, 21 Aug 2018 15:00:58 +0300
In-Reply-To: <20180821114405.GA597@jagdpanzerIV>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
         <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
         <20180821095055.GA400@jagdpanzerIV> <20180821114405.GA597@jagdpanzerIV>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 20:44 +0900, Sergey Senozhatsky wrote:

> Something like below? Not tested, since we are still in "is this
> what we want" phase.

> Returning the length of dst/-EOVERFLOW is a bit inconvenient, because
> "the length" forces us to have size_t return, which is unsigned.

We have for ages ssize_t to workaround that.

> size_t strcpy_trim(char *dst, size_t dstsz, const char *src, size_t
> srcsz)
> {
> 	const char *end;
> 	size_t ret = 0;
> 	size_t len = 0;
> 
> 	if (!dstsz || !srcsz)
> 		goto out;
> 
> 	end = src + srcsz - 1;
> 	while (end >= src && isspace(*end))
> 		end--;
> 	end++;
> 	while (src < end && isspace(*src))
> 		src++;
> 	len = (src >= end) ? 0 : end - src;
> 	if (!len)
> 		goto out;
> 
> 	ret = len;
> 	if (len >= dstsz)
> 		len = dstsz - 1;
> 	memcpy(dst, src, len);
> out:
> 	dst[len] = '\0';
> 	return ret == len ? ret : -EOVERFLOW;
> }

Wouldn't be better to split out something like

strnstrip() out of strim(), with simultaneous changes to strim(),
strstrip(), and use it here?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

