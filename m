Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB69C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DF920837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LC3y3AYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DF920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLHFla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 00:41:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37032 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLHFl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 00:41:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so2780023plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 21:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQAXgi+j/ERE25d+3D2m/8mS9QlI7vr9w7Yoms9bDb4=;
        b=LC3y3AYFcTOiQocBdci6gOEGXKaYjc9Bcc68w0/+AsWBafy+FJRddw0NE4tXyQNV0x
         F7devvizFjwo9/PF54MbR6mYYGSPqjaQ5FGVbb45S2nEj/HtumxtKkrx5NjuwOqDwtAz
         6DIjpvzxJt8GkkcE0L4hP/unaCX4rIyJK8XBHaLyIjkT1jXWS7pz3CSSo6yA9O28mkNS
         AU+KRkYv1Z1A7r85vmHZcNCwyoIC5EuuiqLGvXaL6+X//u09Y+wPy/NlDTZRf3K/emrz
         2qpQzZjtVv/yigmqTx45Jcc1hQatUTVK4t3a03r3sQ/vC0tBcGUR8PFz3z+1VG7GuUi6
         YO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQAXgi+j/ERE25d+3D2m/8mS9QlI7vr9w7Yoms9bDb4=;
        b=MxHBsSMDO1n0qlb40RqbbAllgEUHBWP9HEArMJRdP2v+uvfH7BjIX9hUy/mRTpnfcM
         P2S+2Lfa9JP1p0+XjhIOpmBIseB3t1FNOC2O5ew/LXkYTxOkD+iuIvhjwUh1dmUEof1J
         NmnH5Q0AuFV/PJPJtS+nrnrfZ/14+D7Ec9AVL5JUG0QWKbeg3c6VthoZ3DSF0ZGtIqmX
         ShwnVVLCsEn4/2KxEixXnEQsCnFOLIs8etR0Q2GgIFwEJLx4oERmM2LJ1RAogzzW5U9e
         JSR7xCeorpzs+JwXpa5GBpcnbrcqGBTAO4pjqdO0M1GPK9QPOt0rSL6DunXSV6sf71/9
         8gsQ==
X-Gm-Message-State: AA+aEWYh384VMcp+Eq2x1Jr9ar1FyKNcjsDbAQJSSfDQ4zP72Eyzp5Xt
        PWV/cgcmw8H5MJjeDPONla5NlJllvCpDMA==
X-Google-Smtp-Source: AFSGD/XSUtSs19cIsj7SKuPgUFaA8f9DuF4N118pxS9MMwiUgIwj+kptzogx+281nv/UsVkY8Hxiag==
X-Received: by 2002:a17:902:ba8b:: with SMTP id k11mr4658133pls.177.1544247687538;
        Fri, 07 Dec 2018 21:41:27 -0800 (PST)
Received: from localhost.localdomain ([208.181.63.202])
        by smtp.gmail.com with ESMTPSA id b10sm8249946pfj.183.2018.12.07.21.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 21:41:26 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        serge@hallyn.com, keescook@chromium.org
Cc:     jannh@google.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v5 0/1] signaling processes through pidfds 
Date:   Sat,  8 Dec 2018 06:40:58 +0100
Message-Id: <20181208054059.19813-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This is v5 of this patchset.
v5 does not introduce any functional changes since none were requested
or required in the thread. Instead, it focusses on updated documentation
making it very clear what the intentions are how to extend this syscall.

Eric, I dragged Serge into this and we went through the mails and tried
to very thoroughly address your concerns about whether the width of the
target should depend on flags or file descriptor types. As far as we
understand from the threads this was your ultimate worry and also the
reason why you withheld your agreement to the name of the syscall.
We have outlined how the syscall is intended to be extended and decided
that flags (e.g. PIDFD_TYPE_TID, PIDFD_TYPE_PGID) are the way to go. In
line with this we decided to accept "pidfd_" as prefix for the new
syscall.
All concerns we could identify and understand we tried to address. I
hope this will be sufficient for you to get behind the patch.
The relevant section in the commit message is titled:

/* sending signals to threads (tid) and process groups (pgid) */

Thanks!
Christian

Christian Brauner (1):
  signal: add pidfd_send_signal() syscall

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/proc/base.c                         |  20 +++-
 include/linux/proc_fs.h                |  12 +++
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 kernel/signal.c                        | 141 +++++++++++++++++++++++--
 7 files changed, 173 insertions(+), 9 deletions(-)

-- 
2.19.1

