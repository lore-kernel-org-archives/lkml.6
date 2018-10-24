Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C95ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790EC2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XLafam7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790EC2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeJYFGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:06:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44256 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJYFGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:06:36 -0400
Received: by mail-vs1-f65.google.com with SMTP id w194so4051655vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AEumKorGrwUvdBVHs+uqeeUdc9K384xDOYHikcs0+o=;
        b=XLafam7I4dLVR3Igyxv+pR7gY/Swhu204jILAnDwuWsvHjfaGPIet0OTxI3oakJEEm
         F6AzJAR0AIeNA+g16m3+uSQudAwLwRrVIeyDxqmW21fXbkmHE+oQzw09+mGRgAUcD/h8
         m6wh+533qGhnTuZopuEvo+V6MWEzFTBLffoYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AEumKorGrwUvdBVHs+uqeeUdc9K384xDOYHikcs0+o=;
        b=SxgR0DtL3YXiyi3JEzXODh/fxKcfKiHjdM41drkRosWZrQfpA9szf/Cuq4YvrhibJc
         Iluz4dJDjcE3zdfaFa5T9skT/1lmXvLwOkA6c73tuj8X6rn0tZeTbWm/cBZrJVmgR6/Y
         hKzwbDwuXg+/XlTu6jWLjaL5hdeIPwZLPuUylU267cOeCS1OzUYBRs2omCudyX0nAPOz
         BfTDkbIAbJCU/B1bUbSzKWQQIog7bfGY0hC3h/n0fBSadkmRTMMqR/GnWzMAoewsC2eU
         OXHMSaZy5kaI7Z/qvfXifWIA6Tlhbm52IxeLPbj8HIbvQnrrDQMqJZBscmqAcCEgx8Wr
         zH1g==
X-Gm-Message-State: AGRZ1gJTsahZSjvML19jF1svLvp8Gitv95HfygVkQHEdG46xWIRbyx7C
        XAIX5R4Jg5eQPPA3CbemcOt5U/mKY4Y=
X-Google-Smtp-Source: AJdET5dRVMn1bDiRHnElh5burZ+h8q5GAXnvEiCMw95aXrRU+sLM731mIs/Th+pplTeqR/yGGtazww==
X-Received: by 2002:a67:2683:: with SMTP id m125mr1865184vsm.160.1540413422313;
        Wed, 24 Oct 2018 13:37:02 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 36sm1233324uas.1.2018.10.24.13.37.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:37:01 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id u21so3376469vsl.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:37:01 -0700 (PDT)
X-Received: by 2002:a67:6604:: with SMTP id a4mr1889406vsc.42.1540413420939;
 Wed, 24 Oct 2018 13:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181024172735.154304-1-evgreen@chromium.org> <20181024172735.154304-3-evgreen@chromium.org>
 <6b3edcc1-eaca-0fac-7ec4-a7390650b13b@codeaurora.org>
In-Reply-To: <6b3edcc1-eaca-0fac-7ec4-a7390650b13b@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Oct 2018 13:36:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VoBLh+SFmo8NieRT6LrOopkKRE86xiEMt_ap2gyDZXWw@mail.gmail.com>
Message-ID: <CAD=FV=VoBLh+SFmo8NieRT6LrOopkKRE86xiEMt_ap2gyDZXWw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] phy: qcom-qmp: Utilize fully-specified DT registers
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Evan Green <evgreen@chromium.org>, Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <swboyd@chromium.org>, cang@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 24, 2018 at 11:29 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Thanks for the patch.
> I am starting to think that the driver is heavily relying on the
> resource indices to request
> all these areas ioremapped. Is it a good way forward that driver and the
> dt bindings are
> chained together?
> Should we rather switch to requesting these resources by some names?
>
> Rob can comment on this possibly.

I thought about suggesting that but I know that Rob really doesn't
like accessing register ranges by name [1].  Even in cases where you
reference things by name Rob likes there to be a fully defined order
and once you have a fully defined order you don't really need the
names unless you have more than one optional register range.

In any case, Rob already gave his review to Evan's bindings change.  See:

https://lore.kernel.org/r/20181023002903.GA16854@bogus

...so my vote would be to keep it as Evan's patch series has it and
not try to bikeshed it.


> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Thanks for the review!


[1] https://lkml.kernel.org/r/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com

-Doug
