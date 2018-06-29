Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A475CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E96D27EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B1FE2kRg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hpktfmWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E96D27EA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936259AbeF2LqM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:46:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935441AbeF2LqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:46:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3325F60B10; Fri, 29 Jun 2018 11:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530272766;
        bh=2XDQyd8QTJJltT7F60tlItGbvSzPOTE30mW0CagQgSE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B1FE2kRgGrJRhPvPWVlgL2ioYhCYkPVMaC0tbPgeXWPdRtgJ8vSjgikuRT1vdYeib
         ee/78IC/4MgUSgc58gW6SiUUqq8r9Bg7yBU+vsikXuWEUpnIb9Axrp9Y4LkdjkNnIN
         iMZua2SNL/wPObuesbzjXAUwPEET1c4L2Xh1Y/s8=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 972D460452;
        Fri, 29 Jun 2018 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530272765;
        bh=2XDQyd8QTJJltT7F60tlItGbvSzPOTE30mW0CagQgSE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=hpktfmWN8XL7MZ2DoqLRjyJc60NB4pHnhOXk3QYWKQdfas9ImtUDSsDBiv2oF1Fz7
         E92P8hdFlJccSV8ivLRo5M709zNf8uPFhx7yEuA0RdfXjcMQUKMfMS1pOAgXIhewF5
         ZnVLty8m+FsEeaJIR89OeXWK6vGsfei+BiwapDfU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 972D460452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [4/4] ath9k: use timespec64 for tsf_ts
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180618151142.1214422-4-arnd@arndb.de>
References: <20180618151142.1214422-4-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes.berg@intel.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Wojciech Dubowik <Wojciech.Dubowik@neratec.com>,
        Russell Hu <rhu@qti.qualcomm.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180629114606.3325F60B10@smtp.codeaurora.org>
Date:   Fri, 29 Jun 2018 11:46:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> ath9k is the last remaining user of the deprecated getrawmonotonic()
> interface. There is nothing wrong with this usage, but migrating
> to a timespec64 based interface lets us clean up the old API.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

fe041deba4f6 ath9k: use timespec64 for tsf_ts

-- 
https://patchwork.kernel.org/patch/10471987/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

