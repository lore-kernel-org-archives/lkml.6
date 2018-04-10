Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49T4MDqz1yLdNE8EIHM9dKIa7HvliddLjGs1TGRDmriE49bxf5BIO8eKwATlT5vnf0vtxs0
ARC-Seal: i=1; a=rsa-sha256; t=1523399599; cv=none;
        d=google.com; s=arc-20160816;
        b=nAq0sZRngrh2o243TusrA9va0+3Oxl3OeoxDeGQrdK/5HLQ4ZQyZeZcUgvkCvdh3sH
         6OMHnGzsMqSRibRYz5oqD3Q0IEF3khsGTnMcUmhSEB9FGjJXpQalP/TP8T4STYYnNVoU
         MzlSLwUecjaJJ18nl9KEQv+SCI8JlyqoeJNpauzLbfZxC+cFROOxlL29PY7s8tXU0W8e
         VPTt26oSC8C2cQ6JtsnB7MdvgUL+wlKakWE+GWB3aXyc+pzCrvmBpUsH2tz2CRPpDJx8
         VaJkN2zljapn+SEqcFaYVGGebXANs0W/b416ISkJtbLtdvVqiIkHaQ/UA+ljkz8yZXGR
         D35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=miemeAe90eYprWlSnrPcNS+6l0Mbw9B7+xLYcMxR56E=;
        b=rvBh7R88uUyy2vFNhlpsLBPIVN6DDTYLQpB9WWo7Xv1rhpeHvhd+4PbIVUygtgZnOY
         JWtxTWEF7j8p26xcQt3zhfKcPPkypeDHZK4ehQoLu9UZkYTOwtY3hi7tRkcuk2cOsjMG
         +o+Fpcxx3FMoYUZ29rN9Wef/wM4sD3xoQHtLhls3fGGEKFu6XMdibDb4RhiSXsRxEqut
         s2UlPi65OOquDZy2sMFa2Zl9k3XTbO5rbIhJq9RtgS29w0ExsEpl+6EAFNU9iLIbmy0u
         NY4QDSZhIsrC1I9gTqQhx7Eb9jkJsMdubKMigv8Kb5IJTITOy1FMOF47qUcIDtnDLdjq
         1Rew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 167/168] vhost_net: add missing lock nesting notation
Date: Wed, 11 Apr 2018 00:25:09 +0200
Message-Id: <20180410212808.329783793@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400258502642813?=
X-GMAIL-MSGID: =?utf-8?q?1597400258502642813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit aaa3149bbee9ba9b4e6f0bd6e3e7d191edeae942 ]

We try to hold TX virtqueue mutex in vhost_net_rx_peek_head_len()
after RX virtqueue mutex is held in handle_rx(). This requires an
appropriate lock nesting notation to calm down deadlock detector.

Fixes: 0308813724606 ("vhost_net: basic polling support")
Reported-by: syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -618,7 +618,7 @@ static int vhost_net_rx_peek_head_len(st
 
 	if (!len && vq->busyloop_timeout) {
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock(&vq->mutex);
+		mutex_lock_nested(&vq->mutex, 1);
 		vhost_disable_notify(&net->dev, vq);
 
 		preempt_disable();
@@ -751,7 +751,7 @@ static void handle_rx(struct vhost_net *
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
 
-	mutex_lock(&vq->mutex);
+	mutex_lock_nested(&vq->mutex, 0);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
