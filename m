Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755712AbeEAAMB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 20:12:01 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34725 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753842AbeEAAL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 20:11:59 -0400
X-Google-Smtp-Source: AB8JxZrULXy5FgMKR96PRrnSwvTYaEUEEIfKg0kw+bhZ4cOkmVQMLgcahguZ+ah0BS9EpHqW0C6me6ccUXn+UDwtDMs=
MIME-Version: 1.0
In-Reply-To: <20180430235927.28712-1-eric@anholt.net>
References: <20180430235927.28712-1-eric@anholt.net>
From: Stefan Schake <stschake@gmail.com>
Date: Tue, 1 May 2018 02:11:37 +0200
Message-ID: <CAOZHkRyboQ2uPmv6EXZSnKFLEchBavRYy1jAzm6VzxfqSEgQkw@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: Add a pad field to align drm_vc4_submit_cl to 64 bits.
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 1:59 AM, Eric Anholt <eric@anholt.net> wrote:
> I had originally asked Stefan Schake to drop the pad field from the
> syncobj changes that just landed, because I couldn't come up with a
> reason to align to 64 bits.
>
> Talking with Dave Airlie about the new v3d driver's submit ioctl, we
> came up with a reason: sizeof() on 64-bit platforms may align to 64
> bits, in which case the userspace will be submitting the aligned size
> and the final 32 bits won't be zero-padded by the kernel.  If
> userspace doesn't zero-fill, then a future ABI change adding a 32-bit
> field at the end could potentially cause the kernel to read undefined
> data from old userspace (our userspace happens to use structure
> initialization that zero-fills, but as a general rule we try not to
> rely on that in the kernel).
>

Did a quick sizeof check on arm64 and that indeed came to 176 mod 8 = 0,
suggesting we need this additional pad. So fwiw

Reviewed-by: Stefan Schake <stschake@gmail.com>

Thanks,
Stefan
