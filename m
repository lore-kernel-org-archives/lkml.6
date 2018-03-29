Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+zDLTp2yqJt9N2RU+lUTTz1MMMiLAxcauUGOtBB+LrjcoMVG71MnOfCTzTNIIyDaiHs9ID
ARC-Seal: i=1; a=rsa-sha256; t=1522346774; cv=none;
        d=google.com; s=arc-20160816;
        b=IamBw4PEBsJ4rgpsQgxcnlY9J86TfZua0AqS0PZh3RQ2Yx676gdjhv/MuQG96X4IYv
         hN4lC4WOW1r0YN7VaTSrU8u/05rHtYsWm8O3nBS3H3cD/YSBB23O1yLqC6GBbix4oLgC
         EevQy7ehNrxSYpKLzOsG4T6qxquF7QvBYXnp8Jn5WmOgqLiaVRc6m5xs3nzNNC3O0HIx
         M+RoY+h5fkUjga5+JK0TrJSeKqYM94oHLNSgHXonwT3R2UFGXww8oBJcY+jGG1BCYLEf
         cIBjkX6ZseOtFfMzRRIQ6hb3Ta4eIwWgMGUMsiYDoUWDWw2ztrqapAO94T/wql915PDo
         xFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PbeWISCcBe2Apc2BxkOxShwWY3ZFI1WibFGUGdH0w1E=;
        b=KIjMc7kjsbjwko7BFcdPmuAtDr1TmHe4uOioYPLdvw/xdCTCmlEgl9Xe2f9uQV4+t6
         fpo2isU2IdssELjoIGGLhDS4hOmkBrmmXo3BevFX0vbRAQYa7+O1I2ja1I8n3WuPv3LD
         2zecJN0NlXDdTNlWmw63YmWT0GFZirG8bAfpW47MkSF6W3bhLJCG50wZm1jy+1RNFQOZ
         cvIJpWJCWr5Er5Frk0RqoPOg1RvSFipPYyibodbFoh+FivrnshSYvmypsO+VHDVniAIc
         ae09HVx7o4YmLt5fr0hEW4Mg/xlBAZRm2T2KA0nGAGAVZ23t+W498ov+xrQMheFwCUEJ
         E1NA==
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
Subject: [PATCH 4.9 10/28] dccp: check sk for closed state in dccp_sendmsg()
Date: Thu, 29 Mar 2018 20:00:29 +0200
Message-Id: <20180329175734.735620625@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296089395383323?=
X-GMAIL-MSGID: =?utf-8?q?1596296291728824176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
