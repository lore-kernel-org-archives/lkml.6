Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E615C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93E42082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5EtJuTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93E42082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeKCDHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:07:19 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39862 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCDHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:07:19 -0400
Received: by mail-it1-f194.google.com with SMTP id m15so4302312itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rQmqZuno2zCIkAysoPQ/5FB5W+StQaQRHHNNFWMyqRw=;
        b=M5EtJuTLjv0NClBlQxB3n+H0ODWX6RLPrYKe3XZVbTr54QROkoY3Ol66ENyWAl4c5w
         wcYU8NzNS3jCr5kpidDVnVWWwibSXTqihtRmoHRpj9DFHYaFbhV7j7GVkx7DxyzWkuPj
         K8DoO1abyEk7FFHfANM91MFB6f7+45ZJfK+ltGm38OlZK1xHqmVIDrdOXaO6VAPrpU9R
         u1wATvkr1Kn0rwvbvk/+YX0bnV/haYX3rtojSSHllYhEdZj40+8y/PsQcskdkSj0tIPI
         dcdZpXHeEiu45Ae3mh3PVToSOBO06ZMKvennXu2D395vcEyWhGqkMiqnwkpyIo1e9xcs
         3fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rQmqZuno2zCIkAysoPQ/5FB5W+StQaQRHHNNFWMyqRw=;
        b=EaZRTyYINT9Q9mjgaJrds7L4ei6/Z1WaSOacrLg4SNiCvecawtqKOAKSRiKr0Cr5Fy
         b0lV3mcWGvobNQjbpwxVDt/cdBCNMC7iRmbNbNGWlmCnHFXdGz1Ugu/HCPDBMfxJtVak
         V+X6gyHI4Dz/WJ6YCzzQzA+690XqMfXrY8vkWbV4MfiAhzYqXZAHDR593ebzSu9J6bPY
         a21omBn3DE0K2doD+oVyyZ6Hf6ctSxIiR+cQ/EQnCz3xgyyGrlaVHuirBcWhotrm9Kwz
         edpCVfCxGKJhrCydD9KrDaC54yIEIS/DQjTdhW8VEcEmStJ2vRvLeM+GOWRuy/DLCtp3
         V43g==
X-Gm-Message-State: AGRZ1gIrgllbYBbyZqfdwdFiFqzaMcKvK6bSM4ZY96Xs0aqUBobO6FLH
        r13s95ocCOVuHPIfTx4t+9ht6OV07ui9gU5oWJf8yw==
X-Google-Smtp-Source: AJdET5dBR3ZJ2KT1ktgvoriVDiDELF11uapflRQzg7tfwGGOXBdwrt0LNzAauGYRzNtAcjbm2bw/IkDp7RL+cjcp6Rs=
X-Received: by 2002:a24:7fc8:: with SMTP id r191-v6mr4674itc.107.1541181558114;
 Fri, 02 Nov 2018 10:59:18 -0700 (PDT)
MIME-Version: 1.0
From:   Alistair Strachan <astrachan@google.com>
Date:   Fri, 2 Nov 2018 10:59:07 -0700
Message-ID: <CANDihLFJMo7bX8kfJ7+d3yHtq5xX6bEwF6iVnDx_6QJFBksBvg@mail.gmail.com>
Subject: "x86/mm: Introduce the 'no5lvl' kernel parameter" broke SETUP_DTB?
To:     kirill.shutemov@linux.intel.com
Cc:     mingo@kernel.org, tglx@linutronix.de, hughd@google.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

I noticed that booting 4.19 in qemu while injecting a FDT using the
"-dtb /path/to/blob" feature might have been broken by your change
372fddf70904 ("x86/mm: Introduce the 'no5lvl' kernel parameter").

This manifests either as FDT corruption, which causes the setup code
to fail to unpack it (i.e. corruption of the device-tree structure),
or simply bad node data. If I make the below change, the problem goes
away:

diff --git a/arch/x86/boot/compressed/pgtable_64.c
b/arch/x86/boot/compressed/pgtable_64.c
index 8c5107545251..bfe5aca71254 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -40,7 +40,7 @@ struct paging_config paging_prepare(void *rmode)
        unsigned long bios_start, ebda_start;

        /* Initialize boot_params. Required for cmdline_find_option_bool(). */
-       boot_params = rmode;
+       //boot_params = rmode;

        /*
         * Check if LA57 is desired and supported.

This can be reproduced with the system-root.dtb file in
https://android.googlesource.com/device/google/cuttlefish/+archive/master.tar.gz
using "qemu -dtb system-root.dtb -kernel /path/to/bzImage -drive
file=root.ext4" on x86_64_defconfig with CONFIG_OF_UNITTEST enabled.

If the FDT is unpacked successfully, the
/proc/device-tree/firmware/android/compatible file will exist, and
contain the string "android,firmware" instead of junk.

I'm still looking into the root cause for this, but I just wanted to
let you know.

Alistair.
