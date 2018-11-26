Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8226920855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dwkEBsIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8226920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeK0Ftm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:49:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34247 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeK0Ftm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:49:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so14419569lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZW1RSy+Pg4CzGdxv/poKG/ywLSVWL2EfUiFOOSa+Go=;
        b=dwkEBsIGx2n6MKQEh99DSK+jIxMltvzhPkBH5pNwBgwh4HOoF8YoulvBNmJQvQAe9C
         dYYGELI/OqYWwfvi4Xsqm3k3WbNVxSCuv+M4ePIxYvGmDq/7efS9VvXOapv5j3pHX5IG
         Tmykb7sayHHbi9Xw2HJXBF9y29WtlHR+xB+7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZW1RSy+Pg4CzGdxv/poKG/ywLSVWL2EfUiFOOSa+Go=;
        b=htt2uXWN1FjI3R3ybLhLzGYcu6uWwjue6gro209JuMt2rVBitjpnqFxn9MEy5f4W73
         p94zMq8cHa8wFnZJfKsAzp098ZSURE9FXpEIkggLHuf3ZOfY9c3ac/h+44WVajz99jn2
         Fi+ztqugzp9xAeEfWi6YKPHjw0IPUMeswhfd3Covzp9QKXYbwKZVq5uxNA6dl8hRWIYz
         KzjbFjGHhnQxWzNujP2svcOsY3GBY+NSon65Rc9/+ML2BdDQpvqOs5XXd+NlcgRAIgj2
         lpFsmjf4r2/38NuqTk+jnU2kjePeRjz7Uhhb1XANvOn6DG+TbbqjxrrA3RA0g/Ad34od
         ciww==
X-Gm-Message-State: AA+aEWbGkUrsIhw5Az9+BXxtI6+MoTCUZab3mcyMWIZeW8IUuSpWmHPR
        wYYCFUCWKJ0u/hPaX8gHVQuLhbdcvn0=
X-Google-Smtp-Source: AFSGD/W4dMks9EcS+bxyVTEXBs+F4j2fuZU2BjjU2SIDL66je3U5WjduNe02g7sYRqnNLuVe3lTeXg==
X-Received: by 2002:a19:e601:: with SMTP id d1mr9946528lfh.71.1543258479682;
        Mon, 26 Nov 2018 10:54:39 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u21-v6sm179890lju.46.2018.11.26.10.54.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 10:54:38 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id f23so14367139lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:54:38 -0800 (PST)
X-Received: by 2002:a19:1bca:: with SMTP id b193mr16081053lfb.153.1543258478240;
 Mon, 26 Nov 2018 10:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <20181030230624.61834-3-evgreen@chromium.org>
In-Reply-To: <20181030230624.61834-3-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 26 Nov 2018 10:53:59 -0800
X-Gmail-Original-Message-ID: <CAE=gft5XZD-GQYwcv4YWHrDSWRqT7SDpWXzv7c6MKAAH7uGr2Q@mail.gmail.com>
Message-ID: <CAE=gft5XZD-GQYwcv4YWHrDSWRqT7SDpWXzv7c6MKAAH7uGr2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
To:     axboe@kernel.dk
Cc:     Gwendal Grignou <gwendal@chromium.org>, asavery@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 4:06 PM Evan Green <evgreen@chromium.org> wrote:
>
> If the backing device for a loop device is a block device,
> then mirror the discard properties of the underlying block
> device into the loop device. While in there, differentiate
> between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
> different for block devices, but which the loop device had
> just been lumping together.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Any thoughts on this patch? This fixes issues for us when using a loop
device backed by a block device, where we see many logs like:

[  372.767286] print_req_error: I/O error, dev loop5, sector 88125696

-Evan
