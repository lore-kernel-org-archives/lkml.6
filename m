Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0958FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B767A20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cddFvooa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B767A20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeK0CKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeK0CKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:10:30 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F0720663;
        Mon, 26 Nov 2018 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543245365;
        bh=9d0nKAYCFeUtQbgkFt5EQfMbFmcEMi41a8bvS3wOI20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cddFvooabu2YlAIUFrhfZTcgooUD4MYnhGb+dp4ub33saDEDXDkkl+np4KIKgn5K5
         I/15h00ju4+QBvnFXj5Ilstl2HzjZSjVTu2XuZTypWJ7luO3vg4KvMOwlJi+VvsDBg
         ySdn0E5iI0AT/B3F1azMnLH3Xk5OsCTMzGQ27oW0=
Date:   Mon, 26 Nov 2018 10:16:01 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        nicolas.ferre@microchip.com, rainyfeeling@outlook.com,
        johan@kernel.org
Subject: Re: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node lookup
Message-ID: <20181126151601.GA100860@sasha-vm>
References: <20181126105050.592727680@linuxfoundation.org>
 <20181126105054.941598787@linuxfoundation.org>
 <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
 <20181126160840.1c702e87@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181126160840.1c702e87@bbrezillon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:08:40PM +0100, Boris Brezillon wrote:
>On Mon, 26 Nov 2018 19:46:15 +0530
>Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
>> Do you see build failure arm x15 beagleboard on 4.14 due to this patch ?
>>
>> On Mon, 26 Nov 2018 at 16:31, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >
>> > 4.14-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Johan Hovold <johan@kernel.org>
>> >
>> > commit 5d1e9c2212ea6b4dd735e4fc3dd6279a365d5d10 upstream.
>> >
>> > Use the new of_get_compatible_child() helper to lookup the nfc child
>> > node instead of using of_find_compatible_node(), which searches the
>> > entire tree from a given start node and thus can return an unrelated
>> > (i.e. non-child) node.
>> >
>> > This also addresses a potential use-after-free (e.g. after probe
>> > deferral) as the tree-wide helper drops a reference to its first
>> > argument (i.e. the node of the device being probed).
>> >
>> > While at it, also fix a related nfc-node reference leak.
>> >
>> > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
>> > Cc: stable <stable@vger.kernel.org>     # 4.11
>> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>> > Cc: Josh Wu <rainyfeeling@outlook.com>
>> > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
>> > Signed-off-by: Johan Hovold <johan@kernel.org>
>> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > ---
>> >  drivers/mtd/nand/atmel/nand-controller.c |   11 +++++++----
>> >  1 file changed, 7 insertions(+), 4 deletions(-)
>> >
>> > --- a/drivers/mtd/nand/atmel/nand-controller.c
>> > +++ b/drivers/mtd/nand/atmel/nand-controller.c
>> > @@ -2077,8 +2077,7 @@ atmel_hsmc_nand_controller_legacy_init(s
>> >         int ret;
>> >
>> >         nand_np = dev->of_node;
>> > -       nfc_np = of_find_compatible_node(dev->of_node, NULL,
>> > -                                        "atmel,sama5d3-nfc");
>> > +       nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
>> >         if (!nfc_np) {
>> >                 dev_err(dev, "Could not find device node for sama5d3-nfc\n");
>> >                 return -ENODEV;
>> > @@ -2492,15 +2491,19 @@ static int atmel_nand_controller_probe(s
>> >         }
>> >
>> >         if (caps->legacy_of_bindings) {
>> > +               struct device_node *nfc_node;
>> >                 u32 ale_offs = 21;
>> >
>> >                 /*
>> >                  * If we are parsing legacy DT props and the DT contains a
>> >                  * valid NFC node, forward the request to the sama5 logic.
>> >                  */
>> > -               if (of_find_compatible_node(pdev->dev.of_node, NULL,
>> > -                                           "atmel,sama5d3-nfc"))
>> > +               nfc_node = of_get_compatible_child(pdev->dev.of_node,
>> > +                                                  "atmel,sama5d3-nfc");
>> > +               if (nfc_node) {
>> >                         caps = &atmel_sama5_nand_caps;
>> > +                       of_node_put(nfc_node);
>> > +               }
>> >
>> >                 /*
>> >                  * Even if the compatible says we are dealing with an
>> >
>> >
>>
>> /drivers/mtd/nand/atmel/nand-controller.c: In function
>> 'atmel_hsmc_nand_controller_legacy_init':
>> /drivers/mtd/nand/atmel/nand-controller.c:2080:11: error: implicit
>> declaration of function 'of_get_compatible_child'; did you mean
>> 'of_get_next_available_child'? [-Werror=implicit-function-declaration]
>>    nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
>
>Looks like of_get_compatible_child() has been introduced in 4.18, hence
>this error.
>
>Greg, can you drop this patch from 4.14.y?

Interesting, none of the kernelci builds caught this? hmm

--
Thanks,
Sasha
