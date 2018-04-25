Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+T1ldnUkeApAr+CS9ndC8oPG8P56aUNF12oNVpanW9c+AKYC5J6CA24Sjpj7jeegtBORei
ARC-Seal: i=1; a=rsa-sha256; t=1524653028; cv=none;
        d=google.com; s=arc-20160816;
        b=rqoCQkjIv1XDziccyfGTOVxeel3M501TpiRR4pBUjrw7CzRp+bfxCbZbzbRz96d83o
         Pbt/xbm8LusmxsvRJIuO5iA/X2sZtdQRxgWx24qNlIqRSMJLT5kZsvaGLDiv2w7wjr5o
         lnh0SW4IkJBDQWEbR2b/OGuVm0g+enOQWaQM7QjM07xxfaM6wYZjTJgyZ27OLg0HK7md
         YSFd379qe/76qRU7ZoZfvlNzDJ3aOFnmNCYnV3iTwERi8+WowGTx9v7yJXIkjYTLnXfy
         gfo0hXDgRpRX0J/5BTG/0CSR74XPChwN8oPSOuheP7z3TldK3ye+2dMUiPmcYnQKRn3x
         eRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LgbuWPxBLDn5273THEJ25SVXJyBU/lCOLgoxelGPK7E=;
        b=u750+tD0580vj9UxdAl9XyCMINc1plAv5EY2+pDG6Wx/MSG1Nn3/5n2pm89eh5aZTS
         RztjP/x3ZMheDJ4KIl2R7EDjRfnOf9VapXgvb4sOldB2xros3b/+afiirZxVwKlPdZSI
         DfbuVIgzunjYgcXQnhvr+JyKHAxtKyzsMHON/0SqoBw5OzX1xD2s01oHpXih7r8o6OZ8
         PFE5oaoFXH0LCm+I4C+GkvDhhpJKFibxx1Kzc7j0gyX+RRyBm2OiPQ1pqtsx4ZyIAZCv
         JvoBLZsZD5e7OsJYt7UlySZBHkp1adAgPNCkBBbZVurfi3BMsfOAGdMgAdbSqE237J+g
         fBTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kernel test robot <fengguang.wu@intel.com>,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 158/183] SUNRPC: Dont call __UDPX_INC_STATS() from a preemptible context
Date: Wed, 25 Apr 2018 12:36:18 +0200
Message-Id: <20180425103248.887978060@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714573477079972?=
X-GMAIL-MSGID: =?utf-8?q?1598714573477079972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 0afa6b4412988019db14c6bfb8c6cbdf120ca9ad ]

Calling __UDPX_INC_STATS() from a preemptible context leads to a
warning of the form:

 BUG: using __this_cpu_add() in preemptible [00000000] code: kworker/u5:0/31
 caller is xs_udp_data_receive_workfn+0x194/0x270
 CPU: 1 PID: 31 Comm: kworker/u5:0 Not tainted 4.15.0-rc8-00076-g90ea9f1 #2
 Workqueue: xprtiod xs_udp_data_receive_workfn
 Call Trace:
  dump_stack+0x85/0xc1
  check_preemption_disabled+0xce/0xe0
  xs_udp_data_receive_workfn+0x194/0x270
  process_one_work+0x318/0x620
  worker_thread+0x20a/0x390
  ? process_one_work+0x620/0x620
  kthread+0x120/0x130
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x24/0x30

Since we're taking a spinlock in those functions anyway, let's fix the
issue by moving the call so that it occurs under the spinlock.

Reported-by: kernel test robot <fengguang.wu@intel.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtsock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1069,18 +1069,18 @@ static void xs_udp_data_read_skb(struct
 
 	/* Suck it into the iovec, verify checksum if not done by hw. */
 	if (csum_partial_copy_to_xdr(&rovr->rq_private_buf, skb)) {
-		__UDPX_INC_STATS(sk, UDP_MIB_INERRORS);
 		spin_lock(&xprt->recv_lock);
+		__UDPX_INC_STATS(sk, UDP_MIB_INERRORS);
 		goto out_unpin;
 	}
 
-	__UDPX_INC_STATS(sk, UDP_MIB_INDATAGRAMS);
 
 	spin_lock_bh(&xprt->transport_lock);
 	xprt_adjust_cwnd(xprt, task, copied);
 	spin_unlock_bh(&xprt->transport_lock);
 	spin_lock(&xprt->recv_lock);
 	xprt_complete_rqst(task, copied);
+	__UDPX_INC_STATS(sk, UDP_MIB_INDATAGRAMS);
 out_unpin:
 	xprt_unpin_rqst(rovr);
  out_unlock:
