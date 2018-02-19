Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeBSU7R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:59:17 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43483 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeBSU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:59:16 -0500
X-Google-Smtp-Source: AH8x226RLcwVzqJC3TA/nHSVhN7tiyVTqUCz9PZfUkH3Ckh3SUyBLPg1kBk0oKQBLvBFU6MsmLhxEA==
Subject: Re: [PATCH] regulator: core: Handle PM_SUSPEND_TO_IDLE
 suspend_state_t
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20180218170424.11976-1-hdegoede@redhat.com>
 <20180219113444.GA32761@sirena.org.uk>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5486ab34-4e5b-e2d5-9475-4d7e24a0cda6@redhat.com>
Date: Mon, 19 Feb 2018 21:59:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219113444.GA32761@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-02-18 12:34, Mark Brown wrote:
> On Sun, Feb 18, 2018 at 06:04:24PM +0100, Hans de Goede wrote:
>> The regulator framework is used on x86 in some cases now and x86 has
>> a PM_SUSPEND_TO_IDLE suspend_state_t, treat this as PM_SUSPEND_STANDBY,
>> this fixes these errors on resume:
> 
> This was already fixed by Geert.

There are multiple callers of regulator_get_suspend_state() in
drivers/regulator/core.c, I assume you refer to this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/regulator/core.c?id=57a0dd187956ea04870f4bbbf25a63c425ee7cad

Even with that commit I'm still seeing these errors on resume:

[  753.064002] dpm_run_callback(): regulator_resume_early+0x0/0x60 returns -22
[  753.064014] PM: Device regulator.0 failed to resume early: error -22

These are caused by the -EINVAL return after the
regulator_get_suspend_state() call in
_regulator_resume_early() and there are other callers
of regulator_get_suspend_state() which return -EINVAL
too.

I think just returning 0 in this case makes sense, but it
looks like that needs to be done in several places.

Regards,

Hans
