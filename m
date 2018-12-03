Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A3DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C021120848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZGzuJSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C021120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeLCLUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:20:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33088 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCLUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:20:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so11731910wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 03:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z6xRqZYmQFupWkTAUcvtd6EwodlXBZCPkuOcK2RqHwM=;
        b=HZGzuJSZJf2GzKOzsvoBKh2LwESf3RL/xS8FHz6MY8cf5V6MKF4hkXaks/s5k7rUp+
         264lXaUaqnn2XgSboYcc9r/Bn94z31xMyvayOze3Dfpn0e7zN+Eekqyf7jwvKEhx7u6C
         Sdq6PO8HbIQ+7CQa8aakkFI2H2Cpxu41Fbo9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z6xRqZYmQFupWkTAUcvtd6EwodlXBZCPkuOcK2RqHwM=;
        b=AskCwbU/42c7WiDHNC/RNLxn+860eFcu085am+7a8G6+aTM14V3sligMjXJeH+kKTP
         kEzsax5BERpSOlDz0Bd9DmJ8dM2eVAc1Yd/nM2pW+SXwCw4Qdd5o1lksuN+xt2oZwcV1
         rNJlYaHXt6gHBlT+FdAFLyQKV8sakToQxODejlYoVCTGOWBsQebB44A3AWWWeByr/ZG8
         RCQwvY3sDj4h5sMXcy+4+qTfVBHeXmbljPQufTE9crFJgRq5XYViO2Jxh2myj0is5chA
         xq3Z7485eh2J9SjtHl3Z2b4xDjK/CXUf5CM+DOSLLn19weQBCoxHV256VB50wgH4YJLJ
         H4QQ==
X-Gm-Message-State: AA+aEWYU1QACjnmUsCSqp2Q9e0aA660tQ1C9YEgSBrM13AZqxMohvQqn
        OMHM/g3Td3OFwA0CwaC8JYhq0w==
X-Google-Smtp-Source: AFSGD/WcIu9yUJac///aZIu6LTmEpcZoUObO3Bsda6LMTCAOb/Is8X+V41qOMMW709WiUHg+X7DBHQ==
X-Received: by 2002:a5d:4dc8:: with SMTP id f8mr14092733wru.45.1543835962146;
        Mon, 03 Dec 2018 03:19:22 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id y185sm5403346wmg.34.2018.12.03.03.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 03:19:21 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:19:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20181203111919.GL26661@dell>
References: <20181127120041.90759-1-cychiang@chromium.org>
 <20181128093411.GC4272@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181128093411.GC4272@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018, Lee Jones wrote:

> On Tue, 27 Nov 2018, Cheng-Yi Chiang wrote:
> 
> > Add EC host commands to control codec on EC.
> > 
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> 
> Applied, thanks.

Turns out that this does not actually apply.

What is it based on?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
