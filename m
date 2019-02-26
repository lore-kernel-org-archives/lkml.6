Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8981C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA4C217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESWQ+r/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfBZALz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:11:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34404 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfBZALz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:11:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so5295123plr.1;
        Mon, 25 Feb 2019 16:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YyyUSm/rTAXTlLn0I2TuMYjiTolX16HRfpjhFaA9vio=;
        b=ESWQ+r/5pa9tq+gHuS+/fZByoePFaCQoz0XjakGuerLIwbnVwG712XDVxKWxDLPx1t
         yNH/Uyw23deEEP1kf9D0FfSXmKngUGEiu3JACQe40HU9hGgoWoPRDprNGGlT/ygFalwN
         35teEew8URK1u8lgJSdvjRhPJa0ARspePUAH9lq0nFdZku9EYl+TIXhE77R9hAssC7+u
         KRkWg9zZuXdOKqM6f8c8jZQOLJSHhY9QaP6JVlfHHWneSS6tSrpVMnlsP3g+WGvt/l9i
         7BIYs3hwbBsj8yEhF/vrdakoYuQjtJB4JJGW7bt6uK1MDAYxRlA232EbvB7I1KoL4w9f
         pORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YyyUSm/rTAXTlLn0I2TuMYjiTolX16HRfpjhFaA9vio=;
        b=smMRLR+/edqkBnBNco+VN9ydyBpCslxiZH4gXESGXbaJ8Vwuz15w57CPTw0hJrE7lI
         80O+PE4xuk9cRddgdwll7qGLWWgf1o0zVb6mn/v1w4cfU6h/Q8IPaeU+JKaHYNkI/JTp
         0MT7bZAeWL9wvw82VupUqiYzXs412jnmtwGlg8fUhX8nlOSJl0+1abDHdSXn6guEZ78W
         QpcYCSG6lDoCR2hbZwiYxKbfEwKZRKDk39h5rXbI5e+rZHndL7LUlmcgs14qoEtpLEoJ
         EzSUFqHRJ6QGNIBWsOA634J650DYdZbQ7pPSIS2LqnccXAn8Cw0bpkLicDcm590aVSmA
         2Vug==
X-Gm-Message-State: AHQUAuadLtN2vXi2Tw2gsewnfkj+QzEJYAgki5+QaC9/6W9VJ/tUb38M
        LeUMoU0E4qMBREN8mOQSHAqZzyX8
X-Google-Smtp-Source: AHgI3IYkklondl7qyJqrXPbA0+o5FOh2xbLMiIjfL4udeMwtGo5WF5984N4Pb1spcIPDzh3c3Pp6fg==
X-Received: by 2002:a17:902:e409:: with SMTP id ci9mr22532081plb.221.1551139914471;
        Mon, 25 Feb 2019 16:11:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q13sm14498175pgh.24.2019.02.25.16.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:11:53 -0800 (PST)
Date:   Mon, 25 Feb 2019 16:11:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20190226001152.GA8661@roeck-us.net>
References: <20190226105547.7343cf8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226105547.7343cf8c@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:55:47AM +1100, Stephen Rothwell wrote:
> Hi Guenter,
> 
> After merging the hwmon-staging tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
Ah, sorry for that. I had fixed this up, but forgot to push.

Guenter
