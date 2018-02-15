Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225jXSteL2/VGo71Kmd2rkAYu1EafnUZpVdN8wnWMtS1pfJ7hsS31K4R1bD9t1JSy/NFlp+B
ARC-Seal: i=1; a=rsa-sha256; t=1518708372; cv=none;
        d=google.com; s=arc-20160816;
        b=vP0QjbVkuxLmT4cHp3IPzVK9k6p8i45YyjgRZVlOU+NppuOSD0YkWnZO0VX0Av0xkF
         3ipKlojzy5438RRV0qlOZXmjVbvaeqQzOiHqP7anJScNV1De9ZW1HoHGjVsbdcW6AzCG
         IhvP8mI/JmMcFDC8Eu8cWgczWP/8Hp8IIvnZSnzVWyXQfdRy5NMaQo+v8jwg8LcaFQEA
         OdGqHiVPp5fodWZKdBR2QzsPp7zwSXydejFQ887Rn0cUM7cTzJarygqawKQf/0Qm/+ic
         iY1ulbSeb5mSFkNxDOIhbquftzF5zo6FecNkuKT2KaJg1dBy4LeqeemcfD+FZ7ZLjbGJ
         cMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=siwsikKV/fNQgUL+nKJd3mTPjtv9YymHkM+6v0TpH5I=;
        b=Ac55ROzDfPrp1fGhqtqRSMVA+G/4lS0rxr0PV2B2+PTeKKFPPBPWsaoZPBx/XXxZ3u
         C3OFVhMTmVF4yCdzVBI6BuS7rhP9i05HVYryTVFnHqk7pO5bLzeVQUl9UGPzZU428BAr
         RZ1X3hiK5lVV9yI05JF+sBAFXKuSj3A8u8AOgFVteJsLh8NfTcaTRvmGPzQqTFkrNy4U
         d4aN9FZ+L0TzaiKljAdq6OAEpINaPW3vqgRV5LtGQ4A3PNhSOp02jHb8nEaricuQ4nRf
         IiNTqpe047qHxeNCuRuNY2aPz8eo3bfLVT/hzJER2o6TL6AfX76GG2wQ70LaPWDQp3Rf
         X5VQ==
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
Subject: [PATCH 4.9 05/88] dmaengine: dmatest: fix container_of member in dmatest_callback
Date: Thu, 15 Feb 2018 16:16:32 +0100
Message-Id: <20180215151223.222611754@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480912266361041?=
X-GMAIL-MSGID: =?utf-8?q?1592481150780651373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -339,7 +339,7 @@ static void dmatest_callback(void *arg)
 {
 	struct dmatest_done *done = arg;
 	struct dmatest_thread *thread =
-		container_of(arg, struct dmatest_thread, done_wait);
+		container_of(done, struct dmatest_thread, test_done);
 	if (!thread->done) {
 		done->done = true;
 		wake_up_all(done->wait);
