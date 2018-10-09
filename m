Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE0C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D13213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXlDy+bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D13213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJINoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:44:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38147 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJINoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:44:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so433025wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/GBFI/QDf+2wCuLMcmCmEjR0Zk/A3MfKU8LhJAK9R0Y=;
        b=CXlDy+bnlIH0F5v0NhVpFeiCARaWQmEH0R0CCipE0ULADuYIZlK9bZjCsEQk07HDQO
         Ie9FObYhgaHhHtGXfo6jd6AWFBb925A4R2HoszRQFnTjwrPJW0uq3niFzY0VPgL+Pdfx
         HS1DxUyEnxjZcqOVgNC1+nvCpqLzegjD47VFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/GBFI/QDf+2wCuLMcmCmEjR0Zk/A3MfKU8LhJAK9R0Y=;
        b=Db59sqJy7zIg6vDGNUxPWooj5279q2MfTgbus66DDTpxqN7gaiPdNBi7dG2Nqz+rc3
         DqpzBzjmms1HJOGPGJoIcMG1ocbXHwVhkkleopMO468fLTeOkQdIcHx4f+D1l8e8OZbJ
         GrUMJHkkk9bnQzPXS9aqRI8Kwomj1XhQOYxZd5Lo1/46me0WLtI2M6Hq0tcP3wVGJhwh
         4pMosZ+W7LsY4TktiGKEXho2QEJfQlwZexkqDlXQMsFe0g7d9ZEbRN1ClayeWPJq0NkG
         tiHzc5Ukpjg5KE/TazpstLJtYJlWacV6J0BCQTWS0BU5m9Zl8i2vKUFhJXnJOh7IgB97
         9wKw==
X-Gm-Message-State: ABuFfojpUWUaIQlJMHgSDCTZCJB6WO/dlX+3NwRDGionObWz+qrUG4+x
        PvBsjTFIQRzwNvTrnVON35Is/Q==
X-Google-Smtp-Source: ACcGV605lmMqkqxOI534mLEOmgaKk3+PKB4gddyZjsBjfKbcwPMNB2SwMLb4mhtJXC01koR32k9Fcg==
X-Received: by 2002:adf:8141:: with SMTP id 59-v6mr17595893wrm.127.1539066538028;
        Mon, 08 Oct 2018 23:28:58 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id z69-v6sm11596209wmz.18.2018.10.08.23.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:28:57 -0700 (PDT)
Date:   Mon, 8 Oct 2018 23:28:55 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2 1/2] mfd: cros: add "base attached" MKBP switch
 definition
Message-ID: <20181009062855.GA32033@dell>
References: <20181005184114.207503-1-dtor@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005184114.207503-1-dtor@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Oct 2018, Dmitry Torokhov wrote:

> This adds a "base attached" switch definition to the MKBP protocol that
> is used by Whiskers driver to properly determine device state (clamshell
> vs tablet mode).
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
> 
> v2 changes: None
> 
> Lee, I was wondering if it would be OK for cros_ec_commands.h to be
> merged through HID tree.

Yes, so long as it goes through in this merge-window.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
