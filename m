Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38669C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE3520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fnw9HbqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE3520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeIMEKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:10:55 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41009 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMEKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:10:55 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so404709ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v0dNk49w6GoJjdJZlcckWnJ5rrRlUOnIB8Rq/eBShQE=;
        b=fnw9HbqPNv2cGSON/lerSwrMDQHoFGXzjv8ypWnpvgqDwi7dFMmYYuNM6U6E60F8I5
         NumGucYw94AYfy66y/DIIsft2f6pCAtYuqd1alNuVRENGyWrIzz8ZerEMsW39mxROCNI
         xqT5Jnmi5vE8/22/37R+2DEaujOfeKvrtMQyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v0dNk49w6GoJjdJZlcckWnJ5rrRlUOnIB8Rq/eBShQE=;
        b=g7LRbrvofhHqM7P4sw4ZOWwyyf5vaD8VK0lPxNfYPJARQjoMbTZulMNg6wtoc+uIMW
         LkgtdzBShQ9x1C0zUFuxd4gEhm1zrhFVT+12IqD+EQqyLM1QaO86uMHdPrQz3FA6x5lb
         bx/+03QEE1MR5i1SSGmNKUkX2HzVW0DyczBGGNCjYyxQLAbddHitrUbQLcjEqykBq9yx
         f6qL7Gj1A71TVUPblK44VOda2RSNWkMlt6lMH/g9O1QwQMqmlIGVyOx0j7BYusFQGh8R
         qOUPm0n4RmGxkwRcBBI/2HipHy/sAc7lzXuDBN/8og29ScyRcsuiAMdlD1NoXr/Etizh
         fZ9Q==
X-Gm-Message-State: APzg51CWL/Y/P8BvE+7OSFROTkmSakx1fUk0wpZ3ciqqAYBy05Iija7N
        Um+OsPEV22m+n+xONUuYmoFJpAGJCTs=
X-Google-Smtp-Source: ANB0VdYlj2aLNzDWeOAY1Hzx9zOAVhwRgCRuLtDAcYKF3EzdCfjaLvRDCYm0r7ag1lTA026XaOL6ow==
X-Received: by 2002:a81:1f85:: with SMTP id f127-v6mr2080127ywf.395.1536793452987;
        Wed, 12 Sep 2018 16:04:12 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t4-v6sm714136ywa.51.2018.09.12.16.04.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 16:04:11 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id y20-v6so2474099ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:04:11 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr2107380ybg.171.1536793450959;
 Wed, 12 Sep 2018 16:04:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 16:04:10
 -0700 (PDT)
In-Reply-To: <18c20c50-3ec5-0c85-93ef-58a3dbf3498c@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com> <18c20c50-3ec5-0c85-93ef-58a3dbf3498c@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 16:04:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLZaDxv140w5L48yNLikUs-=JMJ82oDW-sP=4b3tRC_bA@mail.gmail.com>
Message-ID: <CAGXu5jLZaDxv140w5L48yNLikUs-=JMJ82oDW-sP=4b3tRC_bA@mail.gmail.com>
Subject: Re: [PATCH 02/10] Smack: Abstract use of cred security blob
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
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack.h        | 14 +++++++--
>  security/smack/smack_access.c |  4 +--
>  security/smack/smack_lsm.c    | 57 +++++++++++++++++------------------
>  security/smack/smackfs.c      | 18 +++++------
>  4 files changed, 50 insertions(+), 43 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index f7db791fb566..0b55d6a55b26 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -356,6 +356,11 @@ extern struct list_head smack_onlycap_list;
>  #define SMACK_HASH_SLOTS 16
>  extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
>
> +static inline struct task_smack *smack_cred(const struct cred *cred)
> +{
> +       return cred->security;
> +}
> +
>  /*
>   * Is the directory transmuting?
>   */
> @@ -382,13 +387,16 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
>         return tsp->smk_task;
>  }
>
> -static inline struct smack_known *smk_of_task_struct(const struct task_struct *t)
> +static inline struct smack_known *smk_of_task_struct(
> +                                               const struct task_struct *t)
>  {
>         struct smack_known *skp;
> +       const struct cred *cred;
>
>         rcu_read_lock();
> -       skp = smk_of_task(__task_cred(t)->security);
> +       cred = __task_cred(t);
>         rcu_read_unlock();
> +       skp = smk_of_task(smack_cred(cred));

Hm, why is this safe? (i.e. what is pinning the cred?) I would expect
get_cred()/put_cred() since this is not for "current"? And then what
controls the skp lifetime?

Everything else looks to be mechanical replacement, so that's fine.
Did you use some tooling to do the mechanical replacement or was it
done by hand?

-Kees

-- 
Kees Cook
Pixel Security
