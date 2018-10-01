Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7223DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3502720C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHCJwBH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3502720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJBGSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:18:39 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:40092 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeJBGSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:18:38 -0400
Received: by mail-yw1-f44.google.com with SMTP id l79-v6so43306ywc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XlzRVP5lKWv4LNLVaxHuF+5oEpeGtFvtjkJPXnHwLmc=;
        b=ZHCJwBH0NsNTCoJCYVEVIFVviLZE55GWjH3HNV/YNHhYqDhH43gR8E3SJSlHceYiJT
         XqKpRcRXN/TJ5mgd5suFztHggkMW6BVtJugZ21BC0tMgFgN+eUTS66ldYbdWO5RV9Ow3
         oQ82qOIY9CTedRLm9V2PAjd2h5n/bC7Cf0d54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XlzRVP5lKWv4LNLVaxHuF+5oEpeGtFvtjkJPXnHwLmc=;
        b=W5EGalu/WK72l6eB3uIk6bxVuqNLfJqJH31WimYrV5xkf+rYPSoQyve5aVaZKaDrKT
         t4SHfMKVE7QBOnyWZD8QjruYrFylTt1jI4LfNnpNTvh8lKdm5DyAEQ9TbWLHuYxBaZMr
         L/kpL8kFiH69fiGXIzSIAPjjE9i3loaGE1PLwhWAX3AjwhYwa7Ui6UbHQUBmvAjXFexy
         RtwdRg8UCBwiBlyCPvrtydI/VsGfFJ2knIy7vlL5Ya8tudx/OJ3GpiUnfutlNP2aGdhj
         qSkOI5IzqDOOgWRSxxxCcD6z6AQoKdnI7XsLueeAb/FgoqxUV/eh9LNMiqsj00s62tA9
         eq/w==
X-Gm-Message-State: ABuFfoiCDc+AL9tr8DeZbjCo/WiulpDO3Oo3i+x/WsjmribJBKo7XEhL
        kc+0W61k24cormDGL7KN3x9VOlt9HNI=
X-Google-Smtp-Source: ACcGV60ryjE3sPIZYEx/B1aRlhI9mpKCQW4wDjIE83NDvsdY0LUTq0H3IFsviSorHMFDJ3fV0i/ukw==
X-Received: by 2002:a81:6846:: with SMTP id d67-v6mr4627714ywc.303.1538437104053;
        Mon, 01 Oct 2018 16:38:24 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id z130-v6sm3844898ywd.91.2018.10.01.16.38.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 16:38:21 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w7-v6so44595ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 16:38:21 -0700 (PDT)
X-Received: by 2002:a25:238d:: with SMTP id j135-v6mr7127848ybj.137.1538437100765;
 Mon, 01 Oct 2018 16:38:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 16:38:20 -0700 (PDT)
In-Reply-To: <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com> <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com> <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 16:38:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ6ZDs1hZTX9jS9w2MmecbcbMcn6iAmGuyCBbThyjv_iA@mail.gmail.com>
Message-ID: <CAGXu5jJ6ZDs1hZTX9jS9w2MmecbcbMcn6iAmGuyCBbThyjv_iA@mail.gmail.com>
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

On Mon, Oct 1, 2018 at 4:30 PM, Kees Cook <keescook@chromium.org> wrote:
> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
> enabled. Is that okay?

Actually, what the v3 series does right now is leaves AppArmor and
SELinux alone -- whatever they configured for enable/disable is left
alone.

The problem I have is when processing CONFIG_LSM_ENABLE ... what do I
do with the existing "enable" flag? It's set by both
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE and apparmor=0/1.

Right now I can't tell the difference between someone booting with
apparmor=0 or CONFIG_LSM_ENABLE not including apparmor.

i.e. how do I mix CONFIG_LSM_ENABLE with apparmor=0/1? (assuming
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE has been removed)

-Kees

-- 
Kees Cook
Pixel Security
