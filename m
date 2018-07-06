Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B32C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCA6240BE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCA6240BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeGFAtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:49:47 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:46723 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeGFAtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:49:46 -0400
Received: by mail-qk0-f175.google.com with SMTP id o2-v6so5487117qkc.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 17:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9w75SxIRltedpjvEK11lOSU234pof9QInQKyIl4vFDw=;
        b=Wz3jwyhrGCzoGkAf21LZ9yk714MRgQFU+oXJVmXi5UlcZ0rTqvXCETg9RjbVce9lj/
         oXjntlujRlin7UjE11gT6weMBv018NY0X0oFXR4AEi0q7UPfzKmVGkkN9+2evuARM/K8
         MKUNBlXfGZ+M1mNhV5DxmOrq+ADxm/io3DhjAVLSCtooq1mQWcpEvdtjqtnBzlvDIZJT
         Rv99kz8teB2ovinitRbEbshSuoQkNZJ2dur545m+j2VtlFat152+8BS1BoTkCMiIjibW
         oSeDPXEkCYZaBfkeRGcuizgwcgNm3iEhtry1qhsXjAffTkiir3B/4tXS18DKR/LFploT
         qrvg==
X-Gm-Message-State: APt69E1pd15Y4h4qy/ZTVcx8sCFd7tOwtvfqb+A8Z5z2Lf34KqwwH7tM
        qhO6eZ49L1+ZKUD4duVOMKC27A==
X-Google-Smtp-Source: AAOMgpcWCqJgmxGcsY1HMjXwx3R+/2OlcOA1Zm9l3o/iwmWHtYN2Q2Q3tVtM/o2mBrsFo5xvspuyPQ==
X-Received: by 2002:a37:289e:: with SMTP id o30-v6mr6882995qko.432.1530838185570;
        Thu, 05 Jul 2018 17:49:45 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id q67-v6sm4675205qkb.16.2018.07.05.17.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 17:49:44 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv6 0/4] Salted build ids via ELF notes
Date:   Thu,  5 Jul 2018 17:49:36 -0700
Message-Id: <20180706004940.32587-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v6 of the series to allow unique build ids. v6 is mostly minor
fixups and Acks for this to go through the kbuild tree.

Thanks,
Laura

Laura Abbott (4):
  kbuild: Add build salt to the kernel and modules
  x86: Add build salt to the vDSO
  powerpc: Add build salt to the vDSO
  arm64: Add build salt to the vDSO

 arch/arm64/kernel/vdso/note.S     |  3 +++
 arch/powerpc/kernel/vdso32/note.S |  3 +++
 arch/x86/entry/vdso/vdso-note.S   |  3 +++
 arch/x86/entry/vdso/vdso32/note.S |  3 +++
 include/linux/build-salt.h        | 20 ++++++++++++++++++++
 init/Kconfig                      |  9 +++++++++
 init/version.c                    |  3 +++
 scripts/mod/modpost.c             |  3 +++
 8 files changed, 47 insertions(+)
 create mode 100644 include/linux/build-salt.h

-- 
2.17.1

