Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrHNvsdxPefwArpEJoTAe6ztoh6y88tWX7Ng31OObIZfEwPUnFKUwaToHfThpudykBCSlSy
ARC-Seal: i=1; a=rsa-sha256; t=1524837902; cv=none;
        d=google.com; s=arc-20160816;
        b=OEjrsD5key0mYko5rxFSzId1HVUPq/qBiLdruolLf8UNv7x8w+p1gyWIltJU5W63ZJ
         nll02U3b8TxNhsRSr8bUPKFNySiPXsuGmE8CRtujQ9am7EJsAVgblWVaVX/U6pdmPT4D
         PuMzs9wlg9zQPTDZcgpjpz46OeyEYKo9I8wkf3itRjq4S2yz6n10fMJZAjVOo4MD2bJi
         ElvaBR1VFHopTWzuZAf8NN4EKyi3qSU9VpjPVRiy+Y7CDcazbwoNk5xRrfQg2S1BfbWR
         4H+eDdwctSntbjzoTPcWps56Za7zPpZNLbteAw4RytSLEby4D06z1UU5qF6O3eQ9hPng
         PtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=OPN2mBajOyZ7vUf5L1ZXZ8e1czxGOv1ld4FYMPm9WTc=;
        b=ZfvtVwNfgQpWVCu9siXVdczXTUjIChJOBnHNJPDa48Yq+VhH71uuLf8lNwEaN6ijGd
         6TxmBuEZraZQtXQt8Fpaj/IZHVzXL1Io7uOGzgS29ulsjLoLAk8gPFDKysjhDoue/g95
         yNp+PhN7gP2dZYMDJdGOYNpj2FVRmh3dy1SzYRfC9QYIQibrt5v1+3SyYrgzMK0RySUZ
         SFRpr6D/xMPoxg9wKoZWkY8HzGsFuVuYx1nKzJ9LUX7wJEo19PxCH3Lh1STgk38whAAM
         AEIXUu51Aukjx8S8+s3Zdh4gjoETsgBCsxduEzEm0XcE/n8RzZj1oUlRkkv9azhK6GyQ
         L2zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FACD21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 61/74] llc: hold llc_sap before release_sock()
Date: Fri, 27 Apr 2018 15:58:51 +0200
Message-Id: <20180427135712.468234518@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908022431860439?=
X-GMAIL-MSGID: =?utf-8?q?1598908428674647628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
