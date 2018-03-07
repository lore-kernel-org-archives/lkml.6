Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs+5pyhTNLH2LVOJ4PHCarUL3QgeD7IRG0KQ8K+67d9TVT3z6KwRypl+zPF7Bw5OziqpB1o
ARC-Seal: i=1; a=rsa-sha256; t=1520451675; cv=none;
        d=google.com; s=arc-20160816;
        b=yJ8woFdCvj4F3csmbiAyvSd3lI1Ae/gARNWBmfqE/E0D2/+D4t7Z+WLB/4uMUWSrKB
         fj/SXOGL0QcEx3RvdwqH9xm6CAtYl16OSh4+imAn/g/DTewg7u5gLxEJgpMQY8O45nQe
         HfI+Oc6sqb+Y2+KLCr1dV12gpKIbmOF+jJxzm1CdTq3m1pbUCDjXhYuFaV2HekaF8pBZ
         ockBymYSARpKpGlqG3Bra4QdAxKvqw4kx31cV1VQZrZyfx8JMS+TC721kYlU2LljVC7q
         9d/78azoERb7CkG5e7dh+4AM9Ip68tM/y9QukHaFvxLPKPWS0WE+2mw7vu1SkM5P6MbR
         czjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VQNq1zY/n++sqR68R0m21fokcmvqZc7M8DqtSATStX0=;
        b=YMk2AA67Yp7gGVq7ozTIS1DQCwuKIZtDtxg+0eEdhJK4OgU0lqq1V3uN3b+Th40LNc
         AZqv6ncput2qU52kmszU4n0vugqC7lqzZhYHj/36eSqxCIGCKff1B1tHvdXFGgM9FtS2
         4Rpkyv2gozxjDgABVM65aggeOUAVTHtQaamYiVxefjYSBpgbCmp1AMxVuF5qxroB9j+D
         gGRbVit8xSBqBKTxgMP++/InnXHBhSDIE+3luzNVQsVuLG3aFkzIOKPmvG3ueXeY+TY5
         ZbANKRsC2v1wSC6BMrjlAsPTduiVA0cArxpHsZ2Jr/UCA1m9CWnd6AzuayBPthXnuPPo
         71lw==
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
Subject: [PATCH 4.15 049/122] ppp: prevent unregistered channels from connecting to PPP units
Date: Wed,  7 Mar 2018 11:37:41 -0800
Message-Id: <20180307191736.110010631@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309136326653920?=
X-GMAIL-MSGID: =?utf-8?q?1594309136326653920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3161,6 +3161,15 @@ ppp_connect_channel(struct channel *pch,
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
