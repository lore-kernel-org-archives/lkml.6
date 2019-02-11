Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8388FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562252075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549904578;
	bh=TUhoqrv/yifi2ZPnN6hCWuPqVhYNjU8NVuKQJ0KTuOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hzo5TiElWjSd9oqQR2weaMuBSOBuXAPi9L3vvUcahlCD7MLkC1U5lTeT+Qkc9koUb
	 65vW65TZAjJR1h0LejMdqTkTl0H9MVNQdK0q1yvDpyqT4DjzAPfvyYfPXc6P53VAkD
	 8rM4tyeMCYndhqFCGOiLfj9nOr9hhqTN5VdVRLME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfBKRC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfBKRC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:02:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927CE2075C;
        Mon, 11 Feb 2019 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549904575;
        bh=TUhoqrv/yifi2ZPnN6hCWuPqVhYNjU8NVuKQJ0KTuOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZYnOFGzTHp+DKCw2Awg/JQML9dEXWvmWeAE5WeXcZxwNkHlfDog8j0pvu/8poFdg
         KJxyeTbx0lYeSmY8VPm0MndrBI33eKp63OJneDC8J91mhPLn2BLs1luJFnjakCR/Pn
         CHXaXnHsBI8gvUmlQG581nPTWoWv8yGi70+MbdBs=
Date:   Mon, 11 Feb 2019 18:02:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 018/352] ath9k: dynack: use authentication messages
 for late ack
Message-ID: <20190211170252.GE21634@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141847.541071852@linuxfoundation.org>
 <e3740a06-8735-eed3-b427-e924f3e185ae@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3740a06-8735-eed3-b427-e924f3e185ae@ncentric.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:48:30PM +0100, Koen Vandeputte wrote:
> 
> On 11.02.19 15:14, Greg Kroah-Hartman wrote:
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > [ Upstream commit 3831a2a0010c72e3956020cbf1057a1701a2e469 ]
> > 
> > In order to properly support dynack in ad-hoc mode running
> > wpa_supplicant, take into account authentication frames for
> > 'late ack' detection. This patch has been tested on devices
> > mounted on offshore high-voltage stations connected through
> > ~24Km link
> > 
> > Reported-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> > Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   drivers/net/wireless/ath/ath9k/dynack.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath9k/dynack.c b/drivers/net/wireless/ath/ath9k/dynack.c
> > index 7334c9b09e82..cc0dc966c512 100644
> > --- a/drivers/net/wireless/ath/ath9k/dynack.c
> > +++ b/drivers/net/wireless/ath/ath9k/dynack.c
> > @@ -187,7 +187,8 @@ void ath_dynack_sample_tx_ts(struct ath_hw *ah, struct sk_buff *skb,
> >   	/* late ACK */
> >   	if (ts->ts_status & ATH9K_TXERR_XRETRY) {
> >   		if (ieee80211_is_assoc_req(hdr->frame_control) ||
> > -		    ieee80211_is_assoc_resp(hdr->frame_control)) {
> > +		    ieee80211_is_assoc_resp(hdr->frame_control) ||
> > +		    ieee80211_is_auth(hdr->frame_control)) {
> >   			ath_dbg(common, DYNACK, "late ack\n");
> >   			ath9k_hw_setslottime(ah, (LATEACK_TO - 3) / 2);
> >   			ath9k_hw_set_ack_timeout(ah, LATEACK_TO);
> 
> Dear Greg,
> 
> No idea if this is the proper location to report this or if I should inform
> stable@vger.. , but:
> 
> This backport alone is useless without backporting following 2 commits below
> also, unless the 2 wifi devices using dynack start off at very close
> distance.
> 
> Their commits messages indicate them as improvements, but they should be
> considered as fixes.
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc6&id=0c60c490830a1a756c80f8de8d33d9c6359d4a36
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc6&id=9d3d65a91f027b8a9af5e63752d9b78cb10eb92d
> 
> 
> It's safe to add them to all stables involved (4.20, 4.19, 4.14, 4.9)

Thanks, that looks reasonable, now queued up.

greg k-h
