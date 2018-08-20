Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9ACC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C5121531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R96Qj5ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C5121531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeHTSjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:39:46 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:51217 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:39:45 -0400
Received: by mail-wm0-f45.google.com with SMTP id y2-v6so14708835wma.1;
        Mon, 20 Aug 2018 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hk7cJfXZ+DGdx8wx4WWW9gzJjd/2+XS3jGZqVx+kW7s=;
        b=R96Qj5epCaclrmmPfHOjVB3rFuPxjSVGoQT4448bBLlOAPYYENKnz8PMd1f3DB8xYw
         kcrI3tF2Msa4Gpa0u+0xqqwCP+gx/cbqjm7Md6mH5bls7goVtYKoMdoNpN+I35x+PTOg
         v6gFd5MEj9k8TaBAhXZuYJDNJdTAmxqabyVz8OfXl7H1pLbiOwJ2yHBFhjNISjp0LcoM
         6W/dua6xdDCXPCISTmunM8StUXhrt63STw/LISX7GtkjgPvOyWXnv+xWvgcYq7Qt0CAw
         Fws/0MUbPYsPkEgughLbAbNbnLDv+1IBeSrqcjuNe5bwr2zfO3sfIxAKageMTIZOVDJp
         ++MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hk7cJfXZ+DGdx8wx4WWW9gzJjd/2+XS3jGZqVx+kW7s=;
        b=Kis1foSXZm5Js+4DzyKuqXHoeb+WqIr2Rk0uPNRt5grnesbGczbHk/4sEpnzCOIpvB
         euSeAXWG19LAPvwqVwbthcP7RwOdhrwVD0XsULfGSfkOuCDZu67V9SBW5e2yMjYXtjiF
         m5B7Hi30VBbwPbbI11yAOcGATu8/6yw6ZGLcqD5STObvkLb+rh6LXpEmiCzy3cfbN3qZ
         SL9dNs1dNt4QwDKNKfrHTEpEEEqjfeH2ylYOa5eNdw3jNXl25jvNdT107PejPaizUUzR
         KHe1JY4eLAShf0eWAjhAmyx498I0vJWw3Dr0+YnB+4PUvLu7L5V4aW2VtBY2jVy0v8Zs
         vRGQ==
X-Gm-Message-State: AOUpUlEX1CIAqYzQLeOa+9vDn8ztFVXgTRVGFHOW19b0fmcGeiSWxqX5
        3LcZUPUbJh9LWYyeBus3VGKDe792
X-Google-Smtp-Source: AA+uWPyKGaFrg4aF+UZC+Y+o6LdntVsNaWGyx1xiY5TUFXCvyKsdfZCNqhMg/4y57oHICxxX7n7NKA==
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr24613010wmd.60.1534778618947;
        Mon, 20 Aug 2018 08:23:38 -0700 (PDT)
Received: from orange.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l24-v6sm10027128wrb.65.2018.08.20.08.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 08:23:38 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 4.19-rc1
Date:   Mon, 20 Aug 2018 17:23:22 +0200
Message-Id: <20180820152322.29372-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.19-rc1

for you to fetch changes up to 0fcf6c02b205f80f24eb548b236543ec151cb01c:

  ceph: don't drop message if it contains more data than expected (2018-08-13 17:55:44 +0200)

----------------------------------------------------------------
The main things are support for cephx v2 authentication protocol and
basic support for rbd images within namespaces (myself).  Also included
y2038 conversion patches from Arnd, a pile of miscellaneous fixes from
Chengguang and Zheng's feature bit infrastructure for the filesystem.

----------------------------------------------------------------
Arnd Bergmann (5):
      libceph: use timespec64 in for keepalive2 and ticket validity
      ceph: stop using current_kernel_time()
      ceph: use timespec64 for inode timestamp
      libceph: use timespec64 for r_mtime
      ceph: use timespec64 for r_stamp

