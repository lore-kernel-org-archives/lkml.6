Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19DFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFB220857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549626735;
	bh=pohZGXFefnjdUnhTfmgy+boYVO8nt6nd54dOCA9vnC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eIHG3sOyr4qhooiYNqRNScXeQfYOsAbyGqSN+6R4dXFnQumnMWKnOFAk3J0QHK/dn
	 xwr+vyriKIAyHb3pZx9k/2a5K5w+Igjj9R08Ss1U00peUcH5oAE9n3Rr0DUXmhKFTk
	 P7g7PoAHW17H8PyJCWc7+FKd3xUJoV8CjuXA85wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfBHLwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfBHLwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:52:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9F9217D8;
        Fri,  8 Feb 2019 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549626731;
        bh=pohZGXFefnjdUnhTfmgy+boYVO8nt6nd54dOCA9vnC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwxA7bccmmOWBKzhTirhSK6soPqm1Q+Y3HVcYk8qWTSxEMu55T6tdoVLZ/4ByF3uY
         ONZyKQz6YaZG1ibx2T/6YnfdIxjodTQMlNDzZ84WJegsfGP4NOYYFoaljGEbvF4Adl
         RYB9B73/xQlfN5/hQKf6CNQ/MM53GVBT9qh7wNjI=
Date:   Fri, 8 Feb 2019 12:52:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 2/4] components: multiple components for a device
Message-ID: <20190208115209.GB19392@kroah.com>
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
 <20190207232759.14553-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207232759.14553-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 12:27:57AM +0100, Daniel Vetter wrote:
> Component framework is extended to support multiple components for
> a struct device. These will be matched with different masters based on
> its sub component value.
> 
> We are introducing this, as I915 needs two different components
> with different subcomponent value, which will be matched to two
> different component masters(Audio and HDCP) based on the subcomponent
> values.
> 
> v2: Add documenation.
> 
> v3: Rebase on top of updated documenation.
> 
> v4: Review from Rafael:
> - Remove redundant "This" from kerneldoc (also in the previous patch)
> - Streamline the logic in find_component() a bit.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1 code)
> Signed-off-by: Ramalingam C <ramalingam.c@intel.com> (v1 commit message)
> Cc: Ramalingam C <ramalingam.c@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
