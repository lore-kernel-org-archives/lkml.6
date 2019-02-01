Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C74C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBBB20855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upDI238A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfBAPoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:44:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37702 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfBAPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:44:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so3114420pgb.4;
        Fri, 01 Feb 2019 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d1oHH9qmXIiXpGCgUqQHpuh4pHPto/kVPpEYkxMtaPI=;
        b=upDI238Au5WzLUcbP0KPdIxH87BWPY3pfL/PyFa/sxwE/KkkNoZBWeAmH4VJemBCbJ
         hwNipV1oHGdiA28RwSGIgzNHBis9kluvGoGqsfqYUx9SbpEhKtGfIkVCEbTnQhbvUNxA
         AnBzqzq8hPgqcMfmucZIfPuD7VFhLFbP5/ayfqwYMgBEpoZib3amXefOMlwnFtE0k9SI
         0PUCcovNyvoCpCIcykGN9RgKZICiq+YBTV2/PdKs2Ulsv/VzUrbKfW7WT01N561D53RK
         zk2E5CF5aW+S2VTLG/5faBCAHdi8L9bo/lgTJaq3Q2vQAdkFxAdfinE/TwMbBqafMlVV
         +a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d1oHH9qmXIiXpGCgUqQHpuh4pHPto/kVPpEYkxMtaPI=;
        b=oWgjCQtgFl4mNlzogGcMthxy5WgFUvEwoN67J4Fgz5eRNE87WIOZGBuR966a59DGcS
         ADCXWkp9Q8UdcHcH+N9GYlVbfOGlSL9YRuIcNUugI6fcW6YpWYyodSvBQEHs+eG3ireM
         XNKkN4dTZUmn823yGq5TkGYBx3zhMGoRNKdGj5rmALv1MvYPBzL4J5xk+vAoASFSHG3U
         VzaHLLqo0u7bsyzYrJxjGULxe+c2NvwR9qqeEOr8+QQOEz7qqZnqZnxtQjV3qCproavX
         HfPekrX0wW3ftb9BUF/aRHvDn0RLZnF5kDSybExI2+xAh1SMUtVVFUAy6PD+dG2qu86b
         Fc3Q==
X-Gm-Message-State: AHQUAua0nvylYn3TJAZxnJTvOhotuJfgGhaLEeOvUvQZjGk6yUpuoZRY
        wrQ+a8P8FVA+eVd+70gSGaNd8S1dfxQ=
X-Google-Smtp-Source: AHgI3IZ9lBl0FIUC8xg+/A8ZoaR7KDlu1nBSN4YjDV4BO0jel7leTN3+aF7knnr6wT2wtVfk7yzmOg==
X-Received: by 2002:a63:5346:: with SMTP id t6mr2798384pgl.40.1549035867857;
        Fri, 01 Feb 2019 07:44:27 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id z9sm25886959pfd.99.2019.02.01.07.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:44:26 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next v4 00/12] net: y2038-safe socket timestamps 
Date:   Fri,  1 Feb 2019 07:43:44 -0800
Message-Id: <20190201154356.15536-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series introduces new socket timestamps that are
y2038 safe.

The time data types used for the existing socket timestamp
options: SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING
are not y2038 safe. The series introduces SO_TIMESTAMP_NEW,
SO_TIMESTAMPNS_NEW and SO_TIMESTAMPING_NEW to replace these.
These new timestamps can be used on all architectures.

The alternative considered was to extend the sys_setsockopt()
by using the flags. We did not receive any strong opinions about
either of the approaches. Hence, this was chosen, as glibc folks
preferred this.

The series does not deal with updating the internal kernel socket
calls like rxrpc to make them y2038 safe. This will be dealt
with separately.

Note that the timestamps behavior already does not match the
man page specific behavior:
SIOCGSTAMP
    This ioctl should only be used if the socket option SO_TIMESTAMP
	is not set on the socket. Otherwise, it returns the timestamp of
	the last packet that was received while SO_TIMESTAMP was not set,
	or it fails if no such packet has been received,
	(i.e., ioctl(2) returns -1 with errno set to ENOENT).
	
The recommendation is to update the man page to remove the above statement.

The overview of the socket timestamp series is as below:
1. Delete asm specific socket.h when possible.
2. Support SO/SCM_TIMESTAMP* options only in userspace.
3. Rename current SO/SCM_TIMESTAMP* to SO/SCM_TIMESTAMP*_OLD.
3. Alter socket options so that SOCK_RCVTSTAMPNS does
   not rely on SOCK_RCVTSTAMP.
4. Introduce y2038 safe types for socket timestamp.
5. Introduce new y2038 safe socket options SO/SCM_TIMESTAMP*_NEW.
6. Intorduce new y2038 safe socket timeout options.

Changes since v3:
* Rebased onto net-next and fixups as per review comments
* Merged the socket timeout series
* Integrated Arnd's patch to simplify compat handling of timeout syscalls

Changes since v2:
* Removed extra functions to reduce diff churn as per code review

Changes since v1:
* Dropped the change to disentangle sock flags
* Renamed sock_timeval to __kernel_sock_timeval
* Updated a few comments
* Added documentation changes

Arnd Bergmann (1):
  socket: move compat timeout handling into sock.c

Deepa Dinamani (11):
  selftests: add missing include unistd
  arch: Use asm-generic/socket.h when possible
  sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
  arch: sparc: Override struct __kernel_old_timeval
  socket: Use old_timeval types for socket timestamps
  socket: Add struct __kernel_sock_timeval
  socket: Add SO_TIMESTAMP[NS]_NEW
  socket: Add SO_TIMESTAMPING_NEW
  socket: Update timestamping Documentation
  socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
  sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW

 Documentation/networking/timestamping.txt     |  43 ++++-
 arch/alpha/include/uapi/asm/socket.h          |  47 ++++--
 arch/ia64/include/uapi/asm/Kbuild             |   1 +
 arch/ia64/include/uapi/asm/socket.h           | 122 --------------
 arch/mips/include/uapi/asm/socket.h           |  47 ++++--
 arch/parisc/include/uapi/asm/socket.h         |  46 ++++--
 arch/powerpc/include/uapi/asm/socket.h        |   4 +-
 arch/s390/include/uapi/asm/Kbuild             |   1 +
 arch/s390/include/uapi/asm/socket.h           | 119 --------------
 arch/sparc/include/uapi/asm/posix_types.h     |  10 ++
 arch/sparc/include/uapi/asm/socket.h          |  49 ++++--
 arch/x86/include/uapi/asm/Kbuild              |   1 +
 arch/x86/include/uapi/asm/socket.h            |   1 -
 arch/xtensa/include/asm/Kbuild                |   1 +
 arch/xtensa/include/uapi/asm/Kbuild           |   1 +
 arch/xtensa/include/uapi/asm/socket.h         | 124 --------------
 drivers/isdn/mISDN/socket.c                   |   2 +-
 fs/dlm/lowcomms.c                             |   4 +-
 include/linux/skbuff.h                        |  24 ++-
 include/linux/socket.h                        |   8 +
 include/net/sock.h                            |   1 +
 include/uapi/asm-generic/socket.h             |  48 ++++--
 include/uapi/linux/errqueue.h                 |   4 +
 include/uapi/linux/time.h                     |   7 +
 net/bluetooth/hci_sock.c                      |   4 +-
 net/compat.c                                  |  78 +--------
 net/core/scm.c                                |  27 ++++
 net/core/sock.c                               | 151 +++++++++++++-----
 net/ipv4/tcp.c                                |  61 ++++---
 net/rds/af_rds.c                              |  10 +-
 net/rds/recv.c                                |  18 ++-
 net/rxrpc/local_object.c                      |   2 +-
 net/smc/af_smc.c                              |   3 +-
 net/socket.c                                  |  50 ++++--
 net/vmw_vsock/af_vsock.c                      |   4 +-
 .../networking/timestamping/rxtimestamp.c     |   1 +
 36 files changed, 541 insertions(+), 583 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/socket.h
 delete mode 100644 arch/s390/include/uapi/asm/socket.h
 delete mode 100644 arch/x86/include/uapi/asm/socket.h
 delete mode 100644 arch/xtensa/include/uapi/asm/socket.h

-- 
2.17.1

