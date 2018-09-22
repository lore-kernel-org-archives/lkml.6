Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD6DC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2738E21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1/fCvwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2738E21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeIVIg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:36:27 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34028 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeIVIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:36:26 -0400
Received: by mail-yw1-f65.google.com with SMTP id m129-v6so197254ywc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yrRrYun0p1t9laLCKRji1sYubxXnqAmGv2Md1D0qHZg=;
        b=Y1/fCvwPn0MIcPdmwqFf87GLIlWUaLTP+PbJax5jfzgp8W6WhL0FA0J9EYf/iO/xl7
         bnZxWPNAm886937Xg9uRGRrr/T/m5YMmWYPHFbm2CMrGs+AOdhiC/Wcj6aP0/WieXV1W
         iVGTE1tAfyPM59q82oBPUQ85STCyOSuc43zsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yrRrYun0p1t9laLCKRji1sYubxXnqAmGv2Md1D0qHZg=;
        b=KXdzz4gxMssU+ofc2qMW6uW7ZSHC2VUCBoFCy/4y4Mp4+jUUFJqeoLQfWdUbPgtJCm
         aww8eiUctMTB3F9JxBOAWyo+8LN6cyjJNTJt2mJjD6ARizIkgkFU8m1PDiidR4WVhXnr
         MKi2tdxc8Oqhk4HlmSvK2btiL3DalLYFeDYdEjZNDsokSrzeyFm2F/qNojzei4cUvMaJ
         p3SS2E8SeyitPVVki63cs6b+JCkxhhFeJAzPv0NRGVTw4uhpmYX4DdEtZJ311UFKiMLW
         GpCjSSD6Fri8w7QJgSxkNWsjrz3GOwmzULEnWGjv7b1qUK/vj2ZTNiwriIa610+jm1YU
         jKyQ==
X-Gm-Message-State: APzg51C8I0BN6jElIufVx4BHe1umrCSM2t/MWTBwBXGhorkwTgAL7XAz
        4SG2RH0x1T90+Mm7q6uI75ArnhGkmX4=
X-Google-Smtp-Source: ANB0VdZoa5MN7Wz1X0KY4WVediRPKXjJsG/iAyKk6OoiYaZh7FAq3H4R1iGQadD9uMt+kLRSvLyV1Q==
X-Received: by 2002:a81:320a:: with SMTP id y10-v6mr194686ywy.509.1537584278317;
        Fri, 21 Sep 2018 19:44:38 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id z125-v6sm11979361ywg.57.2018.09.21.19.44.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:44:35 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id d193-v6so3097550ywb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:44:35 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr206486ywi.288.1537584274961;
 Fri, 21 Sep 2018 19:44:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:44:34
 -0700 (PDT)
In-Reply-To: <03191752-22d3-4066-3d3a-8fbe209447e5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <03191752-22d3-4066-3d3a-8fbe209447e5@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:44:34 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJMEwAtns_L79WF+CrpYnOBZxCvZi_xnHHVDMVB18_PNQ@mail.gmail.com>
Message-ID: <CAGXu5jJMEwAtns_L79WF+CrpYnOBZxCvZi_xnHHVDMVB18_PNQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/19] Smack: Abstract use of cred security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:17 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
