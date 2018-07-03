Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E797DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA4E218C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA4E218C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeGCXeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:34:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37105 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeGCXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:34:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so7217228oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TS/I98vAAnKjAyOMeCs7V10nIa69dIv5vbdlsKj9C98=;
        b=lYZHRQMHp3wLl1z75mYQPEW9gRWoD0bxuJBffD2ZQEKkpwFnjjmCbjV7UZe9Zg05/y
         q84rFOvjleHt5AZekOBgqwaUm3VP3A+J6JQQJVVvw5otsNWWKzhAyaCemmZJnIPGNxn2
         jcQggXctvqQZ9e1OW67qzG0gn5Vw3DOd7TorFwlF1Ex7AORnDj1WDVvAtTlidCnIxWkY
         gfO+avxS5VHzx9AEduftxltohMJlkeMIY7qGUxC6Re6E4kOonjZcqDE/o0yi3bDVsz2I
         quKH0xThZe7zQdY0aXr2XzVtqoA1XbIcKgOJpNu1+e+GFSCb3dcoWIrmAI3AY8lQG5CZ
         YH4w==
X-Gm-Message-State: APt69E3I2VYtjzV1gN0tHkMfPri+W26/cqLNeP4A1AK1k9Xb1oLWstag
        wrOv6Px5t4ywYulU3vvX2mQ7Y3ZbBQ4=
X-Google-Smtp-Source: AAOMgpfuPI3/fKEoR6mru2NMVFDUPHXFCzL8mOFLlWZxJiOrMAnnj7SkQWOvgsWpbEkC3KiRRnB3+Q==
X-Received: by 2002:aca:6749:: with SMTP id b9-v6mr12646042oiy.247.1530660875364;
        Tue, 03 Jul 2018 16:34:35 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1828702otc.25.2018.07.03.16.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:34:34 -0700 (PDT)
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
Date:   Tue,  3 Jul 2018 16:34:26 -0700
Message-Id: <20180703233430.14416-1-labbott@redhat.com>
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

