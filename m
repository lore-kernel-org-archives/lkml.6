Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6309C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBD120835
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hriTxt2h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fmcvxu4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBD120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeHJOdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:33:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeHJOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:33:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B3DD60B84; Fri, 10 Aug 2018 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533902613;
        bh=7L2/TuF8xaAFoYbw/Fl4vWmkX5PzO/Y/xK5+i9OpZ+A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hriTxt2hevzoHPSJYg0Q3zAKtOrw4hJvQztqDHgoLOWcGKEU3WrXhV/Wjn8oM5O2Q
         aaOqHsB/pfrlvytwTtiH6gEbiq7oyRnb1Nwja14w97DI264OZRVz1nYNT7FVw2fYiU
         IBX4AL+BhFbInQAhUoD4SvY6DTBrm4YAnnrdlFSQ=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2283960B19;
        Fri, 10 Aug 2018 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533902612;
        bh=7L2/TuF8xaAFoYbw/Fl4vWmkX5PzO/Y/xK5+i9OpZ+A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fmcvxu4p32g4YTeNV8O8DQefaUSfIYLJLTpJNoxU6bq/oBiJsRevJi+wAADnBZ67Q
         90jj1AUHq+jl0QbqMRLOkzFXTTCxg7YDJ4mtLFD7Kzfn4yhBPBSfeSkqPnJ60IpT35
         OWiP2r+WBAXUlRB/M4aaWrc3cnlGPC16EndAHaSo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2283960B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     VIJAYAKUMAAR K T <vijay.bvb@samsung.com>
Cc:     "davem\@davemloft.net" <davem@davemloft.net>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        CPGS <cpgs@samsung.com>
Subject: Re: [PATCH 1/1] ath10k: avoid possible memory access violation
References: <1533292805-9709-1-git-send-email-vijay.bvb@samsung.com>
        <CGME20180803104058epcas1p1d5cdd51e2774d72679aaf15358cb3d00@epcms5p1>
        <20180810101916epcms5p1e3d60d9cbc49f9a7c9529d87d691f359@epcms5p1>
Date:   Fri, 10 Aug 2018 15:03:28 +0300
In-Reply-To: <20180810101916epcms5p1e3d60d9cbc49f9a7c9529d87d691f359@epcms5p1>
        (VIJAYAKUMAAR K. T.'s message of "Fri, 10 Aug 2018 15:49:16 +0530")
Message-ID: <87eff6zawf.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIJAYAKUMAAR K T <vijay.bvb@samsung.com> writes:

> It would be great, if this patch could be reviewed.

It's in the queue and you can check the state from patchwork:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork

-- 
Kalle Valo
