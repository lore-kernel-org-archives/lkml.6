Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/LrGeWAovSN/6lpZOX+1LseXVGHEzVaV0ZcC1GqKbsrLPqW/Db7pxVR/G9Xy4ecS6t8IP8
ARC-Seal: i=1; a=rsa-sha256; t=1522346581; cv=none;
        d=google.com; s=arc-20160816;
        b=xOheK7MeOWrC/Wt4fxTpB9aE8xkrva0FViBJXCuVqPB9inSsREBsAxD9y+uhgbMw5N
         ZCQ/cUbrvRp/+RJlYsM/dlfdJeIliVdistR4YUJXuNpYFazaMYDHOdnhWonQryravNcX
         SV8Ei3YQ4lObs3YwOa+5AtuClHHwTDn08hvEeL/zOlJm/NUI5qofrjkeugex9Kq1Ai1x
         RJ2/gPs6jLpR6XVDScV7Omi3D9aroj/b0D799KyeEUdjZBRvO3Bl1e5URlx/eZv+qOA3
         hBRT/8ogWk3LsQ9BXnpiKFdyxeB3ZonpyyZaqCgAvTtGTIkc6ZBjmAEW60uBYP+gjARG
         uSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7mhFTWqtaU82dJPN0YZSGymGUzDwEOTxfuYBi6UnWHU=;
        b=gthgwVbsjSH5iGkbmDV8PNIAlA+8AJoW5GEiiqeCVXyVr1TN/iznh6IHURKExzB13M
         Dcsj7fIpe4mUtrVX1YTaBXH6hmz2CsKq3LgN+nJXqsWrBokNbRY6fzC2qiZQp9nfL4ns
         ZMpCXTrWKAynWEyt+cuH5RXn3vMN8NgIw/xSYJW8ANsofT0x6+JsEILOMhlpROnWRND8
         uDzFBfbctbZdy1JDWbT12/rdWhh3ifUKkAW3O1v64OJZsjvkETJUy6lpkD/IZi1R/Rv5
         yCPbz05Fir3+fkLKJZb3Lp9jUiIbjitkj+lLVcqZp3QLXVhDm/U4i6hZAsm2tEULHWB0
         A+DQ==
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
Subject: [PATCH 4.15 35/47] dccp: check sk for closed state in dccp_sendmsg()
Date: Thu, 29 Mar 2018 20:00:16 +0200
Message-Id: <20180329175732.210194134@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296089395383323?=
X-GMAIL-MSGID: =?utf-8?q?1596296089395383323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
