Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/iUtaaRv81kK73kZErWxvjmA5utbRDicgsyMofjX1aBvV5xkh3ewPbbEo5xf5eZyLye6lx
ARC-Seal: i=1; a=rsa-sha256; t=1522168714; cv=none;
        d=google.com; s=arc-20160816;
        b=IH1MdJtMmmv5cURCVa5GWfhrDRbQOdyoi1LJAHUswn91veGcJb/XU5Mg9jEO6j023s
         vhBjOiKebu4Qf5K32stnlEOWLkMPEMg0ng2cquaXtvTknIgSM/yJD8Ro9wBI146jvhIw
         It8xk70zDGfK5o5pqyYE4V3xOoU7Cm9ITXe85wzY+6nJh1+1p9BmjlL4OZ55koNjilL2
         m5RAIzRTIiMOt9lbFgh4aE5LQKMt1PnFg8iRBBRLbgOTsZMvyC8gpssYex/oRSe98+/G
         M7cU4/voq0pxAXp0KxHQWdbwfKRWbbrfnu6r3M43A1dZX1OtspF/gi5djQbHaE5RxLRB
         2ZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NQOSA+QVtseqejgjj/f2homDwyVBNfmp7W5CTvNelcU=;
        b=JkmknxafURQEMy/ThA5hLymTzPHIE7723iEbI4vnpDADg686ubD7jDXGx+FUFS07tJ
         2xk0JW2PYdiRsxX3eSidcetpjH1ZoWe/YveKXeEWJrirXMIBwvnwQNRL+i1vsMsniYvE
         XuDRqELhUUqqNT0iwEQsm9VX8B8ABN8mPvl0lc62Qdasf+qftSWo35V3fiomDJleMW8H
         zZ+iqYjQkAlFmLnEANRF+8ZU+DsQWL7lTAGpjCqeVwHiD2GjrObF5sQSqp8M4DBB2Ggg
         hK8Qqk6pcf/uqn5rixxQTDGttcplxYOAy6pbu+SBbWh1sSe4zcHyK9Ruio1X6X3sB8BB
         8aeA==
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
Subject: [PATCH 4.14 100/101] bpf: skip unnecessary capability check
Date: Tue, 27 Mar 2018 18:28:12 +0200
Message-Id: <20180327162756.124069050@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109077299522415?=
X-GMAIL-MSGID: =?utf-8?q?1596109582362931390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1455,7 +1455,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf
 	union bpf_attr attr = {};
 	int err;
 
-	if (!capable(CAP_SYS_ADMIN) && sysctl_unprivileged_bpf_disabled)
+	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	err = check_uarg_tail_zero(uattr, sizeof(attr), size);
