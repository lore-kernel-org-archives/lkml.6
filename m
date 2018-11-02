Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74201C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0712082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O4b9wt+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0712082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeKCByy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:54:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43711 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKCByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:54:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so1258117plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=or/q+9t+WoX1Lf8dWsqQtqFIB0Rcpp0FFwKyl2ZiCKY=;
        b=O4b9wt+/9P60cOJ+2VnlOOQaiDBI/SkHIvE1OMx1i3Gh6c60VY0BLvR0k1sVH6sbl/
         7fC1ZdYkrUeJJd1rpyPXUO5uDY3O0Cn9UGymA/ji9nMz8zjc53XZRJSMh1ZnN9K+xfE8
         bzak1F51qQqv/NlYSEKouXu4xKa/GcopsRTA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=or/q+9t+WoX1Lf8dWsqQtqFIB0Rcpp0FFwKyl2ZiCKY=;
        b=aB31XL/XYhnAN7X5L/Ja0iSUmHEFXvivmjRySHMQHWOxo+l/efF9w3GLd5uFatzWoF
         WmLxyUpL95dm/wWKp8RDsyT5vyBbAfXvfuTiLzVjnjsaM5tNqpo5e0hyhoGcBEhO0ihv
         BtnMUAG9/bKqRO6Ag4Dmh/nZ4/nS0POve3wJs9/WY7tZxxfi1gwMeGNwEdiHg4iWS6VU
         jJMB+gnufryDXED3vlhDXA8cy8VWQc8R/2AOndujtvDXRPQXpA3y76IUdj0AtmmHue60
         uhNd+SppK3hQxtyd2cufEyWZ6l6bLmuHfJ9otHhSASPdIIbdd59dZKPk43RMEHHQh1ZZ
         I+Fw==
X-Gm-Message-State: AGRZ1gKy/n54iGXsTGLrYS9ZkTxpkRxlJbL6VH+UDEgkFoQ+9bgI/jcV
        xH5kc2z162PqscoCU3yCz+zE/Q==
X-Google-Smtp-Source: AJdET5egY5D34e0819onobyCBLzM/fu5HbJcihvFQ3LFVbeW6B5HbWJtyL6i02+jRahUUFQmeT48nA==
X-Received: by 2002:a17:902:6801:: with SMTP id h1-v6mr12293879plk.177.1541177229569;
        Fri, 02 Nov 2018 09:47:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id h62-v6sm26079741pfg.27.2018.11.02.09.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 09:47:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        gregkh@linuxfoundation.org, mingo@kernel.org, tglx@linutronix.de
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181029180707.207546-2-dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jslaby@suse.com
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-2-dianders@chromium.org>
Message-ID: <154117722795.88331.829582703808332252@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/7] serial: qcom_geni_serial: Finish supporting sysrq
Date:   Fri, 02 Nov 2018 09:47:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-10-29 11:07:01)
> The geni serial driver already had some sysrq code in it, but since
> SUPPORT_SYSRQ wasn't defined the code didn't do anything useful.
> Let's make it useful by adding that define using the same formula
> found in other serial drivers.
> =

> In order to prevent deadlock, we'll take a page from the
> 'msm_serial.c' where the spinlock is released around
> uart_handle_sysrq_char().  This seemed better than copying from
> '8250_port.c' where we skip locking in the console_write function
> since the '8250_port.c' method can cause lockdep warnings when
> dropping into kgdb.
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Given that it's the same as msm_serial.c, and I wrote the msm_serial.c
"hack" then:

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

