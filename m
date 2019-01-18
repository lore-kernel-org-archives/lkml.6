Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CD520883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfARNUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:20:25 -0500
Received: from nov-007-i650.relay.mailchannels.net ([46.232.183.204]:33404
        "EHLO nov-007-i650.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727100AbfARNUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:20:24 -0500
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 245F0BE0A20;
        Fri, 18 Jan 2019 13:12:00 +0000 (UTC)
Received: from srv17.tophost.ch (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTPA id B7CE8BE0724;
        Fri, 18 Jan 2019 13:11:56 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.155])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Fri, 18 Jan 2019 13:12:00 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Continue-Abaft: 7520c95450af670d_1547817119922_413462037
X-MC-Loop-Signature: 1547817119922:2121460126
X-MC-Ingress-Time: 1547817119921
Received: from [80.219.231.201] (port=59124 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1gkTwA-0002In-1q; Fri, 18 Jan 2019 14:11:54 +0100
From:   =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [RESEND PATCH v2 0/1] Add prctl to kill descendants on exit
Date:   Fri, 18 Jan 2019 14:11:29 +0100
Message-Id: <20190118131130.42209-1-j@bitron.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181127225408.7553-1-j@bitron.ch>
References: <20181127225408.7553-1-j@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new prctl to kill all descendant processes on exit.
See commit message for details of the prctl.

This is a replacement of PR_SET_PDEATHSIG_PROC I proposed last year [1].
In the following discussion, Oleg suggested this approach.

The motivation for this is to provide a lightweight mechanism to prevent
stray processes. There is also a related Bugzilla entry [2].

PID namespaces can also be used to prevent stray processes, of course.
However, they are not quite as lightweight as they typically also
require a new mount namespace to be able to mount a new /proc.  And they
require CAP_SYS_ADMIN.  User namespaces can help to gain CAP_SYS_ADMIN,
however, that further increases the overhead and the other effects of
the user namespace may not be desired.

PID 1 in PID namespaces also exhibits non-standard signal behavior
(SIGNAL_UNKILLABLE) [3].

Changes in v2:
  - Use bool instead of bitfield to avoid race with
    PR_SET_CHILD_SUBREAPER

[1] https://lkml.kernel.org/lkml/20170929123058.48924-1-j@bitron.ch/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=43300
[3] https://lkml.kernel.org/lkml/20180803144021.56920-2-j@bitron.ch/

Jürg Billeter (1):
  prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT

 fs/exec.c                    |  6 ++++++
 include/linux/sched/signal.h |  3 +++
 include/uapi/linux/prctl.h   |  4 ++++
 kernel/exit.c                | 12 ++++++++++++
 kernel/sys.c                 | 11 +++++++++++
 security/apparmor/lsm.c      |  1 +
 security/selinux/hooks.c     |  3 +++
 7 files changed, 40 insertions(+)

-- 
2.20.1

