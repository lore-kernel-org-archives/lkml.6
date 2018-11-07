Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E50C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E2A20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fGbnFhnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E2A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeKHCio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:38:44 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45059 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbeKHCio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:38:44 -0500
Received: by mail-lf1-f53.google.com with SMTP id b20so11999585lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2wGHpaAGbQ9nPS12o/O/N2QRdjR9/hk/0enhbzH9b0=;
        b=fGbnFhnhjKlcE0tCGhoh0jGdQq0YiaGIJ3VcVwGmDXSxbozNXe3bwDB6Oe78pBBTRu
         elhlfuDI/7CeZfMHpWFINOvjMj1tRAlMoQE1eCR2VqtNYsTWeYRff2RmxI3w65snFTEs
         XYD9Et73HEtTrhGy+bO/cBZ9YyLX7SHxExt8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2wGHpaAGbQ9nPS12o/O/N2QRdjR9/hk/0enhbzH9b0=;
        b=GhdS/Wa1Wu7MpjqkA2cQMDUu2tZQFE/+bU57KqHwICtEAOLW8W1Fwo31b+uZEF1h++
         nPwpTAfTXsUlnKL3xcqZnAtZnreu015+nJauH/vVoi4N5lWNESd8++DjdbcncRuapJRZ
         OLjrkZYR2ROl9t2FdtIOpMT+BxiKKTAXhPaZq8MHmA/g+CkZ1lKFN6KsSNRob5FgM0qE
         FGb0VREP7tWWU/Ojq8J4PIPFiLbYSEmRpiI5VW6jSiF5zpK7hRu2Z94XDngV4DcS3D+O
         yBSckfFmMqrqngvIaj5lXIf+nLNnLyVAre9j5NN0XkTY4mMDs9pPIRZfUMeoKzsCtc/w
         yr5A==
X-Gm-Message-State: AGRZ1gIuo7XHdREw4+s60jsZEHVUXHtcDjCvAPCllt2z5UEsmFxkSF/v
        vH0T7BCkdBzKgKylzex5UFr/eIJ3YFE=
X-Google-Smtp-Source: AJdET5fbg/TqKAEumug3cIPrTBIC+wBsp6UdQ4vqEY2txBPAqu3UfGiJ+ylASsT9xDufeDKy739htw==
X-Received: by 2002:ac2:4255:: with SMTP id m21-v6mr642759lfl.6.1541610447117;
        Wed, 07 Nov 2018 09:07:27 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u27-v6sm260909lfc.36.2018.11.07.09.07.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:07:26 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id i26so12040136lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:07:26 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr667546lfc.124.1541610445631;
 Wed, 07 Nov 2018 09:07:25 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1811071125360.21975@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1811071125360.21975@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Nov 2018 09:07:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwT+ZUnMy9mogUzbPdc=56_4nurGNf=bETMSxMP0c3Sw@mail.gmail.com>
Message-ID: <CAHk-=whwT+ZUnMy9mogUzbPdc=56_4nurGNf=bETMSxMP0c3Sw@mail.gmail.com>
Subject: Re: [GIT PULL] HID fixes
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 2:31 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> HID subsytem fixes

Pulled,

               Linus
