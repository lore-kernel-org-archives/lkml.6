Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11DDC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0DA20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hCP2agYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0DA20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeLAEvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:51:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34546 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLAEvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:51:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so5724490ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlhVmvBdGtr05Q88cL8EVpjzsGrb6jLqKfldAXckzMI=;
        b=hCP2agYC0uhWJ6vOVOmIVUstwyRmx9LrLEPVpDqozbWYj5NtjF76DPd3yJjJ+/lWyr
         IDLPLbTOLoXdAsSBB6hLpBZGuoO1UxRtyzw6tI0NjWbV1tTa5AbjiwyF7Z4fMQpbgusZ
         4kVBM+zLaioghevSD6u2fJUNYd6v45OJcr5y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlhVmvBdGtr05Q88cL8EVpjzsGrb6jLqKfldAXckzMI=;
        b=QRlCHkUCrcbeejpgRMrLYDUWWk/U7In4q/y6oY0wt+27WQ0hBIR3r5IyvJK9rAdbCQ
         wTwhLFb/BWGG+KRAZGK/jAwyoupBzN+C864JxO9H60spNOB+Bpz8cuaB9uDgVkAeYYeU
         o/88AChmcR2iZbqjSe5Ol1zSuS749ib7n0JB2WS7728qA5q46Thua/Qsb4SLNNiYPUcc
         XqYWwzKomtz1FAeCKNRiSROQvbZy3EoMXOLMeKboBnNTMO7RXxs2dBgGqhBTF3i6k7DO
         3UqSQYWfxBNB0E4uplVvgJp1j2OqXF59ckkaE8Ct6OlY3grr0gaygLOfDmYOp9WGOtFU
         TueQ==
X-Gm-Message-State: AA+aEWYUOZ/VrbFoAuj43kI3NOPjdVqMEO6gqNwfl4I/bfmkOtKRgMSF
        PBVaWRdMyfLnlfQYHqUTtUsVMX5ZgFc=
X-Google-Smtp-Source: AFSGD/WKbLjNBS/LXRNXcEy9OumQPYnaKiuylPQHzzdRSwgITgO/Q8znbnUWNNGRwB1C7n2bHrqlxQ==
X-Received: by 2002:a2e:4819:: with SMTP id v25-v6mr4783256lja.2.1543599678606;
        Fri, 30 Nov 2018 09:41:18 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 12-v6sm888064ljf.96.2018.11.30.09.41.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:41:17 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id u6-v6so5724378ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:41:16 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr4933819ljk.80.1543599676283;
 Fri, 30 Nov 2018 09:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20181130031829.268422593@goodmis.org>
In-Reply-To: <20181130031829.268422593@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Nov 2018 09:41:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVQNNB6XhJQMwyQdc1B5Qh3nMXhixK5uzbdeOOnwOmdw@mail.gmail.com>
Message-ID: <CAHk-=wgVQNNB6XhJQMwyQdc1B5Qh3nMXhixK5uzbdeOOnwOmdw@mail.gmail.com>
Subject: Re: [PATCH 0/2] [GIT PULL] tracing: More fixes for 4.20
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, this is on top of a previous git pull that I have submitted:
>
>   http://lkml.kernel.org/r/20181127224031.76681fe0@vmware.local.home

Hmm.

I had dismissed that, because the patch descriptors for that series
had had "for-next" in them.

    https://lore.kernel.org/lkml/20181122002801.501220343@goodmis.org/

so I dismissed that pull request entirely as being not for this
release entirely.

I went back and merged things, but in general, please try to avoid
confusing me. I'm easily confused when I get mixed messages about the
patches and the pull requests, and will then generally default to
"ignore, this is informational".

                  Linus
