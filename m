Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvXSAEI2Ia6yrZ73N+m4n/XcZvR3w0NONZm8bHbD6a/8GK7UiAiMW6eh6NjJzIKx5saU8Ph
ARC-Seal: i=1; a=rsa-sha256; t=1521214608; cv=none;
        d=google.com; s=arc-20160816;
        b=HZMddqV28UQieiG00Vt/YqA6tjEjuSW27zavVexo733M+az63f/JPE+0UBWlLNizcw
         PSqhgm27Ca5ibJHU+vpZL3Wf1NeEYEuDu3qufkhEiqPW2wi8l2gywRmjbTct1+RCVoJS
         CwdIKU3NYtHz6f+2S60c+0Zzm/34iNChCAYCRv6om6FO3juB+7okyZqq+LecPduwzT2P
         tI3zg5vZgw0TFhdianokbUNYS/A6+DBKffId15hxQlaeVY6A1Y0AejUOkhLRACy4AVx0
         TayeguNuP4CQuZJjlfQwkQgM9FyoSCam2/+q9Kzhu7uVcVQDp59VrqpCcLVtSAJUiMM4
         X4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3Myu2gSD5cxX7eigYUm6cw8pEM7KAVLsGyseoAoj8VY=;
        b=XchUxjcegHBqa2O31cy6sTsXPusHuJvhicyDyWVQ/C3cDv0iyhFkmD1cjjXo5SGZhH
         7GfoC/WPx3T11I5AvlG2/dBokdnDGbtiNRJGxuwGLVB7Qr4OJWzJ/hM8EhLJkpBhp4q/
         +lnxyIhferpVnhtuz+v9d7gHR0poP3KzmT0zr2T2zO0w5/HMy0EUvpbZfbaDUCaIxW2i
         elCy7THh+bQjDrtYXUq1emd/F7vvBvgGsZ9JaxTl6k7yfaIR2KLFnlPt1LzIPIrXHuaE
         y/UJBG4K1qtMuQtJAXhvaaOxhOG/4GVNIAAIdBTuXJyP8fA98MAuzJIyYuO3zGEIvDqp
         aB0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 032/109] iwlwifi: mvm: rs: dont override the rate history in the search cycle
Date: Fri, 16 Mar 2018 16:23:01 +0100
Message-Id: <20180316152331.715396855@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109129726029447?=
X-GMAIL-MSGID: =?utf-8?q?1595109129726029447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>


[ Upstream commit 992172e3aec19e5b0ea5b757ba40a146b9282d1e ]

When we are in a search cycle, we try different combinations
of parameters. Those combinations are called 'columns'.
When we switch to a new column, we first need to check if
this column has a suitable rate, if not, we can't try it.
This means we must not erase the statistics we gathered
for the previous column until we are sure that we are
indeed switching column.

The code that tries to switch to a new column first sets
a whole bunch of things for the new column, and only then
checks that we can find suitable rates in that column.
While doing that, the code mistakenly erased the rate
statistics. This code was right until
struct iwl_scale_tbl_info grew up for TPC.

Fix this to make sure we don't erase the rate statistics
until we are sure that we can indeed switch to the new
column.

Note that this bug is really harmless since it causes a
change in the behavior only when we can't find any rate
in the new column which should really not happen. In the
case we do find a suitable we reset the rate statistics
a few lines later anyway.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1881,12 +1881,10 @@ static int rs_switch_to_column(struct iw
 	struct rs_rate *rate = &search_tbl->rate;
 	const struct rs_tx_column *column = &rs_tx_columns[col_id];
 	const struct rs_tx_column *curr_column = &rs_tx_columns[tbl->column];
-	u32 sz = (sizeof(struct iwl_scale_tbl_info) -
-		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_COUNT));
 	unsigned long rate_mask = 0;
 	u32 rate_idx = 0;
 
-	memcpy(search_tbl, tbl, sz);
+	memcpy(search_tbl, tbl, offsetof(struct iwl_scale_tbl_info, win));
 
 	rate->sgi = column->sgi;
 	rate->ant = column->ant;
