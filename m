Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvCHeOna3d6zCAb65Oifdt1lrFAHBNNG2dgbWrlr1fMXGtc7WWk/xLZIQJfJckVeb72C2Bo
ARC-Seal: i=1; a=rsa-sha256; t=1520451826; cv=none;
        d=google.com; s=arc-20160816;
        b=aYNE8MsSsfWgMc/x/WZIbOXnpqL713V5+QlfCbbUVLEY7Cc8uSweDbPpkxpsnbpacJ
         LniihXNXjvnny5CFuDqzhmVO2WK6Q1232quvQ3hrd8bIYXBd5HBCMUOZClTesQypvZ6p
         r1OdikCFqiAWTfKVL8/0hmFEZnVkzqwYUgLBiiiiKX3CM5ZTh8GpBVWO4TCWcaEX4YPz
         /hbI276CZYIlAbHEgUYO7MDmsGy8bDTHMxrdVorZ+zQM2guKbU/lESrL71lIK2CiHTHH
         TZ2yWipkMlPol8KwEVWR5qWDmmRtnnKGXvs1/McLCjK5CWiCVEJ34dNOSXcbtF5QwGtQ
         Y8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B44WBYwN23NoMwWyyKnj0MhlGMPaey3O1x1oj5brrTA=;
        b=oe/4/ZX4wzBnVJTUPUjKlh0LkMaTELmVSYZediKaF4CxyZR7VXFa49Ie8XkBjrT0YR
         6LIaXlsthCvn0Zh4VotguIE6e/LhXJp9QBNstFocONcx/DWOHBYPe4iagguT5IhLfSG4
         6wuBjl334rGG9ComD1MLF61U+I0qQPNZw2l8hn3ACuDDmJEQRICkC45nTLPTDCd6Ln+I
         /WMVGkbLBQjYoD/dkTMf39x6yS47YAhTUCgWBoXNE1bB0ojc3Re8pGZ0kT25UtnD+AyQ
         hT3wDeAgSz7+vVX9WriJsyvjSNbXnqh/RPCloNqm5WhzaA8asRBqMMJcp1uBKvLbVlwY
         UmCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 076/122] tuntap: correctly add the missing XDP flush
Date: Wed,  7 Mar 2018 11:38:08 -0800
Message-Id: <20180307191740.280849456@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309294599371891?=
X-GMAIL-MSGID: =?utf-8?q?1594309294599371891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit 1bb4f2e868a2891ab8bc668b8173d6ccb8c4ce6f ]

We don't flush batched XDP packets through xdp_do_flush_map(), this
will cause packets stall at TX queue. Consider we don't do XDP on NAPI
poll(), the only possible fix is to call xdp_do_flush_map()
immediately after xdp_do_redirect().

Note, this in fact won't try to batch packets through devmap, we could
address in the future.

Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Fixes: 761876c857cb ("tap: XDP support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1490,6 +1490,7 @@ static struct sk_buff *tun_build_skb(str
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
 			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
+			xdp_do_flush_map();
 			if (err)
 				goto err_redirect;
 			rcu_read_unlock();
