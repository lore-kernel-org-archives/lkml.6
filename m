Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B52C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1257C204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dCGkUtqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1257C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeIMFbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:31:32 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46673 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeIMFbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:31:31 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so468825ywc.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mJAHqlm195xY72SZ8BF/OuMd7uyk9XT+0JyKb9eX1N0=;
        b=dCGkUtqHqC+oqZ3pUzbtzinHhKU7mzrOnoWT6Qd94WTlqU2YegUB7/COhgNpFh3o+A
         Ntzq398patr4iH3q/UeQeAAv4Fzu9LL0GD9CsJ/clWS2ZpZzlFr6yGCs//bLJBkPHfnj
         C2AuypzcTDg8v5hdRBzoN1mmBDBDJ/JhJEGUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mJAHqlm195xY72SZ8BF/OuMd7uyk9XT+0JyKb9eX1N0=;
        b=ZSGZmzK1BZlUQ2/ftbYFpqdnwsJBDwyhDyOAdTGvMzFqSnPYBg0rOVtyhoqCB9oLsP
         7dD7n1qO6Z1yS3FpozwEmtXYHAFywHloiJfuTzumSozDYR8cO2PI2/6FjDTfHe51cQgI
         ADUP83n/T7tShuZ/ysEShC91t8gvgnOy+MmKKzjwZQXZ5GmhkE/FoU+Xh+FJc84/BIKn
         5Pk3CfjZssFdXLf1iqnSZ39sZV6YTSaLfDOBABHqt1YVgF4aj7Tj8ntR3TCH8jLRRWPo
         uKlI1z93AIobxgv8TEO4ghgZuIzaWJQ+EYuV2dng9hNxJBJgC8z4Ahv/kFeXFPCtxcEi
         9UbA==
X-Gm-Message-State: APzg51BL62WaspxZ6pqbdiVC9QbNZBfn6r4BnguxQ1YmTBknf0Fofscu
        2KLpvh48Nlip2X75bOnsdbyrgwyVjf4=
X-Google-Smtp-Source: ANB0VdZ85XJAQtJ+0s4yMVH9KXATYBLSp56AskMGl36rFMbfZgiVl1mGyfGrdjTKR8EZilKjKIcrpg==
X-Received: by 2002:a0d:cfc2:: with SMTP id r185-v6mr2300169ywd.337.1536798274114;
        Wed, 12 Sep 2018 17:24:34 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id r3-v6sm3037169ywr.80.2018.09.12.17.24.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 17:24:32 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id v10-v6so2559484ybm.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:24:32 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr2228417ybg.171.1536798272201;
 Wed, 12 Sep 2018 17:24:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 17:24:31
 -0700 (PDT)
In-Reply-To: <70b7f8cf-bfb1-1ec3-e4d4-5d2da632b52b@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com> <70b7f8cf-bfb1-1ec3-e4d4-5d2da632b52b@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 17:24:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLnRbEy8h5QVVF=D-qu1Yt=vv5do5+_YVHe2asP84ShJA@mail.gmail.com>
Message-ID: <CAGXu5jLnRbEy8h5QVVF=D-qu1Yt=vv5do5+_YVHe2asP84ShJA@mail.gmail.com>
Subject: Re: [PATCH 08/10] Smack: Abstract use of inode security blob
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

On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the inode->i_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
