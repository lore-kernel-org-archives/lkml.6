Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9C6C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0504527CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE49gZyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0504527CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965378AbeF3CiM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 22:38:12 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:42753 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932904AbeF3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 22:38:08 -0400
Received: by mail-qt0-f171.google.com with SMTP id y31-v6so9573299qty.9;
        Fri, 29 Jun 2018 19:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DoUtE3F/BWxdjQ/geSiYdD5uSm62/zTykls20lO4owU=;
        b=NE49gZyEDPMDyZ9rGoADv9iSHBWGKM2Wa6Q8R1X4f67SWxWE1uxCzUh/ufcBzR9NBr
         GpzHn5SV9iG3ceo3ye18Mw6E6SDCDJe+WP0L9QW6sORyG0+qcQHvbOuN8locayLz5hqi
         78my0Kh8yFHh2CuE5UkX7nMIsM610Wnoedj6/aHbOGz2OrEWWSZ0dyWorbu7eaB6oSVy
         stpa1+6/hdRLSwHyDmIKHBvu39YyUga5Rnd/VNHJa9BJqbTlkRD6DpLq46muy4EoM5WA
         6RRUWDgPqVQDWFx59nLcQGB5F38pzIgMO3zxAHL8qPVBycgBAibS9QDQ98z9ODp5KkWY
         2uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DoUtE3F/BWxdjQ/geSiYdD5uSm62/zTykls20lO4owU=;
        b=dKlOtE5gibrylIEcSLXXW/a7jPRLV6ha3j0aZYWfWX1olJywwqSJvEzi27WEv98Ecu
         KCIEBFlb/Jl8Ps+J5foAvWIrTMLpd9+v3fi581BJWwet4J4rmLEZSWPw9/38WHZe9FqV
         8RQ98f7Yd5nSRQfUiwXFt0htWoYgjb6mCgTsGqXjmn38YsIDOUqmaCwClnz/bxd3mi16
         CDBergtupcmCazqVbSWFIDT4sUdZCPwC7luSbKKuBJtbGNwerjjtBsDkerp+rLqrEygP
         wyP7C6dSUfYk9Gmc906bK+Giu+MbNM3sCOsIGb0OydCKcOdAOxw76vlGkkyuwFNu5I9/
         CcXw==
X-Gm-Message-State: APt69E2/qtQalt1UylLJbgjeV2Efo/7aSpAH0T8dUzdeVTYnzedRWcah
        u594W0EsixOWuiIAhFTR7LE=
X-Google-Smtp-Source: AAOMgpfp3G7NOXalxRX0P0FJfkT9lwh5cGSj7CfAgAPYX3yNmKlWSzZ8QHJ8wiOWdt9mMYvnqH7zDg==
X-Received: by 2002:a0c:c993:: with SMTP id b19-v6mr751311qvk.95.1530326287526;
        Fri, 29 Jun 2018 19:38:07 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id i22-v6sm9364704qtc.8.2018.06.29.19.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 19:38:07 -0700 (PDT)
Date:   Fri, 29 Jun 2018 23:38:02 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
Message-ID: <20180630023801.jhxb3silsbogkz22@eaf>
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf>
 <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
 <20180629184542.jwxhruxgp5xv2abt@eaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180629184542.jwxhruxgp5xv2abt@eaf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:45:43PM -0300, Ernesto A. Fernández wrote:
> Hi again:
> 
> A patch for your original report has already been added to the -mm tree.
> 
> On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> > Now, when mounting the attached hfsplus_16mb_segv to /mnt and
> > performing `dd if=/dev/zero of=/mnt/xyz bs=567879 count=1` I get
> > 
> > [    1.646451] BUG: unable to handle kernel NULL pointer dereference
> > at 0000000000000043
> 
> I just sent you a patch for this second report. It's really simple, so
> it would be great if you could take a look at it and review it yourself.
> Otherwise it's not very likely to get picked up.

Never mind, it got picked up already.

> 
> Thanks,
> Ernest
