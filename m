Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755285AbeDWNa7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:30:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44828 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755059AbeDWNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:30:56 -0400
X-Google-Smtp-Source: AIpwx4+xP8vTFc9mPV3r32LvMEGUSwSVqKkxS320f2otdlV4YroByogh31EB0eSJuw/as8C+HRq6BA==
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
Date: Mon, 23 Apr 2018 15:30:12 +0200
Message-Id: <20180423133015.5455-1-dh.herrmann@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This series adds a new LSM hook for the socketpair(2) syscall. The idea
is to allow SO_PEERSEC to be called on AF_UNIX sockets created via
socketpair(2), and return the same information as if you emulated
socketpair(2) via a temporary listener socket. Right now SO_PEERSEC
will return the unlabeled credentials for a socketpair, rather than the
actual credentials of the creating process.

A simple call to:

    socketpair(AF_UNIX, SOCK_STREAM, 0, out);

can be emulated via a temporary listener socket bound to a unique,
random name in the abstract namespace. By connecting to this listener
socket, accept(2) will return the second part of the pair. If
SO_PEERSEC is queried on these, the correct credentials of the creating
process are returned. A simple comparison between the behavior of
SO_PEERSEC on socketpair(2) and an emulated socketpair is included in
the dbus-broker test-suite [1].

This patch series tries to close this gap and makes both behave the
same. A new LSM-hook is added which allows LSMs to cache the correct
peer information on newly created socket-pairs.

Apart from fixing this behavioral difference, the dbus-broker project
actually needs to query the credentials of socketpairs, and currently
must resort to racy procfs(2) queries to get the LSM credentials of its
controller socket. Several parts of the dbus-broker project allow you
to pass in a socket during execve(2), which will be used by the child
process to accept control-commands from its parent. One natural way to
create this communication channel is to use socketpair(2). However,
right now SO_PEERSEC does not return any useful information, hence, the
child-process would need other means to retrieve this information. By
avoiding socketpair(2) and using the hacky-emulated version, this is not
an issue.

There was a previous discussion on this matter [2] roughly a year ago.
Back then there was the suspicion that proper SO_PEERSEC would confuse
applications. However, we could not find any evidence backing this
suspicion. Furthermore, we now actually see the contrary. Lack of
SO_PEERSEC makes it a hassle to use socketpairs with LSM credentials.
Hence, we propose to implement full SO_PEERSEC for socketpairs.

This series only adds SELinux backends, since that is what we need for
RHEL. I will gladly extend the other LSMs if needed.

Thanks
David

[1] https://github.com/bus1/dbus-broker/blob/master/src/util/test-peersec.c
[2] https://www.spinics.net/lists/selinux/msg22674.html

David Herrmann (3):
  security: add hook for socketpair(AF_UNIX, ...)
  net/unix: hook unix_socketpair() into LSM
  selinux: provide unix_stream_socketpair callback

 include/linux/lsm_hooks.h |  8 ++++++++
 include/linux/security.h  |  7 +++++++
 net/unix/af_unix.c        |  5 +++++
 security/security.c       |  6 ++++++
 security/selinux/hooks.c  | 14 ++++++++++++++
 5 files changed, 40 insertions(+)

-- 
2.17.0
