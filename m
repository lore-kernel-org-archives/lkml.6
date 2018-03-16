Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt6oUUAKVhXXGTZct9cZyvgxBWuyRzV1hP+bRqdlYx1hnsIo7GH0anSURuXIc6Kp87Rxab2
ARC-Seal: i=1; a=rsa-sha256; t=1521214988; cv=none;
        d=google.com; s=arc-20160816;
        b=uDV0Rbuj8Y65Yg69VAG63rJthNwzskWVUS98+zxnu8E2CCel7Jzsbpu2kzx+YKAr7+
         WNrcGsPlt83ZNjONe13NH3IswjSulpxcConwv1VBtdg+ki7caBe5IhXyofEUdRB4dpfw
         sPtb3n5bWQaSl6rzdtIbZ6xyLcMxRPbAevHCt4qKJ7jlQzvpujYzv3acuzNGWUSvgnmk
         6M6goG2whmPnXFx2vtMSt4ozfWzG9eidxAQucwwoPaBdnE4mk9Js4JYcKXlm0mKHdg9k
         WvEPvNae7b5HEPQwhtUt9ahDD5f9WxznZeAhHq89/SEC+ngB/azXESD4Jjj8kLLmxpv8
         +BCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iD+CtoaoxW6HGcJ6YSL/dmqp6jDKjiiggSm0mjNVzYk=;
        b=0CaHXf19Oi32eZ0E9Go48b/SqIDUwxKa0Du+nHy9dqVJlzg+3LcU7KJ1uS0my3MNYB
         Zx2jpd02HP16k0O4U2PNgyYH7WSD8TSfuVoBM9Ygk1Eob6jcTAF0R0GeAjyiw+WVzgZ9
         b/NaPZE+d7pF1gsM+zKXPucrnMrcoeiBspIvtwgH/X+FHoUhNNQ1lW1eQNiuEMa+qt3I
         XIJkF1z1oBRAGveGgSy2XGMlfNmBgUfsjTnGPTd/x2CdFEWL6idwhNnXxwlvpXI5xcNL
         +vblsindy3YupTQtlo7fxvADGr8hGB4YNaGsphRld2HBuM74U08gn4xBomD1XVd/TRPu
         Bmwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sara Sharon <sara.sharon@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 089/128] iwlwifi: mvm: avoid dumping assert log when device is stopped
Date: Fri, 16 Mar 2018 16:23:50 +0100
Message-Id: <20180316152341.004217290@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109150650656229?=
X-GMAIL-MSGID: =?utf-8?q?1595109527269410440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sara Sharon <sara.sharon@intel.com>


[ Upstream commit 6362ab721ef5c4ecfa01f53ad4137d3d984f0c6c ]

We might erroneously get to error dumping code when the
device is already stopped.

In that case the driver will detect a defective value and will try to
reset the HW, assuming it is only a bus issue.  The driver than
proceeds with the dumping.

The result has two side effects:

1. The device won't be stopped again, since the transport status is
already stopped, so the device remains powered on while it actually
should be stopped.

2. The dump in that case is completely garbaged and useless.

Detect and avoid this.  It will also make debugging such issues
easier.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -595,6 +595,12 @@ static void iwl_mvm_dump_lmac_error_log(
 
 void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
 {
+	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
+		IWL_ERR(mvm,
+			"DEVICE_ENABLED bit is not set. Aborting dump.\n");
+		return;
+	}
+
 	iwl_mvm_dump_lmac_error_log(mvm, mvm->error_event_table[0]);
 
 	if (mvm->error_event_table[1])
