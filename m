Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8Iks7JBNXDxH/KjSdfMgnxDMAHY9QgceZ4Gd3+ivBasvLH/XA9NUxzzNsND6elfYjl3Kf
ARC-Seal: i=1; a=rsa-sha256; t=1523472740; cv=none;
        d=google.com; s=arc-20160816;
        b=SpE2JmGAnauOLgTJJCBlYPb8B2iXu7i2f/QMcqEOJDE0tR+kXUySkI2vmsAJ2qdqtV
         uAMlCM40bfN4WJ3WcV3tM7Ne+eUrwaPHJjH7XodU+avjiKp4jGSK73US/de/YFHLRkQs
         FhCM2Xdit8Pf7Ybo4ua5VaUNU4Vo1Gh9x0N0ng2r0SjWJ6ypQ2Uavej5+jicW0YG98vk
         DmxoPvxHsWFRnPIBIQnYqu8sEgIRH1tvIhV6PZ6LxBBOdH1CzakuPoI/SIB4NvDlfbpE
         5Mviw5eCuFSy4mf+uSExbQF728qfUsyvp5nz/DiSq472fcd9vWF2v9nZDYl0osObIch2
         Zyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zHgXW+c8WqkIsWfScyxfjyNFw+s0BNquTPYsUtclVrw=;
        b=ucxLLV2Dn7IhZT3zArsXZnCxnbqm/rB0wUObMk8rWuNZP52HzS11mVEZOQERZNSayp
         5xmpLMQ957Iz25NyYmMB3jwyJAZnDt/s1Cv4ZePOtTZMalQxH3qvs83e67xmykVEqoJo
         gDRwmbCsYdUZiRbaQtqi9+k+yVeUZ0HNLmUt1gh3T2kx5HNkVOBC+n7QgN6xwuZUOlpV
         HOsL36BxjEmyMlLHFVVZCMOPDJylav1XCfPyiiWFww8Fg+0y2Lp48O2vGmYhgn4y1Kl9
         m64OzBHANfXvBlEDMM6HVE/PNqXwh7/FlgwhQ9AVkIVuVZtacAe4LUs2yeEika/NBXLC
         JUpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>,
	syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 175/190] vhost: correctly remove wait queue during poll failure
Date: Wed, 11 Apr 2018 20:37:01 +0200
Message-Id: <20180411183603.177057465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476346549165488?=
X-GMAIL-MSGID: =?utf-8?q?1597476952720926610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit dc6455a71c7fc5117977e197f67f71b49f27baba ]

We tried to remove vq poll from wait queue, but do not check whether
or not it was in a list before. This will lead double free. Fixing
this by switching to use vhost_poll_stop() which zeros poll->wqh after
removing poll from waitqueue to make sure it won't be freed twice.

Cc: Darren Kenny <darren.kenny@oracle.com>
Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -173,8 +173,7 @@ int vhost_poll_start(struct vhost_poll *
 	if (mask)
 		vhost_poll_wakeup(&poll->wait, 0, 0, (void *)mask);
 	if (mask & POLLERR) {
-		if (poll->wqh)
-			remove_wait_queue(poll->wqh, &poll->wait);
+		vhost_poll_stop(poll);
 		ret = -EINVAL;
 	}
 
