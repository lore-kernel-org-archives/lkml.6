Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918C7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC72208D8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kTqA1f6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC72208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeHBM5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:57:23 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49044 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbeHBM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:57:22 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8FC895C08AE;
        Thu,  2 Aug 2018 13:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533208002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoPSzLz0/AHb2zSPTWiS5i9dH0V+aLtHBNgd4P/Wgcw=;
        b=kTqA1f6NtRBvehSlx0Q9KzavcZvBS6WIrrRBPvTtBC3f//Prgj8CMFo1mS0MACST1crQGv
        ouEhZYLt8XUssS+q6QsL5V2RTWFINJHRr2UA03c7bpwQ9BBr5oz30hhrZdBpolooHT3rDP
        x981kUsl0mM+/iW3Pqt4zdRwRKZArTQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 13:06:42 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>, marex@denx.de,
        shawnguo@kernel.org, Anson Huang <anson.huang@nxp.com>,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, kernel@pengutronix.de,
        Robert Chiras <robert.chiras@nxp.com>, l.stach@pengutronix.de
Subject: Re: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
In-Reply-To: <1533205073.3516.17.camel@pengutronix.de>
References: <f873c5592e9907beba905ce68358d5ae2f63a4d7.1531824173.git.leonard.crestez@nxp.com>
 <1533038097.3444.13.camel@pengutronix.de>
 <c5e9f521edbca4b1b168e4ee6c8fbd41b1ca2261.camel@nxp.com>
 <1533205073.3516.17.camel@pengutronix.de>
Message-ID: <0f22023bf42fc7ba458b285d60e3b866@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.2018 12:17, Philipp Zabel wrote:
> On Tue, 2018-07-31 at 12:17 +0000, Leonard Crestez wrote:
>> On Tue, 2018-07-31 at 13:54 +0200, Philipp Zabel wrote:
>> > On Tue, 2018-07-17 at 13:48 +0300, Leonard Crestez wrote:
>> > > Adding lcdif nodes to a power domain currently does work, it results in
>> > > black/corrupted screens or hangs. While the driver does enable runtime
>> > > pm it does not deal correctly with the block being unpowered.
>> > >
>> > > Ensure power is on when required by adding pm_runtime_get/put_sync to
>> > > mxsfb_pipe_enable/disable.
>> > >
>> > > Since power is lost on suspend implement PM_SLEEP_OPS using
>> > > drm_mode_config_helper_suspend/resume.
>> > >
>> > > The mxsfb_plane_atomic_update function can get called before
>> > > mxsfb_pipe_enable while the block is not yet powered. When this happens
>> > > the write to LCDIF_NEXT_BUF is lost causing corrupt display on unblank
>> > > until a refresh.
>> >
>> > Why does this happen?
>>
>> I'm not sure what you're asking but register writes to unpowered or
>> unclocked blocks are not expected to "just work". Here the write is
>> ignored/lost but I think on imx8 it can even cause a bus error.
>>
>> The approach here is to only set the framebuffer address as part of
>> activating the display.
> 
> I wonder why atomic update is called at all while the pipe is not
> enabled.

It can be made to behave differently (see also my review).

However, the default seems also a bit unfortunate to me.

--
Stefan
