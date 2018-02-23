Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs0acAbAZd9TB/x5OpxXZy1ue9N0WTulmcUsA66wCZoJbICNfV+/5Rd3MN4BAS4Og4MjZLy
ARC-Seal: i=1; a=rsa-sha256; t=1519412360; cv=none;
        d=google.com; s=arc-20160816;
        b=Vd3Bniql2av+fBPOg6abrMMQznLdNB9YrmWnmcA3x4MeVJgZybetD3XfMs8T9qS/XU
         LTzw36NV360ZcQ5I06nm0zsnWgKehlUb5bWszRPogtZqvcjLeyC6ssMxvny3/oTRKjqW
         nCvWxF+l4NmIcgRX5Q5Rq/fOWQ37LU62RDgPEoCOo9jUitrXzu5Z1NRaDbL+fGtDjgAS
         oxJH8h3jihFGaDrlf7cbWiCEq5CAsdIhYfKRsuX/7YGXHze5BIOFdOvkm91bmHsoA1qB
         LvWe2xueLYGCeViCvcnlOZALz3khxFW0evtSTr//ZTUhUVghaaQKWaPYLfxq/uv1siNI
         qyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lpXsS0oHCons5apTLRDVRyXMzLfbUegPrdmtL8QPjUw=;
        b=NP6FRsvhm+vIGTGS+if9y49ys8B3TqS3KHi6Qyu4NapFJEfPYZcoPVqH5A+vD3TxQS
         yljwHG8cnbgtFr3UltWogBlDStYhcQZP/o67I/3vtAD1hZ5+TZ9ZpdftqBVCMCzKq7C6
         jqmk5HmCPSg3lp7Fej0SZgI0IWF7aw71W+owpgyL2zr6CsBVy44D0hUR99iBSBJ4NsbU
         t0zFeCHyDOetp7lnxt4Wi5u6up7A8uJOeqzVFZZSUG9N1y4dpW4Zab9cJsAXWp5SxLjR
         +92mOGiSnESgmnEU+M4IY2cHn7z888pPzP1hydaJhkqkWD6KPAbi9igzAJbdEDYN+9jV
         obow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.15 33/45] binder: replace "%p" with "%pK"
Date: Fri, 23 Feb 2018 19:29:12 +0100
Message-Id: <20180223170720.624113327@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218851622448078?=
X-GMAIL-MSGID: =?utf-8?q?1593219335567792178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Kjos <tkjos@android.com>

commit 8ca86f1639ec5890d400fff9211aca22d0a392eb upstream.

The format specifier "%p" can leak kernel addresses. Use
"%pK" instead. There were 4 remaining cases in binder.c.

Signed-off-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2141,7 +2141,7 @@ static void binder_transaction_buffer_re
 	int debug_id = buffer->debug_id;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
-		     "%d buffer release %d, size %zd-%zd, failed at %p\n",
+		     "%d buffer release %d, size %zd-%zd, failed at %pK\n",
 		     proc->pid, buffer->debug_id,
 		     buffer->data_size, buffer->offsets_size, failed_at);
 
@@ -3653,7 +3653,7 @@ static int binder_thread_write(struct bi
 				}
 			}
 			binder_debug(BINDER_DEBUG_DEAD_BINDER,
-				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %p\n",
+				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
 				     proc->pid, thread->pid, (u64)cookie,
 				     death);
 			if (death == NULL) {
@@ -4991,7 +4991,7 @@ static void print_binder_transaction_ilo
 	spin_lock(&t->lock);
 	to_proc = t->to_proc;
 	seq_printf(m,
-		   "%s %d: %p from %d:%d to %d:%d code %x flags %x pri %ld r%d",
+		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d",
 		   prefix, t->debug_id, t,
 		   t->from ? t->from->proc->pid : 0,
 		   t->from ? t->from->pid : 0,
@@ -5015,7 +5015,7 @@ static void print_binder_transaction_ilo
 	}
 	if (buffer->target_node)
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
-	seq_printf(m, " size %zd:%zd data %p\n",
+	seq_printf(m, " size %zd:%zd data %pK\n",
 		   buffer->data_size, buffer->offsets_size,
 		   buffer->data);
 }
