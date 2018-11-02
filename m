Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87982082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MZYRd/eH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87982082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeKCF5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:57:51 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38889 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeKCF5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:57:51 -0400
Received: by mail-yw1-f68.google.com with SMTP id d126-v6so1287641ywa.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AdbRP1e8hhSctEX2RFnFJdxI7Ntlt0NMbsw9ytVJYUQ=;
        b=MZYRd/eHgIPhy4q251SCFQz1FbPFZ2DATzZ72cqhh0z59yxwEZeaeJxElQo3rkIg8r
         66DpVpmMkRxdfasZ9XGXCa5VrZwEwR0DUm2vpUUoLaDrZvU3ydBRop6FG/ZZf4MlOQpB
         vknMJ6EbPx2O443vkScDvzm/jGerGHoLcUHRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AdbRP1e8hhSctEX2RFnFJdxI7Ntlt0NMbsw9ytVJYUQ=;
        b=SgA7+MMXMzsBhPKTSsXxTBHZ/G8tKF2/FO+/JgJBeFXQWhMOhHREq3AumZwiev16iU
         OF1VwlJx9erPYILTXLhXrYtOcYR9chyDX54r1agg9LjC1FOBhUPROR/QtI6cL397Q8jd
         MigNp6giipLdF0VUT7vyYTV+ERwe36y+ybUaaEVy8+uGTsBbD9jqxd/oxeehZFeXCSX2
         grRYNI0Hral29WHVGwm57ih4JcKU1ncvQoEWSri91p5gLgIYcqWV83A9Yig2Ee8eCWWh
         r5HWs+edCssejFxB/MeIl/1QA29nISoLC75tnXpLywToTu3vvqzjMmyvHbashiMbfl2s
         jSVQ==
X-Gm-Message-State: AGRZ1gJ9ktEZQ2OgyNhbG5bKouDOCGy/HNmcbjjX14XFz4uGphOIGtNy
        Wa8K3lITXa5wflo7rkz8r2eRRh7VAYI=
X-Google-Smtp-Source: AJdET5dr9eTew6g9OIo0sFGZoJRlAdscuX2cgXtmIybS+MfeI2mpKIriXb4zijtOmkByj4wEZK9JJg==
X-Received: by 2002:a81:3193:: with SMTP id x141-v6mr13040393ywx.448.1541191752084;
        Fri, 02 Nov 2018 13:49:12 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id q2-v6sm18735648ywa.24.2018.11.02.13.49.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:49:10 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id v199-v6so1296639ywg.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:49:10 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr13322078ywf.237.1541191749802;
 Fri, 02 Nov 2018 13:49:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 13:49:09 -0700 (PDT)
In-Reply-To: <1541182406.20901.31.camel@linux.ibm.com>
References: <20181011001846.30964-1-keescook@chromium.org> <20181011001846.30964-13-keescook@chromium.org>
 <1541182406.20901.31.camel@linux.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 2 Nov 2018 13:49:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKM_goC2519EXZu7Bh0VoW8jQeR=AJ0XovUPe4_635XNw@mail.gmail.com>
Message-ID: <CAGXu5jKM_goC2519EXZu7Bh0VoW8jQeR=AJ0XovUPe4_635XNw@mail.gmail.com>
Subject: Re: [PATCH security-next v5 12/30] LSM: Provide separate ordered initialization
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:13 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> I don't recall why "integrity" is on the security_initcall, while both
> IMA and EVM are on the late_initcall().

It's because integrity needs to have a VFS buffer allocated extremely
early, so it used the security init to do it. While it's not an LSM,
it does use this part of LSM infrastructure. I didn't see an obvious
alternative at the time, but now that I think about it, maybe just a
simple postcore_initcall() would work?

-Kees

-- 
Kees Cook
