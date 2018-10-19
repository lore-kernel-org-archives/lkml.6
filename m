Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA70FECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8482B2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQFFVcJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8482B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeJTC0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:26:48 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53463 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJTC0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:26:48 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so5334259itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0WAkd6xg3j0214TTqW5SrAvT3/2/XAqL8jPwMO5H+o=;
        b=ZQFFVcJtPXfVADUI6yg+tRcZfn/Yx4tt0giXASiHOl6N4z/wA9Uh9dYVKK0ISxUtNT
         4fD58ww/PG7zaaRk8yc2M0269LLYaKULk7BV+N+PhfO7KyNGz3BBwslhgwPQHh9QzubT
         +UlZpc4FZ40HrfUwM5fhlip1Q7wVrbtRB8vO4V1UaY1tfFesWWeGK9DMKiSPw/adGtkV
         Q0m/HgsexWdmSWES8GWEZl/OzY//VeIw28NzKGo3C2OcjynyDnL1LeZNEUSLTZI5orm2
         5w94YYNNwJSxy3hfbjfcJuBGRSj1yvUiJYLqKAb/aYgpT1CFfmblrvdc7dNUYF2w61LF
         cPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0WAkd6xg3j0214TTqW5SrAvT3/2/XAqL8jPwMO5H+o=;
        b=QafJlGpgQs1784EHAtzn46/ADzUbw3IlobDh+f07Wp1HRQvgF6sM4mEUxwLnHs1NEX
         2QYZ4jyy95vNb62miJyWZszRlEd5OPS21V5dkGhiLZk7AeDcNOY1GaihNcSS+YV4gn69
         NrNFFqxcC3SS5XMg8TotahqvuVaRWt7uUpFYCokNGTFyybGhBGzbAriaY4MVUjmwC6d/
         yVnjMnWDi0y/CAJNIc3tbsDanP9ekYqtb5jXs3uHe+xC5WxRW7bibmQEHbPoJs7mmkpq
         GZWzIGqZA1HS/0N9z0SjqGPpcm5mjd+y5yRYrzHhneZ6KMbhhUZKIV9Iasq84+wZLsH5
         51Ww==
X-Gm-Message-State: ABuFfohFPm6+qouIxlcWSeSAtg/qOHXr6/KtzGoR6gLnyajo377yuuzr
        17Y4d2+I+weN90r2T3OeuoixYLyoXKn3jQ/5fAuV6A==
X-Google-Smtp-Source: ACcGV62WiyDO2npKmq+b0hhitCmKGokSe64sztf6nBn+8ybjJjWFt0QdmRXps6fZWavZpQbf+t8D7joC4HrTGkEypNw=
X-Received: by 2002:a02:6a16:: with SMTP id l22-v6mr27841010jac.9.1539973175786;
 Fri, 19 Oct 2018 11:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181015175424.97147-1-ebiggers@kernel.org> <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
In-Reply-To: <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Fri, 19 Oct 2018 11:19:24 -0700
Message-ID: <CA+_SqcDszvqfH7qvEyi8QW2RqkA1kpV6L7VWxhtw5Ogzeovhbg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Jason@zx2c4.com
Cc:     ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        samuel.c.p.neves@gmail.com, tomer.ashur@esat.kuleuven.be
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 at 08:58, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Before merging this into the kernel, do you want to wait until you've
> received some public review from academia?

I would prefer not to wait. Unlike a new primitive whose strength can
only be known through attempts at cryptanalysis, Adiantum is a
construction based on
well-understood and trusted primitives; it is secure if the proof
accompanying it is correct. Given that (outside competitions or
standardization efforts) no-one ever issues public statements that
they think algorithms or proofs are good, what I'm expecting from
academia is silence :) The most we could hope for would be getting the
paper accepted at a conference, and we're pursuing that but there's a
good chance that won't happen simply because it's not very novel. It
basically takes existing ideas and applies them using a stream cipher
instead of a block cipher, and a faster hashing mode; it's also a
small update from HPolyC. I've had some private feedback that the
proof seems correct, and that's all I'm expecting to get.
