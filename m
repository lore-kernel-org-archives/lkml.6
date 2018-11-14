Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F64BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D9F21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LY0tXwhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D9F21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeKOEJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:09:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41360 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeKOEJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:09:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so7706955pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJTgPH6Q8pRc/BUXWe8UESlPLNpIuRtBwpBCFeHSJ2E=;
        b=LY0tXwhqt19AOiSi9+rsnPaeqjaC5EXBVXE5teyABWnTLm86H4eGbZ+WVLrl/o7p09
         Kcn1FSjoi3JrH8C9Aec2ywmc1VrlJKsvfoULd2tecJAQv4G3b1BrON/MfVPIs5tmHSVY
         ipnGZ/jx3dd/4qvf+jwkGr6HrYBZMNZ6U7VDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJTgPH6Q8pRc/BUXWe8UESlPLNpIuRtBwpBCFeHSJ2E=;
        b=fMGdxqUFeYsWMHRMf9oneWOCRiK+fJ08dBsDXAJqRb+nd4UpJKCbmeLUdT2mU3zMGl
         sdvg6nNH8pyuLlrsc15T+NdPpbAw0luV4fVrIY+GArIg39R1RDGwwW7HCNgHLp3AwfiH
         rel9wmfrBlHuwBaCISRhcmzSo4I+LSik46NSjL+jMbuvb9o47El1O4BrlFY1fXbz8lrg
         wQf/9xoOeDlrlDzhvGt84AAWCQ6S340ALQOkrtucQwzALKSCOvd+0iZxMR3C/eAUe0hU
         SMBYA0tBIfCDm0yo7XV/G8DE3CJz4LeTvdV7rycP+dgTkxVLWaf9Pbmc7YrjeLDs1Rre
         f+VA==
X-Gm-Message-State: AGRZ1gJiLDrL0gk5JtkDzz/c2Ny+OBN6ZfHDJYo6kBfS0u+m95jMJqP3
        STRjenNpNtdXWRn4f7/8hy/t4jfw0vAeDyLc
X-Google-Smtp-Source: AJdET5cmRvtnU+zw9vQMs0RA89KSaHmT666aDG8wq3yATtc0feuTXFLXInOrMP5c1LAqh2RA4Cqzvw==
X-Received: by 2002:a63:441e:: with SMTP id r30mr2748594pga.128.1542218691104;
        Wed, 14 Nov 2018 10:04:51 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id x12sm22929406pgr.55.2018.11.14.10.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 10:04:50 -0800 (PST)
Date:   Wed, 14 Nov 2018 10:04:49 -0800
From:   Andy Gross <andy.gross@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     David Brown <david.brown@linaro.org>, bjorn.andersson@linaro.org,
        elder@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: Drop help text for QCOM_QMI_HELPERS
Message-ID: <20181114180449.GE14703@hector>
References: <20181001095554.23815-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001095554.23815-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 11:55:54AM +0200, Niklas Cassel wrote:
> The help text is visible in menuconfig, however QCOM_QMI_HELPERS is a
> hidden kconfig, so it is not selectable in menuconfig.
> 
> Remove the help text so that it is more clear that this is intentionally
> a hidden kconfig.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---

Added to queue.  Thanks.

Andy
