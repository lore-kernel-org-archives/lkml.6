Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F9A213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b5pSpTqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F9A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJBGaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:30:19 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36932 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJBGaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:30:18 -0400
Received: by mail-yb1-f194.google.com with SMTP id h1-v6so60985ybm.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ohEmpld1IFXjpF8PrBFP4qTkcM2P6AcoHxxKbyBNVM=;
        b=b5pSpTqR8TmSGggikp7xyF+snqMrJPH1p7e2lE+1eU7X9y0Z6OFHDpZcPaucVlYuNP
         nRK3vFBfzv60PdkYhhoUyz8uzMQt5WyH7tj/80NkYdGBqXOXpC8u5OPbEtnG1N2ct9is
         OkDfeKDCsH4kAPyJHnMm/NGh3kiYzLLRdQN9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ohEmpld1IFXjpF8PrBFP4qTkcM2P6AcoHxxKbyBNVM=;
        b=gdWm39fGXqLDE62Ij1Dh9hP91yPHs/T6F3QagveQZeShP0WFA4RTHstIEJY1C7LB74
         dFcYhxsnPdWxIqIo8UfdW5BzNykEF6eO95v7MldN0xN3uG6mMxABLn7M3le1Vg5roSyW
         2xZ8YI4ch3O/rFM9JgMDtfdll4JP7Upg0Bvfrr/qZtKlOT8GxiCrPUSsjFHFiZtC0pPz
         kD+okwoUqrL9FvKeIlZ5mIsf1Ljbpn5CaWYqjE5j3gSE62W/PzZ/L4R+D4LgkIhQlifh
         RYqLtcez/cF38Q9DnQlzr0xwG7qx9tobrtvKWpeINbPAk5JY0jh2agcX/Kbo1wrB2Skn
         KAKA==
X-Gm-Message-State: ABuFfoiRk+rLR3aFATTTZxX4XYP0weOnTCpiJ38D051vXwbc/+gQvFMU
        Y9PgIXVti/O0gfCwU3kpfevslQnlRvM=
X-Google-Smtp-Source: ACcGV63iC7lBNHC7VrV9PLXQTvfHmuycjXsUFHhOmLTiPKIvgNXlez6y2x/nd1eJH8u/zFwEmJSx2w==
X-Received: by 2002:a25:74ce:: with SMTP id p197-v6mr7159841ybc.343.1538437802026;
        Mon, 01 Oct 2018 16:50:02 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id y198-v6sm5919695ywy.64.2018.10.01.16.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 16:49:59 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id y14-v6so59262ywa.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 16:49:58 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr7356787ywr.168.1538437798500;
 Mon, 01 Oct 2018 16:49:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 16:49:57 -0700 (PDT)
In-Reply-To: <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com> <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com> <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
 <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 16:49:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJr8P_rS+DcQJxMM9xnB0vFFc75Xrk7Qv9yx8_DLB1Vjg@mail.gmail.com>
Message-ID: <CAGXu5jJr8P_rS+DcQJxMM9xnB0vFFc75Xrk7Qv9yx8_DLB1Vjg@mail.gmail.com>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
To:     John Johansen <john.johansen@canonical.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 4:44 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/01/2018 04:30 PM, Kees Cook wrote:
>> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
>> enabled. Is that okay?
>>
> ugh I would rather get rid of apparmor=0 or to emit a warning with apparmor
> disabled, but if we have to live with it then yes I can live with last
> option wins

Removing it would be much preferred! :)

Assuming Paul is okay with the same results in SELinux, I'll prepare patches...

-Kees

-- 
Kees Cook
Pixel Security
