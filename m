Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E81C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1917C205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2qhYPzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1917C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeH3R4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbeH3R4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:56:48 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A18E20836;
        Thu, 30 Aug 2018 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535637273;
        bh=StQvhtI+/F8HFYbg85QBEGjNa2g4hBKh5cKHFErAVTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R2qhYPzvk1MlXCtgniA/l4GzsFoLwXfLtaqn0OL15Pg+wP+KFzEDx9KjlC3OgJTng
         zIgl9lbXgCknJhsy8RwltN5yTdgk8k1hf6cSuZvjRPMu7sqgeL+eLimjQIiAjfZ58a
         ohe8bqL6EoDo0EjAUslNkLEjc6csUMaOWGM8aBBc=
Received: by mail-wr1-f46.google.com with SMTP id o37-v6so8153997wrf.6;
        Thu, 30 Aug 2018 06:54:32 -0700 (PDT)
X-Gm-Message-State: APzg51CfgWJRfgtU/IZBVZ5MO4cY9+F7RrGb8BSPZ7MNTtPnZgV7gqJL
        OgaFUJPTXMc+aR3KAwxS3KCTtQzlJ/22fwuhZSY=
X-Google-Smtp-Source: ANB0VdYfUgbum+ni2ZytLT1QCjGGfofqOR/6B11+PviRj3M3Or0MsEq851Zz0pL/pHrKtFeGLTXxO0JuY1B/iJBpeTA=
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr7167864wrp.184.1535637271519;
 Thu, 30 Aug 2018 06:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
 <3053033.se6UkFii4W@tauon.chronox.de> <CAJKOXPd7JdzM2_PiHkS1ix1yU9hZmMbGDZaL07vbON0XzORH=w@mail.gmail.com>
 <2002208.sm9qV7UXju@tauon.chronox.de>
In-Reply-To: <2002208.sm9qV7UXju@tauon.chronox.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 30 Aug 2018 15:54:19 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdh6QReKb+Lt-_xTpRuzFbO-O-GVg+T1aA-9ST94oimwg@mail.gmail.com>
Message-ID: <CAJKOXPdh6QReKb+Lt-_xTpRuzFbO-O-GVg+T1aA-9ST94oimwg@mail.gmail.com>
Subject: Re: Locking for HW crypto accelerators
To:     smueller@chronox.de
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 at 15:19, Stephan Mueller <smueller@chronox.de> wrote:
>
> Am Donnerstag, 30. August 2018, 15:09:05 CEST schrieb Krzysztof Kozlowski:
>
> Hi Krzysztof,
>
> > Thanks Stephan for hints. Let's assume the each of init, update and
> > final are atomic... but how about the relation between update and
> > final? I have two concurrent users in user-space but only one HW:
> >
> > Process A:             Process B:
> > init() and set_key()
> >                        init() and different key
> > update(some_data)
> >                        update(different_data)
> > final()
> >                        final()
> >
> > The final() from process A will now produce the result of hashing/CRC
> > of some_data and different_data (and even maybe mixed with init() for
> > different key). All because in the meantime process B added its own
> > data to the HW.
>
> The question is where is the state of the cipher operation kept that is
> produced with each of the init/update/final calls. Your answer implies that
> this state is kept in hardware.

Yes, that's correct. The HW once initialized to specific CRC
parameters (size, polynomial, initial value), will operate on this
till another init happens.

> But commonly the state is kept in software. Look at ahash_request for example,
> the __ctx pointer is intended to point to the memory the driver needs to store
> its state.
>
> Pick a random driver implementation and search for ahash_request_ctx, for
> example.

I see now some drivers are indeed saving and restoring state.

Thanks!

Best regards,
Krzysztof
