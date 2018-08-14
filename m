Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BAC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03C12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1QJRtaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03C12173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbeHNR3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:29:04 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44753 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbeHNR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:29:03 -0400
Received: by mail-wr1-f54.google.com with SMTP id r16-v6so17415164wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oyQyBGTGGyQ61xcSmFZTwigow7UjpG6b4nNXcXI+Cs8=;
        b=D1QJRtaStG9AFAt2rgjGSuDUvRo9HtZ8LUqAupOU2Tg/Ta/pejDMgF2n1oQsuQMuOw
         4F7XeGfhRBK5RuiOV5sED0s3rQL8usNPDqskRwiUV53F6qh1edxtIn2ebwgeukmsls8d
         6PkC+SX+DG5zgezeER0wmnnLWgE4u7QwR2z2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyQyBGTGGyQ61xcSmFZTwigow7UjpG6b4nNXcXI+Cs8=;
        b=Zd5YFMUuGS5FwqMB76G08yhAGYBqOyNzmu/uydCGjQdETW2OZRB/PXZGmS8YRmp+G7
         CjJjcXj/BuIgo/sdU/jPtKtfHZSuIKUY2AblF9jVCs+uuAkUZX6i2rkg8ykk/k+fi0Ul
         BBAX7+42eysZdPSWwYLUNSxUpohUlIix98DrT512O+d/KaZSMt2nsmVaDSZUDA+d7t/B
         3+PEarYCKRxSqRPmugshyboKuWIh09DNEEJqgEHSY5k+sFKH7SB1Egp8KZc7v2fVEenf
         yjvTU03+yuFDlTr4YbOek+MoROMrrkmpXe3l5YWTfmVB4vDY9PWvwtPzS4n6OnRt8r6+
         AtYw==
X-Gm-Message-State: AOUpUlG8G3tv+mmxZWYoGk3g6MV/XHPui7+1kd4//FPPpVsVvIPhEFC4
        ahzg8oRYXxs9utgigf0eIFkW0A==
X-Google-Smtp-Source: AA+uWPxnKc2gY5ZtawKU0XEPm6NYvoaG3txYX+r8IGoo1E9VwDqihkTqtCe4lOV2MQ4OztlQfDWBmg==
X-Received: by 2002:adf:fb0e:: with SMTP id c14-v6mr13389789wrr.117.1534257694891;
        Tue, 14 Aug 2018 07:41:34 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m35-v6sm51006847wrf.41.2018.08.14.07.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 07:41:33 -0700 (PDT)
Date:   Tue, 14 Aug 2018 15:41:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Joe Perches <golf@perches.com>
Cc:     zhe.he@windriver.com, jason.wessel@windriver.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kgdboc: Change printk to the right fashion
Message-ID: <20180814144132.mpqzz3sxdbfzn7fe@holly.lan>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
 <1534250761-824-2-git-send-email-zhe.he@windriver.com>
 <20180814133536.bfpygzwnmlqfsee5@holly.lan>
 <1678613360b7aebbf1ab42dd89139cb666ee8cd9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678613360b7aebbf1ab42dd89139cb666ee8cd9.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:04:11AM -0700, Joe Perches wrote:
> On Tue, 2018-08-14 at 14:35 +0100, Daniel Thompson wrote:
> > On Tue, Aug 14, 2018 at 08:46:01PM +0800, zhe.he@windriver.com wrote:
> > > From: He Zhe <zhe.he@windriver.com>
> > > 
> > > pr_* is preferred according to scripts/checkpatch.pl.
> []
> > > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> []
> > > @@ -136,7 +136,7 @@ static int kgdboc_option_setup(char *opt)
> > >  	}
> > >  
> > >  	if (strlen(opt) >= MAX_CONFIG_LEN) {
> > > -		printk(KERN_ERR "kgdboc: config string too long\n");
> > > +		pr_err("kgdboc: config string too long\n");
> > 
> > Looks like you should remove the tags from pr_err and use pr_fmt(fmt) to
> > put tags on the messages:
> > 
> > #define pr_fmt(fmt) "kgdboc: " fmt
> 
> True and it's probably better to use:
> 
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Good point! Thanks.


Daniel.
