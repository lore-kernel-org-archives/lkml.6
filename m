Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD43C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1F6214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="pHFPpBRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1F6214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJJSX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:23:57 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59900 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:23:57 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 08E975C0578;
        Wed, 10 Oct 2018 13:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539169337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/W3vajcyx02f/8aqS03QE9CAvwoOaYhEd9bB2j9umJo=;
        b=pHFPpBRQzaaDMFLMNmnyqKFeCUxiAjfcDXbG94FmLZHhrrT+UTZ0wEaJvydUUrtA0iyG0m
        0Oadv1rBySpM8dMb+mzd6Tqp7G2WiPTATuiZQy1RZUfVF0+yqbGO9LYS1IuBibYPSX0S/9
        0gdj68ENcOMEVUWVxWfUJDtFrMl2JXA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Oct 2018 13:02:16 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/imx: make sure to cleanup DRM before unbinding
 components
In-Reply-To: <20181010103829.GN30658@n2100.armlinux.org.uk>
References: <83a28282a3f745a4cd4ca77d0593ad2e61359a5d.1539120077.git.stefan@agner.ch>
 <e08eff2ed53b441c8a6c41758c00c1c91dc48d2c.1539120077.git.stefan@agner.ch>
 <20181010103829.GN30658@n2100.armlinux.org.uk>
Message-ID: <11a452de8e6b39c80ae8ff6b2cdc4cc8@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Lucas]

On 10.10.2018 12:38, Russell King - ARM Linux wrote:
> On Tue, Oct 09, 2018 at 11:30:49PM +0200, Stefan Agner wrote:
>> In situations where a component fails to bind, a previously
>> successfully bound component might already registered itself
>> with the DRM framework (e.g. an encoder). When the master
>> component then calls drm_mode_config_cleanup, we end up in a
>> use after free sitution.
>>
>> Use the cleanup callback to make sure all framework level
>> cleanup is done by the time we unbind components.
> 
> I'm not sure about this approach - the idea about the component bind
> and unbind callbacks is that unbind undoes _everything_ that bind has
> done, so everything is correctly ordered.  If bind registers something,
> unbind should unregister it.
> 
> What seems to be going on is that imx is registering stuff in bind()
> but not unregistering it in unbind().

Yes indeed, if that can be fixed this seems to be the better approach to
me.

> 
> Since imx was one of the drivers that the component helper was
> created for, if it's now crashing, that's a regression in the imx
> driver.  Looking at the commit log, I'd say:
> 
> commit 8e3b16e2117409625b89807de3912ff773aea354
> Author: Lucas Stach <l.stach@pengutronix.de>
> Date:   Thu Aug 11 11:18:49 2016 +0200
> 
>     drm/imx: don't destroy mode objects manually on driver unbind
> 
>     Instead let drm_mode_config_cleanup() do the work when taking down
>     the master device. This requires all cleanup functions to be
>     properly hooked up to the mode object .destroy callback.
> 
>     Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>     Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> is probably responsible for introducing this problem, since the
> explicit calls were added by me when imx was stuck in staging due to
> the problems that the component helper solved.

The commit above does not revert cleanly today, but a quick fixing
seemed to resolve the problem I am seeing...

> 
> I think what we have here are different opinions on how cleanup
> should be handled.

In the regular case using the framework cleanup function before calling
component_unbind_all() works fine.

Its really only the case where a subcomponent fails to bind where unbind
happens before calling drm_mode_config_cleanup(drm). I guess Lucas was
not aware of that special case...?

I can send a patch which properly reverts the above commit.

--
Stefan
