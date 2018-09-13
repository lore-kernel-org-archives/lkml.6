Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FF7C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA0B2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RaArCkUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA0B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeINFJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:09:43 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42374 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeINFJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:09:42 -0400
Received: by mail-yb1-f194.google.com with SMTP id j8-v6so4051141ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9fljAUIzFArFW68SO1bHxk1MHzksPO1BKvlQtREJaGQ=;
        b=RaArCkUfH5NOMqZz33WIV30x8X0AfYWYq5aQ+ivmqFU2pDk6Hpn24Fjc7gZGixxmGm
         /6PQg//s5cFcS3ZmzHtZwXJ7tCgggcKnJeNaKsBJwWqqCYOhjetfwpg+jky02kHt/hcw
         mXGtrp+Z009NdTKJhwu64kQ+BzAemCRxZ6eSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9fljAUIzFArFW68SO1bHxk1MHzksPO1BKvlQtREJaGQ=;
        b=Q0bhXgiyqVHlK/toV89tOPId/b9NfLdpZJc4KXksJcFwT6+DZT/8FWfyz2wbuS0ma6
         Ih8snt7amQsocWw0R5UytsSwTsZjUvtuQObxCPXRQZ/orWeikPOxzXoxdJyROESsZVSd
         W3d4Lf1jmmp3g/TEQdRdWY5omSkfZkOzWQDO0rOo4q8Lqe+Imqiup78OENDX6twtcEy/
         szIUJQu9FJkn/SehTDNRwp73zy7N56KCVHADvm3iFivmY6fythfo52X+y4/CDGG2Icbt
         RtarbDXUHY+2nfrDLbc+G5zBa1JYUZ6h84cb5SixuTEBcYnvLDUyIo11nvrQ9mvsQy+e
         xWOg==
X-Gm-Message-State: APzg51DBuE0CfXmv/bZPjcdwS11zZ31X/8gSxeFZtmN8nhs1pOMm8wHo
        nKPzLqtI7ZmjkCagqaNxDgNYhS/Od/I=
X-Google-Smtp-Source: ANB0VdYRLH+70QU6ha5F7C8VI0YLnwUX9ZVZoG3JnrK3SwLVQUb+W0GV3KcnigTQ3GJdIYbZAZtRuQ==
X-Received: by 2002:a25:5a89:: with SMTP id o131-v6mr4627351ybb.73.1536883077119;
        Thu, 13 Sep 2018 16:57:57 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id p78-v6sm7420094ywp.31.2018.09.13.16.57.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 16:57:56 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id y20-v6so4035383ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 16:57:55 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr4518384ybg.171.1536883075446;
 Thu, 13 Sep 2018 16:57:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 16:57:54
 -0700 (PDT)
In-Reply-To: <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com> <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 16:57:54 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
Message-ID: <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/13/2018 4:06 PM, Kees Cook wrote:
>> - what order should any stacking happen? Makefile? security=?
> Makefile by default.

Okay, if ordering is by Makefile and everyone dislikes my
$lsm.enabled=0/1 thing, then these mean the same thing:

security=selinux,tomoyo
security=tomoyo,selinux

i.e. order of security= is _ignored_ in favor of the Makefile ordering.

That seems dangerous to accept input that is "out of order", though,
if we ever DO want to make order definable.

-Kees

-- 
Kees Cook
Pixel Security
