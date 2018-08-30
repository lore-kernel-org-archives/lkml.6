Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7FCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B4920661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNyR9Kwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B4920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeHaAOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:14:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42375 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaAOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:14:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id l5so4806845edw.9;
        Thu, 30 Aug 2018 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCY71oDba5HfDH1IH+EInLZWKOqhzUa8I+3WpzhWLg8=;
        b=RNyR9KwmkOkwufC92/PUcVJvYMEoC/GfoMe4YbEtWDznIYGl5ACD2Mclt0I9D5focF
         o4a459FnkNUg2xGQqI3hHxz7yz7hUSC0pPINYV1AMNTZF/c/r/N/bgKcL6hTnlyFSs3o
         KGL3dxOX/wDL3CcsRtaz2XZGT3sJznP5C7Tet61otuAQ2tzxg5cNE+SqJDRuUtxdgfm1
         wMehmjlWCHaP+NSPi/3bhMg2AjHDhR28xIhe+XwxPa9TW/BRtDMnexjt2hPQE6hBtwPH
         +MACW+95qLGFDzoXp0EMc9Ta5/I22wta0q+kFMOm63sE0/JqwApivXeJp+J9SzLl4xL6
         tsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCY71oDba5HfDH1IH+EInLZWKOqhzUa8I+3WpzhWLg8=;
        b=hFtn+n+X2lXHe4jDNZgqZ8rI3uGIUUoMBGptaRSTGFSuXDiiMTFZHWRvNmWCy7vCKR
         oo6lyQbubLJj3PNEIXrHTbQotaVGUR3pKS2HdnlPJZ/WdByehOss0hUYqi6T2Kugb35/
         eMNbp6ePI4Gf7+Yyit5AIoV908oT0aim4fKUat0ewC31Ha23R2V/C0Cx8iIWUOHTAXOp
         w+0FEyd2QgRgjeVUqmscB9frtmoiiUXu4VmGeGTKEuz5jEeqCOpFjT5plrNHiYyK1TbD
         xI2BQc7PKvuXfaikdpdgMV/ChTzd0ZTryoeDXVU/nDDqCU2dyKom2YylDM4bK/Fjvr6P
         YHpg==
X-Gm-Message-State: APzg51A89vL0ezOJmWeeWGGZOjdZZ9UsYuZ/d72B6Y5GiT73bXN55LqM
        jlK9t/RbPjKD2qQ+FGnok0fFqyGGAKzc7XKuvhHnNMod
X-Google-Smtp-Source: ANB0VdZxiHJn6Pg/NyecOJjwZ2neOKXnRpgGrQ4iyomVTHySsjX+++6frdRn1o3U3QtMWkBbbygz8AKlzwEv60c+qvg=
X-Received: by 2002:a50:fc03:: with SMTP id i3-v6mr14824859edr.85.1535659807918;
 Thu, 30 Aug 2018 13:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180829130308.3504560-1-arnd@arndb.de>
In-Reply-To: <20180829130308.3504560-1-arnd@arndb.de>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 30 Aug 2018 16:09:31 -0400
Message-ID: <CAF=yD-J7-GumUmonrZt7s44e3bsjY2DCD6ZpmhtCx6FOBV5BNA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Network Development <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
        dccp@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 9:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> socket protocol handlers, and all of those end up calling the same
> sock_get_timestamp()/sock_get_timestampns() helper functions, which
> results in a lot of duplicate code.
>
> With the introduction of 64-bit time_t on 32-bit architectures, this
> gets worse, as we then need four different ioctl commands in each
> socket protocol implementation.
>
> To simplify that, let's add a new .gettstamp() operation in
> struct proto_ops, and move ioctl implementation into the common
> sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> through.
>
> We can reuse the sock_get_timestamp() implementation, but generalize
> it so it can deal with both native and compat mode, as well as
> timeval and timespec structures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This also will simplify fixing a recently reported race condition with
sock_get_timestamp [1]. That calls sock_enable_timestamp, which
modifies sk->sk_flags, without taking the socket lock. Currently some
callers of sock_get_timestamp hold the lock (ax25, netrom, qrtr), many
don't. See also how this patch removes the lock_sock in the netrom
case. Moving the call to sock_gettstamp outside the protocol handlers
will allow taking the lock inside the function.

If this is the only valid implementation of .gettstamp, the indirect
call could be avoided in favor of a simple branch.

Thanks,

Acked-by: Willem de Bruijn <willemb@google.com>

[1] http://lkml.kernel.org/r/20180518080308.GA28587@dragonet.kaist.ac.kr
