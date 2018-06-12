Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 051ADC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15DD2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S47XBk7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15DD2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754389AbeFLSoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:44:03 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40045 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbeFLSoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:44:02 -0400
Received: by mail-io0-f194.google.com with SMTP id g22-v6so574067iob.7;
        Tue, 12 Jun 2018 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hE/f9CC42lqo6lUjedluu2b1pGoJAY9adSaQZYALPM=;
        b=S47XBk7Zs2sTxG9WHhDCptwEoMcpKqs+pnrrbZYf7a7mTORMRRwRlIak559a/BX4Tz
         IhpQyXwLeH+1N1bHp7wn64D+3TEQ8nNolyqq83Y5zkwoTC3avNcqw/F3r29CDZil1Yi0
         3uCWsBkW2+WAEfyDtbWnmKBayhEHQ1rKsPrrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hE/f9CC42lqo6lUjedluu2b1pGoJAY9adSaQZYALPM=;
        b=kGNwnF2T1NXAneA8hkXckWNbv6tBfOXevTyj24gqAH8lhFIHpT+213lTpXCz3XGrwG
         WNxUzTKP6Yonj/7paHj5WhzW3A6LIx7ip5ae3m9olAhSw9FiS3mWymi0tItnpzjGlchJ
         cF/fWqLwVKnsTwOeHN+q7mdogeBMKQaodPSx1LaBGzzqHIys3GKvWIHGmZRUNlIeGHhE
         lnQiv57jkw+UwEb0rYZnwxW6eztS2uq1fUW++rKTG/41JEZzwD8USvZXBIK2QGxgYUlG
         y+hYT2t8JbcN+G5PVDdePR3CS61nBHPduR9opVIT8EBJRTBIpxp+qAteAbApBSeUBBok
         UBHA==
X-Gm-Message-State: APt69E2uLRyPJvWSA38qPta8g4YCxQT8zboXwuULdu4YTUA7U8GNmugt
        uFu4o6OYtqiUrRbRB/Xtnov87nBnR3bXfRO7pL0=
X-Google-Smtp-Source: ADUXVKJIkUnp53Mmd5HWX/hInJNgaGVs4QWwmXew0hcBDvPUGAttG+xoPnrkuVqSlUuzumQd28egeAT6JldnaevY/B4=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr1709314ion.259.1528829041160;
 Tue, 12 Jun 2018 11:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 11:43:50 -0700
Message-ID: <CA+55aFxu4pD2Z8VFhojeSczb1Jf7sp9_vETvukAxFpadyj-oqw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:03 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

Grr. Several tedious conflicts. I fixed them all up, and they all
looked trivial, but since most of them were to ARM cases, I couldn't
even test the end result.

I suspect the 'workaround_flags' could be merged into the (now)
allegedly generic 'flags' field in the arm64 kvm_vcpu_arch structure,
but I (obviously) didn't actually do that.

Adding some ARM people to the cc so that somebody on that side checks my merge.

(Still going through my basic build tests, not pushed out yet, but I'm
assuming that will finish cleanly and it should be pushed out soon).

Thanks,

              Linus
