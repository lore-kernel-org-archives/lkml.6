Return-Path: <gkohli@qualcomm.com>
X-Google-Smtp-Source: AIpwx4/YfVMQDZWK8yVhag9nN2amZF4e3KGdo9ZSP2YWSquKymgtJSm+F/16iN9Uls9DkNEMiVGf
ARC-Seal: i=1; a=rsa-sha256; t=1523612119; cv=none;
        d=google.com; s=arc-20160816;
        b=hu8oP5bOcVHupOpUO5Y78bdYPvTUU5Lb15BtO9txMKTYoPYm+b3EqW7kBM7LqubEin
         Vao/jioN0AUNnFyveZ6wzmdDn5UqGPgshOQB3BpBaxk0f2S+k2KPC7HCe4vDPNG4a8XX
         1CEp6+hDB2+0FfmEHAf1ZW7WPckbRsz/AHM4uvg/vzsuXbCYhMM8To67gU2ZtPhgeasU
         THeiHqpDHY9ojRABJtu+M5k0MjC+0L7jliKefWV8LoOCInrC+b+HZ249cLBXGejR+vja
         cRuMhqF96joMPairNQrKL31wHHHJpl8pmurTmp16NThNEsKtDNL4Qlgo4LhDIP4HkAn/
         5Kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=n3ou4IzEqDGq8VPYt93i2W4tn/8iCgdmQmJlsO+6O74=;
        b=Vy6ox3BNNDkLJM527F435ROTUCqeH4DE0VTS9LkushoCp6Ji1hWxmgAfvwEik9DIDM
         cTBVMfandzGF8fOfIZTArM2CS6YtYoNHrgRgppV+l1MpTbhGuDToJxaEFaL7fEEd+M8c
         umLLEDcUdtj2bLzaTihuudaRL5C3DvV9kswQUmPfq3uzDiDJnpWSDyg+kvBGK/F4divu
         rqFa6bpIselxjIO9QvrGnh+fqlUfUoSFcH3gGWOLd1tvvPapBuQWSmdowpHkJTRynOOo
         9ugWJ4JJU062ad+O75HePa3I4A5CB7UcM9zkM/ipcSZ0W+IB/lzVh1+RgIHCteXWTYfw
         8IJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gkohli@qualcomm.com designates 103.229.16.226 as permitted sender) smtp.mailfrom=gkohli@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gkohli@qualcomm.com designates 103.229.16.226 as permitted sender) smtp.mailfrom=gkohli@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.48,444,1517846400";
   d="scan'208";a="299607"
X-IronPort-AV: E=McAfee;i="5900,7806,8861"; a="5789357"
From: Gaurav Kohli <gkohli@codeaurora.org>
To: tj@kernel.org,
	gregkh@linuxfoundation.org,
	nborisov@suse.com,
	akpm@linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH] percpu_counter: Remove debug_object_free call twice
Date: Fri, 13 Apr 2018 15:05:03 +0530
Message-Id: <1523612103-15071-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597623102391720322?=
X-GMAIL-MSGID: =?utf-8?q?1597623102391720322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

During percpu_counter destroy, debug_object_free is calling
twice which may create race. So removing once instance of call
from debug_percpu_counter_deactivate.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index c72577e..68ad030 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -48,7 +48,6 @@ static inline void debug_percpu_counter_activate(struct percpu_counter *fbc)
 static inline void debug_percpu_counter_deactivate(struct percpu_counter *fbc)
 {
 	debug_object_deactivate(fbc, &percpu_counter_debug_descr);
-	debug_object_free(fbc, &percpu_counter_debug_descr);
 }
 
 #else	/* CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
