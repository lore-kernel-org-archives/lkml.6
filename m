Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C2CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A62721486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A62721486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbeHVSYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:24:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:38319 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbeHVSYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:24:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2018 07:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,274,1531810800"; 
   d="scan'208";a="226779895"
Received: from eengestr-old.ld.intel.com (HELO intel.com) ([10.103.238.209])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2018 07:59:24 -0700
Date:   Wed, 22 Aug 2018 15:59:24 +0100
From:   Eric Engestrom <eric.engestrom@intel.com>
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        alexandru-cosmin.gheorghe@arm.com, corbet@lwn.net,
        airlied@linux.ie, daniel.vetter@ffwll.ch,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        liviu.dudau@arm.com, ayan.halder@arm.com
Subject: Re: [PATCH] drm/fourcc: Add DOC: overview comment
Message-ID: <20180822145924.GA13763@intel.com>
References: <20180821161611.10424-1-brian.starkey@arm.com>
 <20180821162639.GA21697@bombadil.infradead.org>
 <20180821164416.GA11553@e107564-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821164416.GA11553@e107564-lin.cambridge.arm.com>
Organization: Intel Corp UK
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2018-08-21 17:44:17 +0100, Brian Starkey wrote:
> Hi Matthew,
> 
> On Tue, Aug 21, 2018 at 09:26:39AM -0700, Matthew Wilcox wrote:
> > On Tue, Aug 21, 2018 at 05:16:11PM +0100, Brian Starkey wrote:
> > > There's a number of things which haven't previously been documented
> > > around the usage of format modifiers. Capture the current
> > > understanding in an overview comment and add it to the rst
> > > documentation.
> > > 
> > > Ideally, the generated documentation would also include documentation
> > > of all of the #defines, but the kernel-doc system doesn't currently
> > > support kernel-doc comments on #define constants.
> > 
> > Can you turn them into enums?  This seems to work ok:
> > 
> > -/* color index */
> > -#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
> > -
> > -/* 8 bpp Red */
> > -#define DRM_FORMAT_R8          fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
> > +enum {
> > +       /* color index */
> > +       DRM_FORMAT_C8   = fourcc_code('C', '8', ' ', ' '), /* [7:0] C */
> > +       /* 8 bpp Red */
> > +       DRM_FORMAT_R8   = fourcc_code('R', '8', ' ', ' '), /* [7:0] R */
> > +};
> > 
> > but I appreciate this is user API and maybe there's some code out there
> > that does #ifndef DRM_FORMAT_C8 ...
> 
> Thanks for the suggestion, Daniel did mention the same. However,
> unfortunately I don't think we can safely change the UAPI header in
> this manner.

You could get the best of both worlds by doing both:

  enum {
    foo = fourcc(...),
    bar = fourcc(...),
  }
  #define foo foo
  #define bar bar

It would mean a bit more code though, but that way these would now be
enums (with all the advantages of enums vs plain literals) and still
pass #ifdef checks :)

(BTW, on the "maybe there's some code that does #ifdef": I can tell you
there is indeed, having written this myself for an out-of-tree driver
for customer-modified kernels that may contain additional formats)

> 
> Cheers,
> -Brian
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
