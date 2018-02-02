Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ORAQ2tL0vVm/Q+ftgrz3DfPVa8oJPwoIvZrQ3jzfK1CrYOZxPu19zguJgCj0uZoirA3Pp
ARC-Seal: i=1; a=rsa-sha256; t=1517590960; cv=none;
        d=google.com; s=arc-20160816;
        b=AaRqi8kMgMnimG2tU1PinXyXEfvmISbqNjBeX6yxvEnfPOb/KGzgxhBGaRJMEkt7ZO
         gH3I1LLHbdrukG1nT9JcERYWrUBaVBB6iqM9mIr9Km+Tsm6pU3TYNiAby7HdyHu63wbN
         0LuTJy9wj6tehkYd28oZUqt7UImVIyIJ6jrz/GoMBUrZGw7AeJyHBSfYASObi+UC6BgS
         1nKdREWR9y/Wgo2df9LNBPBjN1rOQjNJz9R9SHRea++xpC8XhhH4+aUYzZYwv8/6N6Mq
         gSckH0nC6YbEU4EISCwSMHAZ6V5Kgyyp9QbfuX0U258GuadZM0mOgXxeFNtJB7MYjEVh
         FeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=im57/zET/AGtk/weamzhHC7t9VjaC8u/HsYs5Fsd52c=;
        b=hF4a3p0D36cTYZKhbZ6eOaFwD8Y5KaBwkzgzhzyKAiUPWKpmblESJaQyatqAUtkJiS
         JgdqGbcgygiI+k+kYaHuYpCCnEauPYknC+fKvPZEKBTKphk9WCxDprZm86TWAcMvlGz9
         8Zk+PwyW7jhmacSvqRW1iE5Q+uwWG1HwCJW5+4ScqJJwNVsaD4hNqa7NDXdbyfROdvi1
         Zkn2W2/uueuYO8kgGd4S7YlLqG7YY+IGUjtk3wmhuODqI+7fghkCdqmecw510VzZ0OX7
         2QJLKVYlCVmknt84NYIQbjSWEkLITQttxMnseIHbdEc9RuU2drSQ4KpP0jgrc92vkc7T
         X+Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Salyzyn <salyzyn@android.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@google.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	selinux@tycho.nsa.gov,
	linux-security-module@vger.kernel.org,
	Eric Paris <eparis@parisplace.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 4.4 65/67] selinux: general protection fault in sock_has_perm
Date: Fri,  2 Feb 2018 17:58:34 +0100
Message-Id: <20180202140822.373416996@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309458768974120?=
X-GMAIL-MSGID: =?utf-8?q?1591309458768974120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Salyzyn <salyzyn@android.com>

In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE socket
flag") and all the associated infrastructure changes to take advantage
of a RCU grace period before freeing, there is a heightened
possibility that a security check is performed while an ill-timed
setsockopt call races in from user space.  It then is prudent to null
check sk_security, and if the case, reject the permissions.

Because of the nature of this problem, hard to duplicate, no clear
path, this patch is a simplified band-aid for stable trees lacking the
infrastructure for the series of commits leading up to providing a
suitable RCU grace period.  This adjustment is orthogonal to
infrastructure improvements that may nullify the needed check, but
could be added as good code hygiene in all trees.

general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 14233 Comm: syz-executor2 Not tainted 4.4.112-g5f6325b #28
task: ffff8801d1095f00 task.stack: ffff8800b5950000
RIP: 0010:[<ffffffff81b69b7e>]  [<ffffffff81b69b7e>] sock_has_perm+0x1fe/0x3e0 security/selinux/hooks.c:4069
RSP: 0018:ffff8800b5957ce0  EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffff10016b2af9f RCX: ffffffff81b69b51
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000010
RBP: ffff8800b5957de0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 1ffff10016b2af68 R12: ffff8800b5957db8
R13: 0000000000000000 R14: ffff8800b7259f40 R15: 00000000000000d7
FS:  00007f72f5ae2700(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000a2fa38 CR3: 00000001d7980000 CR4: 0000000000160670
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Stack:
 ffffffff81b69a1f ffff8800b5957d58 00008000b5957d30 0000000041b58ab3
 ffffffff83fc82f2 ffffffff81b69980 0000000000000246 ffff8801d1096770
 ffff8801d3165668 ffffffff8157844b ffff8801d1095f00
 ffff880000000001
Call Trace:
[<ffffffff81b6a19d>] selinux_socket_setsockopt+0x4d/0x80 security/selinux/hooks.c:4338
[<ffffffff81b4873d>] security_socket_setsockopt+0x7d/0xb0 security/security.c:1257
[<ffffffff82df1ac8>] SYSC_setsockopt net/socket.c:1757 [inline]
[<ffffffff82df1ac8>] SyS_setsockopt+0xe8/0x250 net/socket.c:1746
[<ffffffff83776499>] entry_SYSCALL_64_fastpath+0x16/0x92
Code: c2 42 9b b6 81 be 01 00 00 00 48 c7 c7 a0 cb 2b 84 e8
f7 2f 6d ff 49 8d 7d 10 48 b8 00 00 00 00 00 fc ff df 48 89
fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 83 01 00
00 41 8b 75 10 31
RIP  [<ffffffff81b69b7e>] sock_has_perm+0x1fe/0x3e0 security/selinux/hooks.c:4069
RSP <ffff8800b5957ce0>
---[ end trace 7b5aaf788fef6174 ]---

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org
Cc: Eric Paris <eparis@parisplace.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/hooks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4032,6 +4032,8 @@ static int sock_has_perm(struct task_str
 	struct lsm_network_audit net = {0,};
 	u32 tsid = task_sid(task);
 
+	if (!sksec)
+		return -EFAULT;
 	if (sksec->sid == SECINITSID_KERNEL)
 		return 0;
 
