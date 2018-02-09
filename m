Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224XkiT4DxqNcxmKqx4pi80D9ZPlPY62Il1QOo6U8rPI8sL+Btkk+2XHHESBC9P7Ufzi8121
ARC-Seal: i=1; a=rsa-sha256; t=1518184028; cv=none;
        d=google.com; s=arc-20160816;
        b=oKUKb3V9L+CCv+jcpKVGxNYcXjYG6Y3PH0S8Ft6u0+L6wbWdFsMSVyCGVoSDsLmmvp
         PvB6HT5ShsNL3wvHf84f9qIn/7NpX7GjzrEljI4V654rGdGUi3Ed6Xzk17lah37c5Z2V
         ylq6Ua0xQUsLlSbL/9ObDYu7EBABdQqrQ3KlP3OEvgGL6g2U8WeobolC3Bv8i/AIH50m
         Wam3K+UCysJHMjyZLWxILOB2bCvhC7d7VQSBTf+TXTDzouuXTDxTvD42UPkqc2zLUkjd
         BWpU3+YQ1TcBpbTQP4bBYcfPyFVSn6iXG/d9E5JE5MqKZfQKFVO7OnZKmKO9vfch/s5P
         EmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0kCqkTFR8fU7K2CTsaJWB8RoZeMumHJBZtqyqI4J91w=;
        b=PeAfPRHD75hMHwxaweJD9mAgvT1sQo5tdHVzuj6/VnXY8XwXAAuRFMJs1OBmDfhSEV
         4uYUfRm1vZCCfihpSBIyI61s7zK7mHzz3m1vw/LS/2CCuJ+DacjcsG3B5XXPG4PaxQA6
         WWNYfOjpz4kAaVyF8A/hfoNCdpX2uN8U8xrMPqmumU1W7mXWwRsBq15bGYaVSNmBegK+
         M67WlLwYRMkFsTTLOYpeW5DkSf9xrUravK6dyjEwzZHEzMJh40v94l7thFoB4epliVFR
         LZ1C6c5q+LjOdNcuJkv4ByXfXJoruYt5H6Xg8C9H6viitjfqbAfFpeXBdESyq9THQ51s
         1A/Q==
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
Subject: [PATCH 4.15 07/23] vhost_net: stop device during reset owner
Date: Fri,  9 Feb 2018 14:40:05 +0100
Message-Id: <20180209133938.758131929@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930971044037305?=
X-GMAIL-MSGID: =?utf-8?q?1591931335825146549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1208,6 +1208,7 @@ static long vhost_net_reset_owner(struct
 	}
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, umem);
 	vhost_net_vq_reset(n);
 done:
