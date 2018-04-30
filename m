Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqE41RvOiBK/9NnMqEcEyOrk95fXSqlxY4pCFdWeunPupLj1q6qIjFRERvL5sXY2uvB7ndh
ARC-Seal: i=1; a=rsa-sha256; t=1525116447; cv=none;
        d=google.com; s=arc-20160816;
        b=GPVPhAKCIVr+NXd6AzZHwX6he5H6k34miEEMy5qZRc2uW6nxjSYvAKOb7Oc6OApQzF
         Tzciv5GrFoXsbkpq69Sqfd3Illl18rwmGllHRq0RNInJDWcZYJu1fzlccRMcCehNnmfw
         eLNTEf0q4TwSZi01Xy/GAa5+rwQ7rExn32BXfwyBF3bE8GwvUODkiNqGwUa4ZYzBwtI4
         2aRrY81IoQ7kQ8aDh3oaXwQl8Zb+qB9TcKAb2142jvTfK/IMq1MI91PzWyCqWe0Tvmq/
         vVoFqXrNQfAxUVsK7r0Wff6bkoIbBLqc1qGJZnH1BdjCg/vtTWFo43SUMgNMINiPu4Wu
         kdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=BTvgHnWiHcfOpP/OTayW4ZkeAnpNIrNKpqD2akEEqgs=;
        b=ne1HvSmolpdnE2S4XRqp2gNDETMdk84YZ3yiGh0hRqb9NAY2ZZDXXba1IEtAAJZml5
         48bYvPKtd3Zqqm+ERydJ6buCYB64+T8OT23IVjL9aKFSKi5YnD+oTzteJwMMHk7XzeFO
         63TZKmIkj5S+CJtRbOS/ThmkGuDMbqvAndTQ3WLAEfttXyG5KbZRkKHfyeyvHNAB29dV
         MP1Bp3MH+d+A2ksNi0puFdpOPooh0demOk2MIJPdTCBJj7gTcakuv+2a9th29X6cXaZR
         1WbCsfxbFr+Fz3kxRWOnXLSUy0viyyV9rcfVJoMLNxWDZT6YdR+/HVlJAa7knDaoh42j
         fo4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1210522DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com,
	Martijn Coenen <maco@android.com>
Subject: [PATCH 4.14 59/91] ANDROID: binder: prevent transactions into own process.
Date: Mon, 30 Apr 2018 12:24:41 -0700
Message-Id: <20180430184007.246412352@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200504167877540?=
X-GMAIL-MSGID: =?utf-8?q?1599200504167877540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2785,6 +2785,14 @@ static void binder_transaction(struct bi
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
