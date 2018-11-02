Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA1C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B912082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZWGPG25y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B912082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeKCGFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:05:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39629 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeKCGFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:05:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so1474681pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=bH3gd5v1ow9gKpotBzCQq9calWLM7/jEQbLpz5vRv9Q=;
        b=ZWGPG25yJh1XCAw72cc3ttP/UjzI98+uLSw8uUkAXQj74VvwDXXv6C4maZKbfoyPio
         Icl3qaJhU8NbXzfJkgQo6guOZysJfWxN4EPXvffaFDD4WvieWxwBHlegdgF6Op+2hZWy
         n2NLaUaGHtZFsdn7v7JZHm30JUeZ1+Ocg+fns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=bH3gd5v1ow9gKpotBzCQq9calWLM7/jEQbLpz5vRv9Q=;
        b=IpQYYi66AfHNF/OZ/vvVkS4VeQnnK98+1KBYYayker/6ocZuOj1zp0iUu2kG4usLJU
         Jq+aXKnQy8tvldWL6DkcF4HzpyrfrXXsyfG2OZscJ6pCJoWdW2PNj5CtPvpMMn13KD8l
         c2bLj5gCrvZ/Bq5vnk8NL8wcVCRMP2C8YT+E8GPWMYxsCk/PoHJL6fXHBnIOF6Mn/enG
         kWVe12VUpKasTySx7K1uf5saFXB2+q17hMFq1efPVYcX6j59inMtgPe1mDprmlT1+I9/
         Uu/t0Ux5OhnPDW4hvWJaQRFBEbagdfurwhBfd2O+vcK8qeR3qhd48oMcyO9zCpJBMNW0
         QHDA==
X-Gm-Message-State: AGRZ1gLM45zeoTVFEFp7VuBCguQebWVVU6egsrmD/9Z6mDs0XzBPTaG2
        czVTt4nBJKXJSL7Ikp88gNt6ag==
X-Google-Smtp-Source: AJdET5f42P5MTeS7lg3mTQecae2zUAvB40bQrW7ewvULYdChzJrLgYygeo0x+4P2cWrwumfjnGPSQQ==
X-Received: by 2002:a62:1b4f:: with SMTP id b76-v6mr10756553pfb.96.1541192190684;
        Fri, 02 Nov 2018 13:56:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id b11-v6sm23105545pgi.10.2018.11.02.13.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 13:56:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=V7JDAP+riAFSt_CUUFvphEN1jTbkJW_+b-2gubUrCoVg@mail.gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-i2c@vger.kernel.org, alokc@codeaurora.org,
        Evan Green <evgreen@chromium.org>
References: <20181102183537.72334-1-swboyd@chromium.org>
 <CAD=FV=V7JDAP+riAFSt_CUUFvphEN1jTbkJW_+b-2gubUrCoVg@mail.gmail.com>
Message-ID: <154119218930.88331.3706147618288145520@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Fix runtime PM mismatch with child devices
Date:   Fri, 02 Nov 2018 13:56:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-11-02 13:43:25)
> Thanks for the fix.  It looks good, but can you also swap the
> pm_runtime_disable() and i2c_del_adapter() calls in geni_i2c_remove()
> to match?
> =


Good catch. Will resend with that.

