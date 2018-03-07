Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+RvBwWQhjD4QKwWb3YBMf1bRnTTbsPAkUCgQUn96ZqdH3F5gWZ2EhcYwD7JSmhPjTDjEQ
ARC-Seal: i=1; a=rsa-sha256; t=1520451954; cv=none;
        d=google.com; s=arc-20160816;
        b=UZsI4h9Yic96gZb56WtSYU72m6jEN9Uans7stO5wez4doq6RlEgWUcn3rJZIQvRHOE
         5HeqaHwu55ezU/id8oZZMzX9pUnTOIgfA5ZJhnqzduf45xFB92rAyN7Ugo3IqyDAGCTf
         +8QPij4h8NB64H0NYWFvfPDE14bh9ETWStfaqkyUyA3yBi+3sQVqkE9tvK/4ZH7zYiV3
         Q9glyvqNaiK8zCp8kEhffkQ2SZjB6YAEJ1coSfDG6iWN1i8A9sNJV5mk2w9wrRO7K1V6
         K6PfoH0mzqoQfury+r/Cgbq+CloF43kBpTmssXhX4FLzIY+qvK4oGHI4BCrMyQKvVUq3
         Mxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+WSOGJefO0/L0SceZWQpa3/rHUyJ23Qfrvvn/Vye/18=;
        b=P6PF/B/Td9HLjE8YRDsJjbM0PjSbmo9rQ6Qs/gixrEPPhA2PcD+Zu8gvLRIBWBBv6T
         ibVW9gi1G0OwigL14tyWKzzTV/oi2f0fZ4AEFJLTpscJVkTBgwR/P/hVwcdQW8QS8wT3
         h3r9+QWEN+sGtAZszJAJoLV0wHJdGo+WMwCqoJhP/zY7jx9tM/C5CRx0oHdhe73PKndl
         pGelpAcmGte2SFD8ut2l7AIhhlHdEyZ3NFwCLeKZ87vJNGcg2r0xn8DvL2DlBaz6UJKD
         Kq4Ne3zIg/s7fYLsoBcTo1W2bUlqloGC+ehFjBxMwhiqr+WK+nJKWgMmN6Mtkw66xHZB
         HcLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 044/110] ppp: prevent unregistered channels from connecting to PPP units
Date: Wed,  7 Mar 2018 11:38:27 -0800
Message-Id: <20180307191045.355009414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309136326653920?=
X-GMAIL-MSGID: =?utf-8?q?1594309427765275648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit 77f840e3e5f09c6d7d727e85e6e08276dd813d11 ]

PPP units don't hold any reference on the channels connected to it.
It is the channel's responsibility to ensure that it disconnects from
its unit before being destroyed.
In practice, this is ensured by ppp_unregister_channel() disconnecting
the channel from the unit before dropping a reference on the channel.

However, it is possible for an unregistered channel to connect to a PPP
unit: register a channel with ppp_register_net_channel(), attach a
/dev/ppp file to it with ioctl(PPPIOCATTCHAN), unregister the channel
with ppp_unregister_channel() and finally connect the /dev/ppp file to
a PPP unit with ioctl(PPPIOCCONNECT).

Once in this situation, the channel is only held by the /dev/ppp file,
which can be released at anytime and free the channel without letting
the parent PPP unit know. Then the ppp structure ends up with dangling
pointers in its ->channels list.

Prevent this scenario by forbidding unregistered channels from
connecting to PPP units. This maintains the code logic by keeping
ppp_unregister_channel() responsible from disconnecting the channel if
necessary and avoids modification on the reference counting mechanism.

This issue seems to predate git history (successfully reproduced on
Linux 2.6.26 and earlier PPP commits are unrelated).

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/ppp_generic.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -3158,6 +3158,15 @@ ppp_connect_channel(struct channel *pch,
 		goto outl;
 
 	ppp_lock(ppp);
+	spin_lock_bh(&pch->downl);
+	if (!pch->chan) {
+		/* Don't connect unregistered channels */
+		spin_unlock_bh(&pch->downl);
+		ppp_unlock(ppp);
+		ret = -ENOTCONN;
+		goto outl;
+	}
+	spin_unlock_bh(&pch->downl);
 	if (pch->file.hdrlen > ppp->file.hdrlen)
 		ppp->file.hdrlen = pch->file.hdrlen;
 	hdrlen = pch->file.hdrlen + 2;	/* for protocol bytes */
