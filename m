Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3610BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5462081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fChSguaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5462081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeLCXNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:13:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44336 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLCXNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:13:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so13040964lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZmrkB51RaSK1jsKYQBfuOpcDQ4vrdeHsiKtcKqld1c=;
        b=fChSguaSFmQniQsELUqawPYR2i1EsT9/AC2S+jpHgSx/x13b5chdYSF6trsZrGO5iG
         jyR5XyT8CIwixb42WdiMWdxFxp/d1i0KDweijipmjf8+eum2hRBIy9R8MccyjwiK/Ysc
         /QzItoq8RMbXgAXVqIVLq/V5V36m/fIo7lrvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZmrkB51RaSK1jsKYQBfuOpcDQ4vrdeHsiKtcKqld1c=;
        b=YMCH+Bh2m+TnDbiR85tlQATBiBerfRngFiciL2Nf/5jBZ46IQOaGdNVhXIRHEyVUB8
         CJfksBDAz1Lt+6LrtNnK2OQKAvaeub2JtKhi5mvUFnfTum2hf080gAMkYjdWBceM7Uzj
         jcTN2LR2oGk62xvRmmC5sWIAhlPNOnysRoEg68DxSJWFSi51+6WiQ7AACtNwJsoIXi9i
         w/IqEB5q81CGC/Iz/WGlGhC8d9kkUhA38L8vbdxShjFW5HrjuuO82y859txUxuim0ate
         1HhzUuswtEvTy74gkNEkFX8HcsMKsbUUf8vH2KMlJ5EAHOAewNOsrSWhT8W7/bGRWsbW
         B1ZQ==
X-Gm-Message-State: AA+aEWZ7/cid27ZefY1QCXovvy48r80eRoNqj2mDMwSV+1/7fwW6wO9d
        1sxEJ0fkzE0nyceXEp/i/YkkZuZjG00=
X-Google-Smtp-Source: AFSGD/V/YKrWAsUEXNywhNbcjNG1QiX/UoxuxSXfLMmg2jefUe+E7nsEen1QjJ+rrOF/TlzUdhMisw==
X-Received: by 2002:a2e:8449:: with SMTP id u9-v6mr12379788ljh.121.1543878803234;
        Mon, 03 Dec 2018 15:13:23 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a11sm2636736lfb.68.2018.12.03.15.13.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 15:13:22 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id c19-v6so13070866lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:13:21 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr12280074ljh.174.1543878801281;
 Mon, 03 Dec 2018 15:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20181129221357.67417-1-evgreen@chromium.org> <20181129221357.67417-5-evgreen@chromium.org>
 <154387672722.88331.10663388522762144439@swboyd.mtv.corp.google.com>
In-Reply-To: <154387672722.88331.10663388522762144439@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 3 Dec 2018 15:12:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft58qzX5UB48c-NbESV23xLtqSUyeytGscpvo4keL4k+ww@mail.gmail.com>
Message-ID: <CAE=gft58qzX5UB48c-NbESV23xLtqSUyeytGscpvo4keL4k+ww@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] phy: qcom-qmp: Expose provided clocks to DT
To:     swboyd@chromium.org
Cc:     Andy Gross <andy.gross@linaro.org>, kishon@ti.com,
        robh+dt@kernel.org, Doug Anderson <dianders@chromium.org>,
        robh@kernel.org, cang@codeaurora.org, linux-kernel@vger.kernel.org,
        vivek.gautam@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 2:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2018-11-29 14:13:57)
> > Register a simple clock provider for the PHY pipe clock sources so that
> > device tree users can point at these clocks via phandles to the lane
> > nodes.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>

Thanks! I meant to add you in the CC line on this series, sorry I missed that.
-Evan
