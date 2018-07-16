Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBEAECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249642084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WarqWsWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249642084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeGPRSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:18:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45692 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbeGPRSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:18:54 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so38435261ioh.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ugd6oiEPP4zlWxc4yp1ZLyQ7+3nXKDxgaj1LhhHfpVw=;
        b=WarqWsWXiMs7nggkYjYtUT8AEkKDCSddkKQDynjcdoX+lShc+vmHcfDtQnv7dp21cc
         ft2eEBTVqgpQOu/DMxLjF36KRb96AajQkQ8YaVRT4hZ9wmjDcBf5+a5EhaSPvlI4DAWI
         rIhK4THSBMxHpsJppxRMxPYujYAuem+wprjE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ugd6oiEPP4zlWxc4yp1ZLyQ7+3nXKDxgaj1LhhHfpVw=;
        b=qCQJVjrGU6Rqul24YaLLtMHTQdTpmB9eSXYjoKGz1rNhYFtekpShjbaS/3W/RvIzZz
         N7iNrFmL82UjjKEQQlY9mSchvzhqIaYbEe5wb0v5sojkfVew/GHT9oXRhMBXoeOGQhg1
         JhOURFLK+7XvpPgjxzdKnJgo63Xq4cLh7pjQh5cR37mdfSVjz08sPENnWeDzojB6TZ1/
         fPRNV5JUSacDaPmCSwLYdlSnk2AMrrDsoNxMRtIXw1wFtpGLv0uA3vYxZVoXRluqcJAb
         P0wYYXV7veiuQ7eiCqbjR1X/yneiG+5dQV3/kL/Q+yBr1UVGUa0V4X284DZqsiU46OTH
         mvhA==
X-Gm-Message-State: APt69E3IcUMLE7BJLy4kDHiu/ydR97+F0uY6M87IZT5TQNThUIjMdbL/
        wfU8cofYYFWTLgRgcTUPo9uIwSle2nqtScMYn04=
X-Google-Smtp-Source: AAOMgpcJfHURj+6MWIuXViYKX0jm/tRAQRVx30xnHPQ6JMUV6atJc6se8dX/orVOAQGcQVLPs3NRxveRB+4yL8duvq0=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr42670099iov.203.1531759839286;
 Mon, 16 Jul 2018 09:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <877em2jxyr.fsf_-_@xmission.com> <20180711024459.10654-9-ebiederm@xmission.com>
 <20180716145540.GA20960@redhat.com> <87lgabrzfd.fsf@xmission.com>
In-Reply-To: <87lgabrzfd.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jul 2018 09:50:28 -0700
Message-ID: <CA+55aFxNMPgg3Y7m8hCjtaFVERPL6LaXPKcbBmz-6C=8_FMpKg@mail.gmail.com>
Subject: Re: [RFC][PATCH 09/11] tty_io: Use do_send_sig_info in __do_SACK to
 forcibly kill tasks
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 8:08 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The change for global init is it will now die if init is a member of the
> session or init is using this tty as it's controlling tty.
>
> Semantically killing init with SAK is completely appropriate.

No.

Semtnaitcally killing init is completely wrong. Because it will kill
the whole system.

And I don't mean that in "now init won't spawn new things". I mean
that in "now we don't have a child reaper any more, and the system
will be dead because we'll panic on exit".

So it's not about the controlling tty, it's about fundamental kernel
internal consistency guarantees.

See

        write_unlock_irq(&tasklist_lock);
        if (unlikely(pid_ns == &init_pid_ns)) {
                panic("Attempted to kill init! exitcode=0x%08x\n",
                        father->signal->group_exit_code ?: father->exit_code);
        }

in kernel/exit.c.

               Linus
