Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsVJNSiZkMmHilkyO5/0VW+xLe0QXeXEl5um20aSyH70rgVXNqqf5ywJQVX8gu2Wzu4zqQS
ARC-Seal: i=1; a=rsa-sha256; t=1521483925; cv=none;
        d=google.com; s=arc-20160816;
        b=C9TD+c4gLd8nnN4FTcAnLiYlOnisYtKr8elkHWKbgZS0XUVpfxceNQGroZ7xsCDF+y
         lK0qQTSlq8QoJ/zLyZRBj7sJco+v0eJgFzgol+2ZbN1be2ySqB6eNZyAscwuqir+tQhQ
         bdGZnwfwndap2GagDRmJZQz9Ow/DU8X8I2VQlIp+nSY5Olp0Y/0Uyp43RYuucLgGIdXr
         QDcfAj+THgNFtow3QBExhra2XzaXsJhfN5ZH8aRHH8+rD5jqatB7XhaVqgpJgCWfRyND
         /JyzhdMoCDnJSmY6+VlI7VhJqpsvKiCu6+NYu1fyatr0QVkqnTrZhqT8q5wCJ0g94Aq4
         Ox1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pu3ODLePSwaIs2rLOgWxPuGgYa6eTEmRZTSqmfNih14=;
        b=k7FLuhBVGc/2Cvx814fEtqs0lMMB9bH6aqZjMzEVtSRCYP+wtpm/SVEFNZ2+F3MlY4
         aVbwp/64hizGd6sVR1FMofPvC510MTxagkhTi26Noz9wvwWVVrDTAwVeQ2UpnwXKKKzL
         rdjn7UZyIfkjypzKHcdtxjX5/bfSPXa10tpHLk25qEJGUuFsrOrwnpZg0/VuSV6pxCIY
         ZyZ8q2ytUy4REER4cM/SHXvJHLcUj/4XxWUKddiFd9HHqANhYuc+anRJO8bCt16yrVry
         eyaxCTG/GasWfYkT8uPVZMq3ynbHamfGXAEgy8ttKi1/xV+pxuS3ZB7pqEtN5H6x4aJx
         zm8g==
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
Subject: [PATCH 4.9 167/241] iwlwifi: mvm: rs: dont override the rate history in the search cycle
Date: Mon, 19 Mar 2018 19:07:12 +0100
Message-Id: <20180319180758.076792547@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391528275022624?=
X-GMAIL-MSGID: =?utf-8?q?1595391528275022624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1867,12 +1867,10 @@ static int rs_switch_to_column(struct iw
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
