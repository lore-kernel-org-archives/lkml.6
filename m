Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAADBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9507121841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545247315;
	bh=CDGEP79ELlurcnFLdRfoySvcDEYPT6P0qPx60Dt4V/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ujBe2/6MuNZlDTaTR+xunb+k5Azj37V3mBrMo2HMrouZJZcOc6D1GUibi9ePLWwZ6
	 Q6OJE0/fKQLYFLR4NoROkfoQCcTbLYmnBtXOj1inQbOeWZgSna7bU+olc8OFAhld+E
	 MeRHxmtH0/BVFghrHHyyVabjviGZxUdRGh348sTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeLSTVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbeLSTVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:21:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F9B72080D;
        Wed, 19 Dec 2018 19:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545247313;
        bh=CDGEP79ELlurcnFLdRfoySvcDEYPT6P0qPx60Dt4V/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTzcJkI0qA6FRAIMVthSO7zc1qHT2ubob7w/nsu5Xzr9BmMuqTwvagrd23wi8Nliz
         GAxwgEeqjHsb5FIM/16q8XqsTeEgiIBOpCSB0RCw65rpPucjE18Cifu8ap/RYjFWvZ
         JOaHDMbtJOfzFaHVzXfbUtlWZC6VF6uFW6F/YsK4=
Date:   Wed, 19 Dec 2018 20:21:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] intel_th: msu: Fix an off-by-one in attribute
 store
Message-ID: <20181219192151.GA4413@kroah.com>
References: <20181219151922.44839-1-alexander.shishkin@linux.intel.com>
 <20181219151922.44839-4-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219151922.44839-4-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 05:19:22PM +0200, Alexander Shishkin wrote:
> The 'nr_pages' attribute of the 'msc' subdevices parses a comma-separated
> list of window sizes, passed from userspace. However, there is a bug in
> the string parsing logic wherein it doesn't exclude the comma character
> from the range of characters as it consumes them. This leads to an
> out-of-bounds access given a sufficiently long list. For example:
> 
> > # echo 8,8,8,8 > /sys/bus/intel_th/devices/0-msc0/nr_pages
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in memchr+0x1e/0x40
> > Read of size 1 at addr ffff8803ffcebcd1 by task sh/825
> >
> > CPU: 3 PID: 825 Comm: npktest.sh Tainted: G        W         4.20.0-rc1+
> > Call Trace:
> >  dump_stack+0x7c/0xc0
> >  print_address_description+0x6c/0x23c
> >  ? memchr+0x1e/0x40
> >  kasan_report.cold.5+0x241/0x308
> >  memchr+0x1e/0x40
> >  nr_pages_store+0x203/0xd00 [intel_th_msu]
> 
> Fix this by accounting for the comma character.

Ugh, this is one major reason sysfs files are "one value per file".

You should never have to "parse" a sysfs file for something like this.

It's a bit too late now, but please, never create such a sysfs file
again :(

greg k-h
