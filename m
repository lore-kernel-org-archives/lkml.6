Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49b7Qy+P7x475gXO98SSoZWAawFR/HL48DLjQkvnj0FQKO44P39MxCnp1brxy61CR0BXw5W
ARC-Seal: i=1; a=rsa-sha256; t=1523022177; cv=none;
        d=google.com; s=arc-20160816;
        b=F6ZTRIyGS1rj+h45KurnBI17FpFvmJvLdM/xnGhtZEiE6OzWboUl5yo+Ec+H71RiKK
         rjvk8k7y8fQPLTGrHSAIp6lN0dD8ZOFC02TXRTVBZUpVZpcCNZgH5YGaFmhdyqCm07An
         hZgIB/nJEaTWpWEl9LbRPMAtq6qUwBVD/BKurp9+2vOcZedZ/Avs9z2u7rNiJ9Lcr974
         JlBCHioelOCc5RP5u3KnfQMUKZI5uB2QEPYknGjyBz7W7RCwMjXUOdi2KRWQY0oBQQC2
         sx9pOTMMpcimOjVXJbvM8eEKi9gceeV1yUJv/doKUxwbtso1g0j1egkGx3R/PJ6mUd7C
         yNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A7Za5o36EPILp1TBw6DNj+8lXz5oexTE4dV07vMncSs=;
        b=FY7bGhsEQGgK7uMi9Q2kFIcNbQlojYaNgBIQjhB949AYIjzkwX9jPkLliFvSyCQqRI
         ZGhO0Rw8JExEkDGY61CDe2M7L58zGwiGqs8XQMfpSGRddj056ilYKnnNuyaxGOzGdVq5
         +QABrLMreF8kXLs6sb8FwhhqG15AL2vT8aBDB5Pz9wTTx1QRHUEppiJQSCQbx9zPzGzK
         5XHq8v3YtKp+C/jzscxkL+ZMykCHM/uxuxEjzRGKr9RFRxeIcFNloKsJs+lgcfyuihHx
         KEyomWTEXdr2gtOnH5r1UjcVvtCG+G0zvrl9kRNL40qLgfxzgwenLdqEUCCSgYk/Qsoj
         As+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+dcfd344365a56fbebd0f@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@mellanox.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 22/72] RDMA/ucma: Fix use-after-free access in ucma_close
Date: Fri,  6 Apr 2018 15:23:57 +0200
Message-Id: <20180406084351.232272204@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003714922293729?=
X-GMAIL-MSGID: =?utf-8?q?1597004502495814089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit ed65a4dc22083e73bac599ded6a262318cad7baf upstream.

The error in ucma_create_id() left ctx in the list of contexts belong
to ucma file descriptor. The attempt to close this file descriptor causes
to use-after-free accesses while iterating over such list.

Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Reported-by: <syzbot+dcfd344365a56fbebd0f@syzkaller.appspotmail.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -497,6 +497,9 @@ err1:
 	mutex_lock(&mut);
 	idr_remove(&ctx_idr, ctx->id);
 	mutex_unlock(&mut);
+	mutex_lock(&file->mut);
+	list_del(&ctx->list);
+	mutex_unlock(&file->mut);
 	kfree(ctx);
 	return ret;
 }
