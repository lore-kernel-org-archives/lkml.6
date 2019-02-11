Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48207C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B91A21773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549915567;
	bh=yUvElnEvyG65dIWr7xpqH8esN//aSZKgiGIPwUv/d8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oCcGIvcIoeJ/9Ipp/jaLJBuzc0NL40vzFyoA4sAdSnZXFfmlkz7+sYi3aSwDE0057
	 laq6hPnDBsozK+UQwizUZMuFHsDybBaukgcBN7sZffDvc2GOLfWQKAa6nB2h9JbGV+
	 rULHj7hSGFP5uS7jjUQ++q0VxuL2UhrmTZ6ZSeDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbfBKUGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfBKUGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:06:05 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18DD32084D;
        Mon, 11 Feb 2019 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549915564;
        bh=yUvElnEvyG65dIWr7xpqH8esN//aSZKgiGIPwUv/d8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yYpB+H6YeRhl2VOj4fVvkhOHqj1aC96YEimcfIBrvjZEIP1Wz1FAqIB+NxAko1g81
         quUcwy5haLIoxkfOL9SIM850LKt2WtQ+uJ++AXrpll8ppnYPq7GMr9nSl8quEaUyKr
         R+u4XrnMXEMWDTA0J0r7TDf4xnaxqNkLf0e3s2+o=
Date:   Mon, 11 Feb 2019 20:05:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     justinpopo6@gmail.com, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: add GPIO support
Message-ID: <20190211200557.7648d447@archlinux>
In-Reply-To: <2e692086-4be5-10ea-34b0-4444995c4275@lechnology.com>
References: <1549653856-47409-1-git-send-email-justinpopo6@gmail.com>
        <20190209170042.69a78684@archlinux>
        <2e692086-4be5-10ea-34b0-4444995c4275@lechnology.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2019 12:56:11 -0600
David Lechner <david@lechnology.com> wrote:

> On 2/9/19 11:00 AM, Jonathan Cameron wrote:
> > Nope.  This is a state lock used to protect against transitions between
> > different modes of the IIO device (buffered vs polled), it
> > isn't suitable for general use.
> > 
> > The driver should be modified to handle that correctly.
> > We have iio_claim_direct_mode etc that deal with the case
> > where a device can't do certain operations whilst in buffered
> > mode.  Note it can fail and should.
> > 
> > Seems there are more drivers still doing this than I thought.
> > If anyone is bored and wants to clean them out, that would be
> > most appreciated!
> > 
> > If you need locking to protect a local buffer or the device
> > state, define a new lock to do it with clearly documented
> > scope.  
> 
> Just as a reminder, there is a use case for this particular
> chip that requires buffered mode and direct mode at the same
> time.
> 
> https://patchwork.kernel.org/patch/10539021/
> https://patchwork.kernel.org/patch/10527757/

Thanks, I had indeed forgotten that entirely.
So it should have a local lock and not take mlock explicitly at all.

Jonathan
