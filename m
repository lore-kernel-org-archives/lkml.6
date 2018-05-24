Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqbdYhdnJlncFbdgOGa4PYQqhoUnCFsUYNFmLAoTtKG/TCIPpBlwd7cIR495RbWlkysCerc
ARC-Seal: i=1; a=rsa-sha256; t=1527155096; cv=none;
        d=google.com; s=arc-20160816;
        b=VNQcrCuYAM2BTxTWbAjdJ7M2DBBDvN+jaxOjvKM8X8zTwmBRJ1V1MOYubyQvOpVPbM
         VWP7CGBLVcPi8vevQy8mR8cHOntof7Xo5oHMGt9vqsIS8rz2RbBaNwyhfg/sFCSYO7po
         Ubxy+PS1YVIlDzEnr3E+m/22wCfEcJtw3qNDokdL+gTExWFDm8OpOjATUHp9/wCmimgN
         LKAXhcVPCY5ZtoNEwc9weqrsGSjzw+tBXW+alLfg4y0qL2gUrvKZxHvwYgBJ44yP4YBo
         qcNrz0N3NajUrHmX85XyE/rMVfEzPHMMhhd/gI6QMzrxrtqVZtXdhZKzcUJtp8znii7t
         bIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=H0KecsFixEuuy8g66jq7ky7CWSNoP4uTtGWGmpPoeJU=;
        b=DsBjy+0r5YRaGgWvAIwqpKigbAj+Vracc5x17iQWhkQcDziTJiydRSkbCBn0da57gl
         XXJ1vDc9n0d7Nh6K1xpUH6Ri+NCuRSQA7AGz6i8YN3G7chRMRLJURIPpRrtOEQXCmDuM
         Kw54MPeWZoxkQhm3b5HTma2Pn5e1QBpIZnozKtjbeBglA9Wkfbp5qNDmR3TqYLLmBmzp
         leIltjLVUo+9pWhx8sglamo6HOJA3X/vqiHUXRd2Fj2yJMcAYsnmE9+QnkVqknWOVRmW
         svYUHxm0BAq5KG9BEeAkp/YwC8eSFyOtpLgoU9wmtpj0tgN2OUabGkSWeiEG4X8Agt1+
         O57Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=t0kp39hI;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=t0kp39hI;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mateusz Guzik <mguzik@redhat.com>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Jarod Wilson <jarod@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Anshuman Khandual <anshuman.linux@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 54/92] proc read mms {arg,env}_{start,end} with mmap semaphore taken.
Date: Thu, 24 May 2018 11:38:31 +0200
Message-Id: <20180524093204.534521242@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338182820393310?=
X-GMAIL-MSGID: =?utf-8?q?1601338182820393310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mateusz Guzik <mguzik@redhat.com>

commit a3b609ef9f8b1dbfe97034ccad6cd3fe71fbe7ab upstream.

Only functions doing more than one read are modified.  Consumeres
happened to deal with possibly changing data, but it does not seem like
a good thing to rely on.

Signed-off-by: Mateusz Guzik <mguzik@redhat.com>
Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jarod Wilson <jarod@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Anshuman Khandual <anshuman.linux@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/base.c |   13 ++++++++++---
 mm/util.c      |   16 ++++++++++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -953,6 +953,7 @@ static ssize_t environ_read(struct file
 	unsigned long src = *ppos;
 	int ret = 0;
 	struct mm_struct *mm = file->private_data;
+	unsigned long env_start, env_end;
 
 	/* Ensure the process spawned far enough to have an environment. */
 	if (!mm || !mm->env_end)
@@ -965,19 +966,25 @@ static ssize_t environ_read(struct file
 	ret = 0;
 	if (!atomic_inc_not_zero(&mm->mm_users))
 		goto free;
+
+	down_read(&mm->mmap_sem);
+	env_start = mm->env_start;
+	env_end = mm->env_end;
+	up_read(&mm->mmap_sem);
+
 	while (count > 0) {
 		size_t this_len, max_len;
 		int retval;
 
-		if (src >= (mm->env_end - mm->env_start))
+		if (src >= (env_end - env_start))
 			break;
 
-		this_len = mm->env_end - (mm->env_start + src);
+		this_len = env_end - (env_start + src);
 
 		max_len = min_t(size_t, PAGE_SIZE, count);
 		this_len = min(max_len, this_len);
 
-		retval = access_remote_vm(mm, (mm->env_start + src),
+		retval = access_remote_vm(mm, (env_start + src),
 			page, this_len, 0);
 
 		if (retval <= 0) {
--- a/mm/util.c
+++ b/mm/util.c
@@ -428,17 +428,25 @@ int get_cmdline(struct task_struct *task
 	int res = 0;
 	unsigned int len;
 	struct mm_struct *mm = get_task_mm(task);
+	unsigned long arg_start, arg_end, env_start, env_end;
 	if (!mm)
 		goto out;
 	if (!mm->arg_end)
 		goto out_mm;	/* Shh! No looking before we're done */
 
-	len = mm->arg_end - mm->arg_start;
+	down_read(&mm->mmap_sem);
+	arg_start = mm->arg_start;
+	arg_end = mm->arg_end;
+	env_start = mm->env_start;
+	env_end = mm->env_end;
+	up_read(&mm->mmap_sem);
+
+	len = arg_end - arg_start;
 
 	if (len > buflen)
 		len = buflen;
 
-	res = access_process_vm(task, mm->arg_start, buffer, len, 0);
+	res = access_process_vm(task, arg_start, buffer, len, 0);
 
 	/*
 	 * If the nul at the end of args has been overwritten, then
@@ -449,10 +457,10 @@ int get_cmdline(struct task_struct *task
 		if (len < res) {
 			res = len;
 		} else {
-			len = mm->env_end - mm->env_start;
+			len = env_end - env_start;
 			if (len > buflen - res)
 				len = buflen - res;
-			res += access_process_vm(task, mm->env_start,
+			res += access_process_vm(task, env_start,
 						 buffer+res, len, 0);
 			res = strnlen(buffer, res);
 		}
