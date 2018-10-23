Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F73CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC6920651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fehhl6PC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC6920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeJXDxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:53:38 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43638 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:53:38 -0400
Received: by mail-yw1-f67.google.com with SMTP id j75-v6so1038438ywj.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hSulT86UqYEbFD96gDsF4McsOX/UG0DNds7+jVQGeTs=;
        b=fehhl6PCscdXtPlJ0oF82wVrgAkh3/mzAuZ7n2kECTGwDjG+FnasRIOzg+o3k6fss9
         ngBmvCYmDOT29nfhdmaK2UoqgjyLK4SvrKRZb1bXvtAqADk388JVeSZPzAQ6i/3TaQCl
         92yF+8ix1/ch3Jvr8MxeGafjNwM+/q43WmBKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hSulT86UqYEbFD96gDsF4McsOX/UG0DNds7+jVQGeTs=;
        b=Lt/QCt7yBY0+gkCW7OdTaUOEIC1mbKDccjSNqOcm5sfHudmidSiClC1OtFDl839pkN
         jqutEVvxgK0kcfGNpFVLGIzjtj65f/waznYOoP6DiArPZZKHZG1BW0YPiSwbE+ilcSRA
         EeIqmZHRKkKuRgqGidRWBAzj7lG9/5HHvYIv8pkyonUUql3W/T5Ds2/Uicau+pehtpQ0
         aHiMuWHNBobIhPK3nKy8Osi6gG4zaVkqV49Gp+R3Cz2NjuEL2ongqbF8Ok12SRWs465B
         at5f2mpkQRFlNz5u0bLiZFygCFdZOALmzZG2np34fd4tEoELBp6Zfn5pwHVUW01fIj3b
         gCPQ==
X-Gm-Message-State: ABuFfoglUIBb9vBopiyd4uj5/B+aghgZC1kmwNFoGBE8yFBjl1Z4bZtV
        slPMbrqnQZOgqsUlaYzwlXnbsrdl+I8=
X-Google-Smtp-Source: ACcGV62+6mh9v0x92wyRSGzugJXAy4Y680lc8/TyYVxVGfwTwFod5q4kXA7k0NCi3Gid1/15vl7c1w==
X-Received: by 2002:a0d:f606:: with SMTP id g6-v6mr36755339ywf.235.1540322931747;
        Tue, 23 Oct 2018 12:28:51 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id p7-v6sm1080258ywd.75.2018.10.23.12.28.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:28:50 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id d18-v6so1065755yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:28:50 -0700 (PDT)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr9730627ybi.141.1540322930009;
 Tue, 23 Oct 2018 12:28:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 12:28:49
 -0700 (PDT)
In-Reply-To: <20181023111450.31837-1-efremov@linux.com>
References: <20181023111450.31837-1-efremov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Oct 2018 12:28:49 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL_WTxSJYVCuWDbPZxTnJnuakZeCr52ZKPMcc-H245bxw@mail.gmail.com>
Message-ID: <CAGXu5jL_WTxSJYVCuWDbPZxTnJnuakZeCr52ZKPMcc-H245bxw@mail.gmail.com>
Subject: Re: [PATCH] security: fix documentation for the socket_getpeersec_dgram
 hook
To:     efremov@linux.com
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Catherine Zhang <cxzhang@watson.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:14 AM,  <efremov@linux.com> wrote:
> From: Denis Efremov <efremov@linux.com>
>
> The socket_getpeersec_dgram hook was changed in the commit
> "[AF_UNIX]: Kernel memory leak fix for af_unix datagram getpeersec patch"
> (dc49c1f94e34). The arguments @secdata and @seclen were changed to @sock
> and @secid. This patch updates the documentation accordingly.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index ae3766720264..a598e601ccb3 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -861,9 +861,9 @@
>   *     the IP_PASSSEC option via getsockopt.  It can then retrieve the
>   *     security state returned by this hook for a packet via the SCM_SECURITY
>   *     ancillary message type.
> - *     @skb is the skbuff for the packet being queried
> - *     @secdata is a pointer to a buffer in which to copy the security data
> - *     @seclen is the maximum length for @secdata
> + *     @sock contains the socket structure.
> + *     @skb is the skbuff for the packet being queried.
> + *     @secid: pointer to where to put the secid of the packet.
>   *     Return 0 on success, error on failure.
>   * @sk_alloc_security:
>   *     Allocate and attach a security structure to the sk->sk_security field,
> --
> 2.17.2
>



-- 
Kees Cook
