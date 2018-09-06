Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1628C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A92075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jS+duY0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3A92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeIFVJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:09:42 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42938 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeIFVJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:09:42 -0400
Received: by mail-ua1-f68.google.com with SMTP id w7-v6so9348348uan.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ht3GzWEddqiYI/E5VB3WNoJtrGOLtl5I40wC4kzFenM=;
        b=jS+duY0tRsMwHfSdMina2mjyP9KQ4YRerSX5/+K1WaVEfE2ywqFgwb4kSpHeP7QiHp
         HC+JRb21xl4NBSK9kiUGb5aV9maG2XDNsNUNjoL71+Fm45N3f9nCzP3893qX7gOPnjrs
         hghLgbA28RDfqRAzzS0+jkvl0NdydzqxsVmCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ht3GzWEddqiYI/E5VB3WNoJtrGOLtl5I40wC4kzFenM=;
        b=O0KweFnzQWm1aTTeCm93/cbYtBJiIahOcZn9QTdkHJKY5/Faf+JKk7iEMGCqoyReJn
         j4lYUx3EX6ZPV/6+c7QrgT8bcz1B+mcF2+rL571rDBOvN22quO/+cD8CHuuSmp/jHF/4
         f7umRna+TohtwwXSLFqg/5gHGkvJAwFZgEbbVGkjdiVEKxX413tSHf2ZWHHbx6nCOW/a
         keEl/TsT5+ExkX7TNY5cn5lKQrovEhESeKkNOdfQJfB87XIs/lG+28msvtJySaLaxQv7
         vPFNYj7B5CWoDzbVX37Jg3OaNLIDl20TxXOuymXbBY1PQghLkQn9s7Gvv9av1KaA0RdQ
         Ydjg==
X-Gm-Message-State: APzg51DsM0xS7F8/8jIrZ9aASN3M/V4IzeiU57/fkLihR0QWWlGg2azP
        GO7EopuamayMsGRAio3nU6GoJqCHQBo=
X-Google-Smtp-Source: ANB0VdZN4OW6S26G28oLHx5UZggriTt3IEZSLAjR/yYNMv2i1s+3GQnbU6JSAuLRZWBX5mSijzrOwg==
X-Received: by 2002:a67:744b:: with SMTP id p72-v6mr1321960vsc.101.1536251604199;
        Thu, 06 Sep 2018 09:33:24 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id b37-v6sm1891257uaa.41.2018.09.06.09.33.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 09:33:23 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id c12-v6so9360211uan.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:33:23 -0700 (PDT)
X-Received: by 2002:a1f:bc6:: with SMTP id 189-v6mr1215235vkl.69.1536251602494;
 Thu, 06 Sep 2018 09:33:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 09:33:21 -0700 (PDT)
In-Reply-To: <20180906002058.GC22824@google.com>
References: <20180830183612.169572-1-dianders@chromium.org>
 <20180830183612.169572-2-dianders@chromium.org> <20180906002058.GC22824@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 09:33:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvCZt1NmG4vodDgD=qc4-ZEMLTMhfJyhX239p1jsOhSw@mail.gmail.com>
Message-ID: <CAD=FV=WvCZt1NmG4vodDgD=qc4-ZEMLTMhfJyhX239p1jsOhSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: geni: geni_se_clk_freq_match() should
 always accept multiples
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 5, 2018 at 5:20 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Thu, Aug 30, 2018 at 11:36:12AM -0700, Douglas Anderson wrote:
>> The geni_se_clk_freq_match() has some strange semantics.  Specifically
>> it is defined with two modes:
>> 1. It can find a clock that's an exact multiple of the requested rate
>> 2. If can find a non-exact match but it can't handle multiples then
>
> nit: s/If/It/

Splleing was nvevr my strong suit.  Done.


>> +     best_delta = 0;
>>       for (i = 0; i < num_clk_levels; i++) {
>> -             if (!(tbl[i] % req_freq)) {
>> +             divider = DIV_ROUND_UP(tbl[i], req_freq);
>> +             new_delta = req_freq - tbl[i] / divider;
>> +             if (!best_delta || new_delta < best_delta) {
>
> nit: if you assigned best_delta to ULONG_MAX above you could omit the
> check for !best_delta here, better to read IMO.

Done.


> Looks good to me assuming that the statement "callers should always be
> able to handle a clock that is a multiple of the requested clock" is
> correct.

I think we should be OK given that currently there's no real callers.
If we really need to add another parameter to disallow multiples we
can always do it later.


> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks for the reviews!

-Doug
