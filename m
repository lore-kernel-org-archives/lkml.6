Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/dXeBS9IL/ehvlQBEFq5A7yU9oItWRIvkn00Lu3njizI41NEnNhwB4aVLFa+C7z/CbnPJ2
ARC-Seal: i=1; a=rsa-sha256; t=1523473305; cv=none;
        d=google.com; s=arc-20160816;
        b=n4KXW3AQLrfTJ3itHdoD2BYZqmEkZf4o/kgAQlGWRyQBKxnu1v5u/k4vjdx8jLdesO
         cE9fgkvU4jMkWM0SoEFPo5R/yG7MhFCQRbJyBqwOdomQxYEYZNjXnC9tUThC88S7Ne/s
         yi4aXfO0+VWUAH5X6KvUl/E73Z3Do5NjA3eEH7LsHlaw4b/Fc1+QGygMEKHn4LuRh9XY
         0YvmbKr51aGUkDBj2ypN/jz4vR67ZAz/mOL6ME3lHBCfaBYo2jLWEqnePRhHECB0uZME
         ofm2jdV2ZIO/8/KNsuUi4DSRx5shV/an9APZN816rKsaVQsSEGZJm5bFSdCZHBbDoZsk
         y1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jEG23qcvPPgoiNKFrERcnHjUhuqot4s40UjOwtfh1eY=;
        b=cWRJ23FDJPkuyhTJFyYhJev15Rd/CYLtXjhIbmVrpB7zlCqU9tZ8Ci1Q7pncIvlNlT
         BuF5p2QE16KGgd5iF5q060AQSsLCgQTqUc/m7sQtk8xgZCOMl5kk8HR9l1y2tp4OHkT9
         2F2HKMJ5m6SYmGj0XnxHa5kUKaA118Dsj6Si2jegJanLXzi6MmFVvRcQI740gCsbhbPD
         LI+R9s72VbvjGqP8e+EhSjjL6PqYejqNHkffgnj3rLWx6dBISEB0SgPNS5yYu4UHM7/T
         Wjf6tsbpM0yH9Pbaz48My6HmkaQKuto5vEaMB9M6QsSdGjxnCIKcZqGY6w4ZwFF8ACeD
         R5bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Haim Dreyfuss <haim.dreyfuss@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 199/310] iwlwifi: mvm: Fix command queue number on d0i3 flow
Date: Wed, 11 Apr 2018 20:35:38 +0200
Message-Id: <20180411183631.150473043@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477544789219223?=
X-GMAIL-MSGID: =?utf-8?q?1597477544789219223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haim Dreyfuss <haim.dreyfuss@intel.com>


[ Upstream commit c72c37b7f392ad7edc10b6092fa48c632ba6f4ed ]

During d0i3 flow we flush all the queue except from the command queue.
Currently, in this flow the command queue is hard coded to 9.
In DQA the command queue number has changed from 9 to 0.
Fix that.

This fixes a problem in runtime PM resume flow.

Fixes: 097129c9e625 ("iwlwifi: mvm: move cmd queue to be #0 in dqa mode")
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1666,8 +1666,11 @@ int iwl_mvm_find_free_queue(struct iwl_m
  */
 static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 {
+	u32 cmd_queue = iwl_mvm_is_dqa_supported(mvm) ? IWL_MVM_DQA_CMD_QUEUE :
+		IWL_MVM_CMD_QUEUE;
+
 	return ((BIT(mvm->cfg->base_params->num_of_queues) - 1) &
-		~BIT(IWL_MVM_CMD_QUEUE));
+		~BIT(cmd_queue));
 }
 
 static inline
