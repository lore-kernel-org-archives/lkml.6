Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeD1Qak (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 12:30:40 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42265 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932552AbeD1Qaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 12:30:39 -0400
X-Google-Smtp-Source: AB8JxZphDggqeJ0Y/aVU1kHwpgN3kazs9TN0YncjoLDHs89MkI8HeVwqBV04L56XijSwlGAfLv0/vyJ3ghEqd/ZWgU0=
MIME-Version: 1.0
In-Reply-To: <20180427130811.7642-1-michel@daenzer.net>
References: <20180426150618.13470-1-michel@daenzer.net> <20180427130811.7642-1-michel@daenzer.net>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Sat, 28 Apr 2018 12:30:37 -0400
X-Google-Sender-Auth: XmJ4I8SqIJyiw5gbIOS13yCxbSU
Message-ID: <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag TTM_PAGE_FLAG_TRANSHUGE
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3SGUkQp005764

On Fri, Apr 27, 2018 at 9:08 AM, Michel Dänzer <michel@daenzer.net> wrote:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> Previously, TTM would always (with CONFIG_TRANSPARENT_HUGEPAGE enabled)
> try to allocate huge pages. However, not all drivers can take advantage
> of huge pages, but they would incur the overhead for allocating and
> freeing them anyway.
>
> Now, drivers which can take advantage of huge pages need to set the new
> flag TTM_PAGE_FLAG_TRANSHUGE to get them. Drivers not setting this flag
> no longer incur any overhead for allocating or freeing huge pages.
>
> v2:
> * Also guard swapping of consecutive pages in ttm_get_pages
> * Reword commit log, hopefully clearer now
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>

Both I and lots of other people, based on reports, are still seeing
plenty of issues with this as late as 4.16.4. Admittedly I'm on
nouveau, but others have reported issues with radeon/amdgpu as well.
It's been going on since the feature was merged in v4.15, with what
seems like little investigation from the authors introducing the
feature.

We now have *two* broken releases, v4.15 and v4.16 (anything that
spews error messages and stack traces ad-infinitum in dmesg is, by
definition, broken). You're putting this behind a flag now (finally),
but should it be enabled anywhere? Why is it being flipped on for
amdgpu by default, despite the still-existing problems?

Reverting this feature without just resetting back to the code in
v4.14 is painful, but why make Joe User suffer by enabling it while
you're still working out the kinks?

  -ilia
