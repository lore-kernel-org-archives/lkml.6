Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC40C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFE82082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFE82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbeKXPxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 10:53:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37930 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbeKXPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 10:53:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so11412929plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 21:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T6o2ZOefdkebaJ3ynEiSkJQZyoh7QZLnbEBnOHULnns=;
        b=fFcubSiXM4HoFSnwH2Ks+D7eogXglAjVpcuyZj/KCpg5JFS4NxnNRIDMqwTerxf/wL
         tJp07hDRXcs0HiWQ5vgIWQk6x0FxGUkF/hBE+GbHLbfQ2/GNKSm+cNrIAfsmIyhMbD1k
         ZMsbHSDrFdqDHgJs/ypyw9rG4MJyoVtHA4YBkISHjAXRB+ne7ue/C7d+yoU7Xwv2tjNk
         SwALrmgWGi3gQQ5ri0+mUNZgzctGKTFHNsRXXaWWpDB38BkxpEj09OVcDs6Okr02Dcnx
         olifRKqbP68lG+fUmMbNF6lLyu8+xAHVP2iRADT/me6bmlnXkFonZYkw3j4Hxm/HSnbX
         7llA==
X-Gm-Message-State: AA+aEWbvQU5L5p+UnWoQ5N2d/5kXP0amKiIVoQFaVVwkfQjjB//kP2d5
        AQSoot4t9b44888wxpmJJpqwTpOS
X-Google-Smtp-Source: AFSGD/UG77QtvGGCXhUm9XA2so1aG+NoWgKkousuniOy3ROgIwKof8h3Clxq1RmiAFHP1k7Gxr33Fg==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr18946552plu.127.1543036005669;
        Fri, 23 Nov 2018 21:06:45 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id c20sm9878762pfc.92.2018.11.23.21.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 21:06:44 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 23 Nov 2018 21:06:41 -0800
Date:   Fri, 23 Nov 2018 21:06:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: test_kmod: BUG on module removal
Message-ID: <20181124050641.GG4922@garbanzo.do-not-panic.com>
References: <70765c55-7da9-c91c-ff20-3c915bc7ded1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70765c55-7da9-c91c-ff20-3c915bc7ded1@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 10:59:46AM -0700, Randy Dunlap wrote:
> 4.19-rc7, on x86_64:
> 
> modprobe test_kmod; rmmod test_kmod
> 
> [  199.033143] calling  test_kmod_init+0x0/0x1000 [test_kmod] @ 1704
> [  199.034636] misc test_kmod0: interface ready
> [  199.035468] initcall test_kmod_init+0x0/0x1000 [test_kmod] returned 0 after 1210 usecs
> [  206.597737] misc test_kmod0: Ending request_module() tests
> [  206.598698] misc test_kmod0: removing interface
> [  206.600052] BUG: unable to handle kernel paging request at ffffe150a6032048
> [  206.601224] PGD 0 P4D 0 
> [  206.601642] Oops: 0000 [#1] PREEMPT SMP PTI
> [  206.602309] CPU: 3 PID: 1707 Comm: rmmod Not tainted 4.19.0-rc7mod #2
> [  206.603479] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
> [  206.604899] RIP: 0010:kfree+0x43/0x180

Thanks, I've fixed this, and sent a patch.

  Luis
