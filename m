Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E9BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A8E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bH2RdKZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A8E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbeITXKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:10:04 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34912 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbeITXKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:10:04 -0400
Received: by mail-yw1-f68.google.com with SMTP id 14-v6so4077244ywe.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F9YjO7XtqfhMG97Tdymx67WZDZxLFnGEZZfFdBMelNc=;
        b=bH2RdKZKxyRzXzgHOb+6oCLoyEsDTuuKdv29JxSrXS3Uil+UqESIBoGkiUNEF1/b01
         RtHXWgjn3FJd8aEmBJpvR6Ja7wHhiGmwQXEYFyFtvthFTZGHqwhzdpo6f0c50yaBpHSJ
         dqq5m3CNQN4kS7HOb+kj50Ad/XpNy7CEJ7ZZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F9YjO7XtqfhMG97Tdymx67WZDZxLFnGEZZfFdBMelNc=;
        b=pCrd8s+r9bF6Pw4SPPS8XIcc1PRmRFYz6LiYVp9eIzd293XJ8iRy2tHg/EC/9M2L5/
         YjhThT2dBQ4AYvewcMgglLZIBT3+FtfvD3CKsf9frr34Chp1KZoIfld9/bGKEkYJwYpy
         1TrJZ4n3dqWvyeRFzHWObePh3aon0K+ctd55GB+Od6HdpBRbXW2hZ3OtCXyhXAcXbZt9
         sTvYYJ0InCnZBP/TKpSRox/IfA0M27o7vgd7q0BuwX+Ix6OXwLc3VmumhgY3EMnK26HF
         wGMnWS8FKpuB7RdG/k/RLlsn1loqPJNbYqZqzaK2nzbI0zIMK0M5OkJ1sMuOM1UQrySp
         GtbQ==
X-Gm-Message-State: APzg51CC+ARlsnb38iAcVzENwEMCN/3pKqA/KBxuzD1VQih5mfrjPIIb
        S6q/jV/7HkLupQoIzf2uHzgF+FnZ++s=
X-Google-Smtp-Source: ANB0VdZMIkfLVGIboWiSsMUOEq2fHLrDXCmBt/duzvkJCrmk9ovROtz6SCRBk3i2TxTVfMHcoWd5Lw==
X-Received: by 2002:a81:c85:: with SMTP id 127-v6mr17996000ywm.364.1537464332244;
        Thu, 20 Sep 2018 10:25:32 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id b135-v6sm6493603ywh.24.2018.09.20.10.25.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:25:30 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id l9-v6so4063387ywc.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:25:29 -0700 (PDT)
X-Received: by 2002:a0d:d347:: with SMTP id v68-v6mr1628578ywd.124.1537464329571;
 Thu, 20 Sep 2018 10:25:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 10:25:28
 -0700 (PDT)
In-Reply-To: <5b95b037-521f-3402-2097-c0f9c427d235@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com> <5b95b037-521f-3402-2097-c0f9c427d235@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 10:25:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKUfHAK-cFj0YtqqGXypFGigpWNitVOPJx9SubSbnfkzw@mail.gmail.com>
Message-ID: <CAGXu5jKUfHAK-cFj0YtqqGXypFGigpWNitVOPJx9SubSbnfkzw@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] LSM: Infrastructure management of the file
 security blob
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

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 01a922856eba..62a22ad8ce92 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -361,6 +361,11 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
>         return cred->security;
>  }
>
> +static inline struct smack_known **smack_file(const struct file *file)
> +{
> +       return file->f_security;
> +}
> +

This (and related) still needs splitting out into it's own refactoring
patch for Smack.

-Kees

-- 
Kees Cook
Pixel Security
