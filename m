Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226g8FPC/3Bcu84sQoZB42NSinoIpRpKPK/8onHOXjIAbkCfGs6lAJWReoEVItnQGsrk0k8R
ARC-Seal: i=1; a=rsa-sha256; t=1518708717; cv=none;
        d=google.com; s=arc-20160816;
        b=VJdG7MmhExGHy7gte/7282wxTDqaKQAD/rN1Q3Tz30simmzBLD6o3tgblgF6Kt4CdY
         9vI/L3UUjqVZb3+ESoieF7trl4tNfy+eoC5W1Lp8XZqg/9tu8TBcrn/HxHh9C8/s9x4B
         ngIsjiPGeX8stDHXdd52yKQhbmfdDRJFbwitpdNJLOv0++cTfOurY6kcTW1cZkP4s/Rr
         4pP5de2J603AAecRaqWSxNU0r6ygXlXXu71dQocz/K2air+rZgTPowP4tWi+TxKpHbUe
         gfA2TSeNwP36Gp0Ad1UCwIu0zCGcrLlYvTMN1l65F3KdTDiKE2yQM1zo2GfelsvWL7X5
         w4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AfYfZ9ZfS9U1AuU/szDsevNyDDpTuHu+N4flJL3lRag=;
        b=jMHOab89ma81/BCxp09zra8WXICFZu0hEVrt60LrMjp4P90fhL/MGNs40ORVOx/yZS
         5x9jH7lEpSR27zuU33TUCtn/YwncCawOp1wzVjJaFZdOg7JEsg9R7xE09iB1jrGj9pTa
         sMpQuLN/iJp/VHF/tziN279GQ6jBYWf8+a1Vr6KNAHsoAM39Zd8IHY58WxcMr8meKZXq
         5ikr1h/AVll7e7R6ELaQz2VWxY9PHJ895B/nr/3AbqgZAtDfKZTab3fCLBjeOL914/J0
         vBAwK/3YSiSJiCcfk28XM7Uv24YoXs4MGRhDlDnG61uF+GBNF6nnFVw+hWxiAb33JUUI
         1+rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yang Shunyong <shunyong.yang@hxt-semitech.com>,
	Adam Wallis <awallis@codeaurora.org>,
	Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4.14 007/195] dmaengine: dmatest: fix container_of member in dmatest_callback
Date: Thu, 15 Feb 2018 16:14:58 +0100
Message-Id: <20180215151706.118253992@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480912266361041?=
X-GMAIL-MSGID: =?utf-8?q?1592481511888233539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Shunyong <shunyong.yang@hxt-semitech.com>

commit 66b3bd2356e0a1531c71a3dcf96944621e25c17c upstream.

The type of arg passed to dmatest_callback is struct dmatest_done.
It refers to test_done in struct dmatest_thread, not done_wait.

Fixes: 6f6a23a213be ("dmaengine: dmatest: move callback wait ...")
Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Acked-by: Adam Wallis <awallis@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/dmatest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -355,7 +355,7 @@ static void dmatest_callback(void *arg)
 {
 	struct dmatest_done *done = arg;
 	struct dmatest_thread *thread =
-		container_of(arg, struct dmatest_thread, done_wait);
+		container_of(done, struct dmatest_thread, test_done);
 	if (!thread->done) {
 		done->done = true;
 		wake_up_all(done->wait);
