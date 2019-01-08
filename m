Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1890C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB942087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546955424;
	bh=35yoXLMJlxhAzXFrmdpn9DDgAlLDniGkmEqLPnbN19c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W4jXKVcuTUQ0I6vJx5hYh0T+OK4goZrEz6CidI1/LHgzOMCXxY/55c0v5u8+TK+pL
	 FwtMbak3Ki8fNj6Trxoqb7pe3rHezEJtBk3/hoPlolxQ7MrpFNIMnTHT8VRLAF+mHf
	 9wkFFwqmzVr5F6iQo67rO42ZJGAim7LOs9XDRFcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfAHNuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbfAHNuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:50:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51BDC206BB;
        Tue,  8 Jan 2019 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546955422;
        bh=35yoXLMJlxhAzXFrmdpn9DDgAlLDniGkmEqLPnbN19c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wd66UOWHtuDEVFGJZGaOAWaLOywbwDe3GAdWc+GGHX/fdlnsYLJz0VdkWbPE5ET0f
         CGAKVu/KV34V8y+u2ol+hFn+EsIeocUVacTmKWAl/pAM+6E9AaFBgrHM8kRhZJJ9Ng
         bm1uPRFA25DMt60cLtRYDHP7cXp0Dyzvdt8wsYG4=
Date:   Tue, 8 Jan 2019 14:50:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: general protection fault in spk_ttyio_ldisc_close
Message-ID: <20190108135020.GA10504@kroah.com>
References: <CAEAjamunJjFFJ8Yd-DQAv64MxYiiktsTUWex=boAOdc0+7h+uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamunJjFFJ8Yd-DQAv64MxYiiktsTUWex=boAOdc0+7h+uQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:37:37AM -0500, Kyungtae Kim wrote:
> We report a bug in linux-4.20: "general protection fault in
> spk_ttyio_ldisc_close"
> 
> kernel config: https://kt0755.github.io/etc/config_v4.20_stable
> repro: https://kt0755.github.io/etc/repro.a670e.c
> 
> This occurs when the function kfree is about to execute
> (driver/staging/speakup/spk_ttyio.c:68).
> Particularly, kfree takes the argument like speakup_tty->disc_data.
> But speakup_tty is invalid, so the pointer dereference causes GPF.
> At a glance, it seems that speakup_tty was deallocated somewhere ahead of kfree.

How did you trigger this?  Did you shut down and close the device
already somehow?  Do you have a real tty device that is driven by the
device?

thanks,

greg k-h
