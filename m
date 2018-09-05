Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4590C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBF1206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PdUA+/Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBF1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIEVoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:44:38 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33760 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEVoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:44:37 -0400
Received: by mail-yw1-f66.google.com with SMTP id x67-v6so2945831ywg.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KxQZp9c31nC4ee5Ddt4qOlD00u934hY33AxSGphgIw0=;
        b=PdUA+/EtJmBRbQENEsS9hhd0YpLdf3LJdPo1waiurJp0ESlG+68Rzq70leQuXoMoFZ
         1YhoBl4zij1Evt4tL1xAH+rh/w59vo6oAwYpxYYzpk6MgcbPf/2ABwPWcetp2HicdN7C
         B1Fdh+YB0FWaN+r+SSkwaj9jFdO4AEBHjZedw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KxQZp9c31nC4ee5Ddt4qOlD00u934hY33AxSGphgIw0=;
        b=PuWNDZXfnBAShAJdEE4wR0JbLRZ80MfnDCwzeI7BKj8StXB+AxfBSo5ISClpbZ7JRX
         AIgIG+y5+HDk/9Cs2BMJ+VIY8dZ1zAtTDbmdor3f+E1e3qx7zUC/P2m2Ma4jPawkXuzm
         JE2AQs5UZ/yvYhMLiasT1FkGnSmxde19gRUqBi+cbF4GGSS4RavajnBF0phnGYQIX2dK
         vLtaZzRKD1mfmCpAroJw5i48fbBf7dfbwIYCK5lAsWE2YWAntMG9YKNno9yPWhDISUOt
         i/HZBlt79gXiHMC8uZ9W+fUkX8t8tjTE14UU3JpgPfnQNDsItscJ5Y+PMKDyQWtt7Ou7
         ni5Q==
X-Gm-Message-State: APzg51DW2napa6CYYV0vvfo5HFU96W5eV6O12heFW2Vs8DrszjJZUt/6
        fm56Rz+d0cVw2l3D7wUuNmHtkQv1yes=
X-Google-Smtp-Source: ANB0VdbFz1UaBXpKb9GXaLk8HZx5IlwwNcs/RDI8tjX8fGRkHi8o6GoG2fUugV9Z3BdzL7G/YxhMIw==
X-Received: by 2002:a81:23d3:: with SMTP id j202-v6mr21252576ywj.201.1536167610661;
        Wed, 05 Sep 2018 10:13:30 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 129-v6sm868320ywq.26.2018.09.05.10.13.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 10:13:29 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id e18-v6so2980021ybq.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 10:13:28 -0700 (PDT)
X-Received: by 2002:a25:5c87:: with SMTP id q129-v6mr1278175ybb.403.1536167608352;
 Wed, 05 Sep 2018 10:13:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 10:13:27 -0700 (PDT)
In-Reply-To: <CACT4Y+ZVHit9C-w78mEUEtpZjyncaR_3S5fu_KZk2YuBtthK9w@mail.gmail.com>
References: <000000000000c178e305749daba4@google.com> <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <5806108.mdyebWjNCB@liv> <CACT4Y+ZVHit9C-w78mEUEtpZjyncaR_3S5fu_KZk2YuBtthK9w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Sep 2018 10:13:27 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+OhEFJQJTiip5AmL2PYgBZwwL7vaRCFjSaFOXhwJnx0Q@mail.gmail.com>
Message-ID: <CAGXu5j+OhEFJQJTiip5AmL2PYgBZwwL7vaRCFjSaFOXhwJnx0Q@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Russell Coker <russell@coker.com.au>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 7:53 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Again, if you change wheezy to stretch here, it should reproduce the problem:
> https://github.com/google/syzkaller/blob/master/tools/create-image.sh

FWIW, I sent an update for the image version here:
https://github.com/google/syzkaller/pull/708

-Kees

-- 
Kees Cook
Pixel Security
