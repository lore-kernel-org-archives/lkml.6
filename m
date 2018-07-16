Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77242ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD5F208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD5F208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeGPIh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:37:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:28190 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeGPIh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:37:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 01:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="54651772"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jul 2018 01:11:13 -0700
Message-ID: <f361dcc9c25e46819100ba1634f56db1c867f1b8.camel@linux.intel.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, NeilBrown <neilb@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Wang <wvw@google.com>, Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Date:   Mon, 16 Jul 2018 11:11:12 +0300
In-Reply-To: <79133322-b04b-f005-f1f6-25c28c5058e4@infradead.org>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
         <20180709162509.29343-1-daniel.vetter@ffwll.ch>
         <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org>
         <20180710075328.GG3008@phenom.ffwll.local>
         <871scbwfd4.fsf@notabene.neil.brown.name>
         <CAKMK7uFEYyD2ChWnO_0PS_rkK180dDoQ1g4J0UWRfchnYQxOTA@mail.gmail.com>
         <20180711160547.59f086a587c7f3c8d3c40f0f@linux-foundation.org>
         <87bmbavhai.fsf@notabene.neil.brown.name>
         <79133322-b04b-f005-f1f6-25c28c5058e4@infradead.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 16:42 -0700, Randy Dunlap wrote:
> On 07/13/2018 04:37 PM, NeilBrown wrote:

> 
> coding-style.rst says:
> Also, use braces when a loop contains more than a single simple
> statement:

Independently on a) would we use some macro for condition, or b) fix
macros against this kind of nested conditions, there is another
weirdness we would like to avoid, i.e.

for_each_foo() {
 ...
} else {
 ...
}

It is written according to coding style, but too much weird.

So, summarize this discussion I think we would
- keep for_each_if() in DRM subsystem alone
- fix macros which are using positive condition 'if (cond)' by replacing
with 'if (!cond) {} else' form for sake of robustness.

Do you agree on that?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
