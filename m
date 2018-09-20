Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D208ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC55621529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m0JnGZbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC55621529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbeITVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:23:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44895 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbeITVXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:23:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so4522777plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=ZfwZT9v0pDxS96+GXbglP+JiX9glvl1GCvkgsDRDNfw=;
        b=m0JnGZbgZs0hyp5cDjuoU2KHFaJFiA5xICYs5gQOWIgZ4m0oQmk5asfJXadFJfdSAG
         eMOfTw0Fbdea22AIJ8Ip0YIOV4agZHiWAGykppvLnSgY9blqyatHUIAGpwFDvjAp4EWy
         lGE2nwsp1qElg8iGj0OvGKYPDw4z+dHL34XDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=ZfwZT9v0pDxS96+GXbglP+JiX9glvl1GCvkgsDRDNfw=;
        b=CRkAsSUnw3TpOEGuUD3AGSbEqUAURQBvby1FkQGG0VIzAvizuMTwtox0/TKf/ApOki
         z3HoUuxfag+YZ6Lw50RbvhePifUos2I4z47k+TdDRNU6ZRNpmJQxTGoSexGGPDzcMLqZ
         In6dhjqgAe3OU1ETCtQ5dZI8sa7SVirNs/583C3lGWxEhn7EG079ODFVAQnWhF5Ykx4A
         X3OlbtDhknCwH6dsyHe0rWjfnNvZGO/+GTRjdbk/9oqMpHq8dtoeLy/xHrtG/rvt6FSO
         Ptoezl2/nrbB4uunu+QrfbdtljxTSb9HcUz4ossilmtMgQrHc9SvRYOW1HPao8Qc11HM
         1XXw==
X-Gm-Message-State: APzg51AWH+ZRdPskv+DLQszjY2fN0zrrPUFj12pL9E6xCxehP9g9vj+6
        Xpid2ehSJbNVJyYq4DrrgE6brA==
X-Google-Smtp-Source: ANB0VdbOfN8LFqNIemElV558lno+Il2Mx1C9n2u7onNQr7sH3tZpV0Vwqd49WOyiEqxBVqeBwj/Fzw==
X-Received: by 2002:a17:902:8a97:: with SMTP id p23-v6mr39631147plo.21.1537457980634;
        Thu, 20 Sep 2018 08:39:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id i25-v6sm28259019pgi.31.2018.09.20.08.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:39:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, broonie@kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mka@chromium.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
Cc:     Dilip Kota <dkota@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
Message-ID: <153745797844.119890.3694938882109396370@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V4 2/4] dt-bindings: soc: qcom: GENI SE SPI controller device
 tree binding
Date:   Thu, 20 Sep 2018 08:39:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dilip Kota (2018-09-18 11:07:24)
> Move GENI SE SPI controller device-tree bindings
> from devicetree/bindings/soc/qcom/qcom,geni-se.txt
> to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.
> =

> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

