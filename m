Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4CD20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sxi76E7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4CD20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHaFWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:22:07 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38379 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaFWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:22:07 -0400
Received: by mail-io0-f196.google.com with SMTP id y3-v6so9169016ioc.5;
        Thu, 30 Aug 2018 18:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAhzIsBPCToQXtNy64TYf11XstDy5RdkSiMeZ1j07Jw=;
        b=Sxi76E7jNyK51rYMhKYHNA2bwpcCmFOrt9UEQVyQh8c41+Qk9CT+PCqJ9nuYOj6/w6
         YpQ+PhlK7jSgTq42Wy3xWHbeDkNtWawQ+XY8vQyuAVGB0e7sWcpwpihGlLytWzC+Ed9X
         /IUCFm1sryef0uWUcnxuuUdqD21oxHkx/olXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAhzIsBPCToQXtNy64TYf11XstDy5RdkSiMeZ1j07Jw=;
        b=E2fIRD2nJwi8nnARW7XAVPaV2fR4SISeb8qZ2q0xraIM8dYsFsnuVCLWCLGvuXspz1
         6CFgxhifVTw7H8wInOdOb2g7ZzDCSBkKE1XZ7sojwJkG8rOhyInrEeVrZI1VAdHCM02Z
         X+eBj9suC/XQsCo+2MWC1DTx3h60w5Q7hUUgDB4I01F6ULFIfYGPUSCq04m9mOlEO3hZ
         xCu8cxAAF9U1E98kp8qkNGZzeLXNijO07SwALp+OLqvNOm5IRmyjGp0o662GvpbmbruG
         eppy+cJiCPV2IdinZQApYpeYyBi1S1ks59qdskhdKbsCWMbh0+qBN+y68VBC7h0BGw14
         35JQ==
X-Gm-Message-State: APzg51Cuyz/7uVtmlloVpqE3VOQtBHLIvnrdTNX6pDx/Ljxv8ldSW8Yv
        83XQDaaS7GuUjDlQMSeGUxlYFINee/NU5QzFPjasXixC
X-Google-Smtp-Source: ANB0VdZvSlBiEtcxMRQR1qKgtS2qs6wUxD8GiAp9+tXDm9DHSE5GJzIoERJyI/eXWJd5m5N+xG+NlTrGFF0oDBCOWlc=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr11267857iop.238.1535678232326;
 Thu, 30 Aug 2018 18:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180831080714.4f94fba9@canb.auug.org.au>
In-Reply-To: <20180831080714.4f94fba9@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Aug 2018 18:17:01 -0700
Message-ID: <CA+55aFyApn2d+bv_3LGwXKnLpj2zdX6HYw_9cYZoNUVPi-Bu_g@mail.gmail.com>
Subject: Re: linux-next: disabling -Wstringop-truncation
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 3:07 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I am now mainly using gcc v8.2 for my builds and -Wstringop-truncation
> causes so many warnings that I am sure to miss others, so I have
> applied the below to my fixes tree until the noise reduces.

Applied.

If people want the warning with W=xyz, then this is still the correct
patch, and we should add a line to re-enable it in
scripts/Makefile.extrawarn.

             Linus
