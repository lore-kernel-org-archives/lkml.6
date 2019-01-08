Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28913C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC03320827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S7Hcy1Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfAHSwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:52:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40240 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHSwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:52:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so2351120pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=CZwbN/htHRHZzxXRs1Pr8UB4Vmqq/oNAuuczQzeEzQg=;
        b=S7Hcy1VbYi7dMcqS3COU1x2qHlp9q8BqZKsMuE+Zakvf1LTVUsJr48Ak/YUIBE9+tL
         7aK7C4OSvwFF1zLdTd+zn9092p7+57So/fwfndGAT/epblCCEC6BMRs5NDSs/RqlUAu4
         CrngqgoM7kldSoNSF2fl6WGQUJSu6uLq9VuHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=CZwbN/htHRHZzxXRs1Pr8UB4Vmqq/oNAuuczQzeEzQg=;
        b=bgQxEQRtZiWXnUbt4OlwAFaBkHsgus4bvQuoxDEw7+2i5vgDo1DYoh1MN2CZXJseot
         MZgruDKpEIffttKsYxqyY+3POTAH47CPfCNWnLGobKczYpSVHpzymP0y8CgtkhdA8v4b
         s/6MVcpAHAdIp9L4QgZUKrxI6dAl8oPvxZLRiuXs+7N83YCr9+oQdlCyO6LKOBbRbjRG
         a7CCtYts81Y3JLdhFSdStTtG6WXXgnzRN5gAAa4/Yl4w+whO5gNhPKf0ZfNlxwgwrmn1
         pfKs35UMcCsww30tftOD7FQMxav4GQsU00YJScApNFmo7bVplee2sCKXVQAVh9R8zJhL
         PQ1g==
X-Gm-Message-State: AJcUuke2DeLXvw3a1ja3PF7R55sy5/UOS+gHWeX3gE1mWBAnGhVKEhTS
        dHxJ5lkiWgjsK5lTrjZCngWcXQ==
X-Google-Smtp-Source: ALg8bN7VaArd9TyGYxhgoGC4vY1YqrWhhggm0iEH/+bFdGJ5HWCpjtvFgnJ4Xp1RDU8PJvAZsO435w==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr2587188pgk.386.1546973551377;
        Tue, 08 Jan 2019 10:52:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t87sm227611293pfk.122.2019.01.08.10.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:52:30 -0800 (PST)
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
In-Reply-To: <CAE=gft6H29BM5k5q=t-eQ_2LT1GORqqhQReVQZ7VCKn7=Oz=Yg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20190103174657.251968-1-swboyd@chromium.org> <20190108174938.GA22547@codeaurora.org> <CAE=gft6H29BM5k5q=t-eQ_2LT1GORqqhQReVQZ7VCKn7=Oz=Yg@mail.gmail.com>
Message-ID: <154697354993.15366.3623820425365137828@swboyd.mtv.corp.google.com>
Date:   Tue, 08 Jan 2019 10:52:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-08 10:30:04)
> On Tue, Jan 8, 2019 at 9:49 AM Lina Iyer <ilina@codeaurora.org> wrote:
> >
> > diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> > index c7beb6841289..0303a2971d4a 100644
> > --- a/drivers/soc/qcom/rpmh.c
> > +++ b/drivers/soc/qcom/rpmh.c
> > @@ -80,6 +80,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int =
r)
> >         struct rpmh_request *rpm_msg =3D container_of(msg, struct rpmh_=
request,
> >                                                     msg);
> >         struct completion *compl =3D rpm_msg->completion;
> > +       bool free =3D rpm_msg->needs_free;
> >
> >         rpm_msg->err =3D r;
> >
> > @@ -94,7 +95,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int =
r)
> >         complete(compl);
> >
> >  exit:
> > -       if (rpm_msg->needs_free)
> > +       if (free)
> >                 kfree(rpm_msg);
> >  }
> >
>=20
> Hi Lina,
> I think that's a worthy fix, too, and is needed to solve the issue you de=
scribe.

Looks like we need both fixes so I can combine them together.

>=20
> But I think Stephen's fix is still needed. In the rpmh_write_batch
> scenario, we queue N things into rpmh, but set the same completion for
> all of them. If only the first one completes but not the others, then
> the loop in rpmh_write_batch will call wait_for_completion_timeout N
> times on the same completion, and then goes on to free all N requests,
> even though only the first one is actually done and out of the system
> (well, almost out of the system, with the bug you noticed above).

This code looks an awful lot like kref_put() with a release function
that's a kfree() of the rpm message. Would that simplify the code
somewhat if we made a refcounter (that probably only counted up to 2)
and then properly refcounted the messages? We would have to allocate a
bunch of messages for the batch writing API, but I'm not sure that's a
big deal either.

>=20
> We considered having just one completion on the last transfer, but
> then if there's an error part way through you have no way of waiting
> on the transfers that did get submitted. So I think N completions are
> needed.

For that, I'd like to make the batch API know more about the TCS it's
filling so it can know how to unwind the state if something fails. From
what I can tell this function is implemented at the wrong abstraction
level. It should be a lower level function so it can manage the queue
and push multiple messages through.

