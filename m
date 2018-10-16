Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5B5C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909722148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9ASXLrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909722148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJQHkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:40:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34785 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeJQHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:40:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so23083168eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L20oBb+GTRAlxBhsQCOZ0ZfwFt4RyVEHkcClT6KSZms=;
        b=M9ASXLrBzHy7kk8zctLq/RrDOtSXJOqEO8iq10RNv40A2XdBfvigk4Jfs/rq4Fjz7d
         7H5apakEwTHlvamo5V9UFlHkWUBQ/IoFgw7FZ7K76gccqehHuUrVVWRC8RkbGNY0atYY
         O1+xmayMMJnb9OB92NFwke6uwaF57tqECbbsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L20oBb+GTRAlxBhsQCOZ0ZfwFt4RyVEHkcClT6KSZms=;
        b=h1tPjRGq1y2lG7Lymf+H3OOS7nRvNXwk63eUCm2+Y5TP6YseyLOlDkvfZyhrqXAKyM
         Cd1Q2tJ/FZllLksLhr26Wt66LYrm4bl6Eb/KO33qi5OP5sOyLM2mmi+ZBWcNj60Xiu5A
         RRn6O2sJk/sq2aghKgsUxPtwRk4T6JguNqV6K/9J1FGe4PcqJRPTOdEqwggnQ34Wyccs
         SC6FecZ8pKg+P1oOrWLZqDTCrdKnotZuTVpHlfGnZwStySIDe/DMsdVU3voDwW+7JhtC
         O5+MEQ1keBZs89AwcoAjlrFsgNU7zhXfp6SaQ7bLUf5b+eO/qk6IOAX/NJBCSxqDtlV6
         nqoA==
X-Gm-Message-State: ABuFfohblQf1AWG5wqwLKneO62nw4sue5AP/3IdbPwui0iqgE46BB9CD
        aTjSZtW7kx9ZNH0NbUA+e5LmQmcT5rE=
X-Google-Smtp-Source: ACcGV62djhQEi/tbptSUjbTLVM5gJ5742TnMTaOyVxmSVHali/FI4neNpL1sssQnTexvp6Ki25g1Bg==
X-Received: by 2002:a50:c94b:: with SMTP id p11-v6mr32942527edh.6.1539733639366;
        Tue, 16 Oct 2018 16:47:19 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id i19-v6sm3306797ejv.73.2018.10.16.16.47.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 16:47:19 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id v18-v6so23064680edq.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:47:18 -0700 (PDT)
X-Received: by 2002:a17:906:1f87:: with SMTP id t7-v6mr25479858ejr.153.1539733637583;
 Tue, 16 Oct 2018 16:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181013005504.46399-1-briannorris@chromium.org> <CAD=FV=UmvnsueUbDTa-vSp5Ay+8Zo0YORW8T7u1AwreUbZA4+Q@mail.gmail.com>
In-Reply-To: <CAD=FV=UmvnsueUbDTa-vSp5Ay+8Zo0YORW8T7u1AwreUbZA4+Q@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 16 Oct 2018 16:47:05 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO6PMudAkt0BTXRh8GjmheYvge+smYdr-n=pdBP5swJrA@mail.gmail.com>
Message-ID: <CA+ASDXO6PMudAkt0BTXRh8GjmheYvge+smYdr-n=pdBP5swJrA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ath10k: snoc: remove 'wcn3990' from generic resource handling
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, govinds@codeaurora.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 4:43 PM Doug Anderson <dianders@chromium.org> wrote:
> On Fri, Oct 12, 2018 at 5:55 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > ath10k_wcn3990_clk_info and ath10k_wcn3990_vreg_info are not
> > WCN3990-specific structures. They hold generic data. So don't name them
> > with wcn3990 specifics.
> >

> > -static struct ath10k_wcn3990_vreg_info vreg_cfg[] = {
> > +static struct ath10k_vreg_info vreg_cfg[] = {
>
> Ironically, you could sorta make the argument that this should be:
>
> static struct ath10k_vreg_info wcn3990_vreg_cfg

Hehe, good point.

> AKA the "wcn3990" shouldn't be in the name of the structure (since all
> snoc devices can have the concept of an array of regulators) but
> wcn3990 could be in the name of the variable since it's possible that
> different snoc devices could have different arrays.  However I'm OK w/
> waiting to do that part until we actually see a different snoc device
> with a different array.

But I think that is a pretty reasonable conclusion.

There's still some other strange stuff in this driver too, like the
fact that this is NOT a const array -- we assign things dynamically to
the regulator fields within the array -- that we would probably want
to fix if this is really supposed to be a generic multi-IP driver.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
Brian
