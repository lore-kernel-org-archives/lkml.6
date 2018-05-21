Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeEUTJi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:09:38 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40519 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeEUTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:09:36 -0400
X-Google-Smtp-Source: AB8JxZoijldGYIE6Y6XkWY6gLxNiwrL95WmNs1Ama1TT4cno3sblzjcKULzgBEPRKpC1olNio1QFhohZCyO3VUFAp5Q=
MIME-Version: 1.0
In-Reply-To: <5B02847C.3000102@hisilicon.com>
References: <CALAqxLX5qPq_5CQwubzk5hiL3kkes7nK9NGqtnyddXKfyaJKTg@mail.gmail.com>
 <5B02847C.3000102@hisilicon.com>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 21 May 2018 12:09:34 -0700
Message-ID: <CALAqxLUJ1uk_QaxtZhERydCMVr6US0hgDx=TQZT5ab=7ZBtH4g@mail.gmail.com>
Subject: Re: REGRESSION: HiKey eMMC corruption
To: Wei Xu <xuwei5@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>, Arnd Bergmann <arnd@arndb.de>,
        Leo Yan <leo.yan@linaro.org>, Guodong Xu <guodong.xu@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 1:34 AM, Wei Xu <xuwei5@hisilicon.com> wrote:
> On 2018/5/18 23:59, John Stultz wrote:
>> The last few months have been busy and I've not been ontop of my
>> upstream testing as well as I'd like, but today I did manage to chase
>> down an issue I've been seeing since 4.17-rc1 on the HiKey board,
>> which was causing emmc corruption and stopping the board from booting.
>>
>> Symptoms usually looked like:
>> [    1.690448] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
>> req 400000Hz, actual 400000HZ div = 31)
>> ...
>> [    1.777288] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
>> req 150000000Hz, actual 148800000HZ div = 0)
>> [    1.777760] mmc0: new HS200 MMC card at address 0001
>> ...
>> [   12.214381] dwmmc_k3 f723d000.dwmmc0: Unexpected command timeout, state 3
>> [   12.457420] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
>> req 400000Hz, actual 400000HZ div = 31)
>> [   12.536676] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
>> req 150000000Hz, actual 148800000HZ div = 0)
>> [   12.616827] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
>> req 400000Hz, actual 400000HZ div = 31)
>> [   12.695742] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
>> req 150000000Hz, actual 148800000HZ div = 0)
>> [   12.772067] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
>> req 400000Hz, actual 400000HZ div = 31)
>> [   12.850429] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
>> req 150000000Hz, actual 148800000HZ div = 0)
>> [   12.863384] print_req_error: I/O error, dev mmcblk0, sector 8810504
>> [   12.869778] Aborting journal on device mmcblk0p10-8.
>> [   12.887900] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
>> req 400000Hz, actual 400000HZ div = 31)
>> [   12.967509] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
>> req 150000000Hz, actual 148800000HZ div = 0)
>> [   13.130182] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
>> req 400000Hz, actual 400000HZ div = 31)
>> [   13.209438] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
>> req 150000000Hz, actual 148800000HZ div = 0)
>> [   13.302085] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
>> req 400000Hz, actual 400000HZ div = 31)
>> [   13.380462] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
>> req 150000000Hz, actual 148800000HZ div = 0)
>> [   13.494539] mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot
>> req 400000Hz, actual 400000HZ div = 31)
>> [   13.571420] mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot
>> req 150000000Hz, actual 148800000HZ div = 0)
>> [   13.640817] EXT4-fs error (device mmcblk0p10):
>> ext4_journal_check_start:61: Detected aborted journal
>> [   13.650043] EXT4-fs (mmcblk0p10): Remounting filesystem read-only
>>
>> And quite often this would result in a disk that wouldn't properly
>> boot even with older kernels.
>>
>> I've narrowed the issue down to the following change:
>> abd7d0972a192 ("arm64: dts: hikey: Enable HS200 mode on eMMC")
>>
>> Reverting this change seems to make things work reliably for me.
>
> Thanks to report this!
> Let me check with Leo and Guodong to know which property changing
> this is caused by.
>
> Hi Leo and Guodong,
>
> Can you help to confirm the commit abd7d0972a192?
> From the log it seemed to cause by the property "max-frequency".

So yes, I can confirm that if I drop only the max-frequency property
out, keeping the "mmc-hs200-1_8v;" line it still boots for me.

thanks
-john
