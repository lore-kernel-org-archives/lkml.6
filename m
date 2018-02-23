Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226kF4Jlpe9RwoSmRhyQsanKfGtTJgBbFWUPqqM6ZUnqA1wMgbPjrJFUMWFUorpqK2OjSNDu
ARC-Seal: i=1; a=rsa-sha256; t=1519412279; cv=none;
        d=google.com; s=arc-20160816;
        b=P4yjeMwVQ+h8g9zJMua6wy0G5wLFHbPK+dp8JUgpcd4x88wvOpdesTg+SVcBShN+Ah
         d8nfUrd4zjpzekln0oTDt9HHd1bOh/J3xGEuUOut4u2yUf9aNKB7qohmjpSbIN3dFbCg
         Tg0ugX+ah++UvyVwLTJvkun9BddRjte5TcS8nCpimCKC7VRBbXw65V9KC9a6DhVJLV19
         fwXeQakPohyOAZ4BIE3ucTHDrIwsQfOlnfioEdBkxAzDPHd+tC8DqgcyZH3LTLIdjtRT
         nNrNGRFjzmgwcsQmndiBFUEyIe8erQge7snT9DyEv8SJdhAaxU9ZkoYJaRFmuRB8kGFh
         QEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bb0t0a/v83LvNxKyNt5eggs8ypHSU/o/nkThbjMEJCA=;
        b=0UIa7oibtsmUNMASrVRpflW5YZULMDVMw04G5wexs4RMUSFq+4KAPu2xmBWA4Ez/DV
         FuLzvY9Q6PSMKSuTiuq80z6q8a7VyNvfNgvEk+SgmYh8kc5ktBFmQC7qRIzb4gDRg+tv
         TwK6V5rvjrkUFw1bZrVjamk+HT/3irxcbNBaJbjwaeOBYel7HJ/3in3iC5pcBJ+Nu4Mj
         37wZlfh/RGSGhBUHlyCYLRDn6/sret5hyrrjMGhnxRVb11yP9KhtgiMXRpYz2qP1KOMX
         2N4SkF7NXCLE9CzTpwfGKMzNJDAyjUEeWWwg5OMk5s7xi5FqIlJ9SjKFd7PKE7OWelYl
         woYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller-bugs@googlegroups.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	James Morris <james.l.morris@oracle.com>
Subject: [PATCH 4.15 05/45] selinux: skip bounded transition processing if the policy isnt loaded
Date: Fri, 23 Feb 2018 19:28:44 +0100
Message-Id: <20180223170716.098386257@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217523069678255?=
X-GMAIL-MSGID: =?utf-8?q?1593219249969218750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

commit 4b14752ec4e0d87126e636384cf37c8dd9df157c upstream.

We can't do anything reasonable in security_bounded_transition() if we
don't have a policy loaded, and in fact we could run into problems
with some of the code inside expecting a policy.  Fix these problems
like we do many others in security/selinux/ss/services.c by checking
to see if the policy is loaded (ss_initialized) and returning quickly
if it isn't.

Reported-by: syzbot <syzkaller-bugs@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -867,6 +867,9 @@ int security_bounded_transition(u32 old_
 	int index;
 	int rc;
 
+	if (!ss_initialized)
+		return 0;
+
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
