Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC2C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6077D216FB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GcZLi0hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6077D216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbeHIRcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:32:04 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34342 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbeHIRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:32:03 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so2682466plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=BhmAkZqkJHDQasq2KtgGbEhRzmOv/cUjZZPSjLEcz5o=;
        b=GcZLi0hpWb58dKe3DSjG0+yGCU2dJXqD1MtgofSSy5bXTGH2hfWTp3/jU9JxUXE2Et
         N7DnhGcJG8NzD00KcQSBKeMn6wcBk/+GK9Gg7qaky6cddLzTX3jJROPmlTEzcNx7rN+Z
         7gdKBHHeGH1YXtmOvDAKc6P8UdVpKlcpZfxyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=BhmAkZqkJHDQasq2KtgGbEhRzmOv/cUjZZPSjLEcz5o=;
        b=eXjFU5tmqJmsxRaAiGNbXu2gHccQ6oGNGokDnTHcYA6ENFOe4lZJAw1G4IoSuHjY8t
         anuc9gJBENFYWr4ClgHH4mtmG/B5HvyKmAbm745WM0Nd1Plapo24FI1kkQu9za1v0j5h
         wI4DvAFr4ytjIol3wVjZHscKAeuFlRZ6QcI8QhW8tLaTnECig546ft/TmZj8P+Ijf1rC
         6Q+Is2oSb8Wn4eXqTwBXyB0wbNaQrW9aHApEjNfZfe8ItOwKqLcRtOgZaFv1p5bEzhS9
         9t1WhJEYC4QNKk3uF4t4JsJ1nKs6ZwujnB2qCYpCvKuIboVBxcKVgF1Op0HKICZluIyE
         RoMg==
X-Gm-Message-State: AOUpUlHCSl4sk7OAldrHmRh7M9FRUTH1Ob24eokxgEEtLlM3MIWJYyaW
        Hr65ZaaoNpV8nrWLQzw8PEkubA==
X-Google-Smtp-Source: AA+uWPyZynW/3/fyLP8cl5MTVO2wYx+++lgnJYa0r1Qr+jreOPdLF5PbunPDTrWu9OI07EC8JzytyQ==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11-v6mr2462408plq.228.1533827204670;
        Thu, 09 Aug 2018 08:06:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id y3-v6sm19532730pfi.24.2018.08.09.08.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 08:06:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mike Shettel <mshettel@codeaurora.org>,
        boris.brezillon@bootlin.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        robh+dt@kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
Cc:     Mike Shettel <mshettel@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        acourbot@chromium.org, dianders@chromium.org, mka@chromium.org,
        bjorn.andersson@linaro.org
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
 <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
Message-ID: <153382720283.220756.3098223794140406023@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 2/3] dt-bindings: i3c: Document Qualcomm GENI I3C master
 bindings
Date:   Thu, 09 Aug 2018 08:06:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Shettel (2018-07-31 22:39:01)
> Signed-off-by: Mike Shettel <mshettel@codeaurora.org>

You need to write some commit text here. Otherwise we don't know why we
want to even look at the patch.

> diff --git a/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt b/Do=
cumentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> new file mode 100644
> index 0000000..8b76fda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> @@ -0,0 +1,44 @@
[...]
> +
> +I3C device connected on the bus follow the generic description (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> +
> +Example:
> +
> +       i3c-master@0d040000 {

Drop leading 0 on unit addresses.

