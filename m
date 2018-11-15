Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051F121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hjA2tUOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051F121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeKOM0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:26:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33124 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeKOM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:26:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id w22-v6so8716981plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 18:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HTm2lBGyWs58fjKz8LORX/2WDmcLYfZ5cup1ucTDGVA=;
        b=hjA2tUOxyaWihydcZ5uryvNPT2ezsqrGEsqcNi7K3zjLy/EaD3TJlVq80E2/i06lyd
         QyRKdDz6oL4Cy88f95PHnsrz2BP0F6iWDx2ZGAZUmttLvQMKlVAGnn8yIr7BsQjffmba
         gYm7WcZJWfEkO1tRNCIYy8FNNLfasWQcMjVlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HTm2lBGyWs58fjKz8LORX/2WDmcLYfZ5cup1ucTDGVA=;
        b=cYr3wcNbPSIAYqFu6RtjEP5duF4Z3eY6Yx/rORDbbMsRWYZkf0iPzqTuD0KhrthHqO
         hTTLsw7Zg1NxflTm3tD0LD44avLWaAFbhjg+k/YYBqEACrWKUiLJKquzep2Jt1QlZRW7
         Rp0nFYzN2MdFFObg2KMAsgM3X6e5TLc+VPfaNOf6TYC+gt6RrT20Gez/amSJOJxyY4Ys
         IEa3ZpXDavPwcJaleKrCzQG5yKHUpPN5NtjAONo2f8z4BFF/f/q+1fHp9BgoAlyLLCsw
         tys7KZIEwSLuVHnbdYLMUIgoF5bTTU5Pn7tKUPbwouBdRjZ6IyfvHfvj1j9Dz/AtkcO0
         b+Qw==
X-Gm-Message-State: AGRZ1gKZSWMxEdPf6X2UZvM1Mfq+DyENF5kr9OO9sAvJjIJaalU5upEl
        LJxmc2kwKZaiH9g/+5jgu2TW0g==
X-Google-Smtp-Source: AJdET5e58pSVd/XWIIrjdv4rmWeIbIkr6HGXAhLNTY0vTDeSgi2OaDv0mr5cA6z/Ka9zF8uibGzY1Q==
X-Received: by 2002:a17:902:d806:: with SMTP id a6mr4246194plz.172.1542248425360;
        Wed, 14 Nov 2018 18:20:25 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z127-v6sm24389356pfz.135.2018.11.14.18.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 18:20:24 -0800 (PST)
Date:   Wed, 14 Nov 2018 18:20:23 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH RFC v2 0/3] cleanups for pstore and ramoops
Message-ID: <20181115022023.GC242356@google.com>
References: <20181103233818.44615-1-joel@joelfernandes.org>
 <CAGXu5jJ3s=pXGaEVLycdV6TYScUmPqhChNBS92j2qUxct2+ZrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ3s=pXGaEVLycdV6TYScUmPqhChNBS92j2qUxct2+ZrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 01:14:57AM -0600, Kees Cook wrote:
> On Sat, Nov 3, 2018 at 6:38 PM, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > Here are some simple cleanups and fixes for ramoops in pstore. Let me know
> > what you think, thanks.
> 
> I took these and slightly tweaked code locations for the first one.
> I'll send out the series for review when I'm back from Plumber's.

Cool, thanks!

 - Joel

