Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F8DC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB3423C49
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB3423C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937023AbeF2Qik (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:38:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:38079 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753553AbeF2Qij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:38:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 09:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="68830748"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga001.jf.intel.com with SMTP; 29 Jun 2018 09:38:33 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 29 Jun 2018 19:38:32 +0300
Date:   Fri, 29 Jun 2018 19:38:32 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Use kvzalloc for allocating blob property memory
Message-ID: <20180629163832.GF5565@intel.com>
References: <20180629142710.2069-1-michel@daenzer.net>
 <20180629161205.GE5565@intel.com>
 <32deece3-b583-ca58-cd41-ba11846240c8@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32deece3-b583-ca58-cd41-ba11846240c8@daenzer.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 06:27:28PM +0200, Michel Dänzer wrote:
> On 2018-06-29 06:12 PM, Ville Syrjälä wrote:
> > On Fri, Jun 29, 2018 at 04:27:10PM +0200, Michel Dänzer wrote:
> >> From: Michel Dänzer <michel.daenzer@amd.com>
> >>
> >> The property size may be controlled by userspace, can be large (I've
> >> seen failure with order 4, i.e. 16 pages / 64 KB) and doesn't need to be
> >> physically contiguous.
> > 
> > I wonder if we should enforce some kind of reasonable limit
> > on the blob size. Looks like we allow anything up to
> > ULONG_MAX currently. We can't tell at createblob time how
> > the thing is going to be used, so can't have any kind
> > of property specific limit unfortunately.
> 
> The failure I was seeing was for a gamma LUT, so a size limit alone
> cannot solve the issue.

Sure. I was just thinking that maybe we shouldn't allow someone to
allocate unlimited amounts of kernel memory via this interface. But
to do that effectively we'd also need to limit the total amount used
by all blobs.

-- 
Ville Syrjälä
Intel
