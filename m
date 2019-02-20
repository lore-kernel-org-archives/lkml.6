Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB8BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62642147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfBTKlU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:41:20 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:44098 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfBTKlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:41:20 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 9B1B815637; Wed, 20 Feb 2019 10:41:18 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
References: <20190216164512.9525-1-mans@mansr.com>
        <CAJZ5v0iZHfU=mE3JGcKqbswGGert7CvpKPkVE1s+-X1zXKJiEw@mail.gmail.com>
        <yw1xk1hxxss8.fsf@mansr.com>
        <CAJZ5v0gG5Rau71YrmUL8V7EpZjHQNOzLpEJHCJjXdgaDm4TrSw@mail.gmail.com>
Date:   Wed, 20 Feb 2019 10:41:18 +0000
In-Reply-To: <CAJZ5v0gG5Rau71YrmUL8V7EpZjHQNOzLpEJHCJjXdgaDm4TrSw@mail.gmail.com>
        (Rafael J. Wysocki's message of "Wed, 20 Feb 2019 10:50:43 +0100")
Message-ID: <yw1x7eduyc6p.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Feb 18, 2019 at 12:10 PM Måns Rullgård <mans@mansr.com> wrote:
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Sat, Feb 16, 2019 at 5:50 PM Mans Rullgard <mans@mansr.com> wrote:
>> >>
>> >> If the provided fwnode is an OF node, set dev.of_node as well.
>> >>
>> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> >> ---
>> >>  drivers/base/platform.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> >> index dff82a3c2caa..853a1d0e5845 100644
>> >> --- a/drivers/base/platform.c
>> >> +++ b/drivers/base/platform.c
>> >> @@ -512,6 +512,7 @@ struct platform_device *platform_device_register_full(
>> >>
>> >>         pdev->dev.parent = pdevinfo->parent;
>> >>         pdev->dev.fwnode = pdevinfo->fwnode;
>> >> +       pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
>> >
>> > of_node_get() generally does a kobject_get() on the node's kobject, so
>> > when is that reference dropped?  Or if it doesn't need to be dropped
>> > at all, why is this the case?
>>
>> platform_device_release() calls of_device_node_put().
>
> Yes, it does, but this is the reference that's already acquired for
> devices added while parsing DT, isn't it?
>
> Your change adds an extra reference AFAICS.
>
> Also, why is this patch needed?

Some drivers are just shims that create extra "glue" devices with the DT
device as parent and have the real driver bind to these.  In other
cases, the same real driver matches the DT node directly.  When a glue
device is used, it needs to get a reference to the original DT node in
order for the main driver to access properties and child nodes.

Right now, my problem is that the suxi-musb driver creates such a glue
device for the musb core driver to bind to without setting of_node.
This means devices attached to this USB interface don't get associated
with DT nodes, if present, the way they do with EHCI.

The sunxi-musb driver uses platform_device_register_full(), so this
seemed like the easiest way to let it set of_node of the new device.
Since this creates a second reference to the same node, of_node_get()
is required.

If you'd prefer solving this in some other way, please tell me how.

-- 
Måns Rullgård
