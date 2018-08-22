Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6500FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1F321473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PcTVVQGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1F321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeHVSSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:18:33 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35785 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeHVSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:18:33 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so3296742itf.0;
        Wed, 22 Aug 2018 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ux9iWoBVSHaIXIhBsX2rNfOiDXt+Zy4ELUNAnpWs+nE=;
        b=PcTVVQGZpf9C3apBM+FGcHQ7Kop7Z5KQhw3nXGTvKIEmnZX37v/12coUiZpBxnC0I4
         U/97KUeJtawyOboDFWfEQgQi0L0cWDzEnO1Z9YR2o/plEkMv89MmwOf0cAJAjAf7VR3z
         osiI9wuqDH4TEXEFRdrLyk5KvTFDd4nkiibec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ux9iWoBVSHaIXIhBsX2rNfOiDXt+Zy4ELUNAnpWs+nE=;
        b=kt7zZMz0HF1SWGIR+GkVrU6WdhHS3Qabpfn/U/i4K+iAjjv3m5u2jCrQluM2HCUWBE
         PfDbSbEw436y1MAzswX+Qqe3prye7thbfMmv3BWdhKiXv3mwCeYImKXqZHwDWC/reo9R
         CcYDcWnmzsTxtL0Y+WLxSJx32Pn38Fmiwzx+7PGcIphGivBn/MN6nJbu+sRxR1kdTf2g
         jHhNvmkzsVmzwTM0M7y866r8OYA/ERFCahTqEUNfZr3Nf3pvG0ikruJJC4dHXNZJWrYR
         7sfWkTxPUCIUUkJji0uh4jnL0KxI9LSEa0HxQYm7UNfbmMQIe7mlr0VHj6Hs+4IwbUCT
         HYJw==
X-Gm-Message-State: APzg51CBaABwrx4jyrfFtj+1lKfORHyB2SFA0D9fFfONnU3xvmuTqt5y
        P0jDlZbkrL1ltFBfP+ogDzQ86u8lB6yt34yKMN/YiQ==
X-Google-Smtp-Source: ANB0VdYhPwIUBAKj9c/ULDGmIB89s2Iw/ZYiecwE5uY87XAXXpDdq9bpftYir0LTxFxsVjVxQbuHNdGVZva+7PhneOE=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr2951671ite.123.1534949599840;
 Wed, 22 Aug 2018 07:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180822085522.GA14354@veci.piliscsaba.redhat.com>
In-Reply-To: <20180822085522.GA14354@veci.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 07:53:08 -0700
Message-ID: <CA+55aFzd53LwrBfvdtKx7e_bQPhzsKEvCME1rGbrrY4pG94d=Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: set I_CREATING on inode being created
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 1:55 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> +       spin_lock(&inode->i_lock);
> +       inode->i_state |= I_CREATING;
> +       spin_unlock(&inode->i_lock);
> +

Why is that spinlock protection there?

Isn't this a new inode that cannot possibly be reached any other way yet?

NOTE! This is a question. Maybe there is something I missed, and there
*are* other ways to reach that inode. But if that's true, isn't it
already too late to set I_CREATING?

So I'd like some clarification on this point before applying it. It's
possible that the spinlock is required, I just want to understand why.

          Linus
