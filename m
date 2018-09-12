Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1052FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B084A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IrfivDUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B084A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeIMFBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:01:33 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46563 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeIMFBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:01:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so444744ywc.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q0EQOHiyymoi/ChqeLMpmIWP8RLFQR5mfYVwn/b29KQ=;
        b=IrfivDUJqwcPryKhGVxzKCfjX+jr2cY0Vubg/BVMQpT4dvdQd0lY3D7IRbaCPaBJyj
         Jn2GZ9YotKnCzgrJpQ49o6BDQ0+kYuji+vibz/hkFxSnAqejGkDyAT/SM5bk2V8lZYEB
         NbxVl2WFRzf76ZAYNJLXavZPww5j9mWhQOW/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q0EQOHiyymoi/ChqeLMpmIWP8RLFQR5mfYVwn/b29KQ=;
        b=JmUkd+xxV+PLTAWk8KcLhVoazNdXtylT6dV/Zqk+KhKmdOPCmvVLr0M5X+T2+m4jcR
         rrVgKeyQVVp0bSTfb1bvoajcs99lF4OpE4b5chm2Jm/qSmUqqt6S7AaX2e07zPyI2vku
         ERXme8L3cJj16xingDJ2qIlwycLAQWojMkiR2VLwmtLtDzWTSRmHZo3x0+VVe/+zXQaR
         TQPW6CgT/U+HtqW85Ac5fnmBShX/9v0GfuQAuiyskwXkUmtFtaMvrJkQTAs/cdPhxkHU
         kEF5Z5lHAujOk0RxGto5wS2li0e4it1tpO8fk5J1uQwPrIfJw+Ynmf4TbvIOU74Kw3zL
         PxAg==
X-Gm-Message-State: APzg51AN902ehWKpvbxbrBwDAMfqvqJxtylWE1RxeAq2I7U9EiK24jlU
        b+eKljUSUxKTwNTDFSQ1vy4Hqj8lRGs=
X-Google-Smtp-Source: ANB0VdYE3Cuvm5na31F0rIX+s1swm0r1s5j8CBK4zH9UIV7cYOBdJ9v/6nXwaW6Zg/H8umbyxFeFqg==
X-Received: by 2002:a81:2fc2:: with SMTP id v185-v6mr2159243ywv.199.1536796481383;
        Wed, 12 Sep 2018 16:54:41 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id i123-v6sm3237440ywe.14.2018.09.12.16.54.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 16:54:39 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j8-v6so2530359ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:54:38 -0700 (PDT)
X-Received: by 2002:a25:5c87:: with SMTP id q129-v6mr2308185ybb.403.1536796478470;
 Wed, 12 Sep 2018 16:54:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 16:54:37
 -0700 (PDT)
In-Reply-To: <65bccad6-5669-9f4a-a645-35e0da301817@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com> <65bccad6-5669-9f4a-a645-35e0da301817@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 16:54:37 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKVXdz+9qp+UCxRiVoXJrMbPxQcNDYy21e3E37pVF5ymg@mail.gmail.com>
Message-ID: <CAGXu5jKVXdz+9qp+UCxRiVoXJrMbPxQcNDYy21e3E37pVF5ymg@mail.gmail.com>
Subject: Re: [PATCH 05/10] SELinux: Abstract use of file security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the file->f_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Seems delightfully mechanical.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
