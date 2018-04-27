Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp1qTQuE3g1cp6kKzjdWdQfcG5yo5VeThsEtZYT1RXjI/jUnysEALJlbDMWPaDWicjZUmyp
ARC-Seal: i=1; a=rsa-sha256; t=1524837720; cv=none;
        d=google.com; s=arc-20160816;
        b=g328yo7ncRqKqDyfo13H9ixprrIgHcDC0vjzT7iP4Q1kuN4iVTeVm+xprk1oN+3rNo
         YMPQjXxd31w1qGJEbKgXFNMsc3jzmhKKpfT4YNXt/AO0DP9/anAY6RbxK/ubMihZfV4l
         5BZM8MeoyMKVilcAeF+SbbUyXOwgNHWyhZ3+nCk+Crrbgizh5w8+d99h3Jh7dSOBVRKj
         mMZ3IALpZWOLVnkvqEbU3S6xTB5KvoZpCIKrvoO8x6YFvrMxVzjpyuWjRbQzjcospkoc
         04VpGw8po8SjMXtZqD1BEK9xBjR8JQD16tWCuQKqS6CUE+bSNsgSJV7WuDsDWKVWpyJU
         Ty3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=tQNuKenMlLKWt0o+r8JiuDLiwipnbBYvK6v1F1n7Sjk=;
        b=JyRSOw6ZigMRcJIcHMXNdFx+Qln6ExO5CR6KHVdWj2fN659NSQ8DbrfP1BRwVxVpN/
         SvlChH+EY7qj7wAZKkh+uethsOioJV0534lNhEKKuhJj2XbIHtXg13fLx9n1RnMD/9+m
         23796VJCtBoEQmN4o73+zNwIUgGe4qN7rAA820/XYJhdtwZXzg0K21QnSfadFB9l8N8S
         x+Qk/fsnwsSxTCKcIf8dNLp3ZFsVUWwQRNchwfkRbdpInFftFP20jnbnex/CU2USkof2
         6rhnH7vtoja20acZgzJPUciGLxtNI5T91i99URrx9ElqWT6ishUO8K81pQ+51jT3h5RE
         2hgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C84E21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 40/50] llc: hold llc_sap before release_sock()
Date: Fri, 27 Apr 2018 15:58:42 +0200
Message-Id: <20180427135658.043224496@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908022431860439?=
X-GMAIL-MSGID: =?utf-8?q?1598908238092414096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit f7e43672683b097bb074a8fe7af9bc600a23f231 ]

syzbot reported we still access llc->sap in llc_backlog_rcv()
after it is freed in llc_sap_remove_socket():

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
 llc_conn_ac_send_sabme_cmd_p_set_x+0x3a8/0x460 net/llc/llc_c_ac.c:785
 llc_exec_conn_trans_actions net/llc/llc_conn.c:475 [inline]
 llc_conn_service net/llc/llc_conn.c:400 [inline]
 llc_conn_state_process+0x4e1/0x13a0 net/llc/llc_conn.c:75
 llc_backlog_rcv+0x195/0x1e0 net/llc/llc_conn.c:891
 sk_backlog_rcv include/net/sock.h:909 [inline]
 __release_sock+0x12f/0x3a0 net/core/sock.c:2335
 release_sock+0xa4/0x2b0 net/core/sock.c:2850
 llc_ui_release+0xc8/0x220 net/llc/af_llc.c:204

llc->sap is refcount'ed and llc_sap_remove_socket() is paired
with llc_sap_add_socket(). This can be amended by holding its refcount
before llc_sap_remove_socket() and releasing it after release_sock().

Reported-by: <syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -187,6 +187,7 @@ static int llc_ui_release(struct socket
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
+	struct llc_sap *sap;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -197,9 +198,15 @@ static int llc_ui_release(struct socket
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
+	sap = llc->sap;
+	/* Hold this for release_sock(), so that llc_backlog_rcv() could still
+	 * use it.
+	 */
+	llc_sap_hold(sap);
 	if (!sock_flag(sk, SOCK_ZAPPED))
 		llc_sap_remove_socket(llc->sap, sk);
 	release_sock(sk);
+	llc_sap_put(sap);
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
