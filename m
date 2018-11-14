Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABA8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAA5223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lXC4hyFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAA5223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbeKNRQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:16:59 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43618 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeKNRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:16:59 -0500
Received: by mail-yb1-f196.google.com with SMTP id h187-v6so6488180ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 23:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wPjb/UR7FlDOT00jp+fErJWlWJ0z5jyUaXY8yBceoUE=;
        b=lXC4hyFYIlM3Ixy3yyYJj11dLExv/UFlpmgy67NyccXioMY2Fv2OJkKJKuQWPcorpf
         EV6oDei6XbNUZYsbCOUS3MOwJnsV6t99KV612IUo9oW5iA+7sk8lcsh6egnZozZn44uO
         bwBqyGRAsGzUVLyABDpiMK2kPGy9xe3NdpVkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wPjb/UR7FlDOT00jp+fErJWlWJ0z5jyUaXY8yBceoUE=;
        b=JTqhxXSCFvhZLCnS4x5+63hkF/GqJTK9QEh8M1/WMKG7TVVqTxcFeysRk6ROxkA5rT
         ZKss5W2yiaL33nsh55GD0yl0EU376NAe3qBcGV99gI85oiemPCMqUwsL9S+j9pcS9hYV
         phuiriIP/+tU0xpFZR6bSCKkrmwdrj9xADlh2/HaZN2gVzkXl8pFH6VZbHC7zzRqpIXt
         Xiri0mprl628EvW96bwlz6FAC8bJRPHAlIOd8ARcWD6z0ZJ1VZ1nKimZynhpxZqrmCht
         cdo6aMFAD8Y3Q47rFP5CfYgr3bbzyKrMhCrJNFM8h3kkT2HctjMAlgrJ3YUZdOpR6cEJ
         Dz2Q==
X-Gm-Message-State: AGRZ1gLpi+vQfYJvG5NAaWgYLAn42El/UXmM8jsXWW4gt3S6xPfdY7Eb
        XAbHiw8f97pjl33FNr8x1y02W5NAq9A=
X-Google-Smtp-Source: AJdET5d4AX1EY9y4h6n3FSjuBFtg2r+moDlpltC4qfOVj1oEp3+cOfqkE2M58K+TOxeyZZL+xlKlIQ==
X-Received: by 2002:a25:be4e:: with SMTP id d14-v6mr561109ybm.321.1542179700128;
        Tue, 13 Nov 2018 23:15:00 -0800 (PST)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id g12-v6sm5872996ywe.59.2018.11.13.23.14.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 23:14:58 -0800 (PST)
Received: by mail-yw1-f43.google.com with SMTP id z72-v6so6932052ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 23:14:58 -0800 (PST)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr595123ywd.124.1542179697888;
 Tue, 13 Nov 2018 23:14:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 13 Nov 2018 23:14:57
 -0800 (PST)
In-Reply-To: <20181103233818.44615-1-joel@joelfernandes.org>
References: <20181103233818.44615-1-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 14 Nov 2018 01:14:57 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJ3s=pXGaEVLycdV6TYScUmPqhChNBS92j2qUxct2+ZrQ@mail.gmail.com>
Message-ID: <CAGXu5jJ3s=pXGaEVLycdV6TYScUmPqhChNBS92j2qUxct2+ZrQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/3] cleanups for pstore and ramoops
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 6:38 PM, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> Here are some simple cleanups and fixes for ramoops in pstore. Let me know
> what you think, thanks.

I took these and slightly tweaked code locations for the first one.
I'll send out the series for review when I'm back from Plumber's.

-Kees

>
> Joel Fernandes (Google) (3):
> pstore: map pstore types to names
> pstore: simplify ramoops_get_next_prz arguments
> pstore: donot treat empty buffers as valid
>
> fs/pstore/inode.c          | 53 +++++---------------------------------
> fs/pstore/ram.c            | 52 +++++++++++++++----------------------
> fs/pstore/ram_core.c       |  2 +-
> include/linux/pstore.h     | 37 ++++++++++++++++++++++++++
> include/linux/pstore_ram.h |  2 ++
> 5 files changed, 67 insertions(+), 79 deletions(-)
>
> --
> 2.19.1.930.g4563a0d9d0-goog
>



-- 
Kees Cook
