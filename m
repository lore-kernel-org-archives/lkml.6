Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvzPYVitA9088tFaeCpeoJ9gArtZey7DNhaHf/f4XT/G4elfEISCAewUWpTtZg0VRyJNTzR
ARC-Seal: i=1; a=rsa-sha256; t=1519981014; cv=none;
        d=google.com; s=arc-20160816;
        b=ZYHD0pGIeJ59WbnhqcfqOD8GtSHKjqjHG4nmZq5Mhh4PtYYazhdB98QZaGkTYG7m2c
         2YbRD7u/x6qy/9P48/44OV1lTVopb5JK7ZraSV7pbaCiPw8Rw15mu3ESHhO3/XrFskG0
         hILqU5NluLog9mOdj714MLmSlM963aoT+r50R2OSCqFDxzM4Uvr0zSll2EGQlcmoZ/k6
         hjFN7li/R6y9PgNPLmtrl02wmdyBdvvtfiMO+lYMQx8KuwACE0ltvhIt/H3F/qdqD+ah
         QvM5S9djIigcsKVXQccwn46rQy2ycmZSP+xbyNsWy1q/IzMfTH7raldvJhX9WuhDw+7j
         +DJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+/uXM6oQwdsFmk+7+WiKnagYkt0ad1UExFolT+ZrMck=;
        b=upDvHBjhqEjsSHbgVySD8hZyG8n/iZuKAzovEv/Cvodhfx79qALfXbv9tual8DLo+c
         fo3tfoe0JHipi5iV8dwHYQ76hEV4aeQY44hGj+1F9j9YDYrrXYBvyqaN0aA0TOzHU4uh
         Z6VD03vOLmJ3rbnxw+8SL8HI59yHPGnq6hjE7TzJu20Jy2xXyl/Xd2kLAsxTnyPolFag
         aoOeN8g6AEdNEXR3x1+HVPLNqGxHQ5GhBtJSztG4L16f95G+oX2SFTVcUNNX5w6KaSN7
         tR9ysAqOxmSgZ7YAwr5lpxB5SwuR235bejW3+rLMoFljOp/ILbL38jWoo+cVWN0CY6ja
         wyAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ying Xue <ying.xue@windriver.com>,
	Jon Maloy <jon.maloy@ericsson.com>,
	Tommi Rantala <tommi.t.rantala@nokia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 25/56] tipc: error path leak fixes in tipc_enable_bearer()
Date: Fri,  2 Mar 2018 09:51:11 +0100
Message-Id: <20180302084450.868200317@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815612315964266?=
X-GMAIL-MSGID: =?utf-8?q?1593815612315964266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tommi Rantala <tommi.t.rantala@nokia.com>


[ Upstream commit 19142551b2be4a9e13838099fde1351386e5e007 ]

Fix memory leak in tipc_enable_bearer() if enable_media() fails, and
cleanup with bearer_disable() if tipc_mon_create() fails.

Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/bearer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -322,6 +322,7 @@ restart:
 	if (res) {
 		pr_warn("Bearer <%s> rejected, enable failure (%d)\n",
 			name, -res);
+		kfree(b);
 		return -EINVAL;
 	}
 
@@ -345,8 +346,10 @@ restart:
 	if (skb)
 		tipc_bearer_xmit_skb(net, bearer_id, skb, &b->bcast_addr);
 
-	if (tipc_mon_create(net, bearer_id))
+	if (tipc_mon_create(net, bearer_id)) {
+		bearer_disable(net, b);
 		return -ENOMEM;
+	}
 
 	pr_info("Enabled bearer <%s>, discovery domain %s, priority %u\n",
 		name,
