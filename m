Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE96206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfuNyqeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE96206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbeLEPBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:01:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36388 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:01:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so14967575lfg.3;
        Wed, 05 Dec 2018 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=isRiqPCBdM++CXDodzTILbM+ZbN8hBo9KQXma/rxdW4=;
        b=DfuNyqeb6Z28CAb9PUVzksC4Lb5W3A7MM9j+6X7K6BN5hAEd3gp6L91mXuOqULk6vW
         7kyiTlsz9cSAHOaCsXDpsgn7MC68+ktvb8upajbnl3zYrfQy5CyshgKfqIO6w56JTQZK
         L04jONKTapOz67h+944DvqqY3SO21MkOo5ftgtWi60vk/rCf2D0W/lmcVb4ShICwd0gM
         aPe4tnoXH31oR0vx2g8WUcR9ND6xUcn8OPX1XFMRMzT8V2tmlxztmHtb5B/p+EhGbWwQ
         SrGS9nIKLn+7u1imYIom6qc+ByFDTtVVwRCOUlNl0rBDUMZ7eQNiLKQO1wvIEGqEEI+L
         Axjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=isRiqPCBdM++CXDodzTILbM+ZbN8hBo9KQXma/rxdW4=;
        b=jN7p/JZvhnDv7whKpDwROngSXF4PwO3B3Nrpcfa9BT0xaqQUkodaEFl8T/CnSnY+GL
         6nTJVIAoPZNpeAh+ShfjPbDATwmWaSMMI9qwxqsunSqS0vRedHhNOuf9eyqQs9rSyAoF
         0k/P1WrIeVCmYHnf6tXYdL5FYBknAY/CgPnBIejdNyzdJYUjVxUEkmo9nX30aeBV9DO5
         t0GoofEarxKwbRS5ubzqK6cmmP3n8SkEzB3BE5xdOkJC3NTfA6K/JbydkHwpU/uzx8dy
         Zaf3XbI8O3N07TGH1EXiX0juqKWM/t1EawZ5IA2hIVcc6gG8b1G6F97PVu93zZjD3IJv
         wRLw==
X-Gm-Message-State: AA+aEWYcnKn1AUknvJeLAOKv/f57reJFjNMZC/u0oL7LpUT/2QbqzI4S
        Ze+2wqLlF6MgxXhtJy2B7Uk=
X-Google-Smtp-Source: AFSGD/XA0ElFp0jL7mOaoCHMdVu2qWB83mCBaUv7PQwchlTBGTLeQ4/0BA0va7XVOoVO+Iu7nBuUgw==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr14165909lfs.42.1544022112997;
        Wed, 05 Dec 2018 07:01:52 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id s127sm3685517lfe.8.2018.12.05.07.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:01:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUYgU-0003zu-Qx; Wed, 05 Dec 2018 16:01:54 +0100
Date:   Wed, 5 Dec 2018 16:01:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 3/5] dt-bindings: gnss: add w2sg0004 compatible string
Message-ID: <20181205150154.GG15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <20181118215801.12280-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118215801.12280-4-andreas@kemnade.info>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:57:59PM +0100, Andreas Kemnade wrote:
> Add w2sg0004 compatible string since devices without wakeup
> pins are now supported.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> index 648d183cdb77..1be7597ae884 100644
> --- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
> +++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> @@ -14,6 +14,7 @@ Required properties:
>  			"linx,r4"
>  			"wi2wi,w2sg0008i"
>  			"wi2wi,w2sg0084i"
> +			"wi2wi,w2sg0004"

Please keep the entries sorted.

>  
>  - vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)

Johan
