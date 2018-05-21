Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeEUJEE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:04:04 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:44843 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeEUJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:04:03 -0400
X-Google-Smtp-Source: AB8JxZqatuULbi1Z1xew1bymCaa6EC+YZxTULqseg8FhfGV5DjqOJ6uo9oCUaDvSNhMfsIZ/j90IsQ==
Date: Mon, 21 May 2018 17:03:51 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>
Cc: John Stultz <john.stultz@linaro.org>, Ryan Grachek <ryan@edited.us>,
        Arnd Bergmann <arnd@arndb.de>, Guodong Xu <guodong.xu@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: REGRESSION: HiKey eMMC corruption
Message-ID: <20180521090351.GA1266@leoy-ThinkPad-X240s>
References: <CALAqxLX5qPq_5CQwubzk5hiL3kkes7nK9NGqtnyddXKfyaJKTg@mail.gmail.com>
 <5B02847C.3000102@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B02847C.3000102@hisilicon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei, John,

On Mon, May 21, 2018 at 09:34:04AM +0100, Wei Xu wrote:
> Hi John,
> 
> On 2018/5/18 23:59, John Stultz wrote:
> > The last few months have been busy and I've not been ontop of my
> > upstream testing as well as I'd like, but today I did manage to chase
> > down an issue I've been seeing since 4.17-rc1 on the HiKey board,
> > which was causing emmc corruption and stopping the board from booting.
> > 
> > Symptoms usually looked like:
> > [    1.690448] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
> > req 400000Hz, actual 400000HZ div = 31)
> > ...
> > [    1.777288] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
> > req 150000000Hz, actual 148800000HZ div = 0)
> > [    1.777760] mmc0: new HS200 MMC card at address 0001
> > ...
> > [   12.214381] dwmmc_k3 f723d000.dwmmc0: Unexpected command timeout, state 3
> > [   12.457420] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
> > req 400000Hz, actual 400000HZ div = 31)
> > [   12.536676] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
> > req 150000000Hz, actual 148800000HZ div = 0)
> > [   12.616827] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
> > req 400000Hz, actual 400000HZ div = 31)
> > [   12.695742] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
> > req 150000000Hz, actual 148800000HZ div = 0)
> > [   12.772067] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
> > req 400000Hz, actual 400000HZ div = 31)
> > [   12.850429] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
> > req 150000000Hz, actual 148800000HZ div = 0)
> > [   12.863384] print_req_error: I/O error, dev mmcblk0, sector 8810504
> > [   12.869778] Aborting journal on device mmcblk0p10-8.
> > [   12.887900] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
> > req 400000Hz, actual 400000HZ div = 31)
> > [   12.967509] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
> > req 150000000Hz, actual 148800000HZ div = 0)
> > [   13.130182] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
> > req 400000Hz, actual 400000HZ div = 31)
> > [   13.209438] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
> > req 150000000Hz, actual 148800000HZ div = 0)
> > [   13.302085] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
> > req 400000Hz, actual 400000HZ div = 31)
> > [   13.380462] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
> > req 150000000Hz, actual 148800000HZ div = 0)
> > [   13.494539] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
> > req 400000Hz, actual 400000HZ div = 31)
> > [   13.571420] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
> > req 150000000Hz, actual 148800000HZ div = 0)
> > [   13.640817] EXT4-fs error (device mmcblk0p10):
> > ext4_journal_check_start:61: Detected aborted journal
> > [   13.650043] EXT4-fs (mmcblk0p10): Remounting filesystem read-only
> > 
> > And quite often this would result in a disk that wouldn't properly
> > boot even with older kernels.
> > 
> > I've narrowed the issue down to the following change:
> > abd7d0972a192 ("arm64: dts: hikey: Enable HS200 mode on eMMC")
> > 
> > Reverting this change seems to make things work reliably for me.
> 
> Thanks to report this!
> Let me check with Leo and Guodong to know which property changing
> this is caused by.
> 
> Hi Leo and Guodong,
> 
> Can you help to confirm the commit abd7d0972a192?
> From the log it seemed to cause by the property "max-frequency".

The commit abd7d0972a192 ("arm64: dts: hikey: Enable HS200 mode on
eMMC") can work well on my Hikey620 board, my Hikey620 board is
Lemaker version with 8GB Samsung emmc flash.

John, are you using different Hikey manufacturing version?

Thanks,
Leo Yan
