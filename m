Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A6C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F72622ACA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F72622ACA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbeGGBH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:07:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40778 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeGGBHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:07:24 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so11400789qtj.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w797Q1E9ieKryuCGLM5l5pC0s4K0AOHbMkPsjTN/RDI=;
        b=aqt6lxZVczCZz5POi2HyWHiyjGOI5AkGPfTlc/esFktDdWDpE7IQ69xS5fhOU5pN46
         /9Bq74p6k11lVLX/HTXwUHvvUxcmrMzw2l7b8JLJoZqpbFbAEzkM9le4dYxQ+AaPYGGQ
         aH0gEZayGnYLdlg19NUCXYAKbNKM3lDMvURTPgiQ8JTrUazR35+wKvxG38WsPTkQSUKe
         QaebHq4qSg7YrgYY9kZbOQ4v3NpzUS4DqDYSD/Y2q2JRHdQEk8pFel21P0jlIsMtpMHA
         2/G5PTVms/RQkUz5SAnnaKx0XTR87G69ey/xhyEii4VP6Zp0CCAv6WtlOqiMee40HC6N
         Sl5A==
X-Gm-Message-State: APt69E2GYO+K9pMOkwCo1L989HmJ/q1LGaOxpfrF1u3/eiHqVgMaQgiL
        dcLW3uVfx1NsiAmZO3htd7PmGg==
X-Google-Smtp-Source: AAOMgpfVJ37XMulReWQMAbL3y4rOPoaqAnNsSTVcvNy+d7KnnqjM5GQLgKt2p8yvH94OdY5T6KlBHg==
X-Received: by 2002:aed:3d2d:: with SMTP id g42-v6mr11289193qtf.195.1530925644046;
        Fri, 06 Jul 2018 18:07:24 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3359698qtg.20.2018.07.06.18.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 18:07:22 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH 0/7] HOSTFLAGS and HOSTLDFLAGS from the environment (new approach)
Date:   Fri,  6 Jul 2018 18:07:02 -0700
Message-Id: <20180707010709.16648-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a follow up from
lkml.kernel.org/r/<20180329004805.7278-1-labbott@redhat.com> . I was
pointed to a previous suggestion (https://lkml.org/lkml/2018/2/28/178)
to rename the variables for better namespacing. I hadn't seen anyone
follow up so this is a series to do just that. I split up the rename by
variable for ease of review. This was mostly just a pretty
straight-forward search and replace. I intentionally didn't Cc all the
outside maintainers on the rename because I wanted to make sure this
approach was correct before bothering people.

This series also includes two other issuse I found to finally have all
the generated files pick up the host flags. The first seems to be a typo
of CHOSTFLAGS instead of HOSTCFLAGS. The second is a missing HOSTLDFLAGS
when linking fixdep. I put these two separately in case there was
interest in picking them up for stable.

For the interested, the full command line I've been testing with:

HOSTCFLAGS="-O2 -g -pipe -Wall -Werror=format-security
-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions
-fstack-protector-strong -grecord-gcc-switches
-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1
-specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection"

HOSTLDFLAGS="-Wl,-z,relro -Wl,-z,now
-specs=/usr/lib/rpm/redhat/redhat-hardened-ld"

Thanks,
Laura

Laura Abbott (7):
  tools: build: Fixup host c flags
  tools: build: Use HOSTLDFLAGS with fixdep
  treewide: Rename HOSTCFLAGS -> KBUILD_HOSTCFLAGS
  treewide: Rename HOSTCXXFLAGS to KBUILD_HOSTCXXFLAGS
  treewide: Rename HOSTLDFLAGS to KBUILD_HOSTLDFLAGS
  treewide: Rename HOST_LOADLIBES to KBUILD_HOSTLDLIBS
  Kbuild: Use HOST*FLAGS options from the command line

 Makefile                   | 17 +++++++++--------
 arch/alpha/boot/Makefile   |  2 +-
 arch/s390/tools/Makefile   |  4 ++--
 arch/x86/tools/Makefile    |  4 ++--
 net/bpfilter/Makefile      |  4 ++--
 samples/bpf/Makefile       | 28 ++++++++++++++--------------
 samples/connector/Makefile |  2 +-
 samples/hidraw/Makefile    |  2 +-
 samples/seccomp/Makefile   | 24 ++++++++++++------------
 samples/statx/Makefile     |  2 +-
 samples/uhid/Makefile      |  2 +-
 scripts/Kbuild.include     |  2 +-
 scripts/Makefile           |  4 ++--
 scripts/Makefile.host      | 28 ++++++++++++++--------------
 scripts/dtc/Makefile       | 24 ++++++++++++------------
 scripts/genksyms/Makefile  |  4 ++--
 scripts/kconfig/Makefile   | 14 +++++++-------
 tools/build/Build.include  |  2 +-
 tools/build/Makefile       |  2 +-
 tools/objtool/Makefile     |  4 ++--
 20 files changed, 88 insertions(+), 87 deletions(-)

-- 
2.17.1

