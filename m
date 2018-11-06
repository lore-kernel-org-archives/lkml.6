Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CE3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA5B2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA5B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbeKFWXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:23:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:50186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387596AbeKFWXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:23:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9262BB647;
        Tue,  6 Nov 2018 12:58:04 +0000 (UTC)
Date:   Tue, 6 Nov 2018 13:58:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Mustafa Kuscu <mustafakuscu@gmail.com>,
        Daniel Drake <drake@endlessm.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: asus: fix build warning wiht CONFIG_ASUS_WMI
 disabled
In-Reply-To: <20181102151443.758229-1-arnd@arndb.de>
Message-ID: <nycvar.YFH.7.76.1811061357520.21975@cbobk.fhfr.pm>
References: <20181102151443.758229-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018, Arnd Bergmann wrote:

> asus_wmi_evaluate_method() is an empty dummy function when CONFIG_ASUS_WMI
> is disabled, or not reachable from a built-in device driver. This leads to
> a theoretical evaluation of an uninitialized variable that the compiler
> complains about, failing to check that the hardcoded return value makes
> this an unreachable code path:
> 
> In file included from include/linux/printk.h:336,
>                  from include/linux/kernel.h:14,
>                  from include/linux/list.h:9,
>                  from include/linux/dmi.h:5,
>                  from drivers/hid/hid-asus.c:29:
> drivers/hid/hid-asus.c: In function 'asus_input_configured':
> include/linux/dynamic_debug.h:135:3: error: 'value' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>    ^~~~~~~~~~~~~~~~~
> drivers/hid/hid-asus.c:359:6: note: 'value' was declared here
>   u32 value;
>       ^~~~~
> 
> With an extra IS_ENABLED() check, the warning goes away.
> 
> Fixes: 3b692c55e58d ("HID: asus: only support backlight when it's not driven by WMI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to for-4.20/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

