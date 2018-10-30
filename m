Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B3BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 04:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DEF20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 04:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VWJ1l5om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DEF20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeJ3NN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 09:13:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45789 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJ3NN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 09:13:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id v5-v6so219979pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4jXXzVbPuBFxgplT4LBRp5GdysgWjVTyeB8ThEmzvW4=;
        b=VWJ1l5om1ERziWeGsmJ7MaBXXay7voyff65DvkFjFXdwZkokWwdhuK+h+EU//cKBuW
         u9ud29iYZ4B6PlOvRfd3mLL7hQidwbL8T0VO2+q0MDC7pHOByPgyJIAl6BwuBXQnnCff
         51TTmuNLKIRZfpOQPlWCafnuNwVxALPShnoJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4jXXzVbPuBFxgplT4LBRp5GdysgWjVTyeB8ThEmzvW4=;
        b=q48wlXLLcitfUsR7CBo6oRxenPxSvc8+5+JPjr+0/Hl3UaK7PpqVOJat7mM0wnHqqp
         cpFIAC2CY6bu8pFZLqfil8PF9Y+mnte7DP8/T+yv+GMSBdTY+G3NpWYvYwk7yFUB+xTP
         /TJ4XHSBZwxINcDSJhdDsgJZ/gGT/h5ix+N9+yo6r5FMsxCco4VaU/050zK1j3jMxn6B
         SZ4XhJCULzH4a6bSNpzYuwT2qfMNukssmPuywy19N6iWII5Kpnkb/u0c8QthPLD1dy5P
         VEdxJBjuinsufKk+6ARBsXqKzUih/T7AMkDt381I1aX2ALkhrSRZd85Z9IvLj6u+UMH/
         8tSA==
X-Gm-Message-State: AGRZ1gI/Uuw6lQX2NvsQOc67k7Z3F+Z8Mi/5J/Sa+9o7XsyNNjmK3FJ+
        ONWnMYtfStII2CdykbWw67VDYA==
X-Google-Smtp-Source: AJdET5dmuKL+hP4W/yM1w8cJCtZCf1UhwIUD4OtTS0x5zuznohGyxvaddS+aefqES7v/KyiBdkDjDg==
X-Received: by 2002:a63:6883:: with SMTP id d125-v6mr16465789pgc.451.1540873330942;
        Mon, 29 Oct 2018 21:22:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id h14-v6sm26377897pfn.80.2018.10.29.21.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 21:22:09 -0700 (PDT)
Date:   Mon, 29 Oct 2018 21:22:08 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peng15 Wang =?utf-8?B?546L6bmP?= <wangpeng15@xiaomi.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] pstore: Avoid duplicate call of persistent_ram_zap()
Message-ID: <20181030042208.GB224709@google.com>
References: <1540645734426.61104@xiaomi.com>
 <CAGXu5jJ_Xsf6KGpDCt5yvdwST9smutdwEeh3eRgj0zEmjz8zKg@mail.gmail.com>
 <1540795068068.62079@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540795068068.62079@xiaomi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:37:53AM +0000, Peng15 Wang 王鹏 wrote:
> 
> ________________________________________
> >From: Kees Cook <keescook@chromium.org>
> >Sent: Monday, October 29, 2018 0:03
> >To: Peng15 Wang 王鹏
> >Cc: anton@enomsg.org; ccross@android.com; tony.luck@intel.com; linux-kernel@vger.kernel.org; Joel Fernandes
> >Subject: Re: [PATCH v2] pstore: Avoid duplicate call of persistent_ram_zap()
> >
> >On Sat, Oct 27, 2018 at 2:08 PM, Peng15 Wang 王鹏 <wangpeng15@xiaomi.com> wrote:
> >> When initialing prz with invalid data in buffer(no PERSISTENT_RAM_SIG),
> >> function call path is like this:
> >>
> >> ramoops_init_prz ->
> >> |
> >> |-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
> >> |
> >> |-> persistent_ram_zap
> >>
> >> As we can see, persistent_ram_zap() is called twice.
> >> We can avoid this by adding an option to persistent_ram_new(), and
> >> only call persistent_ram_zap() when it is needed.
> >>
> >> Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>
> >> ---
> >>  fs/pstore/ram.c            |  5 +++--
> >>  fs/pstore/ram_core.c       | 11 +++++++----
> >>  include/linux/pstore_ram.h |  3 ++-
> >>  3 files changed, 12 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> >> index ffcff6516e89..3044274de2f0 100644
> >> --- a/fs/pstore/ram.c
> >> +++ b/fs/pstore/ram.c
> >> @@ -596,7 +596,8 @@ static int ramoops_init_przs(const char *name,
> >>                                           name, i, *cnt - 1);
> >>                 prz_ar[i] = persistent_ram_new(*paddr, zone_sz, sig,
> >>                                                &cxt->ecc_info,
> >> -                                              cxt->memtype, flags, label);
> >> +                                              cxt->memtype, flags,
> >> +                                              label, true);
> >>                 if (IS_ERR(prz_ar[i])) {
> >>                         err = PTR_ERR(prz_ar[i]);
> >>                         dev_err(dev, "failed to request %s mem region (0x%zx@0x%llx): %d\n",
> >> @@ -640,7 +641,7 @@ static int ramoops_init_prz(const char *name,
> >>
> >>         label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
> >>         *prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
> >> -                                 cxt->memtype, 0, label);
> >> +                                 cxt->memtype, 0, label, false);
> >>         if (IS_ERR(*prz)) {
> >>                 int err = PTR_ERR(*prz);
> >>
> >> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> >> index 12e21f789194..d8a520c8741c 100644
> >> --- a/fs/pstore/ram_core.c
> >> +++ b/fs/pstore/ram_core.c
> >> @@ -486,7 +486,8 @@ static int persistent_ram_buffer_map(phys_addr_t start, phys_addr_t size,
> >>  }
> >>
> >>  static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
> >> -                                   struct persistent_ram_ecc_info *ecc_info)
> >> +                                   struct persistent_ram_ecc_info *ecc_info,
> >> +                                   bool zap_option)
> >>  {
> >>         int ret;
> >>
> >> @@ -514,7 +515,8 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 >sig,
> >>
> >>         /* Rewind missing or invalid memory area. */
> >>         prz->buffer->sig = sig;
> >> -       persistent_ram_zap(prz);
> >> +       if (zap_option)
> >> +               persistent_ram_zap(prz);
> >
> >This part of persistent_ram_post_init() handles the "invalid buffer"
> >case, which should always zap. The question is whether or not to zap
> >in the case of a valid buffer (the "return 0" earlier in the
> >function). I think you v2 patch needs similar changes found in your
> >v1: the v2 patch also needs to remove the "return 0" and replace it
> >with "zap_option = true;" and to remove the zap call from
> >ramoops_init_prz(). Then I think all the paths will be consolidated.
> 
> Thank you so much for the tips!
> 
> Furthermore,  we can make "zap_option" stand for whether its caller want to zap in case of
> a valid buffer. So ramoops_init_przs() would say "false", and ramoops_init_prz() would 
> say "true".
> 
> In persistent_ram_post_init(), if zap_option says "false", we return immediately after 
> persistent_ram_save_old(), otherwise persistent_ram_zap would be called at the end.

Can you not just add it to the flags, something like PRZ_ZAP_NEW, and set
that flag before calling ramoops_init_prz*, then check the flag in
persistent_ram_new? We are already passing flags to persistent_ram_new.

That way no new function arguments are needed and its simple.

 - Joel

