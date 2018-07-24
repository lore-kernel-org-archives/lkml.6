Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5470FECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C8A20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN3go5CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C8A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbeGXDYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388235AbeGXDYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:24:48 -0400
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C611020880;
        Tue, 24 Jul 2018 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532398842;
        bh=8I/74v8EhIPy/7QYtBmoBU90BQPXL+4TIiPXOMlCRBY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QN3go5CLsz8qXSOorh4kEqq1OsBYNEY8JZc19FsgHhmpx1pDqI67uaUWX1mCY9ZWl
         zm2PEmL0zKN8wgRJbZIYkvITvZbmIa6CrZzIIe3ITfLfEO2THBw2ZCT237+YbSvpRi
         rxKJgjmXkBO0BD1J4yNQZFgVTNYinY8pND1keaB0=
Received: by mail-oi0-f44.google.com with SMTP id b15-v6so4787692oib.10;
        Mon, 23 Jul 2018 19:20:42 -0700 (PDT)
X-Gm-Message-State: AOUpUlGgOlI81IBGTgQ9AM1E+HgqGlKgODKYTNn6Ukda83MqnwOFhqli
        8VF341sasbiWaNG/FOmjOcvBFt+8X+gJtomAGik=
X-Google-Smtp-Source: AAOMgpdjePY6U2n5S2tl+ontKf4ZI6vnE2gRQHHhQL3N+FUlHwr212mnuibYUUOw9pEHup4hBEYC5REWDp58AfZyKAg=
X-Received: by 2002:aca:438b:: with SMTP id q133-v6mr1265903oia.234.1532398842092;
 Mon, 23 Jul 2018 19:20:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:6952:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 19:20:41
 -0700 (PDT)
In-Reply-To: <20180723195711.0a3c9301@t450s.home>
References: <20180724000944.7671.64284.stgit@gimli.home> <20180724001310.7671.41243.stgit@gimli.home>
 <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org> <20180723195711.0a3c9301@t450s.home>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Mon, 23 Jul 2018 19:20:41 -0700
X-Gmail-Original-Message-ID: <CAK9iUCPG-H3vWjiEnjAgr_nWEf=0Sn+AvRt68_Sg16Zw8TobRg@mail.gmail.com>
Message-ID: <CAK9iUCPG-H3vWjiEnjAgr_nWEf=0Sn+AvRt68_Sg16Zw8TobRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/18, Alex Williamson <alex.williamson@redhat.com> wrote:
> On Mon, 23 Jul 2018 17:40:02 -0700
> Sinan Kaya <okaya@kernel.org> wrote:
>
>> On 7/23/2018 5:13 PM, Alex Williamson wrote:
>> > + * The NVMe specification requires that controllers support PCIe FLR,
>> > but
>> > + * but some Samsung SM961/PM961 controllers fail to recover after FLR
>> > (-1
>> > + * config space) unless the device is quiesced prior to FLR.
>>
>> Does disabling the memory bit in PCI config space as part of the FLR
>> reset function help? (like the very first thing)
>
> No, it does not.  I modified this to only clear PCI_COMMAND_MEMORY and
> call pcie_flr(), the Samsung controller dies just as it did previously.
>
>> Can we do that in the pcie_flr() function to cover other endpoint types
>> that might be pushing traffic while code is trying to do a reset?
>
> Do you mean PCI_COMMAND_MASTER rather than PCI_COMMAND_MEMORY?

Yes

>  I tried
> that too, it doesn't work either.  I'm not really sure the theory
> behind clearing memory, clearing busmaster to stop DMA seems like a
> sane thing to do, but doesn't help here.

Let me explain what I guessed. You might be able to fill in the blanks
where I am completely off.

We do vfio initiated flr reset immediately following guest machine
shutdown. The card could be fully enabled and pushing traffic to the
system at this moment.

I don't know if vfio does any device disable or not.

FLR is supposed to reset the endpoint but endpoint doesn't recover per
your report.

Having vendor specific reset routines for PCIE endpoints defeats the
purpose of FLR.

Since the adapter is fully functional, i suggested turning off bus
master and memory enable bits to stop endpoint from sending packets.

But, this is not helping either.

Those sleep statements looked very fragile to be honest.

I was curious if there is something else that we could do for other endpoints.

No objections otherwise.

>
> Alex
>
