Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA55C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94B921EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fef47AHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94B921EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeHITjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:39:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46975 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbeHITjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:39:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id f14-v6so3031455pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lai/N/VnWRDC0SDLSld0AuwvZGTWAS0gzAMqkzYdfOM=;
        b=fef47AHEaAjWPYX7WgocUV9ayqbsMN4Tr1wCgqAMIosdEjfT9XLzUAHXnpPg4b/F2T
         Z7xgYYhRdEJeLYRauShWcCh+FxBsUngqNy/f0H0lfLLmWUa4JgsL1QdSQSfIxy13pECT
         5+DCIqoKN/TT3OrWBttRbFp56xHSzg7trbTmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lai/N/VnWRDC0SDLSld0AuwvZGTWAS0gzAMqkzYdfOM=;
        b=CGlhx33MqD1iQHNXtoyp5Q6PiWG1UxCnkswMX8miTLnfpAPRx0kRb/RyBauD9hLUTe
         jGBNPWVr5Y2xjvEw7aLq0543Qglb/htZt3kOBVybhnm8eJ3L1cyO1VwmhF09dOj5N7Qj
         u26c22PBwRYSgFh82Oe/JuBjgY2jWW1PeFnqduhyImQwBh4qz5kzPawXzHLrYWHKvNTf
         1jDEtYIfKABvcKPqs5NWy2Qqit0wUSMyiBzH9Q9UpXnXmfyKHT23kpEK5TgxB9o4iLju
         dtRt1J0xR05ZsWEMyKAIQnYg2q0ob9cA9mMPREnj9A2Q45H+7zlmwC0uYLeC3qz28Gw7
         G5bw==
X-Gm-Message-State: AOUpUlHPxNKRoMghAcwToTMyZEp+VwrA2zVX28fzDGXysmZ0HyHJ9U3V
        VwpQyVJKOy+I/HGt7b1GHBz1eXFqYBk=
X-Google-Smtp-Source: AA+uWPyLarYHa41G2Qs8pqAKQO5H8IKEwpr27pBCFddrkWYHPQP0K6QlUntjRtEzI1/yntR2OL7f7g==
X-Received: by 2002:a63:a347:: with SMTP id v7-v6mr2914064pgn.182.1533834793173;
        Thu, 09 Aug 2018 10:13:13 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id j1-v6sm14286770pfk.125.2018.08.09.10.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 10:13:11 -0700 (PDT)
Date:   Thu, 9 Aug 2018 10:13:09 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH] firmware: coreboot: Let OF core populate platform device
Message-ID: <20180809171307.GA129285@ban.mtv.corp.google.com>
References: <20180806171047.227835-1-swboyd@chromium.org>
 <20180807214102.GA218251@ban.mtv.corp.google.com>
 <153370805099.220756.5343483987100252246@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153370805099.220756.5343483987100252246@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:00:50PM -0700, Stephen Boyd wrote:
> Quoting Brian Norris (2018-08-07 14:41:04)
> > On Mon, Aug 06, 2018 at 10:10:47AM -0700, Stephen Boyd wrote:
> > > @@ -44,8 +43,9 @@ static int coreboot_table_of_remove(struct platform_device *pdev)
> > >  
> > >  static const struct of_device_id coreboot_of_match[] = {
> > >       { .compatible = "coreboot" },
> > > -     {},
> > > +     {}
> > 
> > ...and since I had a *real* comment, I'll mention this bit I noticed
> > previously...this diff seems a bit superfluous. I understand we don't
> > really want to extend this list beyond the NULL terminator, but
> > normally, I'd expect we leave it alone.
> > 
> 
> I was adding MODULE_DEVICE_TABLE nearby. I'll leave the removal here
> unless you really hate the style cleanup.

My ugly and imprecise grepping tells me you're going to have a fun time
enforcing your sense of style, but good luck ;)

$ git grep -n -A 10 'of_device_id.*\[\] = ' | grep '{\s*}$' | wc -l
1020
$ git grep -n -A 10 'of_device_id.*\[\] = ' | grep '{\s*},$' | wc -l
1348
