Return-Path: <gladkov.alexey@gmail.com>
X-Google-Smtp-Source: AB8JxZowjEODBHpwD+WnfOkShn9AKfD084rNCytf0jSbV/6VXYj66cIhMeVK4HfyAVmV+eTHe2S2
ARC-Seal: i=1; a=rsa-sha256; t=1526031972; cv=none;
        d=google.com; s=arc-20160816;
        b=aFbc3YSk5Picg3DSQ6xgSzf4Bhhp4pKQ9j2/Q6sQDVfoku8UXpleBPbfjrDvOGGOLV
         z2znazEtMZPTb5wdW41nxAKeUxTCTMHn+hKVn4h8d0mUKd1VskgmH/hubgW9MOYN8+TM
         gwkpG8vbqYNIYzPfIH6zBMAUJ7AwEMRrh4NLr8fpj5AZpRHeCvbPk6XPv4itU5toTK8e
         uoWl9EMR0OKPQq8WlncKaA0BM/GFseiGgKTym0fQztdId8msCu0JDTR1d3vDwg/oy3TX
         eBpJ707H025kGMRv0XtOofP/9Q9g49QfC9HeWgc59dEamSUFSaazCe4RA7BxMyOU+TzZ
         RHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=4Fegy7ceB6y5NBC8dhXD0OAc4Q7a0UlJaGg9yQBqJsg=;
        b=uAqpNyfwCqo4fnXim70vfx/luhmNZv6dCGa8QnPPxV+VN44RPuP4VgqqFvOLYkA9f3
         idogi7+ZC5GuVsv21HgZPBr+GifexN2RLOtLOJcONyeqfSLtseLSY9ew/6d3Y3sSMc+O
         YmaS/hQEo29/0MrZvQXHzdhVX2cn+M3nzVkUDVUQEtJfvZq839MJuryqM4cJ6H/HGcff
         9D2wQAhUAe62KLB65tZUs8ORwuKSEZLwMhFBtsM6Ji5jmEKlTfvvSVwbUZD/dM61e0bk
         f/rpLDnE/R/JLvWJh6sCIe3Z1W8vzdhvtWgNTGBnq+YPKVEXEV1Ix0t8AA3TUJ8Wg21E
         mVoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gladkov.alexey@gmail.com does not designate 5.9.28.80 as permitted sender) smtp.mailfrom=gladkov.alexey@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gladkov.alexey@gmail.com does not designate 5.9.28.80 as permitted sender) smtp.mailfrom=gladkov.alexey@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Fri, 11 May 2018 11:36:14 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Jeff Layton <jlayton@poochiereds.net>,
	Ingo Molnar <mingo@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	aniel Micay <danielmicay@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, bfields@fieldses.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, solar@openwall.com,
	"Dmitry V. Levin" <ldv@altlinux.org>,
	Djalal Harouni <tixxdz@gmail.com>
Subject: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
 'limit_pids=1' mount option
Message-ID: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600160501137363008?=
X-GMAIL-MSGID: =?utf-8?q?1600160501137363008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Djalal Harouni <tixxdz@gmail.com>

If "limit_pids=1" mount option is set then do not instantiate pids that
we can not ptrace. "limit_pids=1" means that procfs should only contain
pids that the caller can ptrace.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 fs/proc/base.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6f084344..31baeef 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3187,6 +3187,7 @@ struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, unsign
 	unsigned tgid;
 	struct proc_fs_info *fs_info = proc_sb(dir->i_sb);
 	struct pid_namespace *ns = fs_info->pid_ns;
+	int limit_pids = proc_fs_limit_pids(fs_info);
 
 	tgid = name_to_int(&dentry->d_name);
 	if (tgid == ~0U)
@@ -3200,7 +3201,15 @@ struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, unsign
 	if (!task)
 		goto out;
 
+	/* Limit procfs to only ptracable tasks */
+	if (limit_pids == PROC_LIMIT_PIDS_PTRACE) {
+		cond_resched();
+		if (!has_pid_permissions(fs_info, task, HIDEPID_NO_ACCESS))
+			goto out_put_task;
+	}
+
 	result = proc_pid_instantiate(dir, dentry, task, NULL);
+out_put_task:
 	put_task_struct(task);
 out:
 	return ERR_PTR(result);
-- 
2.10.5
