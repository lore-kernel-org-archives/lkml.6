Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9018C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B95420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjDaPkQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B95420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeIJSlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbeIJSlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:41:11 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C9E20870;
        Mon, 10 Sep 2018 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536587221;
        bh=VufMcTa7f0x2r/biAa4oL6uxWKEVXzX1TnjDZvaTM9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sjDaPkQXqfytaVJaF3OkGIWCK/UfThtxYFvDNEX5E95Jb1q2fxfo0Mo/yMvED9BUi
         ioA7JJQOTbfGFCPgJOMTqy/keX/ID/5P0NXZm4r59jPs9pDOj9GIhCk6yDO9+BGUHI
         SjyECsmkO9MU6dguBXLkroqM+BqJSnXx28RNoE4U=
Received: by mail-qt0-f179.google.com with SMTP id h4-v6so24147642qtj.7;
        Mon, 10 Sep 2018 06:47:01 -0700 (PDT)
X-Gm-Message-State: APzg51AHabg6YskG28qY8eXCIlLnngYx2P3rg0n6LsGeJLpGh3pDjkkL
        EPlbhidiLJEMcALAHgzS5gMxaN/BwGQO8C8XWQ==
X-Google-Smtp-Source: ANB0VdZTppi5tPoKfT/Qe25ypYOy1PS5HRdWQg3AEb44SBA/PoykruBgJLGJy1Abw1LG68koFZ96EsaEy9yK1f+PN6w=
X-Received: by 2002:ac8:46d3:: with SMTP id h19-v6mr15915253qto.188.1536587220256;
 Mon, 10 Sep 2018 06:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR04MB52394FDB1266388BCE1374E3FC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
 <c0bcc2c1-3058-db4d-ca4d-4e56c502891b@gmail.com> <DB7PR04MB5243B6ADEBCB4B53B5A161F8FC050@DB7PR04MB5243.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB5243B6ADEBCB4B53B5A161F8FC050@DB7PR04MB5243.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Sep 2018 08:46:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKc1-Rz6iBJ_dpDrEDoFRpTaLR+1voXdTgiJjjG65druA@mail.gmail.com>
Message-ID: <CAL_JsqKc1-Rz6iBJ_dpDrEDoFRpTaLR+1voXdTgiJjjG65druA@mail.gmail.com>
Subject: Re: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
To:     Andre.Kalb@sma.de
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 4:51 AM Andre Kalb <Andre.Kalb@sma.de> wrote:
>
> Hi Frank,
>
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von: Frank Rowand [mailto:frowand.list@gmail.com]
> > Gesendet: Freitag, 7. September 2018 22:01
> > An: Andre Kalb; robh+dt@kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Betreff: Re: [PATCH v2] of: __of_update_property_sysfs only call
> > __of_sysfs_remove_bin_file if of_node_is_attached
> >
> > Hi Andred,
> >
> > On 09/04/18 08:51, Andre Kalb wrote:
> > > To prevent warning "kernfs: can not remove '(null)', no directory" if=
 an overlay
> > isn't applied to the active devicetree.
> > >
> > > Using of_remove_property and then of_add_property doesn't show the
> > warning.

[...]

> > What is the calling path that results in the warning?
> >
> > -Frank
>
> There is the callstack of the warning.
>
> [   10.782830] ------------[ cut here ]------------
> [   10.830357] WARNING: CPU: 0 PID: 170 at /linux-4.x/fs/kernfs/dir.c:127=
6 kernfs_remove_by_name_ns+0x30/0x80()
> [   10.928997] kernfs: can not remove '(null)', no directory
> [   10.993107] Modules linked in: module_capemgr(+)
> [   11.045750] CPU: 0 PID: 170 Comm: systemd-udevd Not tainted 4.4.143-00=
158-g8e5ca65ec7ee-dirty #114

158 patches on top of an almost 3 year old kernel...

> [   12.011373] [<bf0000e4>] (module_capemgr_slot_scan [module_capemgr]) f=
rom [<bf0007bc>] (module_capemgr_probe+0x3c/0x58 [module_capemgr])

And a driver that's not upstream.

Not saying the fix isn't valid, but please reproduce on recent
mainline. Add a unittest if you have to.

Rob
