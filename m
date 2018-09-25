Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10243C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C584720867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C584720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIZBQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:16:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIZBQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:16:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FEEF8EE;
        Tue, 25 Sep 2018 19:07:16 +0000 (UTC)
Date:   Tue, 25 Sep 2018 21:07:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Simplify memcmp logical checks
Message-ID: <20180925190711.GA31631@kroah.com>
References: <20180921002221.14424-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921002221.14424-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 05:22:21PM -0700, Nathan Chancellor wrote:
> Clang generates a warning when it sees a logical not followed by a
> conditional operator like ==, >, or < because it thinks that the logical
> not should be applied to the whole statement:
> 
> drivers/staging/rtl8188eu/core/rtw_ieee80211.c:293:8: warning: logical
> not is only applied to the left hand side of this comparison
> [-Wlogical-not-parentheses]
> 
> It assumes the author might have made a mistake in their logic:
> 
> if (!a == b) -> if (!(a == b))
> 
> Sometimes that is the case; other times, it's just a super convoluted
> way of saying 'if (a)' when b = 0:
> 
> if (!1 == 0) -> if (0 == 0) -> if (true)
> 
> Alternatively:
> 
> if (!1 == 0) -> if (!!1) -> if (1)
> 
> Simplify these comparisons so that Clang doesn't complain.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/161
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 2 +-
>  drivers/staging/rtl8188eu/core/rtw_mlme.c      | 2 +-
>  drivers/staging/rtl8188eu/core/rtw_recv.c      | 4 ++--
>  drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> index 9e5c7e62d26f..20f34d25c369 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> @@ -284,7 +284,7 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, uint *wpa_ie_len, int limit)
>  
>  		if (pbuf) {
>  			/* check if oui matches... */
> -			if (!memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)) == false)
> +			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)))
>  				goto check_next_ie;
>  
>  			/* check version... */
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index ef8a7dc4bd34..43d6513484c5 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -1437,7 +1437,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
>  	/* check ssid, if needed */
>  	if (pmlmepriv->assoc_ssid.SsidLength) {
>  		if (competitor->network.Ssid.SsidLength != pmlmepriv->assoc_ssid.SsidLength ||
> -		    !memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength) == false)
> +		    memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength))
>  			goto exit;
>  	}
>  
> diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
> index ab9638d618a9..f3eb63f8cf0b 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
> @@ -1283,8 +1283,8 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
>  	psnap_type = ptr+pattrib->hdrlen + pattrib->iv_len+SNAP_SIZE;
>  	/* convert hdr + possible LLC headers into Ethernet header */
>  	if ((!memcmp(psnap, rtw_rfc1042_header, SNAP_SIZE) &&
> -	     (!memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) == false) &&
> -	     (!memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2) == false)) ||
> +	     memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) &&
> +	     memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2)) ||
>  	     !memcmp(psnap, rtw_bridge_tunnel_header, SNAP_SIZE)) {
>  		/* remove RFC1042 or Bridge-Tunnel encapsulation and replace EtherType */
>  		bsnaphdr = true;
> diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> index fb496ab5a862..51cf78150168 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> @@ -856,7 +856,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
>  		return _FAIL;
>  	}
>  
> -	if (!memcmp(cur_network->network.MacAddress, pbssid, 6) == false) {
> +	if (memcmp(cur_network->network.MacAddress, pbssid, 6) {
>  		DBG_88E("Oops: rtw_check_network_encrypt linked but recv other bssid bcn\n%pM %pM\n",
>  			(pbssid), (cur_network->network.MacAddress));
>  		return true;

Always test-build your patches before sending them off so you do not get
a grumpy maintainer upset at you for breaking their build system...

Hint, it's the last chunk here...

greg k-h
