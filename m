Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFA9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B4320659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zf5d5UwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B4320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbeK1EW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:22:28 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39038 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1EW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:22:28 -0500
Received: by mail-yw1-f65.google.com with SMTP id j6so3187919ywj.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n6seMOKNWMGgqtLXOXURwjfPrXhhZrHzuJwTTcAOgt8=;
        b=Zf5d5UwL3dzzZKGSxK0dPXmc3XILwkkUbG7PD1jnSmDhy/VHV1idkwhRgQiOH0meZC
         zLVR+YvGUx0vVNTN070bbXp/lweH+fJiWkV0TO1nH+9pOxtbotoEZEG9cXn4zNYBFxK8
         LJehoZ2nN/2ewpkNBM8DP2k/EdqI8nOk5iZng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n6seMOKNWMGgqtLXOXURwjfPrXhhZrHzuJwTTcAOgt8=;
        b=kEXHTbyvdVwvfVaQaetmCGzQoC8byKQR8rmejWHQilH+/IGd5QrmcaNai0g4ercCX7
         rVSkFudg+tIOW3Aj+dYI09+po7oHVzJg6ZhVMA29/UTFKe2KmqGHtZS5azLe2LyJiG16
         y94dQFEX93qWlWTrH+thJM5T9WF2yw1WhOJllcNnGUjGkaGbpW6bvPideQ1OnaVa6Bx4
         csKHcq6/amfe/INxmrsVX7foREljSH5mPQObRLmbTDiQyoy6xuHDkQt6MG2ys26snBZi
         BrcA916Cdo8e6j3XWHjgqF3DjxhD79/eeoiMJwN2EV68W19eTcHCI43H0OKbBo+SATNV
         9klQ==
X-Gm-Message-State: AGRZ1gLZX3Oc00O0COBodn/AqSRkKcpHIGxZCYcrndlCXGmUyqowFAfc
        SHFJ+dxPGiMUScVFdSfN4udSnlKKO90=
X-Google-Smtp-Source: AJdET5dq9qivY+Uq6vRG3Vwi0749/wo5P4yLOHBmHI/cMFSf7UFdjKcOYJw7GyH+pHT7cnOzPkagtA==
X-Received: by 2002:a81:a988:: with SMTP id g130mr34077030ywh.307.1543339431761;
        Tue, 27 Nov 2018 09:23:51 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id u81sm1590818ywf.6.2018.11.27.09.23.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:23:50 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id t13-v6so9381651ybb.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:23:50 -0800 (PST)
X-Received: by 2002:a25:2349:: with SMTP id j70-v6mr33856568ybj.137.1543339430107;
 Tue, 27 Nov 2018 09:23:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 09:23:49
 -0800 (PST)
In-Reply-To: <abf0f0ec-15c5-59eb-8657-e1e0e1f396b6@linux.intel.com>
References: <feac7efa-df6f-cca1-e321-28d220bf0411@linux.intel.com> <abf0f0ec-15c5-59eb-8657-e1e0e1f396b6@linux.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 09:23:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJWTyEzXODmeKkko5A212TAe1KSWGuONRvF7Tt+RY+5Sw@mail.gmail.com>
Message-ID: <CAGXu5jJWTyEzXODmeKkko5A212TAe1KSWGuONRvF7Tt+RY+5Sw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Documentation/admin-guide: update admin-guide index.rst
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jonatan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:16 AM, Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
> Extend index.rst index file at admin-guide root directory with
> the reference to perf-security.rst file being introduced.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  Documentation/admin-guide/index.rst | 1 +
>  1 file changed, 1 insertion(+)

Seems like this could just be folded into patch 1? I'm not sure Jon's
preference here, though.

-Kees

>
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 965745d5fb9a..0a491676685e 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -76,6 +76,7 @@ configure specific aspects of kernel behavior to your liking.
>     thunderbolt
>     LSM/index
>     mm/index
> +   perf-security
>
>  .. only::  subproject and html



-- 
Kees Cook
