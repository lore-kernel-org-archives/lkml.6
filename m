Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeEWF5W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:57:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37193 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeEWF5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:57:21 -0400
X-Google-Smtp-Source: AB8JxZrJiCnjjBjo52KSwJswiGX0VT86UsBXY6UF5lnj6ipC998+f9tA83cSjTbr18xLAG/xrY6EHQ==
Date: Wed, 23 May 2018 06:57:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, Shawn Nematbakhsh <shawnn@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] mfd: cros_ec: retry commands when EC is known to be busy
Message-ID: <20180523055717.GR5130@dell>
References: <20180523002310.87011-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523002310.87011-1-briannorris@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018, Brian Norris wrote:

> Commit 001dde9400d5 ("mfd: cros ec: spi: Fix "in progress" error
> signaling") pointed out some bad code, but its analysis and conclusion
> was not 100% correct.
> 
> It *is* correct that we should not propagate result==EC_RES_IN_PROGRESS
> for transport errors, because this has a special meaning -- that we
> should follow up with EC_CMD_GET_COMMS_STATUS until the EC is no longer
> busy. This is definitely the wrong thing for many commands, because
> among other problems, EC_CMD_GET_COMMS_STATUS doesn't actually retrieve
> any RX data from the EC, so commands that expected some data back will
> instead start processing junk.
> 
> For such commands, the right answer is to either propagate the error
> (and return that error to the caller) or resend the original command
> (*not* EC_CMD_GET_COMMS_STATUS).
> 
> Unfortunately, commit 001dde9400d5 forgets a crucial point: that for
> some long-running operations, the EC physically cannot respond to
> commands any more. For example, with EC_CMD_FLASH_ERASE, the EC may be
> re-flashing its own code regions, so it can't respond to SPI interrupts.
> Instead, the EC prepares us ahead of time for being busy for a "long"
> time, and fills its hardware buffer with EC_SPI_PAST_END. Thus, we
> expect to see several "transport" errors (or, messages filled with
> EC_SPI_PAST_END). So we should really translate that to a retryable
> error (-EAGAIN) and continue sending EC_CMD_GET_COMMS_STATUS until we
> get a ready status.
> 
> IOW, it is actually important to treat some of these "junk" values as
> retryable errors.
> 
> Together with commit 001dde9400d5, this resolves bugs like the
> following:
> 
> 1. EC_CMD_FLASH_ERASE now works again (with commit 001dde9400d5, we
>    would abort the first time we saw EC_SPI_PAST_END)
> 2. Before commit 001dde9400d5, transport errors (e.g.,
>    EC_SPI_RX_BAD_DATA) seen in other commands (e.g.,
>    EC_CMD_RTC_GET_VALUE) used to yield junk data in the RX buffer; they
>    will now yield -EAGAIN return values, and tools like 'hwclock' will
>    simply fail instead of retrieving and re-programming undefined time
>    values
> 
> Fixes: 001dde9400d5 ("mfd: cros ec: spi: Fix "in progress" error signaling")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/mfd/cros_ec_spi.c               | 24 ++++++++++++++++++++----
>  drivers/platform/chrome/cros_ec_proto.c |  2 ++
>  2 files changed, 22 insertions(+), 4 deletions(-)

I'm convinced.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
