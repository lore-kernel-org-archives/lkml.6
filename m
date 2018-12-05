Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04C4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4CD20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KfM172NH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4CD20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeLEXbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:31:05 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39496 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEXbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:31:04 -0500
Received: by mail-yb1-f196.google.com with SMTP id s15so1148692ybk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWBMd7ioReXxeA3Hvcp5KwsvSijs7NahEDw+ApUV5tk=;
        b=KfM172NHyWJ6CycMcxjr1TVJ2Yq4Y48bf8SFUCu+vsv7g4V4eLGp1HapErB8/fq1/M
         54TxQyJVHknxIAJIE1F+QhH7PUBYALV5zyP8vCVFLkekIeiHNEgdpTLa8G5X93JsSgbC
         ps3fR4I272ZnZWS/glm4WNJqpVuLnfWEXt/s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWBMd7ioReXxeA3Hvcp5KwsvSijs7NahEDw+ApUV5tk=;
        b=dXWoeGcuZkythesfRlAjOh/aApE78h7Kp/4D6G6ZY1odcwixKq0lHZ98223Ii7DR5j
         EFxYzVN/9GIqn5We0Tl/P0oYGcPPapIq2FxfIEjbLvrgrjVb+dsKF0y8yL45TUYykMS1
         njrz5PdXRt1kinIsjFbvQruM8S5MsT1MlbNgnn4w93F9u1pVqMoid2TpBTO0yzDj9o73
         ZVLUK0mjhqH6lAn0We0r/HQ469762Cbx4RHeCEkXAJTy/IFcGvmcJQi8BReva4fhMmlw
         /jUMx1KnhV0k/sU1UCHKjeeXWu5DUioPR2usTvyxl+unxIoCc0xhmgE6pGu0sZr1PGzO
         ywhA==
X-Gm-Message-State: AA+aEWZpc+8Zzt/2UgBR1aAkg+DY86uhf1t/zHc8q5kAvK4OS3lPd7+h
        EwzKDGrgZIzHo4B2QvQXV2AOGkqOOuo=
X-Google-Smtp-Source: AFSGD/UssQOvr5C5QlHZrNDy0f/jlNvmAGy5rJkuygW4RSYM9O2cmbQms9XYr0LAF0PYuhiy+NPSeg==
X-Received: by 2002:a0d:e0c5:: with SMTP id j188mr27317201ywe.164.1544052663309;
        Wed, 05 Dec 2018 15:31:03 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id p71sm2607591ywg.98.2018.12.05.15.31.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:31:01 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id w203so5823443ybg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:31:01 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr17002397ybj.137.1544052660676;
 Wed, 05 Dec 2018 15:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20181130191456.GX18410@garbanzo.do-not-panic.com>
 <201812031312398404610@zte.com.cn> <20181203201436.GO28501@garbanzo.do-not-panic.com>
In-Reply-To: <20181203201436.GO28501@garbanzo.do-not-panic.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 15:30:48 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL9MPN1+wWxj9uFK=bG-KzhmOGFLYmyyrEGqs4f=k-u_w@mail.gmail.com>
Message-ID: <CAGXu5jL9MPN1+wWxj9uFK=bG-KzhmOGFLYmyyrEGqs4f=k-u_w@mail.gmail.com>
Subject: Re: Re: [PATCH] proc/sysctl: fix return error for proc_doulongvec_minmax
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>, cheng.lin130@zte.com.cn
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        zhong.weidong@zte.com.cn, wang.yi59@zte.com.cn,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 12:14 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> Since this worked before I do agree that we need to keep it working now,
> and I can't think of an issue with returning 0 now. Since this is about
> semantics though I'd like a bit more review from at last one more
> person.
>
> Kees, Eric, Andrew?

This is a weird one: it would return an error _AND_ still perform the
write. :( I think this patch is right, and I struggle to imagine a
case where removing the failure is a problem.

A quick question, though, do we want to instead do the reverse? (Not
update, and keep the error?) Are there any examples of doing partial
writes like this in real software?

The proposed change is the safest change, though...

-- 
Kees Cook
