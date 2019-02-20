Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E8DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1112089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550664917;
	bh=VhWrDDAjoH70uiau9u39XgR+edCRdY404jgOzL6TgHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iq+SONRvhZZ3RZHj+IA9SPUrO56+9c3EnDy05DGdNYAS6OKLC0EcOj6EXMZHdZdqi
	 4JeDzL7V5QwWksq0mCudaxRmOcYKzJNoI8DnhbKlDuoh/5AbOFFfS1kK+094Q/9XOF
	 7kFfFSiLA/2ddHqRFZn14jZvmWQic+8f033JdY2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfBTMPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTMPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:15:15 -0500
Received: from localhost (unknown [145.15.244.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A332089F;
        Wed, 20 Feb 2019 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550664914;
        bh=VhWrDDAjoH70uiau9u39XgR+edCRdY404jgOzL6TgHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ytMZqiMhS2nrvgGbfObOp4nE5g/t3vw7tDXV6U+wKEnfmvmiV5TqUjOWk6VW5Bc+p
         bPi/V7R6wf8nYIdm3O0H2HdnvpnETnDbe4/KRc//AX3qfrKN4MFpqiERh7JKdL63bQ
         EOgvfPVGOfq8W6XAi8aa29s06eiT9c74zemw1S8s=
Date:   Wed, 20 Feb 2019 13:15:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/2] drivers: provide devm_platform_ioremap_resource()
Message-ID: <20190220121506.GA23933@kroah.com>
References: <20190220111240.10041-1-brgl@bgdev.pl>
 <20190220111240.10041-2-brgl@bgdev.pl>
 <20190220111650.GA13077@kroah.com>
 <CAMRc=MeXPsJCsKAnzUD7Cvhj2gy3pyd6X79e602awv3_Ys6mYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeXPsJCsKAnzUD7Cvhj2gy3pyd6X79e602awv3_Ys6mYA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:21:26PM +0100, Bartosz Golaszewski wrote:
> śr., 20 lut 2019 o 12:16 Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> napisał(a):
> >
> > On Wed, Feb 20, 2019 at 12:12:39PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > There are currently 1200+ instances of using platform_get_resource()
> > > and devm_ioremap_resource() together in the kernel tree.
> > >
> > > This patch wraps these two calls in a single helper. Thanks to that
> > > we don't have to declare a local variable for struct resource * and can
> > > omit the redundant argument for resource type. We also have one
> > > function call less.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> 
> Should this go through the driver-core tree?

No need, put it through the tree for patch 2/2.

thanks,

greg k-h
