Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42A73C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5F7208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zQ/EVIc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5F7208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935911AbeFMOnf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935659AbeFMOnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:43:32 -0400
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B72208B0;
        Wed, 13 Jun 2018 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528901011;
        bh=8ITtq0quMLWbenYml34LGnlOLM0b1HPvTI0ggCNnhe8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=zQ/EVIc57AuZpOBgzDmzRwhGNHXw6zmRF86X7ZsFAIsQu0BspNsQheJNPegD0dVlr
         FOc4Cs3LIX/jpw+reIh4AwaFnW9ldHcGBQuhw/Aqoz8sZ1007/Of65DckGVdCUZDQR
         Z4SaAfdD+v6APzi6OGYSDN24RMZDz7wUfc/hoxGU=
Received: by mail-yw0-f169.google.com with SMTP id t198-v6so963587ywc.3;
        Wed, 13 Jun 2018 07:43:31 -0700 (PDT)
X-Gm-Message-State: APt69E1KzpCk3A4VqAHyoIUiNe3Vijh22TrBKyZzl2pseaQrh60nsoJV
        cMq/SICRf1VpGNsKF5XVmkusiL3tOk7GdHrYtkk=
X-Google-Smtp-Source: ADUXVKItUCxdGtI8XjMQrWp1yhXUp3ata3aqpgUDiclu+ozCuCqOz1G8VDlY7AVxtpFwdwFOyCJ4PeShdqnpKAlQ7L8=
X-Received: by 2002:a81:a316:: with SMTP id a22-v6mr2457034ywh.142.1528901010797;
 Wed, 13 Jun 2018 07:43:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 07:42:50 -0700 (PDT)
In-Reply-To: <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com> <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 13 Jun 2018 09:42:50 -0500
X-Gmail-Original-Message-ID: <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com>
Message-ID: <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 1:16 PM, Alan Tull <atull@kernel.org> wrote:
> On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:
>
> Hi Frank,
>
> I'm investigating a refcount use-after-free warning that happens after
> overlays are applied, removed, reapplied a few (typically three) times
> (see below).  This is new in v4.17, didn't happen in v4.16.  As I was
> investigating I found that rebuilding the phandle_cache after overlays
> are applied or removed seems to help.

I was probably wrong about this.  The more I look at the phandle_cache code,
the more it looks looks good and straightforward.  Probably disabling
phandle_cache is 'fixing' things through some weird side effect.  I'll
keep investigating.  Sorry for the noise.

Alan
