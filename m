Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CD20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WhSJlIcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfAHSfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:35:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38778 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbfAHSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:35:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so2289685plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=gu2/38Y7g7xPtSOrpl8BprJ/DF01j+H/9kbu3B2uWyQ=;
        b=WhSJlIcXDKvke6McMFz4ZIAD1Bn/Vo5XqAdWJn0YE1eSuOUvIIdIHoakUZLvz4BmmZ
         na2IbNy6jychDu0iyiz6MPNRSHjmgPbGW8cTr/jVFIC/Jx9hJ4P9uxx/I4kLQSxfJQei
         YNHFHssPVdSIeQDspGJfUFsStuQjyTqMEnBss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=gu2/38Y7g7xPtSOrpl8BprJ/DF01j+H/9kbu3B2uWyQ=;
        b=UWRZ/f8MSWZUUlfzSw7Nc7DK75p8BE5KNlIO4RvrDOxRB0tKCLPL0z24YTzxFd3whJ
         Ol1tBfcbMcm3bAIPuXJUQoCQUzT+ZinlhEWfdze5tEVqMfqVttHmQplp0Vme1xNDpXy+
         Ve0lMPzUYerriph9tA46WzSG2FBpTWEwUOkA6lKvguB8viy3OB7ZMaCkCmkuVNvo+2pc
         XzBGev9IFmgmADDnWytSM8w9RvOwUW4ZTh5HUZzFbG2l2n0XFQRTLX7DHX5BCJZBBinp
         CR6u+pCdvvFjS+jxf8L+QGSqLvXBPs+uk8/bbnd5Jj96zDyNhsxxhY0T4pxXeEFG51OY
         5BGw==
X-Gm-Message-State: AJcUukdzpDLE9Cb11vKiOHPEKVEdZgEMylbxbk1mH6gKZjmyYes6lvl2
        /FRbqU+c42s0lDdTtJVtAFp9QQ==
X-Google-Smtp-Source: ALg8bN5vz6jNZR/kxZa3knzApWrzY93PIloV7HvL7f10xilFetDjSYJXq/gD5eMoON0rBY6vrV4Ygg==
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr2783324plm.45.1546972519670;
        Tue, 08 Jan 2019 10:35:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j21sm99414958pfn.175.2019.01.08.10.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:35:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] soc: qcom: rpmh: Avoid accessing freed memory from batch API
Cc:     Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
To:     Evan Green <evgreen@chromium.org>, Lina Iyer <ilina@codeaurora.org>
In-Reply-To: <20190107212321.GK14960@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20190103174657.251968-1-swboyd@chromium.org> <CAE=gft6M7aaPjS0KRg7dyfLOGtgXdU1qaT7oNeRHeNFQpRouWA@mail.gmail.com> <20190107212321.GK14960@codeaurora.org>
Message-ID: <154697251815.15366.10888159477746216145@swboyd.mtv.corp.google.com>
Date:   Tue, 08 Jan 2019 10:35:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-01-07 13:23:21)
> On Fri, Jan 04 2019 at 14:02 -0700, Evan Green wrote:
> >On Thu, Jan 3, 2019 at 9:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >>
> >> @@ -380,7 +386,10 @@ int rpmh_write_batch(const struct device *dev, en=
um rpmh_state state,
> >>         }
> >>
> >>         for (i =3D 0; i < count; i++) {
> >> -               rpm_msgs[i].completion =3D &compl;
> >> +               struct completion *compl =3D &compls[i];
> >> +
> >> +               init_completion(compl);
> >> +               rpm_msgs[i].completion =3D compl;
> >>                 ret =3D rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_m=
sgs[i].msg);
> >>                 if (ret) {
> >>                         pr_err("Error(%d) sending RPMH message addr=3D=
%#x\n",
> >
> >It's a little weird that we call rpmh_tx_done on a bunch of transfers
> >we never submitted, just so the completion will get signaled so we can
> >wait on it in the next loop. We could just do count =3D i; break; here
> >instead.
> >
> It seems like it was carried over from my earlier submissions, where I
> was reference counting the number of completions for a batch. I beleive,
> with what we are doing here, we don't need to call tx_done with this
> approach.

Ok. So we can remove this whole chunk of code that forces out
completions and unwind more properly?

