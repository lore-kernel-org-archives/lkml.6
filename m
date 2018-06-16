Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1755EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 23:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E1A2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 23:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E1A2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFPXA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 19:00:58 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:33895 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754016AbeFPXA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 19:00:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1477F181D340F;
        Sat, 16 Jun 2018 23:00:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: force98_7ec01f5aff43
X-Filterd-Recvd-Size: 4454
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Jun 2018 23:00:54 +0000 (UTC)
Message-ID: <aa97094ecc116745d817acb762486c00b6c17507.camel@perches.com>
Subject: Re: [PATCH v2] staging: rtl8712: Adjust if statements to reduce
 indentation level
From:   Joe Perches <joe@perches.com>
To:     Joonhwan Kim <spilit464@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        liamryandev@gmail.com, martin@martinhomuth.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        stefano.manni@gmail.com, kernel-janitors@vger.kernel.org
Date:   Sat, 16 Jun 2018 16:00:53 -0700
In-Reply-To: <3225099.6uizQ2pf4A@joonhwan-virtualbox>
References: <3225099.6uizQ2pf4A@joonhwan-virtualbox>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-16 at 15:03 +0900, Joonhwan Kim wrote:
> Merge two condition of if statements in
> r8712_surveydone_event_callback()

Are you sure you are not changing the logic here?

I think it'd be nicer to refactor the code instead.

Something like:
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 73 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index ac547ddd72d1..d711305b33e1 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -552,6 +552,19 @@ void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
 	spin_unlock_irqrestore(&pmlmepriv->lock2, flags);
 }
 
+static bool r8712_under_linking_then_join(struct mlme_priv *pmlmepriv)
+{
+	set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
+
+	if (r8712_select_and_join_from_scan(pmlmepriv) != _SUCCESS)
+		return false;
+
+	mod_timer(&pmlmepriv->assoc_timer,
+		  jiffies + msecs_to_jiffies(MAX_JOIN_TIMEOUT));
+
+	return true;
+}
+
 void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
 	unsigned long irqL;
@@ -565,45 +578,31 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	}
 
-	if (pmlmepriv->to_join) {
-		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-			if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
-				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
+	if (!pmlmepriv->to_join)
+		goto exit;
+
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
+		if (check_fwstate(pmlmepriv, _FW_LINKED) ||
+		    r8712_under_linking_then_join(pmlmepriv))
+			goto exit;
+
+		pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
+		memcpy(&adapter->registrypriv.dev_network.Ssid,
+		       &pmlmepriv->assoc_ssid,
+		       sizeof(struct ndis_802_11_ssid));
+		r8712_update_registrypriv_dev_network(adapter);
+		r8712_generate_random_ibss(adapter->registrypriv.dev_network.MacAddress);
+		pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
+		pmlmepriv->to_join = false;
+	} else {
+		pmlmepriv->to_join = false;
+		if (r8712_under_linking_then_join(pmlmepriv))
+			goto exit;
 
-				if (r8712_select_and_join_from_scan(pmlmepriv)
-				    == _SUCCESS) {
-					mod_timer(&pmlmepriv->assoc_timer, jiffies +
-						  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
-				} else {
-					struct wlan_bssid_ex *pdev_network =
-					  &(adapter->registrypriv.dev_network);
-					u8 *pibss =
-						 adapter->registrypriv.
-							dev_network.MacAddress;
-					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
-					memcpy(&pdev_network->Ssid,
-						&pmlmepriv->assoc_ssid,
-						sizeof(struct
-							 ndis_802_11_ssid));
-					r8712_update_registrypriv_dev_network
-						(adapter);
-					r8712_generate_random_ibss(pibss);
-					pmlmepriv->fw_state =
-						 WIFI_ADHOC_MASTER_STATE;
-					pmlmepriv->to_join = false;
-				}
-			}
-		} else {
-			pmlmepriv->to_join = false;
-			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
-			if (r8712_select_and_join_from_scan(pmlmepriv) ==
-			    _SUCCESS)
-				mod_timer(&pmlmepriv->assoc_timer, jiffies +
-					  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
-			else
-				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
-		}
+		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 	}
+
+exit:
 	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
 }
 
