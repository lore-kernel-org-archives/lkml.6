Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780CCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384542243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5XivNoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384542243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbeKMDga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:36:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeKMDg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:36:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so934391pga.9;
        Mon, 12 Nov 2018 09:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5aLXHzPZnLJSFOqSfHaaCSm0oPryno5DcWnqOrcRhi8=;
        b=E5XivNoKZdxY5QW0GBXDkd+1kA8HdvULWI/s9Do9r3nIASaeSnQgpRAorGwpJnjOc6
         YcF44whoMoKXalmMBPmAdKKaA/gCcg72RuxRex+3pS3+YoMAFs4F1Pc794VESWwV4eG0
         pUD/nY2bInVIPBvdx3ZalSbQjh/OlBMownLL8F0zVt+e4pGs057eE7WnblHAOKbmtLR1
         5cKHpLe/aJ50qKbFFPnL7aHIK9bBi0LAOp9wfhwVElAJUYU6rLSNjl1wGlLKSj1OE+BP
         trGYcZfoI7JmjSVpiIISGLPkQi/KkxcDbT+ScW3IEBDl6LP5Pv9NenQU9wziAbwxR0yQ
         +OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5aLXHzPZnLJSFOqSfHaaCSm0oPryno5DcWnqOrcRhi8=;
        b=FiBK/QbJgMdt26U1KVooBNZH98USaLiXbqnah3tneqnwDrs7U/lWgbsetb8PGkXKqt
         Fihy1UHD/ZUT7vnqEnBlxs6IXpJAeRjcdzNYfhcwKJkKebAc772I37ac4TEv3cD33lKN
         kZj0VlaYKJkkMJd9Avu5QzKIX/MhmRIn/xYErp3/dAKFBekw97a9BzszkrwgXyI7VrVq
         PX3U2ESEBq6O+z63++cpSpUMY2rzsQJyxUnFlsgs179EO8nOzZgGQkq9ucTE6KlpYScf
         BaLW/wruHiv3sleeReaXu53D6ZYd1wocLORAYxQKuvMqw6EpW1LTP81S6NiO9Op5UP09
         H1PA==
X-Gm-Message-State: AGRZ1gIcS6zt1PlgNaveewW6ySadFkhvRZgb7vUbgDFlLJKzdEhG5Oe/
        VkNyrx6UDq/5UpmjScYnI+sOzos2OhE=
X-Google-Smtp-Source: AJdET5foYQ0bcdNPi5HbbwCqpK+TDwRtdSEh1fCXiJelldMsb3pbXUsFVt1eI4kkevvKF6c02KRNmw==
X-Received: by 2002:a62:5c41:: with SMTP id q62-v6mr1783090pfb.171.1542044535085;
        Mon, 12 Nov 2018 09:42:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y66-v6sm23086630pfy.24.2018.11.12.09.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:42:14 -0800 (PST)
Date:   Mon, 12 Nov 2018 09:42:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/410] 3.16.57-rc1 review
Message-ID: <20181112174213.GA24055@roeck-us.net>
References: <lsq.1528380320.647747352@decadent.org.uk>
 <20180608141426.GA5242@roeck-us.net>
 <945ce3bb1ecd9c70249e79d2cb5572f9475c9786.camel@decadent.org.uk>
 <bf66aa7e856d4c2c83dc78dca95eee76437a1513.camel@decadent.org.uk>
 <20181111162343.GA15513@roeck-us.net>
 <20181111174853.l2ixlz7rmh7lsfye@decadent.org.uk>
 <dc0f4758889a7b6bddbab2443712159f7027b42f.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0f4758889a7b6bddbab2443712159f7027b42f.camel@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 07:20:37PM +0000, Ben Hutchings wrote:
> On Sun, 2018-11-11 at 17:48 +0000, Ben Hutchings wrote:
> > On Sun, Nov 11, 2018 at 08:23:43AM -0800, Guenter Roeck wrote:
> [...]
> > > I re-enabled it, but now it fails. Let me know if you want to try to fix
> > > it. Probably something with out-of-tree build - I didn't try to find
> > > the reason.
> > 
> > Thanks.  I can reproduce the failure when building in Debian unstable,
> > and am working through fixing the problems.
> 
> I fixed most of them.  Two of the problems still (potentially) exist in
> mainline so I'll send patches for those and wait for those to come back
> to stable.
> 
> In the mean time, please can you build perf with WERROR=0?
> 

Done. It still fails to build, though (SYS_futex undeclared).

Thanks,
Guenter
