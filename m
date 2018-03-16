Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv8waSokUCHcPYc4wQWYltCt5OwW9C3n8DWs1jg2mnd13LTxdonHPzqUSVm7Ud0OD346HJe
ARC-Seal: i=1; a=rsa-sha256; t=1521214628; cv=none;
        d=google.com; s=arc-20160816;
        b=d+/+/9AqZD21l5eo8XTekNnM8u0xTP9eWwZ0TGHC2dprU+P9xvJzazQqE+gfwlWzBc
         UuOZJEQsvNOFmicoJULVOzLJUSF6GpyNWVLmTK7QCG5ITJ2HD7C8XvTN48jQiHv64GKF
         XFc2PPXrup2o05JBrQD4AkukUH2CeFcET7ykHI9mOfkUf6Qyw1XXX8RVgux9EuW1QSfP
         DEM1R9jMqUI31pK2mal3bWNSSp9oSg+gpKLoXWvp2gHbkfbavqrHgwDMFn0ovx2KwCc1
         bm2VS1wR9rop3XO6e9BguT+58nGrk04CVVV4/ysnLP2HaVeu8cAsrQoe11jclHyaBj3r
         TSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YyDe9nuFG9RaNEebmWhqes86o5U3yyqcDTMoA9Q2KME=;
        b=XgceZbOl5hvrtWqAX6S9xs0IJUMBFQXc3c7rpxon1POZfvtqZ0bxar6+smWkHZJ8Gv
         cw8ErvoAXY5T6gQm34htXEHXXDxun1Vhf+ZGAzMWtAFQIrJ4GZqLsAb+O6JbfbefehL0
         OJZZOniV20usykPNJeMDSahLKkP2sTuOixsi+tMoe8j93CEcvKtPirQ8rUHoiV3eD24B
         PEZTKHgTDtMjKlZzKJhOMy4NPW0VAA2hYWNkNrycJ6OT7CwlGSXK62z9ud+0cEy6QbJM
         8ixM2W0P3qesuwOJ2qPheb7UzNVL3qjY7B7fB+fyHOu0ATEdEwlvikyvEjmUY9YyPL0c
         FNbg==
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
Subject: [PATCH 4.14 074/109] iwlwifi: mvm: avoid dumping assert log when device is stopped
Date: Fri, 16 Mar 2018 16:23:43 +0100
Message-Id: <20180316152334.002036821@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109150650656229?=
X-GMAIL-MSGID: =?utf-8?q?1595109150650656229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -603,6 +603,12 @@ static void iwl_mvm_dump_lmac_error_log(
 
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
