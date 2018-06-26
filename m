Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9154C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2494D26E57
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmUG2BIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2494D26E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeFZVBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbeFZVB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:01:29 -0400
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com [209.85.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479A926E32;
        Tue, 26 Jun 2018 21:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530046888;
        bh=aYn84LkAxNGCyQEMmLh/b/19PjrLkl8VmDrMxE/g6J8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pmUG2BIhprMyyMkIFNNJz4/HMtjUJDqv7H1UQB8oB3Qw8Gihit0e7+1bN7zCyNeHV
         UaAnZCHJc7/0jBXLGdtzRD3FZq0mWVG2hIL0hTn/f9H9S2Jf8UBe5ax+IAAW2svjbv
         quh9nONqKbqz0zJ/H9I+q86PXye45VV7QG0a3Ctc=
Received: by mail-yb0-f178.google.com with SMTP id i3-v6so3993653ybl.9;
        Tue, 26 Jun 2018 14:01:28 -0700 (PDT)
X-Gm-Message-State: APt69E1jIqn+JvbI/4d/dzk2j/uRjL2iZa089J6rWjTNszArU5o4d+Wq
        z2Qq8VtIDAKOfCc5H7ZUpCvr5eQmHCl4s0Ber1M=
X-Google-Smtp-Source: ADUXVKJZEq58IMwc/H+ESYnGkMD8jmU1yP2rbD8gI2IMDtxlhzfeqgZAIzSJYLej6tNZBGqR7LQxY1xmSSOlX4eEiZM=
X-Received: by 2002:a5b:54a:: with SMTP id r10-v6mr1730011ybp.166.1530046887426;
 Tue, 26 Jun 2018 14:01:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b89:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 14:00:46 -0700 (PDT)
In-Reply-To: <22840601.TEhG8FuRZq@pcbe13614>
References: <4617134.5euanDEBgJ@pcbe13614> <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
 <22840601.TEhG8FuRZq@pcbe13614>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 26 Jun 2018 16:00:46 -0500
X-Gmail-Original-Message-ID: <CANk1AXRFK8CYn_c7ckpJeXpFbc-CcZ+xzZiJzUsiDUUS7ancPA@mail.gmail.com>
Message-ID: <CANk1AXRFK8CYn_c7ckpJeXpFbc-CcZ+xzZiJzUsiDUUS7ancPA@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_get() buggy ?
To:     federico.vaga@cern.ch
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga <federico.vaga@cern.ch> wrote:

Hi Federico,

>> > What is buggy is the function fpga_mgr_get().
>> > That patch has been done to allow multiple FPGA manager instances
>> > to be linked to the same device (PCI it says). But function
>> > fpga_mgr_get() will return only the first found: what about the
>> > others?

I've had more time with this, I agree with you.  I didn't intend to
limit us to one manager per parent device.

>> > Then, all load kernel-doc comments says:
>> >
>> > "This code assumes the caller got the mgr pointer from
>> > of_fpga_mgr_get() or fpga_mgr_get()"
>> >
>> > but that function does not allow me to get, for instance, the
>> > second FPGA manager on my card.
>> >
>> > Since, thanks to this patch I'm actually the creator of the
>> > fpga_manager structure,  I do not need to use fpga_mgr_get() to
>> > retrieve that data structure.
>> > Despite this, I believe we still need to increment the module
>> > reference counter (which is done by fpga_mgr_get()).
>> >
>> > We can fix this function by just replacing the argument from
>> > 'device' to 'fpga_manager' (the one returned by create() ).
>>
>> At first thought, that's what I'd want.
>>
>> > Alternatively, we
>> > can add an 'owner' field in "struct fpga_manager_ops" and 'get' it
>> > when we use it. Or again, just an 'owner' argument in the create()
>> > function.
>>
>> It seems like we shouldn't have to do that.
>
> Why?

OK yes, I agree; the kernel has a lot of examples of doing this.

I'll have to play with it, I'll probably add the owner arg to the
create function, add owner to struct fpga_manager, and save.

>
>> > I'm proposing these alternatives because I'm not sure that
>> >
>> > this is correct:
>> >         if (!try_module_get(dev->parent->driver->owner))
>> >
>> > What if the device does not have a driver? Do we consider the
>> > following a valid use case?
>> >
>> >
>> > probe(struct device *dev) {
>> >
>> >   struct device *mydev;
>> >
>> >   mydev->parent = dev;
>> >   device_register(mydev);
>> >   fpga_mrg_create(mydev, ....);
>> >
>> > }

Sure

>>
>> When would you want to do that?
>
> Not sure when, I'm in the middle of some other development and I
> stumbled into this issue. But of course I can do it ... at some point
> :)

I was meaning to ask something else.  I don't mind writing this and
would be interested in your review/feedback.  Thanks again for seeing
this and for the thoughtful analysis.

Alan
