Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25463C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34072245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ182oO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34072245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeKMOyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:54:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40546 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:54:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so5378623pll.7;
        Mon, 12 Nov 2018 20:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Am7+qzdg5/vZ5GLfUE82Rv78i7926txhIMRKGYCFq5k=;
        b=aJ182oO540zPdYKjeM1IGiw5IRCbM+mg6k2ejNw7ymoFgH21O/WUIGLhiXveEf0eAv
         b9XE7yeQPZlfEj0wAly+iUaDqfTKGlpTiUZquoii18QJH9olAFN4J6RG7V6LJQ4RUmuI
         XMrpzF1NvKqwUdAzIUAWoNB6GfvW9uNXS/i8aDxk1vQ6LGkUFLMemvF2iDH+wurz3TmD
         XWqBn3XD6ipsnfJgiTLmgP3ue38AYZFiMXsPr1kDzgDy2MPACO/y1i6hP5GSie0uuA2I
         ddgCT3BqnCQkHwaDL47CKfFFeeGc4S22gak5bukIHNfeNLTD6TITqeByxU/dfFa1C9eB
         n28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Am7+qzdg5/vZ5GLfUE82Rv78i7926txhIMRKGYCFq5k=;
        b=bNBBl9ZM7k9VLE+6yIw3X6nq1/cTg0xkA9l1oSIJsiqhkOFW2MnCIFO+dzkcR/HP1q
         6AO0s27O8R/hsJPrLM/7c9RUQdZx+YGoi3QisndevdP6fbBsEC60rhAi4ab7Su2U6hkH
         rQ44nogSKKGCmuiECc7DzBbiYygy7rLCE0Xi/CETN+RRo7vSCdmV75oPHNUmha7wwVEZ
         /pt/Wp6iWB7rqXutjTsiWC79gYuYwUwMf2/7zl9EJs0uNrl50isQiX9sOWO7UEdLKkvq
         yWV7B/rz4OsVnYdNv2dATwE0V1auJwWrpY9fE/vkIzJtSLF43H4xcuzj37n7fghItmVc
         Lctw==
X-Gm-Message-State: AGRZ1gJzNR9/zW2ZKtR40avHh/jpNAlXl2dxsTtFor6oN7gaeDhyW4Rj
        v40dgwgcDR5nq+MuIO6C//s=
X-Google-Smtp-Source: AJdET5dwOcDZ937GopzYOS7hOQjNnvl3pPw4HZVrNrn80NzuVNwCk3pxT49jP1Q7AT4Snc6OokwUSQ==
X-Received: by 2002:a17:902:d806:: with SMTP id a6mr1790214plz.172.1542085112210;
        Mon, 12 Nov 2018 20:58:32 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id k70-v6sm21327499pfc.76.2018.11.12.20.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 20:58:31 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:58:24 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
Message-ID: <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
 <20181113043248.GB11205@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113043248.GB11205@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, Nov 12, 2018 at 08:32:48PM -0800, Guenter Roeck wrote:
> On Mon, Nov 12, 2018 at 08:23:53PM -0800, Nicolin Chen wrote:
> > INA3221 supports both continuous and single-shot modes. When
> > running in the continuous mode, it keeps measuring the inputs
> > and converting them to the data register even if there are no
> > users reading the data out. In this use case, this could be a
> > power waste.
> > 
> > So this patch adds a single-shot mode support so that ina3221
> > could do measurement and conversion only if users trigger it,
> > depending on the use case where it only needs to poll data in
> > a lower frequency.
> > 
> > The change also exposes "mode" and "available_modes" nodes to
> > allow users to switch between two operating modes.
> > 
> Lots and lots of complexity for little gain. Sorry, I don't see
> the point of this change.

The chip is causing considerable power waste on battery-powered
devices so we typically use it running in the single-shot mode.

Although the chip now can be powered down, but we still need to
occasionally poll it for power measurement and critical alerts,
so single-shot mode is the best choice for us, considering that
the power-down-and-up routine would be way heavier.

I could understand that you don't really like it, but it's some
feature that we truly need. Do you have any suggestion to write
the code that can make it more convincing to you?

Thanks
Nicolin
