Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49QsOj4vvLaa3zeJFr6uPHBKHVW8rOOHjx46+a/y4JKcpYcYDuR30CaVqlzS2tpMmD2y5H/
ARC-Seal: i=1; a=rsa-sha256; t=1523981200; cv=none;
        d=google.com; s=arc-20160816;
        b=GvKNbj22pUNsMINyO5kr+6X7vy+G8XnVvkaN30RkvXkF+cXO52RZ0xpES+mlQf8Lx8
         sen2iVk9yqKZiqVlIAB3ZB5JwRaxVIQECPu+o3EVjgm8Q7PrUO6F6jUX3kL84k3iQluo
         7GvcrFJXX92roSoY/ECm68rAsZh+E6io89w1hD7u65eU9mWhp7suzlAfXbOBTKe4vQgQ
         LmIXJrss9j2Rsi0dX7HbnYI0mpQuM8SNbbJLwPMwO9kBfBAI8A1MgA3rCkV4uGnYYNX/
         Ae3TkKkDzGy1r4mUwYVS6hHjrnJ0DlB2imSXIJEz8VpgnrJ3ajUIznZ/wdaKGpmPHLmh
         CahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9wtL4ZGSKZZr3Ho/aVnhlbJI8xWO/HK6uuVA2beaTK4=;
        b=c1McECFdfsZEAaxmV6K2zA3X4BfLru/fWl2Ahxxc95i2olNDIUf/TvKIjXTrfBblYO
         R9u9bmlEsfGXyw6yv1VOEkCAOqYxVOOuzpsoe49ooxI2yHCeGZ7Hh/nMQVSJdJ2p8TXI
         wxQiQNoeTCzqQygIkzd2nWVLTuwS2ew+kMOIbbK609v/3VjBb00gXzB54a1pz2h+ejOl
         YZ3KC1sxbPsCts4JMov+CVELU1cC7YO65UamiYl7PIIxQlRKWWL6qBCRArG0OKyFnawN
         fifUDusvIzaZ3ukwGTjAoatc39a7PGXmO/xFl+NPAo6UarOQS5YfJDJCKMoCS69dMc5d
         3uCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/49] vhost: Fix vhost_copy_to_user()
Date: Tue, 17 Apr 2018 17:58:45 +0200
Message-Id: <20180417155715.311593948@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009751810796107?=
X-GMAIL-MSGID: =?utf-8?q?1598010110759008910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Auger <eric.auger@redhat.com>


[ Upstream commit 7ced6c98c7ab7a1f6743931e28671b833af79b1e ]

vhost_copy_to_user is used to copy vring used elements to userspace.
We should use VHOST_ADDR_USED instead of VHOST_ADDR_DESC.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -756,7 +756,7 @@ static int vhost_copy_to_user(struct vho
 		struct iov_iter t;
 		void __user *uaddr = vhost_vq_meta_fetch(vq,
 				     (u64)(uintptr_t)to, size,
-				     VHOST_ADDR_DESC);
+				     VHOST_ADDR_USED);
 
 		if (uaddr)
 			return __copy_to_user(uaddr, from, size);
