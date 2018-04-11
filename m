Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48EBK50O2DyqSGnxxhKne3L6HkSbV4gsLAoJNU2Appw3VQN1+VyAeLavsciv4uz9i1ByAf6
ARC-Seal: i=1; a=rsa-sha256; t=1523472162; cv=none;
        d=google.com; s=arc-20160816;
        b=PM2ljXa3sYZHiD7s2kZVm6OmYebpf0E6OOVpTl5jdyHZhqFvtwyEceq02QCh+sd3wi
         WQun9Ch5h7GQ5jSwrE7EQtTVLrjxgDmNEBwy6xB9qGijt/u3rzPSFv41VBKuZCJJ0uFw
         LE7ZqE6R+Esi4yhDUZj3G4QZuwq1TvyOqWTJ6+Uv5j4OGpNgv+Ai/jiILJaiFqSxqQVB
         k4ik82RoInBJky54IxNg9PG+xLcBfF7rPW6PxtXGwcFAJKk0BRkwWtjD+Sjhwa0/Zzov
         yDV4SmALwJDY5ieReq0+3TLn0CE4h+t0qvKJvjmvWAZemdi/mKDmv8A3Z2dGLhg/8aKb
         DDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s2f5FYlTJJWGO5ff3Om2MiPoZFhBcU1QoJTeMLmrtiM=;
        b=HRPKhJl2gAiDijr6nQpv1hRTFy5RwzJVAhRbW+IusUMXZ9tMFM5W+MV5Ts/kOJtL6u
         7csSPeu1ulPBywf4ck1QS7feRwTrjamo6AyJzycp1Ku0bmGPLXZqEkq+WFfjc9WT1v8d
         UtDWybnBArKLVkKyQezGCx5OsE7EZWtfJtTnMjMiSMQymkMEsLbxwDQZ4/k8gwhzZp6y
         fUDn+sT3sknsiLfmV5tt4vxctNvQfxuqh7OSjQ1C0cAVRQczH2PndiRcSryOw5pqylty
         9KBJCRQfDuOJlCAJNTogKp/phrxJjP+yulSuUkCnVCQTQCp9QiK4nErAFUD1Csvt+HTO
         Z+fg==
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
Subject: [PATCH 3.18 109/121] vhost: correctly remove wait queue during poll failure
Date: Wed, 11 Apr 2018 20:36:52 +0200
Message-Id: <20180411183503.520703134@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476346549165488?=
X-GMAIL-MSGID: =?utf-8?q?1597476346549165488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -96,8 +96,7 @@ int vhost_poll_start(struct vhost_poll *
 	if (mask)
 		vhost_poll_wakeup(&poll->wait, 0, 0, (void *)mask);
 	if (mask & POLLERR) {
-		if (poll->wqh)
-			remove_wait_queue(poll->wqh, &poll->wait);
+		vhost_poll_stop(poll);
 		ret = -EINVAL;
 	}
 
