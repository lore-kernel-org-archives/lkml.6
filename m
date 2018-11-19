Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D8DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0E620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b4XYqDS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0E620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeKSU5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:57:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33380 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeKSU5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:57:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so11028831pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/4wi++Ns1g9+eCwVy989457KzjcxKCXuJuZZxdu53c=;
        b=b4XYqDS98E9YovsIH0PlBxkLil/0orlc3MiP60OAosuIc6soAn2MjRBXEo+O9/5det
         Zk2fEylexrARnI+iTxWH5NP3XPxN8hBASfVdvZVynARAC8p6nQiuKQpGdwnNgeM51Ngr
         59TxFWs2XjRx7LBxTTmdGWURvhTgBQvIn0RrvMHd3ljfeT2lmegDStico+PV/Eh86QWA
         gs9BaHnamAzbzb25/3nwMuVk6adLCJ3X3q1yioeI7RaI+Spt+X/8SYXaMsbPe44z3mw7
         8rYXnYXUndWZL8sTCnvq/DHT/DvO/1FsYVeuR4XUjkn5U5x1n0s2mZsV6fwyHqeTbWc7
         U/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/4wi++Ns1g9+eCwVy989457KzjcxKCXuJuZZxdu53c=;
        b=AHR9LYri7bhlvEkuctGTHqQ08vYawCKt960Hei3OUiQxvBHWlWDlOKbI/kvm2eeI2d
         Au6vtVstlzg8KXwPC1zvbMGOoF74u8KWKlU3ctQIT+icvw3n7u6+Zvv0F3AmhPsvYY34
         rb5dgzZD5E1BsuxrF1MDH1nSGzkM3dkDTgiy6pxyI6xPc6jBQfAw+cNUbcukRiKDGq3K
         s4ie1rcQEBd0t0oZ+SnbtLLqia53w5cXYEDkiQeJK5p564SV8x7HdGgI0rT12LxJU397
         TyM2pgcUfLpGG3KU0YhZWJkIyFppOQ9KK3j8G70QISBnh2X+lHaNOR+vPKlHJro1SoRm
         zfNA==
X-Gm-Message-State: AGRZ1gKwtaABDCl/xSBMDla8JKgfI6vdXw2Vj1m2AeOmaIoxPWpFqIOH
        NJDbuN/sPb913vDFQ7Ao8SCCAJT2Gr5s2Q==
X-Google-Smtp-Source: AJdET5cfjWlV7j9q1rNiz3TJRBsc7aixXBb9YeoOGK7nL4lYr/OUdQJVjnsxkcWSKlYg4CODia7oQA==
X-Received: by 2002:a63:e348:: with SMTP id o8mr19305080pgj.158.1542623633660;
        Mon, 19 Nov 2018 02:33:53 -0800 (PST)
Received: from localhost.localdomain ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id d21sm32958139pgv.37.2018.11.19.02.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:33:53 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH] procfd_signal.2: document procfd_signal syscall
Date:   Mon, 19 Nov 2018 11:32:40 +0100
Message-Id: <20181119103241.5229-4-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119103241.5229-1-christian@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christian Brauner <christian@brauner.io>
---
Changelog:
v1:
- patch introduced
---
 man2/procfd_signal.2 | 147 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 man2/procfd_signal.2

diff --git a/man2/procfd_signal.2 b/man2/procfd_signal.2
new file mode 100644
index 000000000..6af0b74f4
--- /dev/null
+++ b/man2/procfd_signal.2
@@ -0,0 +1,147 @@
+.\" Copyright (C) 2018 Christian Brauner <christian@brauner.io>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.\"
+.TH PROCFD_SIGNAL 2 2017-09-15 "Linux" "Linux Programmer's Manual"
+.SH NAME
+procfd_signal \- send signal to a process through a process descriptor
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.B #include <signal.h>
+.PP
+.BI "int procfd_signal(int " fd ", int " sig ", siginfo_t *" info ", int " flags );
+.fi
+.SH DESCRIPTION
+.BR procfd_signal ()
+sends the signal specified in
+.I sig
+to the process identified by the file descriptor
+.IR fd .
+The permissions required to send a signal are the same as for
+.BR kill (2).
+As with
+.BR kill (2),
+the null signal (0) can be used to check if a process with a given
+PID exists.
+.PP
+The optional
+.I info
+argument specifies the data to accompany the signal.
+This argument is a pointer to a structure of type
+.IR siginfo_t ,
+described in
+.BR sigaction (2)
+(and defined by including
+.IR <sigaction.h> ).
+The caller should set the following fields in this structure:
+.TP
+.I si_code
+This must be one of the
+.B SI_*
+codes in the Linux kernel source file
+.IR include/asm-generic/siginfo.h ,
+with the restriction that the code must be negative
+(i.e., cannot be
+.BR SI_USER ,
+which is used by the kernel to indicate a signal sent by
+.BR kill (2))
+and cannot (since Linux 2.6.39) be
+.BR SI_TKILL
+(which is used by the kernel to indicate a signal sent using
+.\" tkill(2) or
+.BR tgkill (2)).
+.TP
+.I si_pid
+This should be set to a process ID,
+typically the process ID of the sender.
+.TP
+.I si_uid
+This should be set to a user ID,
+typically the real user ID of the sender.
+.TP
+.I si_value
+This field contains the user data to accompany the signal.
+For more information, see the description of the last
+.RI ( "union sigval" )
+argument of
+.BR sigqueue (3).
+.PP
+Internally, the kernel sets the
+.I si_signo
+field to the value specified in
+.IR sig ,
+so that the receiver of the signal can also obtain
+the signal number via that field.
+.PP
+The
+.I flags
+argument is reserved for future extension and must be set to 0.
+.PP
+.SH RETURN VALUE
+On success, this system call returns 0.
+On error, it returns \-1 and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EBADF
+.I fd
+is not a valid file descriptor.
+.TP
+.B EINVAL
+An invalid signal was specified.
+.TP
+.B EINVAL
+.I fd
+does not refer to a process.
+.TP
+.B EINVAL
+The flags argument was not 0.
+.TP
+.B EPERM
+The caller does not have permission to send the signal to the target.
+For the required permissions, see
+.BR kill (2).
+Or:
+.I uinfo->si_code
+is invalid.
+.TP
+.B ESRCH
+The process or process group does not exist.
+Note that an existing process might be a zombie,
+a process that has terminated execution, but
+has not yet been
+.BR wait (2)ed
+for.
+.SH CONFORMING TO
+This system call is Linux-specific.
+.SH SEE ALSO
+.BR kill (2),
+.BR sigaction (2),
+.BR sigprocmask (2),
+.BR tgkill (2),
+.BR pthread_sigqueue (3),
+.BR rt_sigqueueinfo (2),
+.BR sigqueue (3),
+.BR signal (7)
-- 
2.19.1

