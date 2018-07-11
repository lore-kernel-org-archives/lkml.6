Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B86C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8C720020
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoHnV4gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8C720020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbeGKJGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:06:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35375 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeGKJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:06:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id a3-v6so8098064wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AE8DquSxSrfN59LzXIrU+mScQxkz4fnFbV1vDzzUgPc=;
        b=XoHnV4ggwicVdCbZJdk0wKrdZeXEWqah9FwfOwYHY6HoD0zzZymSPEn3ORnadpinzx
         POStaMyBrXCDDCBAkIDOnHh7w/rmoOG5zMc4X//PfFL9GhrQ7kpkEeY86ebjCVXoguIu
         LCR2Z6dbLmdfaRh8a4m5ru/0KYGKNfCsxh2XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AE8DquSxSrfN59LzXIrU+mScQxkz4fnFbV1vDzzUgPc=;
        b=F8l8TmQZavlPtHyjN/kEpPSkLi0VPPDPRgTdIjoS/G/oAAcVVjgmoEQMHm4lUjzAp/
         B8opVQ83mK4MX3sIlb2KXnxOzphULF4Xwoc6swzSavE0mYcMi/3Kjwhi/MuyGPdXmHfJ
         kiAKLXdXzq9aGd06T8Pp6D5Po8CeIaGjA7BbhoWxjUtR1m8EBTODCIwc0p5SYnUo4C1b
         Q3+xeKTClYbLZbd7PyN26hKjptxX5IiCCbup2ZFJmUGJOPz03j/0+9eUte+sWjFco4Qt
         9tIIrJPr+EyxG2aHVPafbdox7fCdifq6ZfPMAwUFIJ4DOZmBRyeU+gVB0NyOq9YI/Efd
         aNPw==
X-Gm-Message-State: APt69E3fnLn0obC2+n/WqcoOq65U4aSWultpQSZzpgx+SuZkc2Lqw2NK
        PmQjG84LXHVO/GkOQbsyWS7Wew==
X-Google-Smtp-Source: AAOMgpdO0uq/jPudxsM542u4+Ts3mNHBSy9nFnc+ZMrgOp6UXFLC2qgXxHykTYGsecxpJCz3cBQvrg==
X-Received: by 2002:adf:eb0c:: with SMTP id s12-v6mr21558624wrn.174.1531299766070;
        Wed, 11 Jul 2018 02:02:46 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id y203-v6sm2327953wme.42.2018.07.11.02.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:02:45 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Subject: [GIT PULL 0/1] EFI mixed mode fix for v4.18
Date:   Wed, 11 Jul 2018 11:02:34 +0200
Message-Id: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:

  Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to d7f2e972e702d329fe11d6956df99dfc31211c25:

  efi/x86: remove pointless call to PciIo->Attributes() (2018-07-11 10:52:46 +0200)

----------------------------------------------------------------
A single fix for the x86 PCI I/O protocol handling code that got
broken for mixed mode (64-bit Linux/x86 on 32-bit UEFI) after a
fix was applied in -rc2 to fix it for ordinary 64-bit Linux/x86.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/x86: remove pointless call to PciIo->Attributes()

 arch/x86/boot/compressed/eboot.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)
