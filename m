Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7DAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449B321473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nl+DZ+H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449B321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeHTIp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 04:45:59 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:34978 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeHTIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 04:45:58 -0400
Received: by mail-yb0-f180.google.com with SMTP id o17-v6so4152435yba.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 22:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jm9CuLkMEOV/PYXkQGMa+owebHiME2v/oGmdWcKd0yM=;
        b=nl+DZ+H6UkRmmCKqupvTgotgh762sNoBQ5lzxNCTOCsc+QjaXZlfwchgMof08WV2j5
         DCCv+Qet7ymfd5EvLCVtM0QKkcEh+tWR/ZnwyJiSLcaBUaSFKEEpz/WVF+1ujN7VeqnO
         7AZw8UJTVPWfnXZq39y2WbcaT9poTGgegErbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jm9CuLkMEOV/PYXkQGMa+owebHiME2v/oGmdWcKd0yM=;
        b=LjOQdDPFKqztlcnl86D3zdG48daXmMLxDbkGUD67GVQStXRAwGox+WamxZE9EZ8mNU
         T0aTFHBKxfGtwT+DeIHC6Mw++2lg8ku3aKOcaMqOB+Ze5fRfEul4mGn/Kf0ysXJntVwa
         IQcsg3sHtOQgYMad+i+Q1qdJSWqYhm+U8EfQ70aOHBLXHxjmQM2ohXrenOutaDZLPT/S
         oPF1ivoBtvPMGQg3vbmsKfEeQjQ0gCzS66y/m9u819HOaFfqN4ipEe0CcOzOscoTYzgi
         s+3OCFKE0l2mTRo4WQWat6GSrEmnoh5UOLwdXfm9OnUiRw+DCQeLrbwFkDxLZw9RpALZ
         OH0g==
X-Gm-Message-State: AOUpUlEnYiyGcOswNwXb9bSGJNtguKQNUlUa3Bl84Y/KzHu6tIWBuK0O
        u7OrRamVciS0gVxdmQbUE3/HdFqsdw4=
X-Google-Smtp-Source: AA+uWPxT99PEAQixoNPjhwY5Akd/WgPrpN1Eu5BGkwaCoAMsDOud/FJp+g34vYWWc36BrfiB0jxHBw==
X-Received: by 2002:a25:3554:: with SMTP id c81-v6mr25098281yba.179.1534743106789;
        Sun, 19 Aug 2018 22:31:46 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id c69-v6sm1679476ywb.11.2018.08.19.22.31.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 22:31:45 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id w76-v6so6423834ywg.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 22:31:45 -0700 (PDT)
X-Received: by 2002:a81:357:: with SMTP id 84-v6mr24784862ywd.47.1534743105133;
 Sun, 19 Aug 2018 22:31:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:aa31:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 22:31:44
 -0700 (PDT)
In-Reply-To: <20180820005204.GB31827@shao2-debian>
References: <20180820005204.GB31827@shao2-debian>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 19 Aug 2018 22:31:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLHq_i-w2Tc75hkzV1VMO45vGyxsP=+670PLTiGEG7Acg@mail.gmail.com>
Message-ID: <CAGXu5jLHq_i-w2Tc75hkzV1VMO45vGyxsP=+670PLTiGEG7Acg@mail.gmail.com>
Subject: Re: [LKP] ab9ee8e38b [ 22.890412] WARNING: CPU: 0 PID: 632 at
 mm/usercopy.c:81 usercopy_warn
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     David Windsor <dave@nullcore.net>, linux-sctp@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 5:52 PM, kernel test robot
<rong.a.chen@intel.com> wrote:
> [   22.855033] Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected to SLUB object 'SCTP' (offset 1332, size 4)!

For this .config, pahole reports 1332 as the offset of the whitelist,
so I'm not sure what's happening here. It's as if no whitelist was
used when building the cache?

I'm still trying to build a reproducers...

-Kees

-- 
Kees Cook
Pixel Security
