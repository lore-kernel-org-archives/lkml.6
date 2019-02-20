Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CDEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE62147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBTM0s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:26:48 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:44912 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfBTM0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:26:48 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id D07A615632; Wed, 20 Feb 2019 12:26:46 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
References: <20190216164512.9525-1-mans@mansr.com>
        <20190220113506.11009-1-mans@mansr.com>
        <20190220115117.GK4072@localhost> <yw1ximxewte5.fsf@mansr.com>
        <CAJZ5v0jTxeVrDSA8RMVZ+U7-TvPN72ZcF+J4r66-dhngaWpiAw@mail.gmail.com>
Date:   Wed, 20 Feb 2019 12:26:46 +0000
In-Reply-To: <CAJZ5v0jTxeVrDSA8RMVZ+U7-TvPN72ZcF+J4r66-dhngaWpiAw@mail.gmail.com>
        (Rafael J. Wysocki's message of "Wed, 20 Feb 2019 13:18:39 +0100")
Message-ID: <yw1xef82wsqh.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Wed, Feb 20, 2019 at 1:12 PM Måns Rullgård <mans@mansr.com> wrote:
>>
>> Johan Hovold <johan@kernel.org> writes:
>>
>> > On Wed, Feb 20, 2019 at 11:35:06AM +0000, Mans Rullgard wrote:
>> >> If the provided fwnode is an OF node, set dev.of_node as well.
>> >>
>> >> Some drivers are just shims that create extra "glue" devices with the
>> >> DT device as parent and have the real driver bind to these.  In these
>> >> cases, the glue device needs to get a reference to the original DT node
>> >> in order for the main driver to access properties and child nodes.
>> >>
>> >> For example, the sunxi-musb driver creates such a glue device using
>> >> platform_device_register_full().  Consequently, devices attached to
>> >> this USB interface don't get associated with DT nodes, if present,
>> >> the way they do with EHCI.
>> >>
>> >> This change will allow sunxi-musb and similar driver to easily
>> >> propagate the DT node to child devices as required.
>> >
>> > Just a drive-by comment, didn't look to closely at this patch, but this
>> > all sounds familiar.
>> >
>> > Note that if both platform devices are bound to drivers you may end up
>> > with some resources like pinctrl which are handled automatically by
>> > driver core at probe time to be requested twice (and failing the second
>> > time).
>> >
>> > Take a look at 4e75e1d7dac9 ("driver core: add helper to reuse a
>> > device-tree node"), which provides a means to avoid this, and
>> > 49484abd93ab ("USB: musb: dsps: propagate device-tree node").
>>
>> Thanks, and ugh.  So we should be setting the of_node_reused flag when
>> this is the case.  It's easy for the musb-dsps driver since it doesn't
>> use platform_device_register_full() and can do this before the
>> device_add() call.  How can we convey that this flag needs to be set?
>
> Through pdevinfo I guess?

Not without adding another field to it.  The most direct is of course to
simply add an of_node_reused flag there too and copy it over.  Would
that be OK, or is there a better way?

-- 
Måns Rullgård
