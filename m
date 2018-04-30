Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpdNeyF6Hn2qoA+wxlogXQW9W01WtT6dvoTOddo+7QpoGh4ZpTQeKGyad/t+EO00ZAN3Uom
ARC-Seal: i=1; a=rsa-sha256; t=1525116510; cv=none;
        d=google.com; s=arc-20160816;
        b=bnOtHTDUycVwV11PcdmVnWu22x55lUgca3Q36uyd2iRQiNICxSRHr6UFvULaM+Hu5G
         j2KFbm/YUl+eJq1cIMLAh01xVSbTa3exfbwuqVMejOgKvcxSo5yljSZumyByEt4EFF3q
         WpM0NSWl8olr0vj8poTtOv1XSdne5tGq0Swsc4MXVJn6nZv4yCR+3qAc/TzESTR8fW+D
         okwWN+LRVLrbQD9VSR4m0Rmm98d/iDmckkWnbU3Wnfd90u5QIDrr2AUemuJfqJsexkyl
         oaOfNUubFE7XoOiyKIn5RqQylPd8ovdEPl5peJWuHDJk000LbhVZQ9BijcGHnkMBZi5N
         5dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=s/gL8QYpANeaKNHNs9yofZCbkqN/85IOaB3J3NapQbc=;
        b=G5uCkhcjgHtvmdPhQJCfqvx8k8twG24jLFies+GqkdF9BuujdPKz6/8HSvmO/zlwvD
         OJFzRx/pNBxLwbd77LL7+HQYMpZFeFOrKXm6fOd8xll6m1CE9cP2h4kwJKkuUnnZQoG3
         2p0JmfQPw8yTaWpkI6xxqYhfHFqsOK/pRnRvN4wb5JCFUIDmOL9ffsyYlnh1owTiUYgN
         hbs9MqyWLKFF1Pf5WFaTWg4ULiAU5dhuuWHVa0jR9ZnlfAR2pmj/WxYue/ZQKqwds2H9
         lOnesTZCatOEABeVgQ2UPpPuA97r0L8nopPQ/kvrTo+evruQRQUCrek8q4o6e3PzFdnA
         hhmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F3422DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com,
	Martijn Coenen <maco@android.com>
Subject: [PATCH 4.16 068/113] ANDROID: binder: prevent transactions into own process.
Date: Mon, 30 Apr 2018 12:24:39 -0700
Message-Id: <20180430184018.103018616@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200504167877540?=
X-GMAIL-MSGID: =?utf-8?q?1599200570273967043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martijn Coenen <maco@android.com>

commit 7aa135fcf26377f92dc0680a57566b4c7f3e281b upstream.

This can't happen with normal nodes (because you can't get a ref
to a node you own), but it could happen with the context manager;
to make the behavior consistent with regular nodes, reject
transactions into the context manager by the process owning it.

Reported-by: syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com
Signed-off-by: Martijn Coenen <maco@android.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2839,6 +2839,14 @@ static void binder_transaction(struct bi
 			else
 				return_error = BR_DEAD_REPLY;
 			mutex_unlock(&context->context_mgr_node_lock);
+			if (target_node && target_proc == proc) {
+				binder_user_error("%d:%d got transaction to context manager from process owning it\n",
+						  proc->pid, thread->pid);
+				return_error = BR_FAILED_REPLY;
+				return_error_param = -EINVAL;
+				return_error_line = __LINE__;
+				goto err_invalid_target_handle;
+			}
 		}
 		if (!target_node) {
 			/*
