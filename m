Return-Path: <kernel-hardening-return-11971-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsN+q8sQTbVC+DSdUm4UPx2c6zParO2pSlQbD3OKWl4mP57I2/F+saVqE59K7rZ0UVTKX2f
ARC-Seal: i=1; a=rsa-sha256; t=1519692213; cv=none;
        d=google.com; s=arc-20160816;
        b=ZJzbPa27Kevrn3rZVvXcgHUPCHSqD7ySNFRObCRpqTCPIvTkOfNPJJY0r9djKr1qv2
         gr9IwFZe4oXsrVUR2csNtSCnwHfdrApo7kV0D8eVtV5rZTQQUZDJxaHk219rtG2SJt/z
         CVJZMtZB0OfcyVtXkCfY4i2E54Sg/uNOBOnSrvrJUxSXZw4HiK6t4+I1/6e0Aoh6HYgL
         O0B2o1h3pfN5eRv/LW42KMhF/NUc0yV49KST5x30A9znRj4qEKIbw+CFmaQKmZ/krn9A
         68RJup+1ES6DvN7wVR4qFXdp/6NJHUPVDa9fET6buu2WaYCY7b06H9nhizFnwOX7mRx8
         KRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=8fVpKOPQ6B5A9jPksktqid2q0geKpPASwzjnBu4Wk/0=;
        b=fFbELIKYOF7y9lGjk4QMAeTSl91gs8prrf+Za0um5DdfPENv0sLqA/duNq7VMWnTbF
         0SurFDim/FMaM+1ZrDjh6oaSWAFBjHbULagJiHpmtEt2Yo3QnCSf3VbWj+cUMoUU7YkM
         DkVTpB/CqFQ+ISegcf4Lyn4z8YLJvvdebl3sSAPOO9dOtSWcgGAn8QbsK8zr9/WUBxcv
         habZ0MMZ+3YHvO5VduiKLKsnvFVHn//6N+3GFS1Dp8MO6GN3kR4gAzA6nvixnh2KwDL0
         eaO1I2sk6zGD3/DFm1hUMxJ2vRJEN67qNn+zz0PjXZXve+K97Tjt4WWV05oXJayYwK15
         8VBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11971-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11971-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11971-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11971-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Tycho Andersen <tycho@tycho.ws>, Will Drewry <wad@chromium.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next v8 02/11] fs,security: Add a new file access type: MAY_CHROOT
Date: Tue, 27 Feb 2018 01:41:12 +0100
Message-Id: <20180227004121.3633-3-mic@digikod.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227004121.3633-1-mic@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus-Code: 0x100000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593512782514392882?=
X-GMAIL-MSGID: =?utf-8?q?1593512782514392882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For compatibility reason, MAY_CHROOT is always set with MAY_CHDIR.
However, this new flag enable to differentiate a chdir form a chroot.

This is needed for the Landlock LSM to be able to evaluate a new root
directory.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/open.c          | 3 ++-
 include/linux/fs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 7ea118471dce..084d147c0e96 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -489,7 +489,8 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR |
+			MAY_CHROOT);
 	if (error)
 		goto dput_and_out;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..67c62374446c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -90,6 +90,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define MAY_CHDIR		0x00000040
 /* called from RCU mode, don't block */
 #define MAY_NOT_BLOCK		0x00000080
+#define MAY_CHROOT		0x00000100
 
 /*
  * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
-- 
2.16.2
