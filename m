Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226vW5BzrkHZqG4ufQ8lIB3BZCvQxunteAPF/3YLVg3oLBk7WGQYfF5sq+lnx3gBxe9hIMlu
ARC-Seal: i=1; a=rsa-sha256; t=1518707915; cv=none;
        d=google.com; s=arc-20160816;
        b=WO4awu5r36o91gnY4XFumUxl+h2jW63jsA8uUFRX9p+EmU3DfI9dZ6yt6e/bZY3hCq
         Cp85d+gFep7G08MNMCSi1vCTzlRytLrzWGI4IMiqw1jw9Y7DJRKx0sOwKZLrCI5guPCT
         KFBYSrDBeiiL2X2gI1Ve4sz7IdQkvJT0aNxWgGYXwBDzq5IInIrzyxe+dh14lEKDDBGK
         5CVOrEdvY7VRUFMqfD/aqzC+7HyOGwxgtJgvMID7v96hTIz5v0vF62FNUsDWZa0ZLEN2
         hWUBwA2qW2DogFH+hIuDEabdSERhCjnx01UQODeSZgXh2BxjFL5fTHDQtH90wC1KwtYb
         vgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Mn1aJaTHXrtGbHZzfY3FjdyCRR0uISVrb5pE9mL1fdY=;
        b=npmR/ItX4GApgrSwXh4NTCB9yqPshQWdv8Fb1MH0LuHZq1VltfeyAFfQKdC0WKSgdx
         VuxbOgWhaQ1lDpk1MpQ5cmW+NEYv/z+WaQyYr3RQD7Zt6rFR3ryiv/kGLsB1UEsK854H
         9M7TXkYkh6roF7g/uFNFWDvCnVnVf7UEcIbd/zlWjicPcYi3huFbSsd/79b9ktnZrMF+
         cm25US5whZ7DaPUyAEuoKhuHneLMl8jUo5N/5sA5XvvHAd1kR6EtFE90EZHAo7b/v9Sx
         NQtGx7T4Mng2Go6FRXCZQjAbWPCFtOqgk1bX1ApJnMvrC4TB9roUKtUEKyc7WY9iZsoC
         hG8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+eb17c6162478cc50632c@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 01/45] vhost_net: stop device during reset owner
Date: Thu, 15 Feb 2018 16:16:52 +0100
Message-Id: <20180215144116.162138244@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480671648397823?=
X-GMAIL-MSGID: =?utf-8?q?1592480671648397823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit 4cd879515d686849eec5f718aeac62a70b067d82 ]

We don't stop device before reset owner, this means we could try to
serve any virtqueue kick before reset dev->worker. This will result a
warn since the work was pending at llist during owner resetting. Fix
this by stopping device during owner reset.

Reported-by: syzbot+eb17c6162478cc50632c@syzkaller.appspotmail.com
Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1009,6 +1009,7 @@ static long vhost_net_reset_owner(struct
 	}
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, memory);
 	vhost_net_vq_reset(n);
 done:
