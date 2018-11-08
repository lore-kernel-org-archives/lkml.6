Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC62C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F92920857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyNmEKPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F92920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeKHQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:06:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39843 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeKHQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:06:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so67009wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 22:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WgOTYrkLHLDooVEAZtekcVaQ4/yUv6V5aUr70mncajc=;
        b=TyNmEKPYPj8HETvfuEA0EVz1wVF+q6uzfGcel54IF7iipdfHhBl8vvi8d1POJPayuV
         6NzaiLftsKAJM36VX/+n3GQ7V1B6Y/PpwKlblJHlyXgWNpSJkI/o4eczfWLtzv+OR48d
         OM0hlfBMuNdMLRU0wJzmV1I0P8APfIbXU64rkqW4/PH8WuFrXVpv56ktROo63mbAfRSe
         fCXGTpq+XJ+3XABMEcFUJCzyOJZ/1RoxqAYUFkZK9av46/iid4v6L1eC/Cm3FlD7VpBR
         NcrCEQCLYmcOQrjeth1A/R+N+xvTdg5eQ4IJ/z5hKwc+lAo4DIbwlpkeFez4IfS5f5bY
         y2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WgOTYrkLHLDooVEAZtekcVaQ4/yUv6V5aUr70mncajc=;
        b=Zv7gCDCchyjeVPE2TLpNxE5avypQc26b1R1EswSeH9CZ5ZXPIB/8JE77tTdlWvjCxZ
         KaPvT1tlcv3HDlT0y1bJItY7gYo0ZazkzuRz2XalM1wfEBuaXgT2UShdHZnhFvHwey6d
         fJ5EzwpqPlE+bVDY7Cv29FJzNUAg87cS6qbzEiKqswVFqWctEWBGkattwICRcSYH5hLX
         Q3Jt8+ooxqb7RmXPK5x76t+ZiMB8YFIIzznDGTYwei1rx8KXyRVWZfDegm2NzBs1HIIi
         KfxoUuE0vXZ4CtbfQ/wwoDw5fIINHhFq5PKiuCBB0ucrucEl1d+KoNt/c36TzVniu7Zx
         Cjng==
X-Gm-Message-State: AGRZ1gJwss3ao0QOppoNl1COKomniDMwIacayEfE+/zPPLXvAiLQbv/J
        lmBXHDwTokYq1KP5yscmbo8=
X-Google-Smtp-Source: AJdET5cT2ConZcuhEHo7M+hRIhnFJkMcSMgWgec3oo2XJgYRXAHHbj6sXcsTCoJ3LnB9tNH1+74sXw==
X-Received: by 2002:a1c:9b4e:: with SMTP id d75-v6mr41878wme.62.1541658769514;
        Wed, 07 Nov 2018 22:32:49 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h189-v6sm6364232wma.10.2018.11.07.22.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 22:32:48 -0800 (PST)
Date:   Thu, 8 Nov 2018 07:32:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com, ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v1 2/2] proc: add /proc/<pid>/thread_state
Message-ID: <20181108063246.GA13233@gmail.com>
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
 <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aubrey Li <aubrey.li@intel.com> wrote:

> Expose the per-task cpu specific thread state value, it's helpful
> for userland to classify and schedule the tasks by different policies

That's pretty vague - what exactly would use this information? I'm sure 
you have a usecase in mind - could you please describe it?

Thanks,

	Ingo
