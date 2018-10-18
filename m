Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B942C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D864208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D864208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJRQB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:01:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:1030 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeJRQB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:01:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 01:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,395,1534834800"; 
   d="scan'208";a="79672221"
Received: from mylly.fi.intel.com (HELO [10.237.72.72]) ([10.237.72.72])
  by fmsmga008.fm.intel.com with ESMTP; 18 Oct 2018 01:01:36 -0700
Subject: Re: [PATCH 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180923144510.4564-1-hdegoede@redhat.com>
 <20180923144510.4564-2-hdegoede@redhat.com>
 <CAJZ5v0iu5eikTw3wOK7wHOVe+xHTv5xPTnQELEyA2oF8sL3S=g@mail.gmail.com>
 <CAHp75VccCQ3ey3kRpE35BDkjjFZtdYiHZ+caSVcviCd-fY71bA@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <3093be44-3dc0-4e47-8d4d-b4f69818a0d3@linux.intel.com>
Date:   Thu, 18 Oct 2018 11:01:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VccCQ3ey3kRpE35BDkjjFZtdYiHZ+caSVcviCd-fY71bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 10:36 AM, Andy Shevchenko wrote:
> On Thu, Oct 18, 2018 at 10:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Sun, Sep 23, 2018 at 4:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> On some BYT/CHT systems the SoC's P-Unit shares the I2C bus with the
>>> kernel. The P-Unit has a semaphore for the PMIC bus which we can take to
>>> block it from accessing the shared bus while the kernel wants to access it.
>>>
>>> Currently we have the I2C-controller driver acquiring and releasing the
>>> semaphore around each I2C transfer. There are 2 problems with this:
>>>
>>> 1) PMIC accesses often come in the form of a read-modify-write on one of
>>> the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
>>> between the read and the write. If the P-Unit modifies the register during
>>> this window?, then we end up overwriting the P-Unit's changes.
>>> I believe that this is mostly an academic problem, but I'm not sure.
>>>
>>> 2) To safely access the shared I2C bus, we need to do 3 things:
>>> a) Notify the GPU driver that we are starting a window in which it may not
>>> access the P-Unit, since the P-Unit seems to ignore the semaphore for
>>> explicit power-level requests made by the GPU driver
>>> b) Make a pm_qos request to force all CPU cores out of C6/C7 since entering
>>> C6/C7 while we hold the semaphore hangs the SoC
>>> c) Finally take the P-Unit's PMIC bus semaphore
>>> All 3 these steps together are somewhat expensive, so ideally if we have
>>> a bunch of i2c transfers grouped together we only do this once for the
>>> entire group.
>>>
>>> Taking the read-modify-write on a PMIC register as example then ideally we
>>> would only do all 3 steps once at the beginning and undo all 3 steps once
>>> at the end.
>>>
>>> For this we need to be able to take the semaphore from within e.g. the PMIC
>>> opregion driver, yet we do not want to remove the taking of the semaphore
>>> from the I2C-controller driver, as that is still necessary to protect many
>>> other code-paths leading to accessing the shared I2C bus.
>>>
>>> This means that we first have the PMIC driver acquire the semaphore and
>>> then have the I2C controller driver trying to acquire it again.
>>>
>>> To make this possible this commit does the following:
>>>
>>> 1) Move the semaphore code from being private to the I2C controller driver
>>> into the generic iosf_mbi code, which already has other code to deal with
>>> the shared bus so that it can be accessed outside of the I2C bus driver.
>>>
>>> 2) Rework the code so that it can be called multiple times nested, while
>>> still blocking I2C accesses while e.g. the GPU driver has indicated the
>>> P-Unit needs the bus through a iosf_mbi_punit_acquire() call.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> If there are no objections or concerns regarding this patch, I'm
>> inclined to take the entire series including it.
> 
> Please, go ahead, it looks good to me.
> Thanks!
> 
Just in case note: please remember to take patches and tags from v3 of 
the series, not from this v1 thread.

-- 
Jarkko
