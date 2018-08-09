Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF5C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFF721EF8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SMpLycfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFF721EF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeHJAea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:34:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33242 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHJAe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:34:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so3504286pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=E8lMEHHp1XpQp1GSl3+driojV4qNti5pVY7ThXl0HL8=;
        b=SMpLycfInSV/+Xtp7t8X+4nXWpZiNGqHDrwNX2WouIfeJZthF0Y1/Z8xeWg8rWx+Ck
         mK4NJcyd9yhKzysCN+exB3hEyDCmtIGh478Ruh+nzDKwSEofFg3chwaOt7RuEb/20xIY
         OdY3mDsOB1JQuvHWmzwcRw6GKfgEU/rF7TbGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=E8lMEHHp1XpQp1GSl3+driojV4qNti5pVY7ThXl0HL8=;
        b=T/c8fK+WBatur54p+j6LiUTg3zcekcC8gnVzB0YMqqc4GhCyyLGkpTAB0wLXB+jC3x
         keQ+lU19VyAZqZuH6tY1LXi0qkyKOoKqQbUC8QDK/juIG4mlWOF7QH0s8rjGS2y8BTWP
         TUDvLCsaKndOOTABylL7HJtc3+ojmmXE2FY3zR9BKBgjCLTj9s/iNXXsujTHhNdx2PXh
         pYknHwb0oFJLacj38Vb23HsuFoUeXegcFjhVVhkUq/KEd3mohVSY9y330ixRg89fqeXl
         qVaggsEixbMyMRvWL8ysqmQQ4QRSAq3tOul6uOetvJo+pzYaAXZCqgdjydVnPid06WOh
         ovSQ==
X-Gm-Message-State: AOUpUlE808XVYnPcfwLitgEHrr+iCsX7tQiacz5nXnXFz045AXU+/z+4
        dN1EhuojVKUN6HLyDNAYm0HFvZ5/xyySQQ==
X-Google-Smtp-Source: AA+uWPyExkL8k1i5+4KCZFel1Ys8EDX+8A3dVM0HlNwDAHHLshKhFPhHJKwlBGnksyLEUn7+kqqrKg==
X-Received: by 2002:aa7:8118:: with SMTP id b24-v6mr4153885pfi.78.1533852459332;
        Thu, 09 Aug 2018 15:07:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id r81-v6sm12244041pfa.18.2018.08.09.15.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 15:07:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Aaron Durbin <adurbin@chromium.org>,
        Julius Werner <jwerner@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAODwPW8x=ghbVpo4q48jh-xGScP+2O_Vt7LTtSqhLvAAnCVXuA@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-6-swboyd@chromium.org>
 <CAODwPW8x=ghbVpo4q48jh-xGScP+2O_Vt7LTtSqhLvAAnCVXuA@mail.gmail.com>
Message-ID: <153385245791.220756.10097093170204882190@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 5/7] firmware: coreboot: Remap RAM with memremap() instead of
 ioremap()
Date:   Thu, 09 Aug 2018 15:07:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2018-08-09 11:24:29)
> One thing to note is that we still want this space to be mappable by
> userspace applications via /dev/mem, so we need to make sure that
> there's no weird memory type mismatch that causes problems with that.
> Adding Aaron to see if he has any concerns here, since I think he's
> seen something like that in the past (not sure if it was related to
> what this kernel driver does).
> =

> Can you please test this on an x86 Chromebook and run the 'cbmem'
> userspace utility, make sure it doesn't fail after this?

Sure!

> =

> Also, stupid question after taking a step back and looking at this
> again: why do we keep a mapping alive for the lifetime of the driver
> at all? It used to be necessary when this driver was
> find-entry-on-demand, but nowadays it just goes through all entries
> once at probe time and immediately memcpy_fromio()s out all the
> relevant information into (struct coreboot_device)s. After that we're
> done accessing the "real" coreboot table, forever. Why not just unmap
> it again at the end of coreboot_table_init()?

Yes, we just copy everything over so it makes it simpler to just unmap
at the end of coreboot_table_init(). Then userspace is free to make a
questionable mapping into system RAM to find the table itself.

I'll make this change.

