Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F2EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFB724F48
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFB724F48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeFXO0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 10:26:45 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:44778 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751915AbeFXO0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 10:26:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E04A7182CED28;
        Sun, 24 Jun 2018 14:26:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: door94_3aa55da67cf17
X-Filterd-Recvd-Size: 1839
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 Jun 2018 14:26:42 +0000 (UTC)
Message-ID: <1ca5d94c5ef94930773c9f3d239e12862a65922d.camel@perches.com>
Subject: Re: [PATCH v2 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
From:   Joe Perches <joe@perches.com>
To:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Date:   Sun, 24 Jun 2018 07:26:41 -0700
In-Reply-To: <20180624095732.12082-4-johnfwhitmore@gmail.com>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
         <20180624095732.12082-4-johnfwhitmore@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-24 at 10:57 +0100, John Whitmore wrote:
> Replaced memory initialising loop with memset, as suggested by Andy Shevchenko
[]
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
[]
> @@ -742,8 +742,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
>   */
>  static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
>  {
> -	u8					i;
> -
>  	if (!pOperateMCS) {
>  		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
>  		return false;
> @@ -756,8 +754,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
>  		//legacy rate routine handled at selectedrate
>  
>  		//no MCS rate
> -		for (i = 0; i <= 15; i++)
> -			pOperateMCS[i] = 0;
> +		memset(pOperateMCS, 0, 15);

Not the same code.

Loop is <= 15, so memset should use 16


