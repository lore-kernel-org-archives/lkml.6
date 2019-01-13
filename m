Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C03C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58842089F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sToe6NVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfAMMeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 07:34:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38205 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfAMMeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 07:34:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so8881112plb.5;
        Sun, 13 Jan 2019 04:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vkY6g5Vqw/ZcPB3+ASMRoGn4tKrtMQnoGHCgEri+h4c=;
        b=sToe6NVOVkEom92efLv70SEU3rada5B2vsTWOSDUDI5zIPuhy+TyYWwbw/QeR7iK8p
         JH1OMPXX+8xzNEHKc/FbZ8Vt8fGYSX0ikWz9rsOCTF7jiqV8NsDzolK9LtTxSGx0BiSD
         kRX+h2ecEb2zS++ct7GSBZ54MCFLGuO14LnFSVTlt6FyTqGVBAkaXoPSu6yL23tluq+A
         uCHqKKy8yggrNWTArhtIjBiKsn3FSvsnQcBppJahmNkOSXO8/icjgQjAsoG8uyLNyt0u
         d+0uqQfEVJIeQ4tbUnOi2Yyk2FfNoZ22BKSb7+982GNPiLnKTCinugbLcP2eoDOtjuAB
         1q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vkY6g5Vqw/ZcPB3+ASMRoGn4tKrtMQnoGHCgEri+h4c=;
        b=mSo8QapHr+dO7AP9qwIlP/FFgOD+uT99YyIjaESHBGFg6NooYI273ZZbamV40xHXwJ
         1aGMCI6cteWwHs7gjYTJULnzUUY38Pxel6OrzRkexFzU5Kvtw7kyALckYpZ+7Jh1vfuv
         GuPvN40x5DU09oQ2B5dKQJFtFNewUVLLrgfK8Qd3t+OzE/G+MoAFb6c8xxes+3Z3kwYD
         JWrg33BPgNc/N/pgCMSDN00jqF7UbYJGUwqnv9W0jIub6pABKJJPNYP3/0u/Rfe9oBXi
         CTLyGS2e9XzOnRdTgGiIDIqW9uGlQZpqnhwvwlAFSl6oh94AlOD9BlSxdbmpRIbJeqQJ
         quDg==
X-Gm-Message-State: AJcUukfmIW3prVi2XZwi7Sg415km7bqurv9o4A7csmRtZN3PfXkHbVwD
        pVzmFyYrBynO7VbiOUIhfII=
X-Google-Smtp-Source: ALg8bN4dB+C4g9JtLNHp7SyR95TpouuAZTp6SiLy1woSWmhuEb4R+8Lg6NDJC27Mbg+ReF4SMETS/A==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr21488290plk.206.1547382840505;
        Sun, 13 Jan 2019 04:34:00 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id r4sm165801214pgn.54.2019.01.13.04.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 04:33:59 -0800 (PST)
Date:   Sun, 13 Jan 2019 23:33:56 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
        Torsten Duwe <duwe@lst.de>, live-patching@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190113123356.GA26056@350D>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <20190112010914.GB10427@350D>
 <20190112084541.GK14180@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112084541.GK14180@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 02:45:41AM -0600, Segher Boessenkool wrote:
> On Sat, Jan 12, 2019 at 12:09:14PM +1100, Balbir Singh wrote:
> > Could you please define interesting frame on top a bit more? Usually
> > the topmost return address is in LR
> 
> There is no reliable way (other than DWARF unwind info) to find out where
> the value of LR at function entry currently lives (if anywhere). It may or
> may not be still available in LR, it may or may not be saved to the return
> stack slot.  It can also live in some GPR, or in some other stack slot.
> 
> (The same is true for all other registers).
> 
> The only thing the ABI guarantees you is that you can find all stack frames
> via the back chain.  If you want more you can use some heuristics and do
> some heroics (like GDB does), but this is not fully reliable.  Using DWARF
> unwind info is, but that requires big tables.
>

Thanks, so are you suggesting that a reliable stack is not possible on
ppc64le? Even with the restricted scope of the kernel?

Balbir Singh.
 
