Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3280E20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OR/daTS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3280E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeLESd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:33:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34945 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbeLESd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:33:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so18429739oif.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrc1SNvODPny/j2B9HJB5wUmnA5JPhKyNQphQrwQp8I=;
        b=OR/daTS47SPhi8F2Xea9tMwQuVSh3xnZSD/S+71P5IPQbP2/PevApfNt8IbXBc7+O5
         LmhKOgR2oE80Iokwz16PqFNKqx4ftUS769D1WbB+kGzOyXYX5ihgU8kHq/+hqWIoPTtM
         9NjfaQxssvgqBR1SbXeorJZIcpM3ip0On/rj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrc1SNvODPny/j2B9HJB5wUmnA5JPhKyNQphQrwQp8I=;
        b=WW7KSJAUpjo+XLVmsM8J/I5DPbdRbj6NGWX2YkdV1vvPlBoDRpd7K8MPnaNedxfUUO
         XNwIw3muB8mQdpdNoVc1u7llghlGC7QqNIz/Vo6UnTp57gG0b2wVcyxnnruAz3obKEuX
         Xdo+vsJBbRWA0OcIxosCyXmqj9JMZa8YORjcu5YwBljaMgrKJyGSr4uShTITlx2lHqB6
         wPofsouT07YL4BiPuI7IwUhDDR0g6tO4lDm2zeM4LPkGnQyEdBKYSlZ9UmR2L7sKKKsv
         FITNCgocFri09WDD85t23WJxrYAXgVf0ut0T9Tkt2DQaFsKZWs0fb3CVLYV4/VAi71b3
         bOwQ==
X-Gm-Message-State: AA+aEWbGatHzp3oQQQtkoZOGEhoSe69bFlDISbdm90NXxi2kPzuw04ra
        gdRHYnxIIUy/o3r47lFu/fQ9xQ==
X-Google-Smtp-Source: AFSGD/UhR16ywiLZNgEAw/W/O62SDCDR2SC121JZj0iZsR0jkptkzLWVomjsbtjHoZ9gcWFsHXftWQ==
X-Received: by 2002:aca:2ec5:: with SMTP id u188mr16419307oiu.291.1544034807834;
        Wed, 05 Dec 2018 10:33:27 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:545d:d91f:9ae0:9fd8])
        by smtp.gmail.com with ESMTPSA id 35sm8688644ott.13.2018.12.05.10.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:33:27 -0800 (PST)
Date:   Wed, 5 Dec 2018 12:33:26 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add UART nodes
Message-ID: <20181205183326.GB5497@hector.attlocal.net>
References: <20181004002409.39350-1-mka@chromium.org>
 <20181204203718.GD14307@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204203718.GD14307@google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 12:37:18PM -0800, Matthias Kaehlcke wrote:
> Hi Andy,
> 
> can this be landed or are any more changes needed?
> 
> Thanks

I'll see about adding it to the second pull request.

Thank,

Andy
