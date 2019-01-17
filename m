Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE32C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107A420855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfAQToe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:44:34 -0500
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:34555 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728173AbfAQTod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:44:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C7457613E;
        Thu, 17 Jan 2019 19:44:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crook05_278f5d9c4ac38
X-Filterd-Recvd-Size: 4859
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Jan 2019 19:44:31 +0000 (UTC)
Message-ID: <174b4234659bfbb4f5a072f2928301da9cce67d8.camel@perches.com>
Subject: Re: [PATCH 2/2] staging: rtl8188eu: cleanup indenting issue in
 mlme_linux.c
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 11:44:30 -0800
In-Reply-To: <20190117192301.17579-2-straube.linux@gmail.com>
References: <20190117192301.17579-1-straube.linux@gmail.com>
         <20190117192301.17579-2-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 20:23 +0100, Michael Straube wrote:
> Cleanup indenting issue reported by checkpatch.
> CHECK: Alignment should match open parenthesis
[]
> diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
[]
> @@ -52,9 +52,8 @@ void rtw_reset_securitypriv(struct adapter *adapter)
>  		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
>  
>  		/*  Restore the PMK information to securitypriv structure for the following connection. */
> -		memcpy(&adapter->securitypriv.PMKIDList[0],
> -			    &backup_pmkid[0],
> -			    sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
> +		memcpy(&adapter->securitypriv.PMKIDList[0], &backup_pmkid[0],
> +		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);

Hi.

Please try not to blindly follow checkpatch messages but
please do try to make the code more readable.

Just below this block is another block with a temporary
that uses &adapter->securitypriv.

How about hoisting the temporary and using that?

Something like:
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index d5ceb3beabbc..320a0be2af3d 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -39,31 +39,31 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 	u8	backup_index = 0;
 	u8	backup_counter = 0x00;
 	u32	backup_time = 0;
+	struct security_priv *psec_priv = &adapter->securitypriv;
 
-	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
+	if (psec_priv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		/* 802.1x */
 		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
 		/*  Backup the btkip_countermeasure information. */
 		/*  When the countermeasure is trigger, the driver have to disconnect with AP for 60 seconds. */
-		memcpy(&backup_pmkid[0], &adapter->securitypriv.PMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-		backup_index = adapter->securitypriv.PMKIDIndex;
-		backup_counter = adapter->securitypriv.btkip_countermeasure;
-		backup_time = adapter->securitypriv.btkip_countermeasure_time;
-		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
+		memcpy(backup_pmkid, psec_priv->PMKIDList,
+		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
+		backup_index = psec_priv->PMKIDIndex;
+		backup_counter = psec_priv->btkip_countermeasure;
+		backup_time = psec_priv->btkip_countermeasure_time;
+
+		memset(psec_priv, 0, sizeof(*psec_priv));
 
 		/*  Restore the PMK information to securitypriv structure for the following connection. */
-		memcpy(&adapter->securitypriv.PMKIDList[0],
-			    &backup_pmkid[0],
-			    sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-		adapter->securitypriv.PMKIDIndex = backup_index;
-		adapter->securitypriv.btkip_countermeasure = backup_counter;
-		adapter->securitypriv.btkip_countermeasure_time = backup_time;
-		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
-		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
+		memcpy(psec_priv->PMKIDList, backup_pmkid,
+		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
+		psec_priv->PMKIDIndex = backup_index;
+		psec_priv->btkip_countermeasure = backup_counter;
+		psec_priv->btkip_countermeasure_time = backup_time;
+		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
+		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
 	} else {
 		/* reset values in securitypriv */
-		struct security_priv *psec_priv = &adapter->securitypriv;
-
 		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
 		psec_priv->dot11PrivacyKeyIndex = 0;


