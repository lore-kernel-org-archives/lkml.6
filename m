Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E10C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB353206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB353206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeKSUan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:30:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:64191 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeKSUan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:30:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 02:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="101407181"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2018 02:07:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E051B186B; Mon, 19 Nov 2018 12:07:30 +0200 (EET)
Date:   Mon, 19 Nov 2018 13:07:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Alistair Strachan <astrachan@google.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, hughd@google.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: "x86/mm: Introduce the 'no5lvl' kernel parameter" broke
 SETUP_DTB?
Message-ID: <20181119100730.p6q74vyuezgtqza7@black.fi.intel.com>
References: <CANDihLFJMo7bX8kfJ7+d3yHtq5xX6bEwF6iVnDx_6QJFBksBvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDihLFJMo7bX8kfJ7+d3yHtq5xX6bEwF6iVnDx_6QJFBksBvg@mail.gmail.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 05:59:07PM +0000, Alistair Strachan wrote:
> Hi Kirill,
> 
> I noticed that booting 4.19 in qemu while injecting a FDT using the
> "-dtb /path/to/blob" feature might have been broken by your change
> 372fddf70904 ("x86/mm: Introduce the 'no5lvl' kernel parameter").
> 
> This manifests either as FDT corruption, which causes the setup code
> to fail to unpack it (i.e. corruption of the device-tree structure),
> or simply bad node data. If I make the below change, the problem goes
> away:
> 
> diff --git a/arch/x86/boot/compressed/pgtable_64.c
> b/arch/x86/boot/compressed/pgtable_64.c
> index 8c5107545251..bfe5aca71254 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -40,7 +40,7 @@ struct paging_config paging_prepare(void *rmode)
>         unsigned long bios_start, ebda_start;
> 
>         /* Initialize boot_params. Required for cmdline_find_option_bool(). */
> -       boot_params = rmode;
> +       //boot_params = rmode;
> 
>         /*
>          * Check if LA57 is desired and supported.
> 
> This can be reproduced with the system-root.dtb file in
> https://android.googlesource.com/device/google/cuttlefish/+archive/master.tar.gz
> using "qemu -dtb system-root.dtb -kernel /path/to/bzImage -drive
> file=root.ext4" on x86_64_defconfig with CONFIG_OF_UNITTEST enabled.
> 
> If the FDT is unpacked successfully, the
> /proc/device-tree/firmware/android/compatible file will exist, and
> contain the string "android,firmware" instead of junk.
> 
> I'm still looking into the root cause for this, but I just wanted to
> let you know.

[ Sorry for late reply. I was on vacation. ]

I failed to reproduce the issue with my setup. I can see the string
"android,firmware" and all tests seems pass:

[    2.796657] ### dt-test ### start of unittest - you will see error messages
[    2.798680] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-dat1
[    2.799038] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-dat1
[    2.799384] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    2.799681] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    2.799915] OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
[    2.800135] OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
[    2.801191] OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-dat1
[    2.801606] OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
[    2.801842] OF: /testcase-data/phandle-tests/consumer-b: arguments longer than property
[    2.811520] ### dt-test ### end of unittest - 162 passed, 0 failed

I've checked 372fddf70904 and v4.19. I don't see a difference comparing to
v4.17.

Were you able to track down the issue?

-- 
 Kirill A. Shutemov
