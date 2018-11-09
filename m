Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54DFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D69C20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fh6q3u7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D69C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeKJJEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:04:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33493 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeKJJEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:04:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id q1so3196309otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qts3v6PmQYWsu+lBnxMQTyFzGNDMvJGvPCzX9bXMAK4=;
        b=Fh6q3u7id6gFGD4pHWrweZvU4TAH7hB9wRxIoxApX45OMoPSAIetfTpnjBukg/ct7l
         lewjayK061ZpgT0NY5yhUTwqDB3G4QXcmE7w3PLJSSjzdGTOfng4IPm1/nDP6oq/B8j2
         4JFFOoJM08zaN/6vOir9cm/lCAFrZDQBJ1a94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qts3v6PmQYWsu+lBnxMQTyFzGNDMvJGvPCzX9bXMAK4=;
        b=jP10NMs+b/aV8+g54Er/ePpZtt6tMc6aR/6lKOEXbe4LIFR+xx7DDYir7yb8Qvu3ux
         75QExT0Kh1nWsGydEo8gIXE+LCWG232urPcsSmoxMBUjunVWXvEAxY8iBpZQ3uSEBTBv
         UJXZT+3vHsqYwzEUzj6nw5p3aQiuHGxsRR54GXnLnMT8TzAxf7Q214BWknjN2nX8ZpP8
         0sLkvNZg6gJjbnfIJZcBVvX2mXUIib5kJaqBHSaqxmZzCxCOE7TeiuOht4zU6di8oh19
         6OwbDBySjc18CIlkA0Fo2AATPj/0kN6Amk00yAJ0AwiWK4TdgVrstIGPrkRBS9GzAHyx
         RLkA==
X-Gm-Message-State: AGRZ1gJdZguzxlAxrayYBmcc6+lWe8HiVNsNxQFgNNjksyNBCiKbAsV0
        1OiVcZZM+JaoqlpPulHeF9/z/w==
X-Google-Smtp-Source: AJdET5ent6sFCsZWF6nRnbwJ2KJDQNR3Vm68LKldVBseyy6yoj+TSQcthOTMYreD2d2+hMVCzGMz8g==
X-Received: by 2002:a9d:fae:: with SMTP id d43mr6006591otd.368.1541805712358;
        Fri, 09 Nov 2018 15:21:52 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:2c8b:81ba:25b4:a1fc])
        by smtp.gmail.com with ESMTPSA id w31sm4641006otb.57.2018.11.09.15.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 15:21:50 -0800 (PST)
Date:   Fri, 9 Nov 2018 17:21:49 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Mark protected gcc clocks
Message-ID: <20181109232149.GA8686@hector.attlocal.net>
References: <20181105194011.43770-1-swboyd@chromium.org>
 <20181106055013.11271-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106055013.11271-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 09:50:13PM -0800, Bjorn Andersson wrote:
> As of v4.20-rc1 probing the GCC driver on a SDM845 device with the
> standard security implementation causes an access violation and an
> immediate system restart. Use the protected-clocks property to mark the
> offending clocks protected for the MTP, in order to allow it to boot.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This looks fine to me.

Acked-by: Andy Gross <andy.gross@linaro.org>
