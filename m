Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B89CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA48A2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="htenlsyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA48A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeHBIVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:21:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53637 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHBIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:21:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so1127923wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q0lKRB9tTTqKOiPc4jlrtmsoWTXlNq4roitM5KtGSsc=;
        b=htenlsyT8MlqRy69IH7IB+vqbybzKy8FwS5q5l1O6/FWog7/m+nIscgxRZn6UQ4dmv
         Ya1JHjBYOr0I6IWP+ZZMdJv9t4hdY5UZnaoGaidvYmtoKqv+SjFt8sf0PqaYLdKwBH+p
         qhm799JGDeGtx7nr3vP89WVYNHSVMGZ+veqPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q0lKRB9tTTqKOiPc4jlrtmsoWTXlNq4roitM5KtGSsc=;
        b=M/OrxUnOyjdURG53ywIwkBCYHMLRZmLGwuaer3lKmS1iFXHGJpD4wdz8OHU/tF8McK
         AXem4YwkCYszCn6LrJOSnLKO5fXpotEqWps4sa50NWHNWk/2qFtk4215xJ6aX+XoQP1E
         UtPEaC8nHhksPl5ovkqkW3a4jfJhdZ0ycgpCMnOF2PctRk0hsvjPLiqKcfRXkytrOSTm
         G2J/u91bWGHFoO1C6vBi7zJDDsWdzUJB9xly59W3vOeqjC+hld7CksLAcrpppobtT+Zx
         OfAw0R5x45YNB99QuiuaFk9hjVUtzc1HWmqdyJ8DzYbYZbffi+ovKuvz0C0hvsHDClXf
         GsfQ==
X-Gm-Message-State: AOUpUlHFLsDA5dHblivMZrW4/0Fa/XmW7V+NI7yFwYbfoLZP5RcsgQ1S
        v5xI3TGhQHWAPf3QJHh4hPYnng==
X-Google-Smtp-Source: AAOMgpdJ+8HECHPx6R8ZiMOMrWClInv5fdsHYqXQf9Qoj2m6/6/sTTUlRbwrP2sq2jjB7FZ8mM4tiw==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr1028637wme.20.1533191492789;
        Wed, 01 Aug 2018 23:31:32 -0700 (PDT)
Received: from dell ([95.149.160.4])
        by smtp.gmail.com with ESMTPSA id 188-v6sm1263547wmv.11.2018.08.01.23.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 23:31:32 -0700 (PDT)
Date:   Thu, 2 Aug 2018 07:31:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Subject: Re: Applied "ASoC: wcd9335: add CLASS-H Controller support" to the
 asoc tree
Message-ID: <20180802063130.GJ4662@dell>
References: <20180801112000.DC6B51124241@debutante.sirena.org.uk>
 <d7c2e466-9f60-9347-bc62-7ed0dc3df91b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7c2e466-9f60-9347-bc62-7ed0dc3df91b@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Aug 2018, Srinivas Kandagatla wrote:

> Hi Mark,
> 
> On 01/08/18 12:20, Mark Brown wrote:
> >   snd-soc-wm0010-objs := wm0010.o
> > diff --git a/sound/soc/codecs/wcd-clsh.c b/sound/soc/codecs/wcd-clsh.c
> > new file mode 100644
> > index 000000000000..2393456cbd97
> > --- /dev/null
> > +++ b/sound/soc/codecs/wcd-clsh.c
> > @@ -0,0 +1,605 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
> > +// Copyright (c) 2017-2018, Linaro Limited
> > +
> > +#include <linux/slab.h>
> > +#include <sound/soc.h>
> > +#include <linux/kernel.h>
> > +#include <linux/delay.h>
> > +#include <linux/mfd/wcd9335/wcd9335.h>
> > +#include <linux/mfd/wcd9335/registers.h>
> Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" It
> would break the build.

This is not a run-time dependency.

Without 02/10 there is no build. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
