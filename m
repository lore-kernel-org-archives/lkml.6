Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9lTsro4S7u2lSqgOnRMKnXZbKZOxXdcQUpTcy1GLEH/CtM4zyqM4McGzrXckK6pLES8Hb
ARC-Seal: i=1; a=rsa-sha256; t=1523473532; cv=none;
        d=google.com; s=arc-20160816;
        b=We02CV0o3JT0MiHimHVr+3mWNniVDNPlDdlIYeUDZ2fQYE2XI82D88Ms8Az90IKYZt
         5tMHEQcZzG/dZb5wWeNrc9ujm687o2/0/7lfW1PuB7cDQXKLXB8nuWTc5SYwd/c5O1ua
         YIgm4DCUveSr2hgkrs35s9HCVIkoJWwxvfqDrttbbzdMF8rcJpHzE2UCmXO1rNJG1EXD
         3O99PBwpBwn64ZEPcdNdSqAYBYf9b6IY+PmIdyhq1jTM2Bg4/WLUjNK6MilJOAgtQHpk
         d1wQ89Gp3DQkN39w//spIMeIpAorIwoUavMIYU9VpYTRl2l1eEZtVOdaBKbyzq35sLN5
         SI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mHz+U+D4UhXYEqV8dHLyipvUwfLf5SrmOiolN2tZRLs=;
        b=J3W+HpxARBOd4PnWQuqId1R2kciIH3U7GNS6Pb2s91XB3l6CFVgi12OPWgfFF/7r6F
         z7cjZMR/2x8MO9n0443cQHldQ13gLtVxrTBLII0nC/YUslBuQIwnNu1h/tqyTi7YLa4L
         mNl74Lw/kxpcUnvIU4TMnf7QyKwJbl12K53jUwRfoO172plzHrNaHKZSGkoRH7xm2DV3
         9oOzUhYVxqHQNiiA+OmqbJF0AbFqNPWWfBQvUidJuDkS5/qYn29PHtH60tH7wysXtiXy
         zziHUzTT57jjplree/Rt2+OOI2ZwoF+qYgZj5gwTmcgNPXaLDo85K0YZXS6HcmBxnF7H
         rlNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 281/310] netlink: make sure nladdr has correct size in netlink_connect()
Date: Wed, 11 Apr 2018 20:37:00 +0200
Message-Id: <20180411183634.706120395@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476332058088557?=
X-GMAIL-MSGID: =?utf-8?q?1597477783299748203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>


[ Upstream commit 7880287981b60a6808f39f297bb66936e8bdf57a ]

KMSAN reports use of uninitialized memory in the case when |alen| is
smaller than sizeof(struct sockaddr_nl), and therefore |nladdr| isn't
fully copied from the userspace.

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1054,6 +1054,9 @@ static int netlink_connect(struct socket
 	if (addr->sa_family != AF_NETLINK)
 		return -EINVAL;
 
+	if (alen < sizeof(struct sockaddr_nl))
+		return -EINVAL;
+
 	if ((nladdr->nl_groups || nladdr->nl_pid) &&
 	    !netlink_allowed(sock, NL_CFG_F_NONROOT_SEND))
 		return -EPERM;
