Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8079BC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476F321479
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Pi5JsJCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476F321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbeLCD2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:28:45 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36824 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeLCD2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:28:45 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so6562334itj.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 19:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xooh3ENfgPFgNU5c1Z/paOWiAslSDCDRwGzwbnGZ/w=;
        b=Pi5JsJCn6oBLwQtcUsKn7bvqtUMKLq8B2984aScPxb4BrMEph1TBPzijUHBLQItVho
         UFLpkgYdpIIDYPbXjH2TcESV319d3Yztif5hfP1i9o+ubQlVih0HapM+BvI5bS70SUM0
         af5jGnTdkczjIg84vlTo1E8Lt4bNUwxLdnHLJQGuoUovTpJ/DPtOqTo1jvWvYhfycz9H
         1x7RNamWxJbodU1kkPUZ2fDNpLF8vK8BlSmHDQ6aKYlmFTr58bnTDxbqbQhYcsieHX5D
         n+qlOER3dmVDWDD31mySh2w3sSgtgVxmd70sN9SAmyLPo9ngE2GIQu0nzk5jKlogHTOJ
         z1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xooh3ENfgPFgNU5c1Z/paOWiAslSDCDRwGzwbnGZ/w=;
        b=T8AF53d3O3oV0covAgtW2W7iPL//AB5GBP9UEtUyy3VjEO22nl5uz8poMFkH2duS0X
         AVbWKjuS85coDYf6hQokQRm52YjuKSLlISbMj+qpyUxzTgIGYkp12n0B4bOggNHqmA4X
         iEL2chIKHyg5IoweeovQpptrUyyWWMLxvwnjUW6kU8kBjgN+mfEKZzfBKqwRRv4wpzxT
         k7dFx/TXQurl5o5/IUAGXQ5tbguXafMQarEzGhsbDMIiYp7N6s+7z8ZWYs8KJAIBaXsj
         dR7DmgJc0dmh7+BavXS9o56WLGYVKvsm8EJhfmnwgfC9vZhJSANW+/jhMM73Tp6bz5/j
         QLVA==
X-Gm-Message-State: AA+aEWYYJa5ICPNg1BSEDRkH6astraQtlIpLklfy0JIhBAAKEss2hzeQ
        MMFJPrkge+i2OqzKojH23FtBEg==
X-Google-Smtp-Source: AFSGD/Ub+ZGAfM9j8DySaNFET0+vN7/LfaVfa+C5RP4K4ptSgMhnRJRXb23vYHcvhjExE/qMlTvnOA==
X-Received: by 2002:a05:660c:742:: with SMTP id a2mr5624226itl.121.1543807720992;
        Sun, 02 Dec 2018 19:28:40 -0800 (PST)
Received: from cisco.lan (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id n136sm3243529itb.35.2018.12.02.19.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 19:28:40 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v9 0/4] seccomp trap to userspace
Date:   Sun,  2 Dec 2018 20:28:23 -0700
Message-Id: <20181203032827.27978-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a v9 of the seccomp trap to userspace series. Major changes are:

* drop the whole SIGNALED flag thing. This was confusing to a number of
  people, and Oleg pointed out that it makes it fairly easy to get a
  task into an uninterruptible sleep. Now, replies to a task with a
  signal will just get ENOENT, indicating that something happened to the
  other end.
* refactor the tests so that each test tests only one thing :)
* several other minor bug fixes

Cheers,

Tycho

Link to v8: https://lore.kernel.org/lkml/20181029224031.29809-1-tycho@tycho.ws/T/#u

Tycho Andersen (4):
  seccomp: hoist struct seccomp_data recalculation higher
  seccomp: switch system call argument type to void *
  seccomp: add a return code to trap to userspace
  samples: add an example of seccomp user trap

 Documentation/ioctl/ioctl-number.txt          |   1 +
 .../userspace-api/seccomp_filter.rst          |  84 ++++
 include/linux/seccomp.h                       |   9 +-
 include/uapi/linux/seccomp.h                  |  40 +-
 kernel/seccomp.c                              | 468 +++++++++++++++++-
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |   7 +-
 samples/seccomp/user-trap.c                   | 375 ++++++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 447 ++++++++++++++++-
 9 files changed, 1410 insertions(+), 22 deletions(-)
 create mode 100644 samples/seccomp/user-trap.c

-- 
2.19.1

