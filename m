Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFBC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FC22086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFH6hrDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FC22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbeKGJsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:48:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37054 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeKGJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:48:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id o15-v6so11910683wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3dmmkrBM26xZCruBFL0oc+LVw/FdHiNlDaVh9Ykdms=;
        b=iFH6hrDqieyL0+ThKkryVLSC8XS1BdAPCrsjtx2VaaxjB3I8X2sPFNZ5iBFwxsrGuo
         80odhMq/3KQDopMfEUVFRLc5bPKJvALFvYZFPBLGKnonbeIICrJHYvST227KKU8XHClo
         uWnG7xBYEW5gfJerBlUvqZV8FxE8OnVosFXYQlCRYLmSVf0jjGiw8vQFA8EwTsoZafV3
         MTOuHwQgmSYQisu5WEr+Lo3JdwCNP/CnRAHssY770sxbX40fMgx0da+/gMquhYO+pwGo
         qhZyFRxl6Ydjxp+uZkofUKpJgkI3XG5Aq087GYwzOlOsL/X/kwMrbRbjg3QwLiq+ItAh
         AQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3dmmkrBM26xZCruBFL0oc+LVw/FdHiNlDaVh9Ykdms=;
        b=N2rm9YGBOMHEWKGVEjLvhnG6Ml9dPM/QCnvJCWciY1ASV04oWtOx8UO4U8KV0KjSoj
         FqD5PJeHUPKGrzZtCxcVCgoPfwDEAhYsNvdbcmHPuLQ8AHWfCp39sr4dZ+7HV2V4TrQv
         PlFakFydm19p4n4sj2334L2HBjkBKNWQv1Ecl3t9oWf+00rR1hwUcPWvz+/VSf+6MEH6
         hccwCFGLl1Smk17ebccfcvLnPAPU/VrmwObENaEvN1VduDzVcQ4Krcy0q3UxOp9/Swok
         h9+3XuyDuslcGCnrf/QMND8r9l2QsCSC903GPe2yL2iYbn6XAlVtpcn9IC122VTfymYG
         4VdQ==
X-Gm-Message-State: AGRZ1gLcubMgqrdxxaY7p8hPusHaci0xnR4LDQxIwIRqTsPqR+Ez42Zu
        Dxr4vBc2J/DZ1Fx6PW9Z1gFnq82EGB7a+2aT/jodDw==
X-Google-Smtp-Source: AJdET5faDz4gtUlcrpWkTf38q8RkWE+2NL3r+lGeJUYncFMTmTNy5BMkGSu8sC478lhjZFnb21zSzOhtAodeFJY5fLA=
X-Received: by 2002:a5d:6489:: with SMTP id r9-v6mr23574074wru.92.1541550061092;
 Tue, 06 Nov 2018 16:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20180818155724.GA22569@kroah.com> <20180828103817.GB1397@do-kernel>
 <20180828123607.GB13441@kroah.com> <20180828143049.GA7388@darwi-kernel>
 <20180910081626.GA31344@kroah.com> <20180910152837.GA31819@darwi-kernel>
In-Reply-To: <20180910152837.GA31819@darwi-kernel>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Tue, 6 Nov 2018 16:20:49 -0800
Message-ID: <CAAW3YpZj=U=RtKLtB3Wq-agi9Vxxd_Mn8x1qo5hXXcV7hSLV9Q@mail.gmail.com>
Subject: RFC: staging: gasket: re-implement using UIO
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Springer <rspringer@google.com>,
        LKML <linux-kernel@vger.kernel.org>, devel@linuxdriverproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 8:28 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> The gasket in-kernel framework, recently introduced under staging,
> re-implements what is already long-time provided by the UIO
> subsystem, with extra PCI BAR remapping and MSI conveniences.
>
> Before moving it out of staging, make sure we add the new bits to
> the UIO framework instead, then transform its signle client, the
> Apex driver, to a proper UIO driver (uio_driver.h).
>
> Link: https://lkml.kernel.org/r/20180828103817.GB1397@do-kernel

So I'm looking at this for reals now.  The BAR mapping stuff is
straightforward with the existing framework.  Everything else could be
done outside of UIO via the existing device interface, but figured I'd
collect any opinions about adding the new bits to UIO.

The Apex device has 13 MSIX interrupts.  UIO does one IRQ per device.
The PRUSS driver registers 8 instances of the UIO device with
identical memory mappings but individual IRQs for its 8 interrupts.
Currently gasket has userspace pass down an eventfd (via ioctl) for
each interrupt it wants to watch.  Is there interest in modifying UIO
to handle multiple IRQs in some perhaps similar fashion?

Speaking of ioctls, are those allowed here, or is sysfs or something
else always required?  The aforementioned multiple IRQ stuff probably
maps nicely to sysfs (there's a small number of them easily
represented as attributes), while DMA buffer mappings seem more
problematic, but maybe somebody's thought of a good way to represent
these already.

And then we need to map buffers to our device.  We could probably
implement this via an IOMMU driver API for our custom MMU and hook
that up to generic IOMMU support for UIO, which sounds like something
a lot of drivers could use.

There's a few other tidbits the driver does, including allocating
coherent memory for userspace to share with the device, but that's
probably enough for now.

If anybody wants to squash any of the above as a non-starter for UIO
or point things in a different direction, it's appreciated.

Thanks,


Todd
