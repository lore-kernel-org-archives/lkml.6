Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoFacjN6FGLPzi3kzfX6JRG7R5pWtq6IEVftWi3zuW9jXAvSyFqhyshHW6jS03Bh/TTqB2t
ARC-Seal: i=1; a=rsa-sha256; t=1524837723; cv=none;
        d=google.com; s=arc-20160816;
        b=wGOWem3+R/5J76gTUkx+FlzAT932y1XCOtxREJESrLJ6PStmNDuH79rPF+XKGq3J00
         D8skZtjgp0SywDeohEMXcCb1PhwsLoKW8DZQVYP8qwgtsIgVAEuekCYS7Ti3g1TQeElx
         yNL7ejmkLWu9Y1F3lnApfwptsbrSnbptXh8tWLoHky1/XA2OqycXpZkbnhFuPCOnvFwU
         waald2NCenqQVdpOMM/BKNAxYQEYM82d06V9wQaXtENKaABukq71pXalr+RmV2Uh9PLm
         XHrIAjNmi5ewt+5F53wn9PbOKEfB6KJlkPX3zTQoW43z4oO1Q94dIeimY/SmLzBd6ShU
         LKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=bwU20L7cU2rT0PPhpky0feVP+lm9lKkKL7Q2RJup1kI=;
        b=nkjYHDWpQqnxiWnWbWt1IgOIWMBafKya5KZRK1hQjvWJqbuo2VY07Oqai37ID9aDEa
         RaYRhGb4/XL+tZM6Jo+HoohNMcPxOA7vm0zNywRKu/IJFtxFOpN/TuifixsFzlJreu4/
         YL5BlR1cJpr3Q9o3izo/FBCLrZA89dzDvbFHsHO6jSG6szcMNRMhPc+qziCzX4QNaAPj
         153geMx7tCLoKvwhRpf6xKcDbABJlJqYkv27BqXNfrAWFf9qsGvub8P4+HjtQLtvmmn6
         3waxeeG7jhaQQsSBYM8F8PKCN6mmPYRi/De+xx8Xhp6MZkorBqaNJn713fRcVT5d7r6U
         ROyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA1721897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 41/50] llc: fix NULL pointer deref for SOCK_ZAPPED
Date: Fri, 27 Apr 2018 15:58:43 +0200
Message-Id: <20180427135658.104287309@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908105270702201?=
X-GMAIL-MSGID: =?utf-8?q?1598908240716339775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit 3a04ce7130a7e5dad4e78d45d50313747f8c830f ]

For SOCK_ZAPPED socket, we don't need to care about llc->sap,
so we should just skip these refcount functions in this case.

Fixes: f7e43672683b ("llc: hold llc_sap before release_sock()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -187,7 +187,6 @@ static int llc_ui_release(struct socket
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
-	struct llc_sap *sap;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -198,15 +197,19 @@ static int llc_ui_release(struct socket
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
-	sap = llc->sap;
-	/* Hold this for release_sock(), so that llc_backlog_rcv() could still
-	 * use it.
-	 */
-	llc_sap_hold(sap);
-	if (!sock_flag(sk, SOCK_ZAPPED))
+	if (!sock_flag(sk, SOCK_ZAPPED)) {
+		struct llc_sap *sap = llc->sap;
+
+		/* Hold this for release_sock(), so that llc_backlog_rcv()
+		 * could still use it.
+		 */
+		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
-	release_sock(sk);
-	llc_sap_put(sap);
+		release_sock(sk);
+		llc_sap_put(sap);
+	} else {
+		release_sock(sk);
+	}
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
