Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC38C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA49A2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkFuu65N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfAHFXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:23:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42374 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfAHFXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:23:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so1324319pfr.9;
        Mon, 07 Jan 2019 21:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C/PZBrvynKthJJ/lsF1pt+JT3JSAbBllFgTcfNdsDto=;
        b=YkFuu65N+ngxVlHyeP0s/V9Iod2E+T5hUPbkRPQCh2yKnlCzkVVWq6aCB1rO18RPVv
         Va6IUWqSuQBNmsTUmS2Ki064WizCMs9ehC3oa4wamc+2WANf8A0xJMwdQEmoLt9FMTLc
         TLnwCCGiNtpbKSmbSwS3ncUx1s7rJG3/ZZEkIFSmAsznHR9MwqdRz0l/uEmgwqDSxgIC
         Hnu3c+5wyfrwxSJareRyEVjwA2869fv5iJ4XmW+f5X8SqBGZoQYb/cpb9L/QdDGZCzzi
         l5W+q8/iqpilkwwb8mIBYxWNRrcv01JVjwQr073PF8KMF4Z4JN3BjUhSQcUCUyL9kSxG
         JZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C/PZBrvynKthJJ/lsF1pt+JT3JSAbBllFgTcfNdsDto=;
        b=c2JzLmUA4BJxLBzEItWKDRoArVwpTz8mjBkKBunckr+YP9OGwE9dyeUbBtlDY+1Ued
         bT3JlE75A8xk3In1P+7Vr/pl4y5gRoWVGT7kH3NmwsdAx8cuFFyKOPQDuxpzUb30AODG
         AQnY6gXFT8QjlQWxw5vHUksbxlINCZRwYnipNdVlS/g3N7KUP40Lm8pxeGMADtEhk1LY
         XpN9fSklYcRDobYHb6KEe3F8OWVok309WNalJWFSZLu4Hw7Ina1VxY+Fd0tuM6nmPve2
         qHT0tfYvPKjCz0qzpBpJXu4YK5wYKfAnjo8LbyArfwpXgnlVENDq41NLsA9Ukcyu8nv8
         FMIA==
X-Gm-Message-State: AJcUuke5Qx5QHDEvKZXhLf0DfW4C4pj2sVxpVESv5x3/78EyE2zMU3Uj
        eQ1qxDjSwl1rD87ODBb3QQRe5Lz0
X-Google-Smtp-Source: ALg8bN7ghZyE1I0wD5gN5PUQnaYnkYOy9P+PydTedV977KUL90hHzyPMg9r/c9JBoF+NRNuGobCIpQ==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr400161pfd.56.1546925001107;
        Mon, 07 Jan 2019 21:23:21 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id x127sm102710626pfd.156.2019.01.07.21.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:23:20 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        ccaulfie@redhat.com, cluster-devel@redhat.com, deller@gmx.de,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, sparclinux@vger.kernel.org
Subject: [PATCH 0/3] net: y2038-safe socket timeout options
Date:   Mon,  7 Jan 2019 21:22:52 -0800
Message-Id: <20190108052255.10699-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series is aimed at adding y2038-safe timeout options:
SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW.

This is similar to the previous series adding y2038-safe
SO_TIMESTAMP* options.

The series needs to be applied after the socket timestamp series:
https://lore.kernel.org/lkml/20190108032657.8331-1-deepa.kernel@gmail.com

Deepa Dinamani (3):
  socket: Use old_timeval types for socket timeouts
  socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
  sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW

 arch/alpha/include/uapi/asm/socket.h   | 13 ++++-
 arch/mips/include/uapi/asm/socket.h    | 13 ++++-
 arch/parisc/include/uapi/asm/socket.h  | 13 ++++-
 arch/powerpc/include/uapi/asm/socket.h |  4 +-
 arch/sparc/include/uapi/asm/socket.h   | 13 ++++-
 fs/dlm/lowcomms.c                      |  4 +-
 include/uapi/asm-generic/socket.h      | 13 ++++-
 net/compat.c                           | 14 ++---
 net/core/sock.c                        | 78 +++++++++++++++++++-------
 net/vmw_vsock/af_vsock.c               |  4 +-
 10 files changed, 126 insertions(+), 43 deletions(-)


base-commit: a4983672f9ca4c8393f26b6b80710e6c78886b8c
prerequisite-patch-id: a03ec6afbdd328cd90557f7ee6675016a5f5c653
prerequisite-patch-id: 724d26c3036e6f3a38f810c2f10db3f7ddbf843b
prerequisite-patch-id: 14017867b6eb4d5231eec1b563edcd840a1be26e
prerequisite-patch-id: 8df0edfd9b973ff5aae91c7709c8223be096a5bc
prerequisite-patch-id: 9850ad48d41bf068f074c0dd3c7610fb7177c89f
prerequisite-patch-id: bd31f35bba11902d1cc3e8726492b54df34b5c59
prerequisite-patch-id: ea4b005c5ad188a4e0899d728357c114710a3a8e
prerequisite-patch-id: cc3ee912c1ee1ea502ca079de81236a467950501
-- 
2.17.1

Cc: ccaulfie@redhat.com
Cc: cluster-devel@redhat.com
Cc: davem@davemloft.net
Cc: deller@gmx.de
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: sparclinux@vger.kernel.org
