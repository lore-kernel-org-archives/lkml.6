Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD34520645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jvL/MEZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD34520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeIJVk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:40:29 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35530 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeIJVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:40:29 -0400
Received: by mail-yw1-f67.google.com with SMTP id 14-v6so8103059ywe.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5gl8S2SFTL6n4o9Xj/4fhC7NAYtay9ykmr+LRqQ8NWQ=;
        b=jvL/MEZBmlXjx9+9OmRmHQHD65fdsANA0AR41O+OiWPYA5H5hO3mqbDN17swBIvs0w
         ehEhLJLjfmeHlq0T/KesvcniSVH9XgKgm/ZwRrSyafSOilDJQAr8jW7w7anyLEi0FKFM
         +Z+Pzicie8QtdwKJA5few0DhzlzFTKG306e/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5gl8S2SFTL6n4o9Xj/4fhC7NAYtay9ykmr+LRqQ8NWQ=;
        b=b6JgbEwjQgL+k3XXiptlZ+rRCZjFE5qcm2iNb6zuEY4B+nv3/m3KVHdfEwm4CxwejA
         WJHGKgKNhAVizOhLA9FMaE68giZUf7Bn8lsiMSoBqQIGGCbSZWR+SXOGU6+0QdoY9bwM
         tdi5bs8GuUvh5xmpOqN3i+rcbGxJzCgCkVvfDogZZT0BtbeoJvwg7oLd6aakfLpaJVEo
         9PtC2PKFSfxbs0WUZMSgK15hCY5rBvUHX6py8bcnGc1+qho+a/89yMn8jgbbZrq+ZHYz
         59HW4LQeUxtAVMFjXlWkluiVS03y6IXeEwibep1tbcAfuNR8vSYo8KJpsEUmAxlFeJ0c
         q7iw==
X-Gm-Message-State: APzg51AkiB4ILS3CHTIFzOgO1/znR9DAWUYbHOxahUFfm9EmNXohBpPK
        7xzo6wUMyIHocIc6n0cXH/sSeqSBZV8=
X-Google-Smtp-Source: ANB0VdYZHcd1nm0gWYfGXBF4hPbeHW8d1rgbXDcf76IGDRPwBfbHRc/pc5shGuupqnZQIn1/zTWkFA==
X-Received: by 2002:a0d:f384:: with SMTP id c126-v6mr10524326ywf.10.1536597931778;
        Mon, 10 Sep 2018 09:45:31 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id c69-v6sm6444146ywb.11.2018.09.10.09.45.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 09:45:30 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id y20-v6so8187989ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:45:29 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr10582594ybz.410.1536597929409;
 Mon, 10 Sep 2018 09:45:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 09:45:28
 -0700 (PDT)
In-Reply-To: <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
References: <20180910122907.GA23963@redhat.com> <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Sep 2018 09:45:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ+aiJWL0G0Zpq2Df4ADEmpSBZHSTaUkzJiNbgg+B6x2Q@mail.gmail.com>
Message-ID: <CAGXu5jJ+aiJWL0G0Zpq2Df4ADEmpSBZHSTaUkzJiNbgg+B6x2Q@mail.gmail.com>
Subject: Re: get_arg_page() && ptr_size accounting
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 9:41 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Sep 10, 2018 at 5:29 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> Hi Kees,
>>
>> I was thinking about backporting the commit 98da7d08850fb8bde
>> ("fs/exec.c: account for argv/envp pointers"), but I am not sure
>> I understand it...

BTW, if you backport that, please get the rest associated with the
various Stack Clash related weaknesses:

c31dbb146dd4 exec: pin stack limit during exec
b83838313386 exec: introduce finalize_exec() before start_thread()
8f2af155b513 exec: pass stack rlimit into mm layout functions
7bd698b3c04e exec: Set file unwritable before LSM check
e816c201aed5 exec: Weaken dumpability for secureexec
779f4e1c6c7c Revert "exec: avoid RLIMIT_STACK races with prlimit()"
04e35f4495dd exec: avoid RLIMIT_STACK races with prlimit()
fe8993b3a05c exec: Consolidate pdeath_signal clearing
64701dee4178 exec: Use sane stack rlimit under secureexec
473d89639db0 exec: Consolidate dumpability logic
a70423dfbc58 exec: Use secureexec for clearing pdeath_signal
e37fdb785a5f exec: Use secureexec for setting dumpability
2af622802696 LSM: drop bprm_secureexec hook
46d98eb4e1d2 commoncap: Refactor to remove bprm_secureexec hook
c425e189ffd7 binfmt: Introduce secureexec flag
a9208e42ba99 exec: Correct comments about "point of no return"
ddb4a1442def exec: Rename bprm->cred_prepared to called_set_creds
da029c11e6b1 exec: Limit arg stack to at most 75% of _STK_LIM
98da7d08850f fs/exec.c: account for argv/envp pointers

(and there may be more related to the secureexec changes)

-Kees

-- 
Kees Cook
Pixel Security
