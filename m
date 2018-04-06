Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/KnfIuUcZr/dG4P37djYdZ0o49iXry8TGanRsIPsvCobZXMYGrUH9E2mRVtZgiJ6zBA0Or
ARC-Seal: i=1; a=rsa-sha256; t=1523021142; cv=none;
        d=google.com; s=arc-20160816;
        b=w3VUas3+t1kKXqEpg0l2vA1k7x5VQK/abQC/mgF0H7KO3B5cjUh5LcS+0HoJctKBsk
         od9MIJEtQGEAXxPXNLvO0vHXYJ/oL7o7eYykF4t3pzeklPVgmyWxU40h0d8X8luby7Bh
         1bFkxnohgrqMv+JY3RJtXod76yFlHqGUW8rK8VOklyQ0XtdsjCkUANb2zzquqZBXIsRR
         YgEaKJUMvqAoPhRkVygGnu76QFI2EqpKHjYAAx2XsP2XEOAE4+uaYBAqBx3crq2OD85j
         xe31n0/VEHvtKEx64dkxAGMzscf9u8P6Dq3llZ+E48q0SprTp068oxGJM5m236Yu3Krw
         d9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Mb0kGQV59F62kzWT2jjQyoPhjCXsSTRxyTu5uCChm1U=;
        b=cSYb93TwHdrq7vQ5zekRZrQyD/jS26bRzYFX+PlGpEfrsgGEaCMEBAaH907hCAxoeH
         xIuzr358yVM9cryTHd5GPH+gzz7wJzfxltWuZCX66k3Vdzz0gzMVcxB5/udGqXyyN3UO
         qUWJBJEBSJ9znSyvk6qDuA7MwIJRgw+mQbKBOWvj68sxnhimjmQD7MJAbsa3Ok/8SeIy
         MHaIqPUj41Dyv4FNpvv0hiLIM5BWbFk9DKt8AeNS5NYoIA/Zr05J6rqoZ2cLQYTjlyxr
         7PO15/N79jhZqgu5ujNKk3tu+Q4uVGHWaoDWiI4+WQqiOiOdjVKFSkY7Md3OglzQ++b7
         hIaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+f99ab3887ab65d70f816@syzkaller.appspotmail.com,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 23/93] dccp: check sk for closed state in dccp_sendmsg()
Date: Fri,  6 Apr 2018 15:22:52 +0200
Message-Id: <20180406084225.977167807@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003418083901287?=
X-GMAIL-MSGID: =?utf-8?q?1597003418083901287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 67f93df79aeefc3add4e4b31a752600f834236e2 ]

dccp_disconnect() sets 'dp->dccps_hc_tx_ccid' tx handler to NULL,
therefore if DCCP socket is disconnected and dccp_sendmsg() is
called after it, it will cause a NULL pointer dereference in
dccp_write_xmit().

This crash and the reproducer was reported by syzbot. Looks like
it is reproduced if commit 69c64866ce07 ("dccp: CVE-2017-8824:
use-after-free in DCCP code") is applied.

Reported-by: syzbot+f99ab3887ab65d70f816@syzkaller.appspotmail.com
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/proto.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -792,6 +792,11 @@ int dccp_sendmsg(struct kiocb *iocb, str
 	if (skb == NULL)
 		goto out_release;
 
+	if (sk->sk_state == DCCP_CLOSED) {
+		rc = -ENOTCONN;
+		goto out_discard;
+	}
+
 	skb_reserve(skb, sk->sk_prot->max_header);
 	rc = memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len);
 	if (rc != 0)
