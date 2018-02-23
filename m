Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224mCsNFatU7rMYFMtsoUG3wDGxOEwDQ9lc+3MaaHwRpTEoZP90M7KTzBi2c51lkaWQ4nIqE
ARC-Seal: i=1; a=rsa-sha256; t=1519412258; cv=none;
        d=google.com; s=arc-20160816;
        b=vDth8xyq8Mf9ijWUgQiq6MppjKFDbdA+/0d5md+4A94bPBQcfJLcTiTVIGzitydPWX
         xkRgP07650xP3KwhTMrqEwToUwHLxaTi4oKvrnlJIrmfzNBTRj6l3I73lKLIciQUu72M
         cScC3s9ezB+BcYi3VxNL1SXKz//PRAYqm/Vc8++MBKzpOZDZntGqzfsE67NG4/peSDv1
         Bw5iueNDR8OMHaIA6490FaxY4L0Oq5SaqFFSWhop++o50wWVX8ZZAeYyHKC4pXx0XTf/
         v7XBRNSCAA3/whqOZTaz8iuD0iBrAtjGEXwnmCU3guGVGTeyoQ2CY27vASNVU2AxMMCD
         xRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PqKcFrXpHiWfqWkCffCAiul6zWSxwDPz9EwRyiO2/GI=;
        b=kRK9UGinBXZr0N/IGh9PAFZb5kNW3z7c/lUjvK4CZKDRYuVR1WqZpTGGL9LR1ykbUG
         nXt+vZpWysphERpaMSw0BKPxOP4AYGdN7crMq7Mt6Dk9v3RU3urAeLTRa2OzXIbN1Mu2
         zC7yDjPryM9CPHcKrg7ZkY/uaFCkGBJYIDtodRiGDED5YG3DY/QxUceeqO2FoDNZTeoT
         C971+QBUdp+wG2ncLub8+4ElvwN7jSEkDrkibyRI3QSXvS3ScQVmQiU5RNNkxFT/ZrH/
         sMGNDr+A8S9Ka1BsT056Xy//OG/Z0easXTisp1I4P01B0CsVLxY1NVpsmdZGqcykEYHY
         SBJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 02/45] ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE
Date: Fri, 23 Feb 2018 19:28:41 +0100
Message-Id: <20180223170715.623064634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218272827905940?=
X-GMAIL-MSGID: =?utf-8?q?1593219228657977461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

commit 6e6e41c3112276288ccaf80c70916779b84bb276 upstream.

To avoid slab to warn about exceeded size, fail early if queue
occupies more than KMALLOC_MAX_SIZE.

Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ptr_ring.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -453,6 +453,8 @@ static inline int ptr_ring_consume_batch
 
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
+	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
+		return NULL;
 	return kcalloc(size, sizeof(void *), gfp);
 }
 
