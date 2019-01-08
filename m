Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6934BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49F218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae4bfRVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfAHD11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:27:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47020 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfAHD1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:27:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so1180387pfe.13;
        Mon, 07 Jan 2019 19:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=53eG1MihA10uvQoTcq8xNmo0jwEZfSdP9MAYM6dnCwE=;
        b=ae4bfRVYI1XkhhEGb/HrAWI7BnG1FSa4PMhM2M0T/1PWxR64gSM08cCTUbVBE0NJZc
         BBzFzIQPa6ILqK5LOD4rhZEUZoQavohnw4Z3XqkABBHAoueWVWckWPd0qxLoXo2YXsig
         3D9LoMEe6oaI8A9JyO6ZDFZjKOA/SOOBimsnVMjr+1wed8pUyjLF11SlNbJVeMyDOsgN
         c3VRAaX3nBTNW4wnvJWwzCPTIduDwxiximYvoc7UbHXZhON+oC7hrc2LEtLazTzxInS3
         zGTHzD4fc8jrpW+vcuEQmTqK66+djxBj5vFobrxi5oZKD1zGuwVIDE6ZdvAk3jqY+FOo
         gAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=53eG1MihA10uvQoTcq8xNmo0jwEZfSdP9MAYM6dnCwE=;
        b=fA6AWHHTs0AHkRJCvc691O9cfvaESbCD/cxlwbYjse1RWTdo6FWijCay92nPD2I5QN
         BGF1iccfcriNXLcH7C7J9EKGQ4c3Dx7V+r6SlYEkS4uH1N/V/8AASgxghW/Up3vWncbK
         f0VKHjZQI8qCCyHJgC5sQWB4LfSI/WwBzrPbxUtXCGgy4ib1w93TPNH86ilcPWPgiOHR
         wwOYeQWwlKcMyUQ1p4W8HDU9tEKEm2K/irH6nZBygTGsomB2EbE8hZaN+dGa1vg8KuMt
         p/gopQpJy2qG8JdZ7VX8bbO63xQuV/2f9PEAOwBO5DHQmJ8SYfBZYvMj7Lz8+/8iybRp
         QvVg==
X-Gm-Message-State: AJcUukeWWPtkWWST8UbqWaq5jvMD18GFI+6GzFpJmIMQ71AxFwSEB3A+
        Vs99vdOvrbP5MUq+S1+C1PQ=
X-Google-Smtp-Source: ALg8bN6A2S/+GVzjlJQge9lohppjl7LjHIqtUHHnMnd7fpZx7DKOG2rXKxbwL0UlzA5TblfVxTAuTw==
X-Received: by 2002:a62:1e87:: with SMTP id e129mr77257pfe.221.1546918044030;
        Mon, 07 Jan 2019 19:27:24 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id v5sm117327735pgn.5.2019.01.07.19.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:27:23 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        chris@zankel.net, deller@gmx.de, dhowells@redhat.com,
        fenghua.yu@intel.com, isdn@linux-pingi.de, jejb@parisc-linux.org,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        ubraun@linux.ibm.com
Subject: [PATCH v3 0/8] net: y2038-safe socket timestamps 
Date:   Mon,  7 Jan 2019 19:26:49 -0800
Message-Id: <20190108032657.8331-1-deepa.kernel@gmail.com>
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

The overview of the series is as below:
1. Delete asm specific socket.h when possible.
2. Support SO/SCM_TIMESTAMP* options only in userspace.
3. Rename current SO/SCM_TIMESTAMP* to SO/SCM_TIMESTAMP*_OLD.
3. Alter socket options so that SOCK_RCVTSTAMPNS does
   not rely on SOCK_RCVTSTAMP.
4. Introduce y2038 safe types for socket timestamp.
5. Introduce new y2038 safe socket options SO/SCM_TIMESTAMP*_NEW.

Changes since v2:
* Removed extra functions to reduce diff churn as per code review

Changes since v1:
* Dropped the change to disentangle sock flags
* Renamed sock_timeval to __kernel_sock_timeval
* Updated a few comments
* Added documentation changes

Deepa Dinamani (8):
  arch: Use asm-generic/socket.h when possible
  sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
  arch: sparc: Override struct __kernel_old_timeval
  socket: Use old_timeval types for socket timestamps
  socket: Add struct __kernel_sock_timeval
  socket: Add SO_TIMESTAMP[NS]_NEW
  socket: Add SO_TIMESTAMPING_NEW
  socket: Update timestamping Documentation

 Documentation/networking/timestamping.txt |  43 +++++++-
 arch/alpha/include/uapi/asm/socket.h      |  35 +++++--
 arch/ia64/include/uapi/asm/Kbuild         |   1 +
 arch/ia64/include/uapi/asm/socket.h       | 120 ---------------------
 arch/mips/include/uapi/asm/socket.h       |  34 ++++--
 arch/parisc/include/uapi/asm/socket.h     |  34 ++++--
 arch/s390/include/uapi/asm/Kbuild         |   1 +
 arch/s390/include/uapi/asm/socket.h       | 117 ---------------------
 arch/sparc/include/uapi/asm/posix_types.h |  10 ++
 arch/sparc/include/uapi/asm/socket.h      |  36 +++++--
 arch/x86/include/uapi/asm/Kbuild          |   1 +
 arch/x86/include/uapi/asm/socket.h        |   1 -
 arch/xtensa/include/asm/Kbuild            |   1 +
 arch/xtensa/include/uapi/asm/Kbuild       |   1 +
 arch/xtensa/include/uapi/asm/socket.h     | 122 ----------------------
 drivers/isdn/mISDN/socket.c               |   2 +-
 include/linux/skbuff.h                    |  24 ++++-
 include/linux/socket.h                    |   8 ++
 include/net/sock.h                        |   1 +
 include/uapi/asm-generic/socket.h         |  35 +++++--
 include/uapi/linux/errqueue.h             |   4 +
 include/uapi/linux/time.h                 |   7 ++
 net/bluetooth/hci_sock.c                  |   4 +-
 net/compat.c                              |  14 +--
 net/core/scm.c                            |  27 +++++
 net/core/sock.c                           |  43 ++++++--
 net/ipv4/tcp.c                            |  61 +++++++----
 net/rds/af_rds.c                          |  10 +-
 net/rds/recv.c                            |  18 +++-
 net/rxrpc/local_object.c                  |   2 +-
 net/smc/af_smc.c                          |   3 +-
 net/socket.c                              |  50 ++++++---
 32 files changed, 404 insertions(+), 466 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/socket.h
 delete mode 100644 arch/s390/include/uapi/asm/socket.h
 delete mode 100644 arch/x86/include/uapi/asm/socket.h
 delete mode 100644 arch/xtensa/include/uapi/asm/socket.h


base-commit: a4983672f9ca4c8393f26b6b80710e6c78886b8c
-- 
2.17.1

Cc: chris@zankel.net
Cc: deller@gmx.de
Cc: dhowells@redhat.com
Cc: fenghua.yu@intel.com
Cc: isdn@linux-pingi.de
Cc: jejb@parisc-linux.org
Cc: linux-afs@lists.infradead.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: netdev@vger.kernel.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: schwidefsky@de.ibm.com
Cc: sparclinux@vger.kernel.org
Cc: tglx@linutronix.de
Cc: ubraun@linux.ibm.com
