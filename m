Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5823EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062252087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLuSZlkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062252087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeIJSpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeIJSpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:45:49 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D5132087E;
        Mon, 10 Sep 2018 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536587497;
        bh=grLWO9SNv97XjpeahKkFZ6ptyvFdnnY9DMayeP5Ds8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mLuSZlkFkjPp7npO/OctFj48odyrYXYiZ5FWyDecIFamq5d0+/rGwERq9pZgID+J2
         9Au+we1fyyGV8YjB2Xps5/EN89exiTz7stsMeYzatPmqevRU2/U3yaF52T6ODNNwRt
         jvc9CQgEAlW/LCpfJgN5R+IsOSe3nFtmlQpXizMQ=
Received: by mail-qk1-f182.google.com with SMTP id 130-v6so14368369qkd.10;
        Mon, 10 Sep 2018 06:51:37 -0700 (PDT)
X-Gm-Message-State: APzg51CC+YVdsqYHFSFc3c4thNz5HHUqt7p/W74hUiLOJZkInVYlhLdj
        DWPHS0iP7LAyThn5R8YPSc2jfIqmAUbjEPBxQg==
X-Google-Smtp-Source: ANB0VdakuiABDqiVrpsaWHqTvtoZ+HupH0IxSoaNPd9I8LuBQXtZIon+kKU6YD1uH4X39pq2GBJLNr5pdG40PARjlLo=
X-Received: by 2002:a37:169c:: with SMTP id 28-v6mr14778861qkw.184.1536587496785;
 Mon, 10 Sep 2018 06:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-15-robh@kernel.org>
 <20180910133757.GA21593@infradead.org>
In-Reply-To: <20180910133757.GA21593@infradead.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Sep 2018 08:51:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ3VG7Yr6OqKTZD16TowOksNTQkO859UNLFdyMSnS3VQQ@mail.gmail.com>
Message-ID: <CAL_JsqJ3VG7Yr6OqKTZD16TowOksNTQkO859UNLFdyMSnS3VQQ@mail.gmail.com>
Subject: Re: [PATCH 14/21] riscv: use for_each_of_cpu_node iterator
To:     Christoph Hellwig <hch@infradead.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 8:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Sep 05, 2018 at 02:37:31PM -0500, Rob Herring wrote:
> > Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> > has the side effect of defaulting to iterating using "cpu" node names in
> > preference to the deprecated (for FDT) device_type == "cpu".
> >
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack and I will take via the DT tree. This is dependent on the
> > first 2 patches.
>
> We have a few pending patches in this area that look like they might
> conflict.  It might be worth to delay this one and apply it post -rc1
> to avoid dependencies if that isn't a problem for you.

Sure. That's fine.

Rob
