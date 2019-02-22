Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863C32075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBVLfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:35:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:63311 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfBVLfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:35:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 03:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,399,1544515200"; 
   d="scan'208";a="124391500"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2019 03:35:14 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id BA0C9206FC; Fri, 22 Feb 2019 13:35:13 +0200 (EET)
Date:   Fri, 22 Feb 2019 13:35:13 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Forney <forney@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND PATCH 1/1] headers_install.sh: Support __aligned(x) for
 uAPI headers
Message-ID: <20190222113512.abpmbptqsnroibsi@paasikivi.fi.intel.com>
References: <20190221132853.32043-1-sakari.ailus@linux.intel.com>
 <CAK7LNAR99+J1LOiy66+QA_uYf328B6EfecrBk0iUvuQEDnf5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR99+J1LOiy66+QA_uYf328B6EfecrBk0iUvuQEDnf5pQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Fri, Feb 22, 2019 at 01:36:03PM +0900, Masahiro Yamada wrote:
> On Thu, Feb 21, 2019 at 10:29 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > The headers-install.sh already supports __packed conversion to
> > __attribute__((packed)) for uAPI headers but it does not support similar
> > __aligned(x) conversion.
> >
> > Add support for __aligned(x).
> 
> 
> I am not a big fan of sed scripting in headers_install.sh
> 
> Is it a problem to write __attribute__((aligned(x)) in UAPI headers?

Not really as such. __packed is supported in uAPI headers so I thought
__aligned should probably be as well. One factor here would seem to be that
__packed is way more common than __aligned is.

FWIW, a corresponding change has been done to scripts/kernel-doc; see
commit 3d9bfb19bd705f503ac7afc2776d5d56dab88858 so kerneldoc does correctly
handle that now.

Cc Jonathan.

> 
> 
> 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  scripts/headers_install.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> > index 593f8879c641..9ed490f33a3a 100755
> > --- a/scripts/headers_install.sh
> > +++ b/scripts/headers_install.sh
> > @@ -36,6 +36,7 @@ do
> >                 -e 's/__attribute_const__([[:space:]]|$)/\1/g' \
> >                 -e 's@^#include <linux/compiler(|_types).h>@@' \
> >                 -e 's/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g' \
> > +               -e 's/(^|[^a-zA-Z0-9])__aligned(\([0-9 ]*\))([^a-zA-Z0-9_]|$)/\1__attribute__((aligned\2))\3/g' \
> >                 -e 's/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g' \
> >                 -e 's@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @' \
> >                 "$SRCDIR/$i" > "$OUTDIR/$FILE.sed" || exit 1
> > --
> > 2.11.0
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
