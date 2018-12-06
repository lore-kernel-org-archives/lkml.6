Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB677C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701BF2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5QsHq97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701BF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeLFDzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:55:37 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37970 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFDzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:55:36 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so13491189vsa.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8p+oRvH8GClZ33XJ1CZx0DHSum1K8zcjO/xC+vm0bM=;
        b=j5QsHq97UGqU0OBmZna87WHV41lURwPRb2drmQkr/G8Bliki54vX3sKmC0INm9NfYS
         FE2k57kV8JASXSdw7sYz8TVv8u6FwTUFxVLZBjRuyHo/+//6Z9PMnBH4QFj1RTpFnNOD
         mFo+xB0TALi8a0cj2elpXBBT9WvqRBrdDXsrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8p+oRvH8GClZ33XJ1CZx0DHSum1K8zcjO/xC+vm0bM=;
        b=OXcAYvyg1R1Z4mw2DGYSGa3LaTJIdYZ8xX6MSSMOlnZGIHoZXu3vWdmgU+9Med5Zw1
         7atXzPdgTJdbkn+9BoWtxuy/9WfdrQMn+F/43aqhA5iwYQ1/r/BK/fpkC/Zb3wooplCv
         WZd0pYLLFld0K0FSf6VeyNiMzKKaAKdF760OPWy/lfpOTNDgnICfTM9RJq6ZXdoa8iFj
         0sOQV3dzv1kcyoNpkx4mpbuUWsWC0EZXpeXMrw7Qlm7zvVlAcB9x+UCfDuboPh7Y7FWM
         eCE86ifO7YKkiVJxT/aJlarh8Z69DhwSig7KIHqJS7rJTXnBhUYHBwpRUqvE6GoLr6wP
         OB2g==
X-Gm-Message-State: AA+aEWb/ou7D7h7yuHk2ANJSGURiGw/3oQynFkoHOcEAj73sgjZJGhB2
        0YmXr2tXK2dRA2+prNi2spABg8xFJcA=
X-Google-Smtp-Source: AFSGD/UwjKhi9ktPsffi1+fibcm3fPdyYn2i/5VVvAWM/BqUnEf+Da1AZEpgiWsX4ZMw50tz6v7l8Q==
X-Received: by 2002:a67:c29c:: with SMTP id k28mr12142128vsj.130.1544068534823;
        Wed, 05 Dec 2018 19:55:34 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id k133sm7108032vkf.19.2018.12.05.19.55.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 19:55:34 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id z23so7947830uam.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:55:33 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr12691635uac.122.1544068533318;
 Wed, 05 Dec 2018 19:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20181130150859.27366-1-anders.roxell@linaro.org>
 <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
 <20181205212651.488d9cd4@vmware.local.home> <20181205212945.58edee31@vmware.local.home>
 <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com> <20181205224333.3c589916@vmware.local.home>
In-Reply-To: <20181205224333.3c589916@vmware.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 19:55:20 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+PjtxDD7sCCPwVf8=Ofzx-=6OT14xAKdV3vGqJDgx7XA@mail.gmail.com>
Message-ID: <CAGXu5j+PjtxDD7sCCPwVf8=Ofzx-=6OT14xAKdV3vGqJDgx7XA@mail.gmail.com>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 7:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 5 Dec 2018 19:29:11 -0800
> Kees Cook <keescook@chromium.org> wrote:
>
> > On Wed, Dec 5, 2018 at 6:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 5 Dec 2018 21:26:51 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > On Wed, 5 Dec 2018 17:08:34 -0800
> > > > Kees Cook <keescook@chromium.org> wrote:
> > > >
> > >
> > > > I'll Ack the Makefile
> > > > change in the tracing directory, but the rest belongs to others.
> >
> > Okay, I wasn't sure. Anders's patch was marked "1/3" so I thought it
> > was directed at you. :)
> >
> > I'll grab this one in the gcc-plugins tree.
>
> Should I just take patch 2 then? I'm thinking it's independent too.
>
> I'm collecting patches for the next merge window right now so it wont
> really be an issue if I do.

Sure! I'm not sure what Anders's intention was, but yeah. :)

-- 
Kees Cook
