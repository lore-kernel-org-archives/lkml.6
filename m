Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx494xuBuoFWYGOvBSgUjypn/RmDMq7kk/l9zi3W9CEMaYsUsBvVLaAdoJyfSN3seV0//SMz9
ARC-Seal: i=1; a=rsa-sha256; t=1522346870; cv=none;
        d=google.com; s=arc-20160816;
        b=i7nYO+W/hIpU3crx0fMeNEWKC2J2JslfRzXew7AUfr891a9ttzmvGWBDgknVx/ToGC
         8LiQsrTDFYYCa9+uZUnmYunsDqf0R8JPwR3ttF5mnODsQq7qjfOLSDa7iXhqBNyxJkXa
         Eo8yXKtfXxEd5eKpU9orp495cj1iWf/BAyPDJkiBXFSmePasMS6lJKJFjQ+Sr7EW9gGC
         FgEDPOB6D6ICTDEjIea1hGvUzM3O0bEmcEFoHHuXy/AxfsOCN2By9sirNS1JhLMITvwc
         F7tR2G1dwgsSLOVUS0UJcnvw0MPiLJMcC3BY/1ac/jupHJihNymC5taW40Xz1E16NQ25
         nZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kjOpv0O0B9EzIXyv3Ugr2fnykhoOMnIhVqnMPC/xISc=;
        b=ZWHS1z4HWRikvRcrOJPtzvpqg2+lBp/e/G9PGhT2oFJCGQuJX8LV20iZbNcNDmhDsn
         rgUYbmxJs5h8bODwGP1Bt+yAkX5waoN1/wL3zg6qisDQYu7qffR5y/EcgxZDhWjBN6Rn
         ELlkFi5gNZQ/8Z3x0aWLn66/cwcqet1QSiB1f+H5AJMRBMpw0VNlEh5N4jh9e6Dd98RM
         2ltKYV7WjMTahvdbENyuNvPJzyTMSJyqeiaSDyAnNvrycuqqeHdi7+2NSy6WPvASY7Gp
         qTuQNegkZhPa+ON29LupSmZZr6dObEMmwKv6YfGLHZwtooqFnu3ajiZR/riU6Cy92Pdj
         wobA==
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
Subject: [PATCH 4.4 04/20] dccp: check sk for closed state in dccp_sendmsg()
Date: Thu, 29 Mar 2018 20:00:40 +0200
Message-Id: <20180329175742.066392990@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296089395383323?=
X-GMAIL-MSGID: =?utf-8?q?1596296392155362805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -789,6 +789,11 @@ int dccp_sendmsg(struct sock *sk, struct
 	if (skb == NULL)
 		goto out_release;
 
+	if (sk->sk_state == DCCP_CLOSED) {
+		rc = -ENOTCONN;
+		goto out_discard;
+	}
+
 	skb_reserve(skb, sk->sk_prot->max_header);
 	rc = memcpy_from_msg(skb_put(skb, len), msg, len);
 	if (rc != 0)
