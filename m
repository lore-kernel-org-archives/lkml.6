Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224UJ6x1vteOkYTTfyGmt9S5jkvdlXZTe2h1hboNF8U8d0NZUmcklZ++Ai9AzN0LOVNENM6+
ARC-Seal: i=1; a=rsa-sha256; t=1519217953; cv=none;
        d=google.com; s=arc-20160816;
        b=lYtc/gVKw04TqafeAHriN7QTpsuuKzXG3ZoHpetgwAPJMFJ8vgybYiWpWkGT8Lywc3
         lhCFrPTm2YcCl8E61VcqAftSvXfkm/DqPwo3iifQMDgXAP7xzuXp0PZKiHYKD+0TVOLp
         9/TI4FBiDq1drT0lBpktfOv35/1662R7wFExV+6xHXUnAGdGaLFqPYqvtlTgZ7O32eFp
         MnQj5suoKvPK+xy5ski9LhqH2IfykoBS0/sE6f61Cdf5jHFbHhl2juFtsrE9tL6M6V2D
         nqFeCBFHoLb5qizUXletKLueXbWd6cb3lAyB3XT6YL6FtgQVhSqYt6JUByt7/UOn1Atm
         Q6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v4uubXf8qAj8fjqGCmEwUUWFbMKz9tiIb++HwH4jocg=;
        b=AaLigsA6BaHe4bNEyIqhCnZSRwT4Fd22alrm84fot0pgOnBAeSEAEW0klKzPUIG+tE
         +DXN9e6B+0MTlEtv3sCuglqzSwaSxW1oXgCJzXjNYC9chxBnqWEFonSjyavagKPI7AKV
         /ltm+UwoFZSH8wdkpK+wW+BFUWrHo0ZvkBrV2sKAiJ7qxoTAq32LHpLjQBGq1wjMpidl
         Os1ew1E4vwrAY0513mLY+tBTZIQwyMXkAFfL5DJ8vYW95KOBSY5hLEb8mddic0ov0QWZ
         7W5JVhY0YLKyZzKh9JtvuVhjbmLPaEmI5GcJk5h+wHlxiDJc3S8k6htXXqJWiQSUAotV
         k6Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 008/167] IB/core: Avoid a potential OOPs for an unused optional parameter
Date: Wed, 21 Feb 2018 13:46:59 +0100
Message-Id: <20180221124525.067909126@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015484554049351?=
X-GMAIL-MSGID: =?utf-8?q?1593015484554049351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit 2ff124d597c2df8696169ce0006fc974c49a4569 upstream.

The ev_file is an optional parameter for CQ creation. If the parameter
is not passed, the ev_file pointer will be NULL.  Using that pointer
to set the cq_context will result in an OOPs.

Verify that ev_file is not NULL before using.

Cc: <stable@vger.kernel.org> # 4.14.x
Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_std_types.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -315,7 +315,7 @@ static int uverbs_create_cq_handler(stru
 	cq->uobject       = &obj->uobject;
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
-	cq->cq_context    = &ev_file->ev_queue;
+	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
 	obj->uobject.object = cq;
 	obj->uobject.user_handle = user_handle;
 	atomic_set(&cq->usecnt, 0);
