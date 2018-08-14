Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD52FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536D121566
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AS9eKduj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536D121566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeHOAdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:33:10 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52715 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeHOAdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:33:10 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so20532449itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RmjQ/2qzSuvx+SMsiCfaW4PSgcMFfcqEl0j5eat9Pw=;
        b=AS9eKdujgPZjTuxwwF1u1XmBh2NCdxxf/xL7W9a1TOkGQFudAZQlL3YmHziwqTE36w
         QlVys5qOdNkQfSea6beMA/OZBPvp4fLT6RMusXRPTUsJGeskQO3vTmSxN828IOWf+1rN
         NI0AlIQTEuT6s6cwg4eM/2sNVxok7XrTXTWo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RmjQ/2qzSuvx+SMsiCfaW4PSgcMFfcqEl0j5eat9Pw=;
        b=Nq92QNcLl+YyJZZeGiTKS3IiIc/XH+xLL3rHQHzbTV2+KZs75ESQaqjfIeAmMhwX4C
         gC3SH1bvHWrXlSoxARTv3prkSanSBt5E9c6VAnYTiaFPK0NoLWqPyH5BU045Gl733NJT
         EksaU9XsBf4hG84tbBSqfM4baTUc3De3mEjXyt+QgMr2ONZ1mTozXICB0s0s3E0eZAGj
         FHAmBtdfyEHlkpeNz00t0j30eIDmM0f/KkX6EagJmtqcVSv9mEjEuWPzKnOkLuT8vR+K
         xjpiJXHMa0fnaTO2sipu1ol6hs9b6ak3UrVipHAGDqb/LREFbvNt/YNgsyT3GhhMLymA
         o22A==
X-Gm-Message-State: AOUpUlGO+29fnp34BVIx31mxRSwGbIAiaEbejCVtTwfU/AeYi8s7Qzm/
        eUbcCLoUhjMJrPVogr7CER85VZcopf0/hS8lWmc=
X-Google-Smtp-Source: AA+uWPy6HV4VxcgA7QC4duVKhkRLQWro0C53SEuBLkQd0VNKSiATM5ZmMp+v2ZG395tW54InfwYeM5Pur4s850MS8OE=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr21088136jaf.70.1534283041452;
 Tue, 14 Aug 2018 14:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180814212600.19132-1-abelvesa@linux.com>
In-Reply-To: <20180814212600.19132-1-abelvesa@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 14:43:50 -0700
Message-ID: <CA+55aFws9DndTy4L_eaCWu4T0w1NBr+FDrS72GE_aG8++9s=4w@mail.gmail.com>
Subject: Re: [PATCH] cpu/hotplug: Non-SMP machines do not make use of booted_once
To:     abelvesa@linux.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        brendan.jackman@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 2:26 PM Abel Vesa <abelvesa@linux.com> wrote:
>
> Following commit breaks the non-SMP builds.

Thanks, we obviously don't do a lot of coverage of UP any more.

I'm not sure if we should just move the bool's to be bitfields and
make them all available unconditionally, because the #ifdef in code
annoys me.

I'll think about it. The x86 maintainers are all on vacation this
week, and I don't want to disturb them, so I'll fix it one way or
another.

             Linus
