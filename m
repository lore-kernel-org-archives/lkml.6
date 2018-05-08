Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755371AbeEHPrF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:47:05 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:44809 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbeEHPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:47:03 -0400
X-Google-Smtp-Source: AB8JxZp4Ot6WLDN8yFvXPHEwdM5Wg3Y9o0/hXo/mAAE81jhBiXeRfHPPk/wbdXDAl4ojCtKS0T/h41HL4ubH61D0Uqc=
MIME-Version: 1.0
In-Reply-To: <a9e1f1cb-b823-8690-930f-f7346798341a@linux.intel.com>
References: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
 <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com> <a9e1f1cb-b823-8690-930f-f7346798341a@linux.intel.com>
From: Daniel Drake <drake@endlessm.com>
Date: Tue, 8 May 2018 09:47:01 -0600
Message-ID: <CAD8Lp46b+-B=xqSAqB+zV4xF6SRUGs46FkydS37UEuqav_jNog@mail.gmail.com>
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Chris Chiu <chiu@endlessm.com>, Jian-Hong Pan <jian-hong@endlessm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Adrian Salido <salidoa@google.com>,
        Jason Gerecke <killertofu@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 8:31 AM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>> Some update, we can make the touchpad work by simply modifying the
>> clk_rate of spt_i2c_info from 120000000 to 133000000 in intel-lpss-pci.c for
>> specific PCI ID 8086:a368 ~ a36a (CoffeeLake). Is the clock setting different
>> for the CoffeeLake series?
>>
> Hmm.. at quick look it looks like to be 133 MHz but I want to double check first from other specs. I'm also wondering why it results 600 kHz instead of expected 133/120 * 400 kHz = 443 kHz. Need to check timing parameters too.

Thanks for looking at this. I believe we tried 133MHz just because
some other platforms in the file have the clock at that speed.

In the original/shipped setup, the scope shows the SDA clock is
running at ~635kHz (rather than the intended 400kHz) and the debug
logs from the kernel producing that waveform shows that HCNT=105 and
LCNT=191

105+191=296 parent clock ticks per cycle

At 635kHz, a single clock cycle is 1575ns. What is the speed of the
parent clock if it ticks 296 times in 1575ns? I calculate this to be
187960000Hz and further experiments indicate that clk_rate=187960000
also makes the touchpad work. Unfortunately we don't have easy access
to the scope to measure the effect on the waveform.

Also through experimentation we tried i2c-sda-falling-time-ns=400ns
(increasing from the default of 300ns) in order to make the HCNT
increase to 117. This also makes the touchpad work.

Please let us know if we can help further in finding an upstream fix
for this issue.

Thanks
Daniel
