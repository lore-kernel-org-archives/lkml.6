Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B25A2463B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B25A2463B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeGCXWI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:22:08 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39089 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeGCXWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:22:06 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so7182443oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TS/I98vAAnKjAyOMeCs7V10nIa69dIv5vbdlsKj9C98=;
        b=DX4S0QVntEa7anOX/Y/Spy5WdIjls7SvLf3uQcAXCEKOwQfQw/pe/cRwbGuIe9v4FN
         cQTk7vO5w64LIdRwQUWyJ1K8VB1NDbqT2K0G+osqNuy7ooWh4Krwi5sSnG0bHEzehtwj
         O2imbCmPg8yj9V4ov7ads7J/QExJdG9mf20wtlE0q6ufLR7VVGkYQ7G7La4PqyCenWuy
         QWv5Rk6hFBN7JGQHQBJwR4VK/sPUudT+TsO58mu36PVP1LmVD+sX/oR25Bh7VSVjlbt+
         uK25fnU07a1ILXWC1tzW0dkUbW3xfojTrOMpTvwuEeZUrb0K5IA8GlJSyrGYCWWUpmKi
         klVQ==
X-Gm-Message-State: APt69E2lIJrbP9m8OX0o36DzIzKOxPY0bYvUvGvmmlf52hpOXGii0+1T
        SdQuf2ZV3hMYMnIil4JxnEErlQ==
X-Google-Smtp-Source: AAOMgpepXTbSnP4YY7Hq1m15g+rhmEscf84yIOh4gPhdBvcyOvxeNlJENyrcOTqJAExDH1Ynk/F4WQ==
X-Received: by 2002:aca:cc0b:: with SMTP id c11-v6mr19895206oig.314.1530660126099;
        Tue, 03 Jul 2018 16:22:06 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id 17-v6sm946587oir.27.2018.07.03.16.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:22:04 -0700 (PDT)
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
Subject: [PATCHv5 0/4] Salted build ids via ELF notes
Date:   Tue,  3 Jul 2018 16:21:56 -0700
Message-Id: <20180703232200.11315-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is v5 of the series to allow unique build ids in the kernel. As a
reminder of the context:

""
In Fedora, the debug information is packaged separately (foo-debuginfo) and
can be installed separately. There's been a long standing issue where only one
version of a debuginfo info package can be installed at a time. Mark Wielaard
made an effort for Fedora 27 to allow parallel installation of debuginfo (see
https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
more details)

Part of the requirement to allow this to work is that build ids are
unique between builds. The existing upstream rpm implementation ensures
this by re-calculating the build-id using the version and release as a
seed. This doesn't work 100% for the kernel because of the vDSO which is
its own binary and doesn't get updated. After poking holes in a few of my
ideas, there was a discussion with some people from the binutils team about
adding --build-id-salt to let ld do the calculation debugedit is doing. There
was a counter proposal made to add in the salt while building. The
easiest proposal was to add an item in the linker script vs. linking in
an object since we need the salt to go in every module as well as the
kernel and vmlinux.
""

v5 uses the approach suggested by Masahiro Yamada which uses the
existing ELF note macro to more easily add the salt (vs previous
approaches which tried to adjust via linker section).

If arch maintainers are okay, I'd like acks for this so this can go
through the kbuild tree.

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

