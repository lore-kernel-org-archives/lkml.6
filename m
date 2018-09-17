Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B0EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7722D2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fVRqAiMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7722D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbeIREuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:50:04 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:39611 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeIREuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:50:04 -0400
Received: by mail-yb1-f182.google.com with SMTP id c4-v6so21589ybl.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z3jCLNQEqM+QuGe6MBSsyK872SEelhgmjjeOuoqczAI=;
        b=fVRqAiMWPoq4QZD2Ks8n4ww+ou7VW4cQXdWmfPD8na2AP83UeUfQgbwENM+TE112yC
         c8DpIfNO4txVaT8n8P9xU8vjljEm1Y0OxLaFA9/tofYe7/wf8jAYJPrNiqFJlqIqlApG
         AIF1IfLUqrTF82AAjzxs9lfG4bTdETX6rOeL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z3jCLNQEqM+QuGe6MBSsyK872SEelhgmjjeOuoqczAI=;
        b=Cr/9eZq0PcaFmEpAcQmdswwPWDm/iCF1wkbzVzYnP5HmoBlQalJwafKIrXrYMJL2UJ
         0Fm10XouInSOa7VDDAii6lJE1AOsOhKJ6F/u9lVVQpOIxnpfpfn+iDtSB8qnk0ASwp8J
         JfkxVamgq5LTvdQmYlXoeMUJnxCtzqDFTKQsi86dHWozQQ2nF6Oed9heXKAUE3ugGDNg
         8Z52Up+k1ivQ0pY3LKkufonfXBgTw9OWxoq/3Ailhxqk4CBuCwZkT1gOfXSQzXMZ1Ix4
         xsYH0/on0XaHk4rrAcJEoJgRjbnrNiGTWzecVCZJwg3ZXmITM2R9I0s90w/SY1sQrJMQ
         FGOw==
X-Gm-Message-State: APzg51Ag9j1AFqNDJO/wGkpuUG8oko9KlhiCV5nTAsx13IC5eOT5MT0S
        7hg5BjVYCFiMbJ5S6xI89jFEkkqaHdo=
X-Google-Smtp-Source: ANB0VdauyJfwb0fTw/vaCNgcrhDmy5K4mRbStZeKjOhD0YuycATIUWi7u1DJSOh73yFJaufNtZteXg==
X-Received: by 2002:a25:c60f:: with SMTP id k15-v6mr11551574ybf.63.1537226430077;
        Mon, 17 Sep 2018 16:20:30 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id o74-v6sm898434ywo.54.2018.09.17.16.20.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 16:20:28 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id l189-v6so11145ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:20:28 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr11073712ywg.353.1537226427839;
 Mon, 17 Sep 2018 16:20:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3408:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 16:20:26
 -0700 (PDT)
In-Reply-To: <a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com> <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com> <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com> <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com> <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com> <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
 <a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 16:20:26 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLfCNSDWDV-MX6Kyyz3AcMBwubH8YAzZ=28xe9kwNCw4g@mail.gmail.com>
Message-ID: <CAGXu5jLfCNSDWDV-MX6Kyyz3AcMBwubH8YAzZ=28xe9kwNCw4g@mail.gmail.com>
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:10 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> Landlock, because it target unprivileged users, should only be called
> after all other major (access-control) LSMs. The admin or distro must
> not be able to change that order in any way. This constraint doesn't
> apply to current LSMs, though.

Good point! It will be easy to add LSM_ORDER_LAST, though, given the
machinery introduced in this series.

-Kees

--=20
Kees Cook
Pixel Security
