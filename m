Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C04C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EE120C01
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5yb+qDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfAZVdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:33:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfAZVdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xitWcqFSmQ6mUoCR+w/b99ILgvjXpkacgAEoLUUBg/Y=; b=P5yb+qDwxs5913ZMeq9O/3q0+
        NMfGeW0noFjBjOcATdjMbtMqdan/EQo35R8eMV8xw40HjpO5I1+92H8Xb/3fSf2bh5CSE+E38ltIq
        03WnhaZ5VTKnO0iN465A96fMYsrPQs4yC0ivbRdVO547bCLeJsT9cqlLR5hLvPa/gDZt8JV4lzDcY
        DwU/Aj/Qp51GcaWwpe+2ywVnajehX4LAMrAv+wSVrg8/ANnSXEU++8FkU7RaU3l27+ZmswQoitd81
        5paeZUg/5Q2Xbq2Mv3LtxzlojugcwpW/FgZDI+xalW6aXh2bRhMALAxQE/kIKaYOfcad8R2WSkS8k
        TmDJZeKAg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gnVaL-0000h6-IC; Sat, 26 Jan 2019 21:33:53 +0000
Date:   Sat, 26 Jan 2019 13:33:50 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Yang Fan <nullptr.cpp@gmail.com>
Cc:     ike.pan@canonical.com, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: ideapad-laptop: Fix no_hw_rfkill_list
 for Lenovo RESCUER R720-15IKBN
Message-ID: <20190126213350.GA41709@wrath>
References: <d4974133-580d-9166-f554-7e03bb1948b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4974133-580d-9166-f554-7e03bb1948b9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 07:16:33PM +0800, Yang Fan wrote:
> Commit ae7c8cba3221 ("platform/x86: ideapad-laptop: add lenovo RESCUER 
> R720-15IKBN to no_hw_rfkill_list") added
>     DMI_MATCH(DMI_BOARD_NAME, "80WW")
> for Lenovo RESCUER R720-15IKBN.
> 
> But DMI_BOARD_NAME does not match 80WW on Lenovo RESCUER R720-15IKBN, 
> thus cause Wireless LAN still be hard blocked.
> 
> On Lenovo RESCUER R720-15IKBN:
>     ~$ cat /sys/class/dmi/id/sys_vendor 
>     LENOVO
>     ~$ cat /sys/class/dmi/id/board_name 
>     Provence-5R3
>     ~$ cat /sys/class/dmi/id/product_name 
>     80WW
>     ~$ cat /sys/class/dmi/id/product_version 
>     Lenovo R720-15IKBN
> 
> So on Lenovo RESCUER R720-15IKBN:
>     DMI_SYS_VENDOR should match "LENOVO",
>     DMI_BOARD_NAME should match "Provence-5R3",
>     DMI_PRODUCT_NAME should match "80WW",
>     DMI_PRODUCT_VERSION should match "Lenovo R720-15IKBN".
> 
> Fix it, and in according with other entries in no_hw_rfkill_list, 
> use DMI_PRODUCT_VERSION instead of DMI_BOARD_NAME.
> 
> Fixes: ae7c8cba3221 ("platform/x86: ideapad-laptop: add lenovo 
> RESCUER R720-15IKBN to no_hw_rfkill_list")
> Signed-off-by: Yang Fan <nullptr.cpp@gmail.com>

Thanks for the patch, queued for testing.

-- 
Darren Hart
VMware Open Source Technology Center
