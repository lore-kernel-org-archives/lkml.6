Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B497EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1EA20645
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1EA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeK2LNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:13:45 -0500
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:46478 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbeK2LNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:13:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 72C89180A8141;
        Thu, 29 Nov 2018 00:10:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plane06_1f7db9e3ba51d
X-Filterd-Recvd-Size: 2104
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Nov 2018 00:10:16 +0000 (UTC)
Message-ID: <cb0e83e2f99aa066d40b3bb1c560486f0f278445.camel@perches.com>
Subject: Re: [PATCH v4 01/21] nvmem: Mark nvmem_type_str array with
 __maybe_unused
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Wed, 28 Nov 2018 16:10:15 -0800
In-Reply-To: <20181128190537.14074-2-andriy.shevchenko@linux.intel.com>
References: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com>
         <20181128190537.14074-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-28 at 21:05 +0200, Andy Shevchenko wrote:
> Since we put static variable to a header file it's copied to each module
> that includes the header. But not all of them are actually using it.
> 
> Mark nvmem_type_str array with __maybe_unused to make a compiler happy:
> 
> In file included from include/linux/rtc.h:18,
>                  from drivers/rtc/rtc-proc.c:15:
> include/linux/nvmem-provider.h:29:27: warning: ‘nvmem_type_str’ defined but not used [-Wunused-const-variable=]
>  static const char * const nvmem_type_str[] = {

It would be better to move this definition into
the one file that seems to use it.

$ git grep -w nvmem_type_str
drivers/nvmem/core.c:   return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type])
include/linux/nvmem-provider.h:static const char * const nvmem_type_str[] = {


