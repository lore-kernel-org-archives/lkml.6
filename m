Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D824C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E960520684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="A4QH6hMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E960520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeJCTCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:02:10 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:58656 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:02:09 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id D4911B00A75
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 14:13:59 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1538568839; x=1539432840; bh=c2HRf60Ewcj7zRu4Bhmq+ouHmj2YqpXj/RA
        m+PWbIOE=; b=A4QH6hMGjxO/fc0T37QJDPpl9qMHQxnZA2sIrkUVuDIgROGSUU9
        8O+xUJCvjSDJR9FXjemLWpsnihS+Ay/9NcfZfy1qcIk9bNfOTWkiR/v5jfujWszz
        xeFNgZCiWcJB5Q8mfe/HwkeF+PZxLTj0wCoKt+zfscFHZ71lkNDpSVRU=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NWTl1fVZdI1u for <linux-kernel@vger.kernel.org>;
        Wed,  3 Oct 2018 14:13:59 +0200 (CEST)
Received: from [192.168.0.105] (146-241-101-147.dyn.eolo.it [146.241.101.147])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id DD917B00568;
        Wed,  3 Oct 2018 14:13:54 +0200 (CEST)
Subject: Re: [PATCH 1/2] drm/sun4i: tcon: fix check of tcon->panel null
 pointer
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20181001093612.GA13672@mwanda>
 <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
 <CAGb2v64z+j=ywU8n210Zw+97n=Ff4rVdUwNR9nbKO-hMD3nJcQ@mail.gmail.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
Date:   Wed, 3 Oct 2018 14:13:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v64z+j=ywU8n210Zw+97n=Ff4rVdUwNR9nbKO-hMD3nJcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/10/2018 11:43, Chen-Yu Tsai ha scritto:
> On Wed, Oct 3, 2018 at 5:59 AM Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>>
>> At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
>> has been used, but that macro doesn't check if tcon->panel pointer is
>> null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).
>>
>> Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
>> condition to check if it's a pointer not null.
> 
> There's actually more than one occurance of this error:
> 
> drivers/gpu/drm/sun4i/sun4i_lvds.c:     if (!IS_ERR(tcon->panel)) {
> drivers/gpu/drm/sun4i/sun4i_lvds.c:     if (!IS_ERR(tcon->panel)) {
> drivers/gpu/drm/sun4i/sun4i_rgb.c:      if (!IS_ERR(tcon->panel)) {
> drivers/gpu/drm/sun4i/sun4i_rgb.c:      if (!IS_ERR(tcon->panel)) {
> 
> These four are responsible for enabling and disabling the panel.
> 
> drivers/gpu/drm/sun4i/sun4i_tcon.c:     if (!IS_ERR(tcon->panel)) {
> 
> All this looks like it was left over from commit ebc9446135671 ("drm: convert
> drivers to use drm_of_find_panel_or_bridge"). We have checks against tcon->panel
> in several places and not all of them were converted.
> 

Then, I'm going to send a patchset to correct them.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
