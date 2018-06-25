Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6C8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511D526273
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CajoA9Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511D526273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934147AbeFYXAz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:00:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38747 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933263AbeFYXAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:00:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id a1-v6so3284332pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5A3F3hq6owsSI4xGbzzDfKQyGVBnoUpft5aysLRaXDY=;
        b=CajoA9VzpzfujHwk2oF4m7FFaWHYTsYXO4E0NPgLGHsL9nUqFMRICmGY95IwGNiu/m
         4dgxynbP7jICRYbLhGwuOpGieNtKabcNfjvYLzU77JH4pNRj3sStDFErkDth8JIoNZ1I
         gOSBNjSn9tBQ1z+lFOWgX95yB4IdVLjgpl/FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5A3F3hq6owsSI4xGbzzDfKQyGVBnoUpft5aysLRaXDY=;
        b=YuVttQRqtxflK8cADuFYGAZ5/F2myNljRdIaapRmsf7+7OXcRdIHUBl8luBJMZ4WZq
         U2cV4MYFcCTrbVad0RMtOyLcibHjLlLWktfRcVIQAMyC01w3JxlxE8Htv8BNc5vDqZ8X
         2oAamO65uyAHYH2UQCH8KRHD8b2MRZRJR4Ue2VaYZGb8PrNFKqWQwN8T3GSPUz02CU8F
         0+a5TNUUvScI7O+0KevFELaZmtOTcttQNmSZ9JjQuwSYh/4dqJnkIo1UaTpHlx3B9Rxl
         QkCW2qyz7jQb7qu3Q9eRjSTagBFYrbMgftcwsT6prVrfuUGdj2fJQCCbmazpvKkmm4w+
         +CNg==
X-Gm-Message-State: APt69E3Wv5ZMuqkqdtMbvwT4oU7Fx2FreGG01Y0YxCa8KFIlR8dHuSd1
        ihUZdLp8Z1mBP572V9JmD1L8Rg==
X-Google-Smtp-Source: ADUXVKLV8zTy7NxcaluWBR2iEdaFwgdPx/NaQO02djK7O7TgBP4XQXUW0nZcQz83hOV59MA7o4FEpg==
X-Received: by 2002:a62:a309:: with SMTP id s9-v6mr6386549pfe.80.1529967652177;
        Mon, 25 Jun 2018 16:00:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 4-v6sm154811pfi.78.2018.06.25.16.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 16:00:51 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:00:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 2/7] Bluetooth: btqca: Rename ROME specific functions
 to Generic functions
Message-ID: <20180625230050.GG129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-3-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625134013.19684-3-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems you have to respin anyway due to comments in other patches, so I
squeeze in some optional improvements of the commit message.

> Subject: Rename ROME specific functions to Generic functions

nit: s/Generic/generic/

On Mon, Jun 25, 2018 at 07:10:08PM +0530, Balakrishna Godavarthi wrote:
> Some of the QCA BTSoC ROME functions, are used for different versions
> or different make of BTSoC's. Instead of duplicating the same functions
> for new chip, updating names of the functions that are used for both

nit: s/updating/update/

> chip's to keep this generic and would help in future when we would have

nit: s/chip's/chips/

> new BT SoC

nit: you might want to start a new sentence here, it's a long churn to
read :) optionally you could just say 'logs' instead of 'bt_dev_info,
bt_dev_err and bt_dev_dbg'.

> and to have generic text in bt_dev_info, bt_dev_err and
> bt_dev_dbg updated from ROME to QCA where ever possible. This avoids
> confusion to user, when using the future Qualcomm Bluetooth SoC's.
> Updated BT_DBG, BT_ERR and BT_INFO with bt_dev_dbg, bt_dev_err and
> bt_dev_info where ever applicable.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
