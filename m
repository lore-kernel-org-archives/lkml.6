Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB74EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797E92173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547103463;
	bh=zURElWaV1s1C73JNRKoyfkAu0+W613sSKDS8Jw22Imw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V+pUx5it3SmQUiEcbFvbl/e2waIBTxgQfeXHyMQqcNg4fJJUtML9dF4BYwlGrryQA
	 Wvv2hRLu6ri7qKLDNpa3ld6jDA0Da7iBOKqITkKTAawdrBLYfFcaeVMM2Oo99jw0/c
	 PMZ1lZFhNcs3lpRLkBSLyr7jpC6RsAqDMs07C3Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfAJG5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:57:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAJG5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:57:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FBA20657;
        Thu, 10 Jan 2019 06:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547103461;
        bh=zURElWaV1s1C73JNRKoyfkAu0+W613sSKDS8Jw22Imw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iS0/KpWi3vnl0rtHkMb7IiOKevwYH5t1Z6s6D+IfMqFl00A43aNGWJRo4Zyofufdd
         aHK+I5EzNlJiRZBtCTi3la9Ug8YsSQQdH9e9Pzc7cjMv3AnFiHGRv8C/074HUYAa6N
         gKr53BkvLmo7692SV8/bAA5m4rJHKKjkRE1r2OHo=
Date:   Thu, 10 Jan 2019 07:57:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Chen <hzpeterchen@gmail.com>
Cc:     Pawel Laszczak <pawell@cadence.com>, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        hdegoede@redhat.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, rogerq@ti.com,
        lkml <linux-kernel@vger.kernel.org>, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Message-ID: <20190110065738.GA28817@kroah.com>
References: <1545577992-4013-1-git-send-email-pawell@cadence.com>
 <1545577992-4013-6-git-send-email-pawell@cadence.com>
 <CAL411-oF2j1Xjz60Q3B1beBoUoFUxN+rBi9_Z0nx7R2P0p_3tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL411-oF2j1Xjz60Q3B1beBoUoFUxN+rBi9_Z0nx7R2P0p_3tg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:30:41AM +0800, Peter Chen wrote:
> On Mon, Dec 24, 2018 at 12:44 AM Pawel Laszczak <pawell@cadence.com> wrote:
> - debugfs is nice to have feature, I suggest removing it at this
> initial version. Besides, role switch
> through /sys is normal feature, the end user may use it at real
> product, so, it is better at device's
> /sys entry instead of debugfs.
> 
> - I don't know why you add "disable" at debugfs, please comment.

As you imply here, no real-world functionality should ever be in
debugfs as it is an optional system component and kernel code should
work just fine without it being enabled (as more and more systems are
disabling it due to the obvious security problems it has.)

thanks,

greg k-h
