Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EBDECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7DE2088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYapqbIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7DE2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeIRG3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:29:36 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:44072 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIRG3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:29:36 -0400
Received: by mail-yb1-f176.google.com with SMTP id s8-v6so95966ybo.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lTWFAxInNwFKnRQOBaghMH/Cz2nNHM8DY0LKUL1ybc8=;
        b=dYapqbIfyju5fCL/MvE/O8tHAuRZ0UtK5h09clmHzvdNeWioJt4SO4fMb80Ywemos2
         QmMBIJIDywV41vX+sTSpJ1A8Lcj+KBEQkAJIs17R7qVFDHEL1zq0GsaTK3hrqLAqqIm1
         ICx/Le8I+szGldRSvEb9HmhhOL5SpEITrs2/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lTWFAxInNwFKnRQOBaghMH/Cz2nNHM8DY0LKUL1ybc8=;
        b=ObXoAfpQXeiQxcQT3+Yd7NwdHWvZwEgkC2D87IFged0rhpnjOTBxlaqA5VBNY9GCxD
         N/yOFRRmo8Te/CP+inG3JsA3hLslL6yrPymX9ob+MMHLyMjmQQ1bHXGjzF/0bPYNsRjl
         ROWn3xHLDIdC4DAW/eMLB3IRFtEjIliV/GGrChSwXGObBe1uho6kOynZn2l9IASl5R5R
         /w1+w3XJFAi0g+yXsc5PVAYDr8RLucIjzP0BQ9MCDQciNBkaE/XJ3YrvXmkpv//AZVkn
         4kqXbBiZb9mIt3dmkEylRhtOX+FNs7WPtbrDclIuuXD/T+QORyk7txloheJbjIo+q7U0
         3rGg==
X-Gm-Message-State: APzg51BSg5qFXroGuPXa7HwsppioHUIFvrdXj33tUf/2SeYGKmfwaKPD
        154X0Nhh5hB/O5nVGdkYvPt2zzeCRzk=
X-Google-Smtp-Source: ANB0VdbLUPdx7vEe+uMG2LsnfLt3RL0LVclJV7uNkGnkk2E5zDsNabgzW9dh1AB6u/Cw7ztzWFMQRA==
X-Received: by 2002:a25:af52:: with SMTP id c18-v6mr1784191ybj.375.1537232378892;
        Mon, 17 Sep 2018 17:59:38 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id r84-v6sm1176061ywe.10.2018.09.17.17.59.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:59:38 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id j131-v6so87218ywc.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 17:59:37 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr11285411ywg.47.1537232376436;
 Mon, 17 Sep 2018 17:59:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 17:59:35
 -0700 (PDT)
In-Reply-To: <580f7894-14d7-c0a3-75b7-9a5f4e3af0b8@schaufler-ca.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com> <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com> <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com> <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com> <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com> <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
 <CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
 <ee3b287d-95a4-db16-e3c6-fc6f6172a5ae@schaufler-ca.com> <CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
 <580f7894-14d7-c0a3-75b7-9a5f4e3af0b8@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 17:59:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+RsokzzEZ1mNThZZPSYWBp_XSejQ53JXyLRhrr6yrEJw@mail.gmail.com>
Message-ID: <CAGXu5j+RsokzzEZ1mNThZZPSYWBp_XSejQ53JXyLRhrr6yrEJw@mail.gmail.com>
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 5:57 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> If I read you correctly, "first exclusive" would suit my needs just fine.
> I like the notion of build time ordering because I hate using the boot
> command line.

Okay, excellent. I think I have enough for a v2 on this. I'll crank it out...

-Kees

-- 
Kees Cook
Pixel Security
