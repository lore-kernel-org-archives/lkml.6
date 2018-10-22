Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E31FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A02F20651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erie74sS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A02F20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbeJWFn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:43:26 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38163 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeJWFnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:43:25 -0400
Received: by mail-ot1-f53.google.com with SMTP id l1so41555959otj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=DLP24IgxG9Dw9N9EK6bbSk+FymV3CprVaRGAV3OTM3s=;
        b=erie74sSnrftzSZwkaiFz75lPGbQG9PCb7H+zVuiHhlbbTLPzWbcypN4YjgxQr+Wnp
         6i0gbzoVI7G5hLd9f+6AhrKJRrkVxDotKZqGxXsk93jM1T4/5A0S81s5r2+SxRSOYhe5
         uWMzUUXw567yX7fVr3YiFvopaLszRwldfPnazQSFMvE37rroFM4Z0DC5GjjWf8mrHy9C
         xbYlm2DYtixpyLR3FPfTbS32ZndSo+mPpOs/98lgmn2ijQJth19/9e5DA1jHtoZvlM5I
         2vdv2Tq2oCNSGjFXlwaIa1nn0z2fTtjoAjnoIJw7ke4EnE2NZhfNhMbRMfBxI/Oe4E6P
         Y0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:to:cc:from:subject:message-id
         :date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=DLP24IgxG9Dw9N9EK6bbSk+FymV3CprVaRGAV3OTM3s=;
        b=KWcrRORe0kCG8ep8wPEUZ2toZ5e/mtQb3m8rNNKSh5nWUftEUXzsBJ+YL4PsfItqQ3
         6c07+PCWnaCviDIJ7TPaYspb6sFBXVx/wM5YQWle9WUa0ZU0/sMl/9TwZ5mH5niTTbN6
         LppA/gb+C6GoVHBvwXWQ16818nIBWMy4dGprbJ0O97zbRhpeCrMNTuh/2WQ+ckmmXj/1
         UTc0KglIvUTS145sIVUSfgVcHOzLxTCCdMJFfS4zE6oPzhWJz6a+3M/itZqkvCeDIIh9
         Cy2PSX18sNzqykh8FB3Jt5rrWwFbQK73bk351hO021nqS4amaMxgp76iapiMdk5wkohp
         2oTA==
X-Gm-Message-State: ABuFfojo3I9cmpfUKKw5bO10Nff23hv9gdCVQKU6/w+vRNK+ES/Gub4Z
        f4fUI8oNOeSvYQ17NzYgHvbPY4g=
X-Google-Smtp-Source: ACcGV63uXXuPxLT7eXpcu4FnKpzjAcpkAq8fvWD6DdMbQcXltsW39WcocjHURssvnjIwHrwOk3AFFg==
X-Received: by 2002:a9d:6042:: with SMTP id v2mr10174575otj.42.1540243390838;
        Mon, 22 Oct 2018 14:23:10 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id t14-v6sm10415016oie.11.2018.10.22.14.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 14:23:09 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id C2EA084F;
        Mon, 22 Oct 2018 16:23:08 -0500 (CDT)
Reply-To: minyard@acm.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
From:   Corey Minyard <minyard@acm.org>
Subject: [GIT PULL] IPMI updates for 4.20
Message-ID: <a03e86d4-6888-de64-ff0b-9908b5024574@acm.org>
Date:   Mon, 22 Oct 2018 16:23:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

   Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the git repository at:

   https://github.com/cminyard/linux-ipmi.git tags/for-linus-4.20

for you to fetch changes up to 0711e8c1b4572d076264e71b0002d223f2666ed7:

   ipmi: Fix timer race with module unload (2018-10-11 20:08:27 -0500)

----------------------------------------------------------------
Lots of small changes to the IPMI driver.  Most of the changes
are logging cleanup and style fixes.  There are a few small
bug fixes.

-corey

----------------------------------------------------------------
Arnd Bergmann (1):
       ipmi: Change to ktime_get_ts64()

Colin Ian King (1):
       ipmi_si: fix potential integer overflow on large shift

Corey Minyard (12):
       acpi:ipmi: Convert ipmi_user_t to struct ipmi_user *
       hwmon:ibm: Change ipmi_user_t to struct ipmi_user *
       ipmi:powernv: Convert ipmi_smi_t to struct ipmi_smi
       ipmi: Finally get rid of ipmi_user_t and ipmi_smi_t
       pci:ipmi: Move IPMI PCI class id defines to pci_ids.h
       ipmi:dmi: Use pr_fmt in the IPMI DMI code
       ipmi:dmi: Ignore IPMI SMBIOS entries with a zero base address
       ipmi: Convert pr_xxx() to dev_xxx() in the BT code
       ipmi: Don't leave holes in the I2C address list in the ssif driver
       ipmi: Free the address list on module cleanup
       ipmi: Remove platform driver overrides and use the id_table
       ipmi:ssif: Add support for multi-part transmit messages > 2 parts

Geert Uytterhoeven (1):
       MAINTAINERS: Add file patterns for ipmi device tree bindings

Jan Glauber (1):
       ipmi: Fix timer race with module unload

Joe Perches (3):
       ipmi: msghandler: Add and use pr_fmt and dev_fmt, remove PFX
       ipmi: Use more common logging styles
       ipmi: Convert printk(KERN_<level> to pr_<level>(

Meelis Roos (1):
       ipmi_si_pci: fix NULL device in ipmi_si error message

YueHaibing (1):
       ipmi: fix return value of ipmi_set_my_LUN

  MAINTAINERS                          |   1 +
  drivers/acpi/acpi_ipmi.c             |   4 +-
  drivers/char/ipmi/ipmi_bt_sm.c       |  66 ++++----
  drivers/char/ipmi/ipmi_devintf.c     |  11 +-
  drivers/char/ipmi/ipmi_dmi.c         |  31 ++--
  drivers/char/ipmi/ipmi_kcs_sm.c      |   4 +-
  drivers/char/ipmi/ipmi_msghandler.c  |  53 +++---
  drivers/char/ipmi/ipmi_powernv.c     |   4 +-
  drivers/char/ipmi/ipmi_poweroff.c    |  67 ++++----
  drivers/char/ipmi/ipmi_si_hardcode.c |   9 +-
  drivers/char/ipmi/ipmi_si_hotmod.c   |  17 +-
  drivers/char/ipmi/ipmi_si_intf.c     |  28 ++--
  drivers/char/ipmi/ipmi_si_mem_io.c   |   2 +-
  drivers/char/ipmi/ipmi_si_pci.c      |  21 +--
  drivers/char/ipmi/ipmi_si_platform.c |  26 ++-
  drivers/char/ipmi/ipmi_smic_sm.c     |  26 ++-
  drivers/char/ipmi/ipmi_ssif.c        | 307 
++++++++++++++++++++++++-----------
  drivers/char/ipmi/ipmi_watchdog.c    |  52 +++---
  drivers/hwmon/ibmaem.c               |   2 +-
  drivers/hwmon/ibmpex.c               |   2 +-
  include/linux/ipmi.h                 |   2 +-
  include/linux/ipmi_smi.h             |   2 +-
  include/linux/pci_ids.h              |   4 +
  23 files changed, 425 insertions(+), 316 deletions(-)

