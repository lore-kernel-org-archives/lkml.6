Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuK+KYNMnNJbTpvsr9Wyd1ojCBQdvdA/cqfJLBMlUyo9UQo3Y+oXACcrIIaab3X+zmZL79k
ARC-Seal: i=1; a=rsa-sha256; t=1520641230; cv=none;
        d=google.com; s=arc-20160816;
        b=d1Jw9+QJiuwtx3ezFdkTkXJYrs4/eZQEZ1T2mRJdvwm9bwab4o+eYokGIR8SV/B1DE
         3pJ8B4AaPsruEq69wAYFIczd7nUC/1GLxesQHjIATzrbzDsC8Z4OjWkhCdrNnN3znyRu
         geDXWQY4+DyqJwkdzMMsj4qIUPf9A4nHVBEFTMLvFwtk4ZLARvBpqMesrg5ov+zJbfuI
         jS5biu9aWsJNhcybScSn2WASOtco/O4JZr+TYD+poJNSre5eZPjwLYNBu4YsWs+hqJyY
         MGJghEvvNgdBskmysmfnu9fkwGmOMaitODHk1EAzk/BcMzeLiG/eTm5zFHJ2RB+AkS/z
         Wezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S2kFmgmgNaEDsKm7i1bsRqW4lgUx+q5wiYYQBXtQs1U=;
        b=mU3z6HUzUiicOLhsRy5zep5XTA/Dah4KuFeI29w9sJQZMUrZZeaLQpNz0129+WNGUW
         rNRgAyY91ijqM8CujWLV7JKuzySb1gu8Vs5VFyKdDegTyEozBobYozM+1Mn3AYV+qxuu
         tUJduUgc+Rviy2QPAZfFFkoZijASaKxJNCK62q34pHryM5Xh36bYo6i92FYAsETr3qq1
         mP+LpwKxnZziMxZnNYXJLGnKf5p9yIoMeVUt5keOcX3A//18OyF4pUfSBqFHu51lB6Iu
         CbeFOKyqA2NYb5SDGRA8lBuedrpLaQv8KZJKBNKjaaMIKj8Q3LaNprd/+r79ud21X4i7
         s2Qg==
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
Subject: [PATCH 4.4 25/36] ppp: prevent unregistered channels from connecting to PPP units
Date: Fri,  9 Mar 2018 16:18:41 -0800
Message-Id: <20180310001808.741475823@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507820152251435?=
X-GMAIL-MSGID: =?utf-8?q?1594507898824181288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2952,6 +2952,15 @@ ppp_connect_channel(struct channel *pch,
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
