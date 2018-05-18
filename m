Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZov46Mt340/5Yeuyx8972C269d2EVZ/p5WLtWhe7/+R84li/b02NJT16My9nRfrDwHEJVn8
ARC-Seal: i=1; a=rsa-sha256; t=1526631453; cv=none;
        d=google.com; s=arc-20160816;
        b=SUa0qIqQ8asKAo9lbnG3Mb5THRuHsMQdsmrIdl9BycJcqW/45IhPAt/Nqaqqnwy4uk
         BZrWb7yGJqZV/dlQ8fMZ10csXK5o+uClQPkzVsWew4a6Elm57QK2dCMVVJdR5p2kzOpt
         BjdtHHfzS55VPBVvB17kTTz8uQBe6RvAQfbXVTJk9wGBuZ0+J363vBr2K0LBlZb2J+O9
         0b66ltU40zpgKaqOwA6EG46yv3HvQfPQpVRqGCJsv5slM9LmAfer5sGROGER3XKmHkYi
         Y0yG2hVCa62m2mw2nHXBJk0+RQ7wZ42T/YA/+jsoNw95mUXDX/xJCELSAJ1/WKrD0yWs
         e9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=V3P3FTlO8Oi4W363HPsrJoJAJlTdvSj4lWV7SBOz9uw=;
        b=xeRbEidYX5p6+sgIO2G3cbo7zp8EDhQMpSppN/TJJYp5CTORkzeCo/SRdigOoN8SGy
         hZv/txuy2hHjl4FJjgCGjPDi0to+2EdzyM+PTi+nUEgBkbTcccWn7NALrqh+xNJoucnq
         aPpwU4sskxD/H/vJmINfhaznZs5p2NVhWHhci/BmgHFJU4Mx9g2pVaxspx5YHlkiwGk5
         cggYnbFaQTaOOwTgdYpdadSqI6QZX2ualy2ROOI6lL3qC7FXx5wO4nA0vsZcI2jcDMpt
         d9JmxK9lP3XUro0rGTSoxFKBXq/Tva2vElKxDptstFdREHUnomBp8E85L2ASZAHF0Y3H
         pb/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tunxHFUN;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tunxHFUN;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+141d898c5f24489db4aa@syzkaller.appspotmail.com,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 26/55] sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_make_rcvmsg
Date: Fri, 18 May 2018 10:15:22 +0200
Message-Id: <20180518081458.753299529@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789103167895925?=
X-GMAIL-MSGID: =?utf-8?q?1600789103167895925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 6910e25de2257e2c82c7a2d126e3463cd8e50810 ]

In Commit 1f45f78f8e51 ("sctp: allow GSO frags to access the chunk too"),
it held the chunk in sctp_ulpevent_make_rcvmsg to access it safely later
in recvmsg. However, it also added sctp_chunk_put in fail_mark err path,
which is only triggered before holding the chunk.

syzbot reported a use-after-free crash happened on this err path, where
it shouldn't call sctp_chunk_put.

This patch simply removes this call.

Fixes: 1f45f78f8e51 ("sctp: allow GSO frags to access the chunk too")
Reported-by: syzbot+141d898c5f24489db4aa@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ulpevent.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/sctp/ulpevent.c
+++ b/net/sctp/ulpevent.c
@@ -715,7 +715,6 @@ struct sctp_ulpevent *sctp_ulpevent_make
 	return event;
 
 fail_mark:
-	sctp_chunk_put(chunk);
 	kfree_skb(skb);
 fail:
 	return NULL;
