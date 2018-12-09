Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB0BC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F3C2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3S94tZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F3C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeLIVj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:39:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37018 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIVj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:39:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so7887645edb.4;
        Sun, 09 Dec 2018 13:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uyTQPtdr4A9r4ZS9ejdDwDv7qvc9S6X+6S/2ik1R/lo=;
        b=B3S94tZ7y6ibRZWivqrtYxfDTov5hazUY1A1HFbIuRmqwYQjJwxKpuEa4CjrFAUmBM
         KH17EmkZByOKPqC7d32AKf91geP3R6xKbTt1z/pzIabU6JQKDywTFNQXoITrXMeWnOWW
         LOuc2xP5igt2i5Q53bpz2zRszpEvkiqN0y0MLDocqgVnlGQltaehdMPlB0OQ3XML0Bg0
         2qd4iiRhPCypZgBFUbiSvoPN9WS+2zGsFkBhTl7Zn5/rITSvCkYaDoTPcBer6MUhtXV+
         hmU4tgYhKDyyYEgsRCvyMU+Ojfn2y7idY8YxmenhQt2u9o9HBFZsxWHhi/5DciHOg7Gn
         aLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uyTQPtdr4A9r4ZS9ejdDwDv7qvc9S6X+6S/2ik1R/lo=;
        b=uWTU701i4AABSXZXpEEionuyah2Me27/9RebTt9I0rVdxjzai4w9JOZnkpzOkuyqFH
         geVXETmqTYYNQcSdLPIRGfuwfkchPi/V6gviBaVtCLNrgw0F3tXUftstjavBog8MzHAO
         dJwRuZMnPb5UdTIBKZSyk68fR0qzRBETfVMI5LR63saNQjG4PCiuYoXQF7dnGxPUiHwH
         Bm7uI57bp18EwcTU9KBq7699EY2K0/5zRIv7ZY2toHpryy7CH7UyhGFPMvZZ6/BEK9ax
         iU6TNvcT/OpXqXRvVt1ZtzbuXJrwMNvQYM8DT7S3I2vFDJ9SKmTEd6eZnKcFQKPWSDDI
         amew==
X-Gm-Message-State: AA+aEWYS0mGkkGfNByj8ju/fSfDZuFZsTPVev5SG3Tk1ibAAd2YEOTV9
        wxaFW4Ahx8mzr1/YVAikkXXHNpkM
X-Google-Smtp-Source: AFSGD/X4gXAPrn/4AmUbBtdcev6JgSp6rND9A7Qce4tnaElJ7TXGeNq831M0fweA0jfUh4eMAX6l6Q==
X-Received: by 2002:a17:906:4d41:: with SMTP id b1-v6mr7911326ejv.171.1544391594861;
        Sun, 09 Dec 2018 13:39:54 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:e8b1:47b5:cae1:da95])
        by smtp.gmail.com with ESMTPSA id w28sm2977744edd.38.2018.12.09.13.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 13:39:54 -0800 (PST)
Date:   Sun, 9 Dec 2018 22:39:52 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Message-ID: <20181209213951.kumz33u6prb2seqz@ltop.local>
References: <20181209204449.18906-1-tycho@tycho.ws>
 <20181209210220.GB2217@ZenIV.linux.org.uk>
 <20181209212523.GE30796@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209212523.GE30796@cisco>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 02:25:23PM -0700, Tycho Andersen wrote:
> Hi Al,
> 
> On Sun, Dec 09, 2018 at 09:02:21PM +0000, Al Viro wrote:
> > On Sun, Dec 09, 2018 at 01:44:49PM -0700, Tycho Andersen wrote:
> > > While working on some additional copy_to_user() checks for sparse, I
> > > noticed that sparse's current copy_to_user() checks are not triggered. This
> > > is because copy_to_user() is declared as __always_inline, and sparse
> > > specifically looks for a call instruction to copy_to_user() when it tries
> > > to apply the checks.
> > > 
> > > A quick fix is to explicitly not inline when __CHECKER__ is defined, so
> > > that sparse will be able to analyze all the copy_{to,from}_user calls.
> > > There may be some refactoring in sparse that we can do to fix this,
> > > although it's not immediately obvious to me how, hence the RFC-ness of this
> > > patch.
> > 
> > Which sparse checks do not trigger?  Explain, please - as it is, I had been
> > unable to guess what could "specifically looks for a call instruction" refer
> > to.
> 
> In sparse.c there's check_call_instruction(), which is triggered when
> there's an instruction of OP_CALL type in the basic block. This simply
> compares against the name of the call target to determine whether or
> not to call check_ctu().
> 
> I think what's happening here is that the call is getting inlined, and
> so the OP_CALL goes away, and check_call_instruction() never gets
> called.

Yes, it's what's happening.

There are several more or less bad/good solutions, like:
* add raw_copy_{to,from}_user() in the list of checked function
  (not inlined in most archs).
* add a new annotation to force sparse to check the byte count
  (I'm thinking about __range__/OP_RANGE or something similar).
* do these checks before functions are inlined (but then some
  constant count could not yet be seen as constant).
* ...

Wasn't there some plan to remove all these __always_inline
because of the future 'asm inline'?

-- Luc
