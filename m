Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6CE16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8316205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8316205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeG3RjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:39:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:44581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbeG3RjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:39:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 09:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="75777212"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2018 09:03:43 -0700
Message-ID: <884376f1fd82a99e5d47eeba1fd1aaa3b19bc604.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] clk: Add of_clk_get_by_name_optional() function
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 30 Jul 2018 19:03:42 +0300
In-Reply-To: <1532957509-14541-2-git-send-email-phil.edworthy@renesas.com>
References: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
         <1532957509-14541-2-git-send-email-phil.edworthy@renesas.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 14:31 +0100, Phil Edworthy wrote:
> Quite a few drivers get an optional clock, e.g. a clock required
> to access peripheral's registers that is always enabled on some
> devices.
> 
> This function behaves the same as of_clk_get_by_name() except that
> it will return NULL instead of -EINVAL.

I'm puzzled a bit.

__of_clk_get() may return few error codes, and to me ENOENT sounds
correct when clock is not found. Other error codes should be passed to
the caller even for optional clocks.

If above is not true, we need to understand what circumstances for each
possible returned code are, and fix / act accordingly.

P.S. Possible way like regulator framework does is to return -ENODEV.

So, basically what I'm asking here is to be sure that single error code
(for now supposed -EINVAL) in this case is _the_ error code for absent /
can't be found clock.

>  - Fix check for clock not present. __of_clk_get() returns -EINVAL
>    if it's not there. Cover case of when there is no clock name.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
