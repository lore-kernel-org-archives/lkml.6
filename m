Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8446C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBE521529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uzo9itDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBE521529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeITX3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:29:16 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:35456 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeITX3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:29:16 -0400
Received: by mail-yb1-f181.google.com with SMTP id o63-v6so4283023yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pf58AIJO3iGyQATpFfAX8RdRedlGHKSV7nvn3wrpXM8=;
        b=Uzo9itDIpNdH7mgbBWAf7ppl+dLOjdlLOAgLkErrOIzCW9F4PBeDtqwW9U9KS10xrK
         b/AbISb7gA0Zz/Fsn6XDK0tiWatWLlcF5KfUygUII+Dv9yws6iNv1jnBpIKzTqbAil6E
         pVQPZ0MvW5zDdeiL9pleMJDJSbLqJoNiJFBV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pf58AIJO3iGyQATpFfAX8RdRedlGHKSV7nvn3wrpXM8=;
        b=f7Jj3mFcvJQZEgIB8fywubBW7KOvmAPKBQsvTTVWCfHxEsEANMtbSlBbFdcgj6Z9MS
         MLm+zF+1fBYLjSIIngw75hoy8TZLBFWvmxNvQZBpKedR0UHORRjoMGbeSHVtR+miXT8S
         JwxCB49YD0kXlvSciE+L+sAt8ppU6/6vU1BdjS9mHPJJGr2PSbMe3bzoVEKAlflOP0al
         cEfBbS/azFsU+v3zIkr6gpZR2HhZmFBWHsiXDgLjFPt3PHycxW8m4dOH5D6qddxt1jnP
         UQeDFIw8q+R6DHJ5fuAirX+nktocrEMP1JqhY15MBJD0UcvVkrC1xRiBwbrH2mmNxHpv
         nygA==
X-Gm-Message-State: APzg51AEOT6P0gN6zHd7CK8387lBR87AnSMLDVAcwM0woqGiLFe1qcNk
        T9L64JUh07n3k0pMuKfraud0/8pblpw=
X-Google-Smtp-Source: ANB0VdbJRNT3ulNcsSXMd5Dnw/XrQ2Qzdp6qnRrB8O+hlpNNSQoiLKwMfSomZ21IPkMcR3bUPAq2Zw==
X-Received: by 2002:a25:4fd6:: with SMTP id d205-v6mr8629640ybb.426.1537465478900;
        Thu, 20 Sep 2018 10:44:38 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id f82-v6sm4958212ywf.58.2018.09.20.10.44.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:44:37 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id w7-v6so4273762ybm.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:44:37 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr18067635ybg.171.1537465476998;
 Thu, 20 Sep 2018 10:44:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 10:44:36
 -0700 (PDT)
In-Reply-To: <b977e081-4402-f31d-e219-f9716ea7a83b@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com> <b977e081-4402-f31d-e219-f9716ea7a83b@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 10:44:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJRQzWF=C_kmOpZ8XcUzAhkoZnNi7a7KzEHJtFhMNd+3Q@mail.gmail.com>
Message-ID: <CAGXu5jJRQzWF=C_kmOpZ8XcUzAhkoZnNi7a7KzEHJtFhMNd+3Q@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] LSM: Infrastructure management of the ipc
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
> LSM: Infrastructure management of the ipc security blob
>
> Move management of the kern_ipc_perm->security and
> msg_msg->security blobs out of the individual security
> modules and into the security infrastructure. Instead
> of allocating the blobs from within the modules the modules
> tell the infrastructure how much space is required, and
> the space is allocated there.

Maybe split this up too? (SELinux and Smack need tweaks?)

-Kees

-- 
Kees Cook
Pixel Security
