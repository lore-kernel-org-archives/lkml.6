Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83899C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C40E25530
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C40E25530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeGBKG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:06:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:47686 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752954AbeGBKGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:06:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 03:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="61657256"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2018 03:06:39 -0700
Message-ID: <048c10a3acb3dec624d1064e84ffd4957648949b.camel@linux.intel.com>
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com,
        keescook@chromium.org, j.w.r.degoede@gmail.com,
        david@lechnology.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Mon, 02 Jul 2018 13:06:38 +0300
In-Reply-To: <20180702073028.GZ13978@phenom.ffwll.local>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
         <ffe03b382ee84dbef8567b7377b929e4a8d6c23c.camel@linux.intel.com>
         <20180702073028.GZ13978@phenom.ffwll.local>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 09:30 +0200, Daniel Vetter wrote:
> On Fri, Jun 29, 2018 at 07:20:13PM +0300, Andy Shevchenko wrote:
> > On Fri, 2018-06-29 at 00:20 +0800, Yisheng Xie wrote:

> > LGTM except macro implementation. That's why I have mentioned
> > for_each_pci_bridge() to look at.
> > 
> > > +#define for_each_registered_fb(i)		\
> > > +	for (i = 0; i < FB_MAX; i++)		\
> > > +		if (registered_fb[i])
> > > +
> > 
> > This needs to be protected against nested conditionals.
> > Otherwise compiler issues a warning and even may generate wrong
> > code.
> 
> See for_each_if() in include/drm/drmP.h ... we should probably lift
> that
> into a general header. The for_each_if() is used all over drm in
> iterator
> macros, exactly to avoid surprises.

Wow, didn't know we have a such. It's a good idea to forelift it for
wider use.

Yisheng, it seems you may use it in your patch directly.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
