Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48QOed1xs427ZNy2PhWjTiTlfycv5s+CSThFOg7lnx/DhzRN+nCCbkVyVeHn1AeVlwaRNle
ARC-Seal: i=1; a=rsa-sha256; t=1522168420; cv=none;
        d=google.com; s=arc-20160816;
        b=n8Wk7LzFfTqvtBvrkc27d1clP0MoRwq1+dqnqj5WqPg5SxrYwE6CvTNq7twl4jBhEn
         s7+AN0IysMZFDaLlxToQoKK+hHn+ji07rPgn+Cs4uDT2fjJsLy/NhweV29D8a8Nauc8U
         Aq/dzb/35itlxb3EKSlwGUdIm4qRAD/CjtyFkpHFi2d1gDyIJJEFGGcW6LPifNcj5bYb
         Vst3xMOXRZcp1d9+nLyCRXe1crPmOk4hl1W8ABiYcJ3QrUcyr8KJJzxB9jQayCN+euFT
         GG/vBw/+aIVpaDOgQkyxBmflTf9IoPvwPQRp8EQn7NE7NBIgOsTqYcJ0Tgu0c7sH6zD9
         dqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9xt1FKvniYTxZjWd4cchBsgCcKb76myOAO5T97f5GYg=;
        b=Ziaeeu1V9va9tQKQmLd5E+VVOn7oAdhJo7NGdAMaPZR11u8rRtjMJtfwcxMm9w2jCs
         PgzyUbZ8gUszLZs52NxgZmePIQWHQA+FVRyToliFMNKaQJ9zJovjusQXnW/Opu6WnWjJ
         ohAoEzWpvCZ0o8IaksD/1oqSEJRq9M2Md9/ry4/48G+zB0eO3WUk+zcNCrlLfGZyeUxR
         YhK1OF22a5K+uQcqa6+3aW6cL2lkLbCPlb9/dhtvgzvEcNnmwb6k94ujKbWqZVF74/vQ
         8PRhvUZUqIrKtjX4yL/ldhLN5PouPlI9EHDE9DoTkZN+YcDN73PzPbD238vdbYt6KQzO
         jswA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chenbo Feng <fengc@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.9 66/67] bpf: skip unnecessary capability check
Date: Tue, 27 Mar 2018 18:27:58 +0200
Message-Id: <20180327162731.414763377@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109077299522415?=
X-GMAIL-MSGID: =?utf-8?q?1596109273916519244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenbo Feng <fengc@google.com>

commit 0fa4fe85f4724fff89b09741c437cbee9cf8b008 upstream.

The current check statement in BPF syscall will do a capability check
for CAP_SYS_ADMIN before checking sysctl_unprivileged_bpf_disabled. This
code path will trigger unnecessary security hooks on capability checking
and cause false alarms on unprivileged process trying to get CAP_SYS_ADMIN
access. This can be resolved by simply switch the order of the statement
and CAP_SYS_ADMIN is not required anyway if unprivileged bpf syscall is
allowed.

Signed-off-by: Chenbo Feng <fengc@google.com>
Acked-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -801,7 +801,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf
 	union bpf_attr attr = {};
 	int err;
 
-	if (!capable(CAP_SYS_ADMIN) && sysctl_unprivileged_bpf_disabled)
+	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (!access_ok(VERIFY_READ, uattr, 1))
