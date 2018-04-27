Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqLYdAmzp6ZGk4eS3SJuB3kHpdAXiT1AG1REx5wkGLoeAiX+gKKzYA8zRDErdVfHubcU1vA
ARC-Seal: i=1; a=rsa-sha256; t=1524838332; cv=none;
        d=google.com; s=arc-20160816;
        b=UxFXzRM4OP4BYj70HW+tcZ5bpPlBbHLzIskFByyJcRx3Fclzcd2mPe3IWq26GsTbxN
         cTD4OS9NNvf8EwQWj0AnwQ7NPnkhGyooXKXOUIeWshRExvcOHk9yQrCY9fyCPehCZn7A
         jTxMj0bzg85/v0lPsSdZSdtMDKgRFKgK79qSJlBmxHv5sBudvfoWq/nVkLFodk8xbJiJ
         Bti0xwePY6dDyrCfLqweP6FTceW/gDRaOo/cxMCUoxAoyd3ukOLnFdZzte69pRZ4m79F
         Og6cI1IHpjID8zxuyJAVXp+jnGl9Uad1HGMjLW+p0u9A7kwVaPt4kvMPAzgrGs6ywfW3
         VBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=cYPHppv2z+eAv9HOGZLXHF8mamvH7snDbcKjvWdRvlw=;
        b=nRewrC/8IISHJ+iuDNR9PCvocvIuEhNlbNIWETuqqJBwtUAztiv96DaOk7z3+vF/yv
         ZGgwMONwU3YV9WbGuZaNd9W0Bx4KV4rOtm9IXYIAm2o6fFB+xEc5i9QnPcFPjCfHr3zS
         KEwbX0PbJ/+HBZ1vukj9sq+Br0l0O+LuSrNQpgrLillsU24KgO3d8BBHlo/akjEd+RdN
         9rcYHRppE2LqaDthCMauR9JZB0GK6O/75kvxLd2UUwrN45vJ+8JrTgO16Zr9rlEIhTw4
         SkAdJhSNL68B4l6Wu/s4Dg+h+86symSnRf6Q1oGUmtMx/VZaG9jqag9hcEAJSuo+aHsO
         GVHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93864218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Kolchmeyer <rkolchmeyer@google.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4.16 64/81] fsnotify: Fix fsnotify_mark_connector race
Date: Fri, 27 Apr 2018 15:59:06 +0200
Message-Id: <20180427135747.053318680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908656302888331?=
X-GMAIL-MSGID: =?utf-8?q?1598908879528853476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Kolchmeyer <rkolchmeyer@google.com>

commit d90a10e2444ba5a351fa695917258ff4c5709fa5 upstream.

fsnotify() acquires a reference to a fsnotify_mark_connector through
the SRCU-protected pointer to_tell->i_fsnotify_marks. However, it
appears that no precautions are taken in fsnotify_put_mark() to
ensure that fsnotify() drops its reference to this
fsnotify_mark_connector before assigning a value to its 'destroy_next'
field. This can result in fsnotify_put_mark() assigning a value
to a connector's 'destroy_next' field right before fsnotify() tries to
traverse the linked list referenced by the connector's 'list' field.
Since these two fields are members of the same union, this behavior
results in a kernel panic.

This issue is resolved by moving the connector's 'destroy_next' field
into the object pointer union. This should work since the object pointer
access is protected by both a spinlock and the value of the 'flags'
field, and the 'flags' field is cleared while holding the spinlock in
fsnotify_put_mark() before 'destroy_next' is updated. It shouldn't be
possible for another thread to accidentally read from the object pointer
after the 'destroy_next' field is updated.

The offending behavior here is extremely unlikely; since
fsnotify_put_mark() removes references to a connector (specifically,
it ensures that the connector is unreachable from the inode it was
formerly attached to) before updating its 'destroy_next' field, a
sizeable chunk of code in fsnotify_put_mark() has to execute in the
short window between when fsnotify() acquires the connector reference
and saves the value of its 'list' field. On the HEAD kernel, I've only
been able to reproduce this by inserting a udelay(1) in fsnotify().
However, I've been able to reproduce this issue without inserting a
udelay(1) anywhere on older unmodified release kernels, so I believe
it's worth fixing at HEAD.

References: https://bugzilla.kernel.org/show_bug.cgi?id=199437
Fixes: 08991e83b7286635167bab40927665a90fb00d81
CC: stable@vger.kernel.org
Signed-off-by: Robert Kolchmeyer <rkolchmeyer@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/fsnotify_backend.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -217,12 +217,10 @@ struct fsnotify_mark_connector {
 	union {	/* Object pointer [lock] */
 		struct inode *inode;
 		struct vfsmount *mnt;
-	};
-	union {
-		struct hlist_head list;
 		/* Used listing heads to free after srcu period expires */
 		struct fsnotify_mark_connector *destroy_next;
 	};
+	struct hlist_head list;
 };
 
 /*
