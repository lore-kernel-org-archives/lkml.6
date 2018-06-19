Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A389CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3562083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOyttYCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3562083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966257AbeFSOeJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964999AbeFSOeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:34:07 -0400
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com [209.85.214.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39CE9208A1;
        Tue, 19 Jun 2018 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529418847;
        bh=uuWll2ndYsJ0Mi6L66AMu6G+664xyqoHoUwnkjYcIPw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=tOyttYCf7bkQ9pzrluwMTPYQSN8PTKCQCjav7CrapQ6rzCyXJX8/aa5ink0ZeSnRS
         W21lBYKu/KtQdcljm1shWGROFgcj5Ci8sQsSOQhcZ2NKV6bd5fq84lnGJzmIm3gRFK
         jH+KNxoyZMQaIvTEsoCsdP4gW24Jt/y1NdNAYyUE=
Received: by mail-it0-f52.google.com with SMTP id u4-v6so683124itg.0;
        Tue, 19 Jun 2018 07:34:07 -0700 (PDT)
X-Gm-Message-State: APt69E3+TNrOP/9N2cqNVBy+0C9scbBGsGMyJlrB2cNedv2RG5hT1QVZ
        l0/s6/DO8wUvqegSZHhkzeMqQOH1KIBw3UoKgQ==
X-Google-Smtp-Source: ADUXVKLf3DmTT4FmFb0Fp6ddMlGo2UUxyf+IeoK9N16gu7Jp8gkcyF12Kza50vUQ9j3D7KZ12BqNHLw4HmaVQf3hFso=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr12525937itc.19.1529418846645;
 Tue, 19 Jun 2018 07:34:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 07:33:46
 -0700 (PDT)
In-Reply-To: <20180619014608.92061-1-toddpoynor@gmail.com>
References: <20180619014608.92061-1-toddpoynor@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 19 Jun 2018 08:33:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLZXwD7SEmJYPZpRXZcdmS6XwPOdVY_M22Q+cV0xX7E9Q@mail.gmail.com>
Message-ID: <CAL_JsqLZXwD7SEmJYPZpRXZcdmS6XwPOdVY_M22Q+cV0xX7E9Q@mail.gmail.com>
Subject: Re: [PATCH] of/platform: add initcall_debug logs for device creates
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 7:46 PM, Todd Poynor <toddpoynor@gmail.com> wrote:
> From: Todd Poynor <toddpoynor@google.com>
>
> Add initcall_debug logs for the amount of time taken by each OF platform
> bus device create call.  For example:
>
>    of platform device create /reserved-memory/ramoops@a3800000 took
>    3255 usecs
>
> initcall_debug already reports the total of all such device creates
> as a single entry for function of_platform_default_populate_init (or
> similar, depending on the board).  The new logs help identify which of
> the potentially hundreds of device inits take significant amounts of
> time.

It's really the probe time that matters here. Outside of that,
creating the devices should be fairly constant time. So why not add
timing around non bus specific probe code (driver_probe_device)
instead of adding this in multiple places. Then you can remove the
timing from deferred probe code.

Rob
