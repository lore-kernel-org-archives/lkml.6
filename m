Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924B2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609312146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609312146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeK3TIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:08:51 -0500
Received: from nov-007-i650.relay.mailchannels.net ([46.232.183.204]:14803
        "EHLO nov-007-i650.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbeK3TIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:08:51 -0500
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id F39172EC0008;
        Fri, 30 Nov 2018 08:00:20 +0000 (UTC)
Received: from srv17.tophost.ch (swiss-ingress-1.mailchannels.ch [46.232.183.5])
        by relay.mailchannels.net (Postfix) with ESMTPA id 9E05C2EC0030;
        Fri, 30 Nov 2018 08:00:17 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Fri, 30 Nov 2018 08:00:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Trail-Stretch: 1c69c3a646219a7e_1543564820657_4100978092
X-MC-Loop-Signature: 1543564820657:4136570025
X-MC-Ingress-Time: 1543564820656
Received: from [88.98.246.21] (port=60558 helo=jx1y.mynet)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1gSdih-002eST-90; Fri, 30 Nov 2018 09:00:15 +0100
From:   =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH v2 0/1] Add prctl to kill descendants on exit
Date:   Fri, 30 Nov 2018 08:00:03 +0000
Message-Id: <20181130080004.23635-1-j@bitron.ch>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181127225408.7553-2-j@bitron.ch>
References: <20181127225408.7553-2-j@bitron.ch>
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
2.19.2

