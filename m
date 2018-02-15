Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225/CdVko9gvuj7QtVg2U7Pr0vSTgWVzk/XV+Dhx3vf7SCN1FgRpsTdh576weLtmU+PXW9h1
ARC-Seal: i=1; a=rsa-sha256; t=1518709148; cv=none;
        d=google.com; s=arc-20160816;
        b=oEAf/NUvLog2tXanT8tLOdoDC0zL7VkabgCpAXhSpd4veqPHfwsu6oO4upzAMGDKPa
         oyb8D5xTgJsExdMiii8/Q+qw3Ef/pMCuaEyjaxmUxxGcZzR/CzyVuV8JSJaPU80URis5
         Q3Xz5WEgO6GT7l2MGvN5SXAGwRTXFwuadNZbw1/E5qFY/6kgdLJVi+6AUiMEukGlUtIM
         q9z1uO1kA2eOy+EiCDH1ra6YYWflimGH99mHps9Zj9URO/h/bRnTYlNTjCJtc2CB2Z5U
         iv8eh9DICdNAKhECw7FhzVzWOFz/qMtRlhRbF5jLN4NjFrE3UU2EXM1xSgSRp7y2z/fO
         CTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IjvQnKvDeXYgHrOZRGEu8KQThhA42hdgHyW9yW5LtzI=;
        b=Fwe4CtTElQm1sAVg3Bll608BSGOknI4FG8d1VlqHj/jiIungkD6BEgC9VzfpSNIRAy
         IKUT30KKLk3xeGOPqhPHO6d85qgUFWTe6opC2TBYuIy4yXDr+KyDh52jIVPNKn4u/yiI
         DhloEigRSmdD1qU3VXh7wAXv7i4TSlhJNNY5O+a3Qa4QGe40vI0aFjKniNkk/l9SKhWS
         ueN1eidLwVgvH7hACfjLrDX4KACNNRRkugARKekxZaAvCnvAnHBJd01QrR+ROYuxPTOz
         laJTdJwST8GO1dKGuwJqag6OV+yz+WDfslGUDp3LC6R839WpnQN8MrffUWB+1WQFXZOt
         SPnQ==
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
Subject: [PATCH 4.15 006/202] dmaengine: dmatest: fix container_of member in dmatest_callback
Date: Thu, 15 Feb 2018 16:15:06 +0100
Message-Id: <20180215151713.117545617@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480912266361041?=
X-GMAIL-MSGID: =?utf-8?q?1592481963994668426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
