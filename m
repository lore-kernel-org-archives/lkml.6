Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5DDC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56CA2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="di/cwHL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56CA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeJaGog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:44:36 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44306 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeJaGof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:44:35 -0400
Received: by mail-yw1-f67.google.com with SMTP id k6-v6so1218791ywa.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ga2nEOPvIwUYywBDkqbUH6ZXONUHVEyuPRXON1dMRhU=;
        b=di/cwHL9pCYacoB//i7xbNdx+pPYbkO6HDvO8JJumzfLpm6b8X0NvfVZKx+S7bE3r4
         sFaDN2YmX1tPmyk8jsnoOtBK6N2X+wYLqWUaW0xhkyB8WCk/o5HcGAKxFMWeMbt3RVEx
         TtsxuMtcFc1K15sKIFLoLpQulN5NOpoGRkv8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ga2nEOPvIwUYywBDkqbUH6ZXONUHVEyuPRXON1dMRhU=;
        b=MR4almEP8PYTeSYLentbgrArWdCimC+7sb9BCdGkf+NmE3hxh4E+OShnNMOEPYvWPr
         QtS3EIA1U3lW+Uk9d8V1VUZvU7nIkBFY/xj9xpDQYmF+JM5o2WSprzvh3bPB8fReMo6p
         mricZ6eDs4Co/U7ciFv7XpFTd8JQttiTTyihIlvrbg/Aiwcj4wLSv+Y86JXNyegrGvDz
         7gcj2LVctpqBUJx/QmQX0foyXfPxS1rncekfzNjfjLASCPnLGaZXidXzrBretIQiyPFV
         HurGuKjKiBVRuHV7FZPnIB2K32hpY2sec+qo5L4VHAwWIW6xHaxvHfyLJQI9O3/1zjQt
         COvQ==
X-Gm-Message-State: AGRZ1gJTkTPpif5CcZDJapy04E7dnZ51+bsJfcf23slTfk9Hg3qFR3+T
        SUJwOHIJ8fTBnBQ+EuQ4LNj+wd91s8I=
X-Google-Smtp-Source: AJdET5cqQpMKz+88P//CEPoDqeFv2B7x1XpCR1z0XxHGWacjvY3ZRNCt051ZxQDwvxGpC8/0gIEddA==
X-Received: by 2002:a81:ae42:: with SMTP id g2-v6mr494763ywk.151.1540936164085;
        Tue, 30 Oct 2018 14:49:24 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id q2-v6sm6386353ywa.24.2018.10.30.14.49.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 14:49:22 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id z72-v6so1329136ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:49:22 -0700 (PDT)
X-Received: by 2002:a81:813:: with SMTP id 19-v6mr555686ywi.168.1540936162187;
 Tue, 30 Oct 2018 14:49:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 14:49:21
 -0700 (PDT)
In-Reply-To: <20181029224031.29809-2-tycho@tycho.ws>
References: <20181029224031.29809-1-tycho@tycho.ws> <20181029224031.29809-2-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 14:49:21 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLjum=TDab67L5XdWKEmzU_5rYeLfGXB1vb2BmfZdPuHQ@mail.gmail.com>
Message-ID: <CAGXu5jLjum=TDab67L5XdWKEmzU_5rYeLfGXB1vb2BmfZdPuHQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 3:40 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>     * switch to a flags based future-proofing mechanism for struct
>       seccomp_notif and seccomp_notif_resp, thus avoiding version issues
>       with structure length (Kees)
[...]
>
> +struct seccomp_notif {
> +       __u64 id;
> +       __u32 pid;
> +       __u32 flags;
> +       struct seccomp_data data;
> +};
> +
> +struct seccomp_notif_resp {
> +       __u64 id;
> +       __s64 val;
> +       __s32 error;
> +       __u32 flags;
> +};

Hrm, so, what's the plan for when struct seccomp_data changes size?
I'm realizing that it might be "too late" for userspace to discover
it's running on a newer kernel. i.e. it gets a user notification, and
discovers flags it doesn't know how to handle. Do we actually need
both flags AND a length? Designing UAPI is frustrating! :)

Do we need another ioctl to discover the seccomp_data size maybe?

-- 
Kees Cook
