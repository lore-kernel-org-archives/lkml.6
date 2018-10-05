Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E652C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008B1213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="cn1MkxsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008B1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJFEio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:38:44 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:44646 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeJFEio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:38:44 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id CEA9CB007A0
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 23:38:07 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1538775487; x=1539639488; bh=O7OP41IKVVl16KvfKVxbCQMXgQ1YNm+KcrC
        iK55JFH8=; b=cn1MkxsCywXDOSBAbgsR97Zrho1qc/Sorc3lCgTLmptVjvSiTZX
        hscTcIfwZnIS81WJuHCtCy/mvtat3JSE+oD2nVviUSYDIefamlbp1C+N2VSu/RiK
        Rl4yK3tQyBYhETu9tUM81Mr8GiA0ComAOGbgOnQ1DTambYdQRLoby1ik=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U_2P60P5aOxe for <linux-kernel@vger.kernel.org>;
        Fri,  5 Oct 2018 23:38:07 +0200 (CEST)
Received: from [192.168.123.60] (unknown [192.168.123.60])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id DEA9EB003B2;
        Fri,  5 Oct 2018 23:38:06 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if null
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
 <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
 <20181003142458.33120-2-giulio.benetti@micronovasrl.com>
 <20181004195605.txvbkshvxklyzxyb@flea>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <5c45b263-e310-82af-ffb3-85eac93622d5@micronovasrl.com>
Date:   Fri, 5 Oct 2018 23:38:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181004195605.txvbkshvxklyzxyb@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 04/10/2018 21:56, Maxime Ripard ha scritto:
> On Wed, Oct 03, 2018 at 04:24:58PM +0200, Giulio Benetti wrote:
>> If using tcon with VGA,
> 
> We don't have support for VGA at the moment. Or are you talking about
> using a VGA bridge?

You're right, in general VGA is not the point.
tcon->panel is retrieved by drm_of_find_panel_or_bridge() and panel can 
be present or not.

>> tcon->panel will be null(0), this will cause segmentation fault when
>> trying to dereference tcon->panel->connector.
> 
> It's not a segmentation fault, but a null pointer dereference. And
> that case will also happen with bridges.

Right.

Going to improve/rewrite commit logs and submit v2 patchset.

Thanks for reviewing.

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
