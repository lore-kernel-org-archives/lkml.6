Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C9AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EFE20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SC6dkYue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EFE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJDW4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:56:49 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:41487 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeJDW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:56:49 -0400
Received: by mail-yb1-f174.google.com with SMTP id e16-v6so4088542ybk.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ypCfS2PgP8RQK85F3gN7hN9fyU5MYN1UsS9KF6upNOA=;
        b=SC6dkYueb5HmqJ4931EPohjoQ7JOgyPmgF7PsxB6ovvyYUBoie/2UEKXctbgCu4FxA
         vZLGlmKegUkRhNINWcNNYOQysk5gfDCy12ym6xXmpC1JKlNuRSJ2G27rXYrYzLLm2gqx
         ObEJ+hzku/IywTG5coOZZZHQGSXMk2OCyYY8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ypCfS2PgP8RQK85F3gN7hN9fyU5MYN1UsS9KF6upNOA=;
        b=XW4LBtGgUaoHJyNutNeeFBOq8vUoCxNJRiIevIDk+GmFew538LsyRbOyPMj/ZN0qSg
         NIK8lVP+2JX7bhH81iqbIuQlpsF4yvwmZMWoR41i4DA+QE0b4CySUAq7wlJqWQeGa6j7
         q06kWtQGFUPELtCvGxZLTnjbAU75gV/mS5E0LML9yPNvBEYC1eoIdTb1vPmSqbNFWD3Z
         WF9jhJjw4jHGn3IBwL4wO9JANxVl7LutJCsyrRHML7U8bYy6q2uMVDVIKmlvzCxJw1sN
         BtXJMOp9L0dWQbaA4RYwlW1ZxSZp1p/qy+qAj3reT4wJ5QZsQz85S0OpmwJGmTq9hJD7
         DmMA==
X-Gm-Message-State: ABuFfog5KYunRDwvzKpARYpJ1EEVbDyN3aYfuEExNF4Y6HOZbNHCXsup
        l4xWOcbdfO3qYUyxt3QYW4D372b9T80=
X-Google-Smtp-Source: ACcGV63SEQRGnbNIDDDQdv8A1GUqOKDZUekphnor+Ay6Is9b5/1XktsndF8Bto3ONvZt+ijrSoE/BA==
X-Received: by 2002:a25:8b88:: with SMTP id j8-v6mr4167819ybl.183.1538668973927;
        Thu, 04 Oct 2018 09:02:53 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id w207-v6sm6202091yww.95.2018.10.04.09.02.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 09:02:52 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id l79-v6so3965939ywc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:02:52 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr4109421ywd.288.1538668971937;
 Thu, 04 Oct 2018 09:02:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 09:02:50 -0700 (PDT)
In-Reply-To: <638db305-cfef-4391-90bf-458f50c4612f@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org> <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
 <583a703e-18af-a1b2-dfc9-62a2a3384825@tycho.nsa.gov> <CAGXu5jLmQQd4e=B3YsiEoRVih2m889ia2tnzu5r8bqcms2sOqQ@mail.gmail.com>
 <638db305-cfef-4391-90bf-458f50c4612f@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 4 Oct 2018 09:02:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKkCL7YVajp0b5x7G=06XyrhLrvh_p8FAKNKKYZW7sAfw@mail.gmail.com>
Message-ID: <CAGXu5jKkCL7YVajp0b5x7G=06XyrhLrvh_p8FAKNKKYZW7sAfw@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     John Johansen <john.johansen@canonical.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 10:38 PM, John Johansen
<john.johansen@canonical.com> wrote:
> but distinct of first exclusive (major) will likely be going away
> once full lsm stacking land.

Right -- then policy loading because the "enabled" flag. The point is
to get us to where we don't care about exclusivity at all.

-Kees

-- 
Kees Cook
Pixel Security
