Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeDSPLH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:11:07 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44797 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeDSPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:11:05 -0400
X-Google-Smtp-Source: AIpwx49In6UsczOEpvVCOPnzpzE0YChBbH4dyWGXD0yAPROpixJI8wqK4i7YRge+mY4gR32VPvh6Ww==
Subject: Re: [RFC PATCH v2 4/4] acpi: apei: Warn when GHES marks correctable
 errors as "fatal"
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-5-mr.nuke.me@gmail.com> <20180418175452.GK4795@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <807002b1-ccb9-22c8-6563-ade7e44912ff@gmail.com>
Date: Thu, 19 Apr 2018 10:11:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180418175452.GK4795@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2018 12:54 PM, Borislav Petkov wrote:
> On Mon, Apr 16, 2018 at 04:59:03PM -0500, Alexandru Gagniuc wrote:

(snip)
>> +
>> +		corrected_sev = max(corrected_sev, sec_sev);
>> +	}
>> +
>> +	if ((sev >= GHES_SEV_PANIC) && (corrected_sev < sev)) {
>> +		pr_warn("FIRMWARE BUG: Firmware sent fatal error that we were able to correct");
>> +		pr_warn("BROKEN FIRMWARE: Complain to your hardware vendor");
> 
> No, I don't want any of that crap issuing stuff in dmesg and then people
> opening bugs and running around and trying to replace hardware.
> 
> We either can handle the error and log a normal record somewhere or we
> cannot and explode.

There is value in this. From my observations, fw claims it will do
everything through FFS, yet fails to fully handle the situation. It's
rooted in FW's assumptions about OS behavior. Because the (old) versions
of windows, esxi, and rhel used during development crash, fw assumes
that _all_ OSes crash. The result in a surprising majority of cases is
that FFS doesn't properly handle recurring errors, and fw is, in fact,
broken.

> The complaining about the FW doesn't bring shit.

You are correct. It doesn't bring defecation. It brings a red flag that
helps people get closer to the root cause of problems.

That being said, I can just drop this patch.

Alex
