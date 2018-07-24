Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C3CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1998620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sis/4XH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1998620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeGXSlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:41:39 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38476 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbeGXSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:41:38 -0400
Received: by mail-io0-f194.google.com with SMTP id v26-v6so4093803iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upOJO3BLOmG4LVjRJ/v80tcHTlYkB1OVWAohGSMHlDI=;
        b=Sis/4XH+v2ps76g/cmr/5upvNRzHRrioMJtff7fsiJevDshRsfG8N9wN4WPggtXfor
         Zf9vVwONGQvHGXNjVegpRpvMDBiQ65Q5dKJTz7zxxP5rfuU3gB7AnGxG2SKqB32QhdzB
         5hRS0pB7NR3BtqNyX+6BIF+lEe8iCCaXGTAOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upOJO3BLOmG4LVjRJ/v80tcHTlYkB1OVWAohGSMHlDI=;
        b=kbC3z6HkzGR7N1HCs55A82FcKM+7VElZyMhycQBmun3clcS2UlYJ0QqJsLl/G1PbJ/
         e3SW+jwLlc4784gdsxf1hC39KuZGWTv7ZVCWBnvXFNMX87YBx3kNaCe4w/sUWCifnN7J
         m+vbw5IcqJyWppGZx5klEQQP5GPmMyQFUV/gvpjxzy6YK+oG8y7eXHX5CUIaeWlUhwTi
         uaYJymuIuxiQir0xUMt+Xfjm4aMhRihkYBgI/8udDzLRIYgRonrLvv5l2yka1BXxQoIW
         wuR0L4vlhQbTzWuKpUFs5OygQ6YQvfpAAFdgkeBXMZF0k+Qz8Rr1XHZWpcRtoHWceymv
         TE0w==
X-Gm-Message-State: AOUpUlE6VOGQkcnuT4jlAaCPa2isi0nXPkp1/PImWzBOdd/C0ZDDYp7f
        j4HhvNybqLjTrQbMuBdXuUQ8KfmOP0vxBGDfQZM=
X-Google-Smtp-Source: AAOMgpfZDe1/yuLe9IXV4Yd/mfbjVPcbKddiMVfiVP4Nt7MfdMc8VcEhOs59PcNeJMVrWYWf9D0JNM48tFBnFf4mo1s=
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr14930900ioh.259.1532453645906;
 Tue, 24 Jul 2018 10:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 10:33:55 -0700
Message-ID: <CA+55aFwwY0UUYtyohfd-fnhpd=G3EYTtirfmQHXJ3n7C_PCSJA@mail.gmail.com>
Subject: Re: [PATCHv3 0/3] Fix crash due to vma_is_anonymous() false-positives
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 5:11 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Fix crash found by syzkaller.
>
> Build on top of Linus' changes in 4.18-rc6.
>
> Andrew, could you please drop mm-drop-unneeded-vm_ops-checks-v2.patch for
> now. Infiniband drivers have to be fixed first.

Ack, these look good to me.

We still need to have the rdma people fix up their vma mis-use, but
that's a related, but independent issue.

             Linus