Chengguang Xu (14):
      ceph: add retry logic for error -ERANGE in ceph_get_acl()
      ceph: restore ctime as well in the case of restoring old mode
      libceph: stop parsing when a bad int arg is detected
      ceph: return errors from posix_acl_equiv_mode() correctly
      ceph: add d_drop for some error cases in ceph_mknod()
      ceph: add d_drop for some error cases in ceph_symlink()
      ceph: add new field max_file_size in ceph_fs_client
      ceph: add additional range check in ceph_fallocate()
      ceph: add additional offset check in ceph_write_iter()
      ceph: add additional size check in ceph_setattr()
      ceph: compare fsc->max_file_size and inode->i_size for max file size limit
      ceph: change to void return type for __do_request()
      ceph: refactor ceph_unreserve_caps()
      ceph: refactor error handling code in ceph_reserve_caps()

Ilya Dryomov (14):
      libceph: make ceph_osdc_notify{,_ack}() payload_len u32
      libceph: change ceph_pagelist_encode_string() to take u32
      libceph: amend "bad option arg" error message
      rbd: pass rbd_spec into parse_rbd_opts_token()
      rbd: support for images within namespaces
      libceph: remove now unused ceph_{en,de}code_timespec()
      libceph: store ceph_auth_handshake pointer in ceph_connection
      libceph: factor out __prepare_write_connect()
      libceph: factor out __ceph_x_decrypt()
      libceph: factor out encrypt_authorizer()
      libceph: add authorizer challenge
      libceph: implement CEPHX_V2 calculation mode
      libceph: check authorizer reply/challenge length before reading
      libceph: weaken sizeof check in ceph_x_verify_authorizer_reply()

Souptick Joarder (1):
      ceph: adding new return type vm_fault_t

Stephen Hemminger (1):
      ceph: fix whitespace

Yan, Zheng (3):
      ceph: fix incorrect use of strncpy
      ceph: support cephfs' own feature bits
      ceph: don't drop message if it contains more data than expected

YueHaibing (2):
      libceph: remove unnecessary non NULL check for request_key
      crush: fix using plain integer as NULL warning

 drivers/block/rbd.c                | 125 +++++++++++++------
 fs/ceph/acl.c                      |  30 +++--
 fs/ceph/addr.c                     |  74 ++++++------
 fs/ceph/cache.c                    |  11 +-
 fs/ceph/caps.c                     | 138 ++++++++++-----------
 fs/ceph/dir.c                      |  20 ++--
 fs/ceph/file.c                     |  34 ++++--
 fs/ceph/inode.c                    |  83 ++++++-------
 fs/ceph/mds_client.c               |  98 ++++++++++-----
 fs/ceph/mds_client.h               |  14 ++-
 fs/ceph/quota.c                    |   2 +-
 fs/ceph/snap.c                     |   6 +-
 fs/ceph/super.c                    |   6 +-
 fs/ceph/super.h                    |  12 +-
 fs/ceph/xattr.c                    |   4 +-
 include/linux/ceph/auth.h          |   8 ++
 include/linux/ceph/ceph_features.h |   7 +-
 include/linux/ceph/decode.h        |  18 ++-
 include/linux/ceph/messenger.h     |   8 +-
 include/linux/ceph/msgr.h          |   2 +-
 include/linux/ceph/osd_client.h    |  10 +-
 include/linux/ceph/pagelist.h      |   2 +-
 net/ceph/Kconfig                   |   1 -
 net/ceph/Makefile                  |   1 -
 net/ceph/auth.c                    |  16 +++
 net/ceph/auth_none.c               |   1 -
 net/ceph/auth_none.h               |   1 -
 net/ceph/auth_x.c                  | 239 +++++++++++++++++++++++++++++--------
 net/ceph/auth_x.h                  |   3 +-
 net/ceph/auth_x_protocol.h         |   7 ++
 net/ceph/ceph_common.c             |  13 +-
 net/ceph/cls_lock_client.c         |   4 +-
 net/ceph/crush/mapper.c            |   4 +-
 net/ceph/messenger.c               | 113 +++++++++++-------
 net/ceph/mon_client.c              |   2 +-
 net/ceph/osd_client.c              |  27 +++--
 net/ceph/pagevec.c                 |   1 -
 37 files changed, 737 insertions(+), 408 deletions(-)
