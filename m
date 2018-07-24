Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3D8C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2DB20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgYjRhB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2DB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbeGXWy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:54:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46974 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbeGXWy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:54:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so3773467pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=h9xPBgbcxBKIuIGXp43GXGPXYrz8Fz9+SSNnomV7e6o=;
        b=tgYjRhB8B3HzPNiWQXXoa58RBcCNwkT2FkshceeDp+J+fhJALTtgqIDOHgPz9QWhms
         CEfRFFOZB1IZtmt9ZwmgQVu0luAQdF54PLgRSZdY/JiTpqtzSzkqG7hAO5gXTAv6mbZZ
         lqXDgx8s6LtUQilhHPzp7FcLHO4WdbDVIoQMad0Ym8vVEHlUb9WNhpYMKNPZPJ2mTpIs
         wLBwc3I/uOxQswFtVm0ux9+WNjoeHjYwvt4gwLD0MGaY60w5NSHwCH3oqaYwvNpH9YGW
         AYhtB0msQrMrGG7qBdtfqPLcSJ96PEkrsnpvnCJbeuxqEH6zK9lUk2BjGUOa+k/nbbTJ
         JlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=h9xPBgbcxBKIuIGXp43GXGPXYrz8Fz9+SSNnomV7e6o=;
        b=pTFoX/fvk8IWr5eHXCEv4X1fYk/AdQFzE28K6IWyJ2b05RrWcl+OJBws1uj2CML2dJ
         rMSVGHtOGDV9Yj1xdvDA+DXdv/yjyJQAZIzm+K64/5UG1B5RebInAfCWcJXPrs8XFRNR
         06S02iyEkSeSTHtTOh379Lf0B/uKu279+b96AyV8wR/fk4LwToes6P6xzD0LoiMRyzDY
         VssjMD2fZYPRhBeoiEebFRjwhvCxfsBxdLILuFSU2p5JQyWE4FvA6RdkpsZ4embybUM2
         3ZED2nsAVLcwbkbsCQCI8s1Eeqh4OVwDH9IW3f3uUTyqDB3tDLl6aW7nVAafsIqQAqgU
         sMDA==
X-Gm-Message-State: AOUpUlEHc8GMEjBC3YqINimFXFn1qXwHnUBg133ZRfv9M3znhUHHlT5W
        r77JaXN/X8yR0Mn01aIPugGIrQ==
X-Google-Smtp-Source: AAOMgpdSqjECvtr2+RGoWKW8XFSgqluJ1xFawQAnQuo+Dh6OPds2Tiz7R9pNXB9VvVczx1Q78EuuJw==
X-Received: by 2002:a62:5f82:: with SMTP id t124-v6mr19459338pfb.223.1532468759592;
        Tue, 24 Jul 2018 14:45:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id o27-v6sm24678036pfj.35.2018.07.24.14.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 14:45:58 -0700 (PDT)
Date:   Tue, 24 Jul 2018 14:45:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch v4] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <f8d24892-b05e-73a8-36d5-4fe278f84c44@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1807241444370.206335@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com> <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com> <alpine.DEB.2.21.1807201314230.231119@chino.kir.corp.google.com> <ca34b123-5c81-569f-85ea-4851bc569962@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807201505550.38399@chino.kir.corp.google.com>
 <f8d24892-b05e-73a8-36d5-4fe278f84c44@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018, Tetsuo Handa wrote:

> You can't apply "[patch v4] mm, oom: fix unnecessary killing of additional processes"
> because Michal's patch which removes oom_lock serialization was added to -mm tree.
> 

I've rebased the patch to linux-next and posted a v5.

> You might worry about situations where __oom_reap_task_mm() is a no-op.
> But that is not always true. There is no point with emitting
> 
>   pr_info("oom_reaper: unable to reap pid:%d (%s)\n", ...);
>   debug_show_all_locks();
> 
> noise and doing
> 
>   set_bit(MMF_OOM_SKIP, &mm->flags);
> 
> because exit_mmap() will not release oom_lock until __oom_reap_task_mm()
> completes. That is, except extra noise, there is no difference with
> current behavior which sets set_bit(MMF_OOM_SKIP, &mm->flags) after
> returning from __oom_reap_task_mm().
> 

v5 has restructured how exit_mmap() serializes its unmapping with the oom 
reaper.  It sets MMF_OOM_SKIP while holding mm->mmap_sem.
