Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 19C90C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE313208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE313208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934797AbeFLAct (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:32:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40718 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934675AbeFLAcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:32:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so11120343pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QCPb3+W8Dc+YjFxnFovwQRs+CT/I6flVV4/pcIUWrPY=;
        b=jhY2LKf1G78irb6f7vpkE7oMa8tBnCSKeKS2jh1C01NCfYaI2rw00fxdi61ZLuxutK
         MafTB+M/gWJGKpdHIAMwFZu91ovn/+ofUoM634AOPSGahORu1MitVfu8l2u+GUCupbI8
         evnjqYm+OXuX0taHSYO1CdUq6M/2x1ClcHnKRF9t3W0uOD61daURQqbET18Lefum1629
         cLzAUi85SJ5B/pi5/In5zeo8k5JHAv2XwMtYtnReh70Ilvjm2kVInI3B3s0+bTfBhmyM
         stBKfX1j0iYojLrxkxSq9wA4GXivt96fou3RH809BEIyP+wpdUMRAoxQpCBpJ4/DBs1R
         06SQ==
X-Gm-Message-State: APt69E1lEo/sTp8rF8+UZJzqFMDw2fq6MZ1022DiYApq9XbnypO5nRcC
        FxqKMO+N/G7qs/V+7258fL6+SA==
X-Google-Smtp-Source: ADUXVKJQxYQ1g5De/ZPT0bMuXmzN9zu9IeSk61gmuhIdWHTCzVdjed6Xksrk7qwWtksThS5USOs0JQ==
X-Received: by 2002:a63:6f89:: with SMTP id k131-v6mr1141808pgc.345.1528763567916;
        Mon, 11 Jun 2018 17:32:47 -0700 (PDT)
Received: from localhost.net ([2601:602:9802:a8dc::27e5])
        by smtp.gmail.com with ESMTPSA id c12-v6sm40866112pfi.177.2018.06.11.17.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 17:32:46 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
Subject: [PATCHv4 0/3] Salted build ids via linker sections
Date:   Mon, 11 Jun 2018 17:32:21 -0700
Message-Id: <20180612003224.3658-1-labbott@redhat.com>
X-Mailer: git-send-email 2.18.0.rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is v4 of the series to allow unique build ids in the kernel. As a
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

v4 takes Linus' suggestion of using linker fill to insert the build id.
This removes the need to use a generated header which makes things much
easier. One change is that because this section isn't .comment it won't
get stripped automatically. This is pretty small but I also know people
can be picky so I'm open to opinions or suggestions here.

Laura Abbott (3):
  scripts: Preprocess module-common.lds
  kbuild: Introduce build-salt linker section and config option
  x86: Add build salt to the vDSO and kernel linker scripts

 arch/x86/entry/vdso/vdso-layout.lds.S              | 3 ++-
 arch/x86/kernel/vmlinux.lds.S                      | 1 +
 include/asm-generic/vmlinux.lds.h                  | 6 ++++++
 init/Kconfig                                       | 9 +++++++++
 scripts/.gitignore                                 | 1 +
 scripts/Makefile                                   | 2 +-
 scripts/{module-common.lds => module-common.lds.S} | 4 ++++
 7 files changed, 24 insertions(+), 2 deletions(-)
 rename scripts/{module-common.lds => module-common.lds.S} (94%)

-- 
2.18.0.rc1

