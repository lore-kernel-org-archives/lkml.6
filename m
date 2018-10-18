Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5891EC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2AC2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nbEAtqm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2AC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeJSHyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:54:45 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40744 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeJSHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:54:45 -0400
Received: by mail-ua1-f66.google.com with SMTP id c21so6835511uap.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRjGUXac8wI20zJFfcbJlWhBnsVPKloJQulzagUCP8s=;
        b=nbEAtqm/XjZf+toqwpAxvdZA0wT+O8f57QJPbQhFpZxTF1nIUDkJTF4Lg1LGgxvfv8
         9umkiybS22D2LY3pCC2ToxDIkJRT1ndnZbIvAH9lL+drlwDSUlQU6KJpyyWQ4ayviP6O
         5lA1m8XTleTdDmc1PHZQQ0NBUBT/PjJVnPkz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRjGUXac8wI20zJFfcbJlWhBnsVPKloJQulzagUCP8s=;
        b=cZGUaiBDPbzttuOIFgj2fp6LdpG+en6p+CycMSkAy/eav7R6QnhKq94iJuq0gk6k1M
         axfNCp4XO+Y/mDnArB5gKjssxZTQOrkielapXhMsGc30yVDMLqXFdwGqUjmD9tTftOBE
         gh6T5bTuRefwRURGkjbyCmpUeqAhra42m5xxrTY2kck6S10gz/70AW/qOEf76hT/IFcT
         rjKd1poPEmB+ogudYyqI1gj7lfZtg691dh6bimeeSzYz/TVjP0EkhYXqxk0Jr9Bvi6he
         ybuppha2oNZLT/XzNLRqdRPoKRC5kjdT+xJcs5VtGaGL0Cyt3ZfbzRtFl/oXQ2j0tqST
         N6Sg==
X-Gm-Message-State: ABuFfojVLN6nZgANQ5hHTVyP+b9Im00V6srriG7WhMMfTfodDmZsHJli
        +h8BO9zGqP/kIQbGHBeunBikOgCBUWI=
X-Google-Smtp-Source: ACcGV61gYNHReP+QHsFZn43eb4iCR5rUJgnh2YlvarIhyYRxmkL/60TNOk8jDHWpbqY8hHgQUZ9Grg==
X-Received: by 2002:ab0:1089:: with SMTP id d9mr8688696uab.42.1539906682854;
        Thu, 18 Oct 2018 16:51:22 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id w2sm4469481vsg.29.2018.10.18.16.51.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 16:51:21 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id q15so9951903vso.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:51:21 -0700 (PDT)
X-Received: by 2002:a67:8316:: with SMTP id f22mr13374255vsd.6.1539906681339;
 Thu, 18 Oct 2018 16:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181018210933.113592-1-evgreen@chromium.org> <20181018210933.113592-3-evgreen@chromium.org>
In-Reply-To: <20181018210933.113592-3-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Oct 2018 16:51:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VMnTEUgPoDnfF-Oh8FDj9hy+ohz6oViJOtZCD_K-t_Dg@mail.gmail.com>
Message-ID: <CAD=FV=VMnTEUgPoDnfF-Oh8FDj9hy+ohz6oViJOtZCD_K-t_Dg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] phy: qcom-qmp: Utilize fully-specified DT registers
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>, cang@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 18, 2018 at 2:09 PM Evan Green <evgreen@chromium.org> wrote:
>
> This change utilizes the newly fixed up DT bindings to get the tx2
> and rx2 register regions for the second lane of dual-lane PHYs. Before
> this change, the driver was simply using lane one's register region and
> adding 0x400, which reached well beyond the DT-specified register
> allocation. This would have been a crash were it not for the page size on
> ARM64. Fix the driver not to rely on the magic of virtual memory by using
> the newly specified DT register regions for tx2 and rx2.
>
> In order to support existing device trees, this change also contains a
> fallback mode for when those new register regions don't exist, which
> reverts to the original behavior of overreaching and prints a complaint.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 51 +++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 13 deletions(-)

Looks good to me.  This seems like the right compromise for moving
forward to fix the problem.

A few notes:

* The only current SoC that uses tx2/rx2 is SDM845 and the support of
that SoC is in its infancy in mainline.  Thus I don't mind that using
existing device trees with this new patch will print a warning and
continue to take advantage of the Linux "bug" that the whole page
could be accessed.  We should fix the old DTS files ASAP and then
remove the nod to backward compatibility in the code.

* This should land _before_ dts patches land.  If dts changes land
without this change then the old code will end up mapping tx2 and
using it as pcsmisc.  ...so either we'll need to delay landing the
device tree patch by one major version or Andy / Kishon will need to
coordinate.


Reviewed-by: Douglas Anderson <dianders@chromium.org>
