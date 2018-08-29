Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0CAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B6D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwPnDdaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B6D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeH2HkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeH2HkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:40:09 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7667220850
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535514323;
        bh=cDs/n96Euvj3q36LKroQWZbUZzRHi//KYTsGwjyu8+Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=uwPnDdaQa4fLKZ23/yR9/hF9e40U4CgfcgTyxfIoSJpczbC/j53vhl6mb9T1d0Ije
         NPt+WyHC8WMCay6BkfMJB2eBTk5X/cv1nvBSIEHsDcPi+arxKPY6e5cxjcDod4qqpq
         c2UrTVg97vY5KWFWw4mDSUIRM6jzRjV3zx8cTbPM=
Received: by mail-wr1-f44.google.com with SMTP id v16-v6so3354016wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 20:45:23 -0700 (PDT)
X-Gm-Message-State: APzg51AK1VLICKLXR+z2EhDIgTF7260SfjZzAYbM1T3rfjeburCKLCLu
        Gz3wRtCvJLNNaofumx8ccKoK1heeGAKRXaMwu5J3PA==
X-Google-Smtp-Source: ANB0Vdas1RjfAgksA1CwsMij1PsV/Dsw38sYyontBkRtFI7kGSjuf28oj7+8MoVpJgUWp4s99aT4t3cNNKj++iWPtM8=
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr3007415wrm.21.1535514322006;
 Tue, 28 Aug 2018 20:45:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 20:45:01 -0700 (PDT)
In-Reply-To: <8F811430-A9D5-446C-9D6A-C4CA82555559@gmail.com>
References: <8F811430-A9D5-446C-9D6A-C4CA82555559@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 Aug 2018 20:45:01 -0700
X-Gmail-Original-Message-ID: <CALCETrWy3v-DiCNJs=wkym_q4U07-mtmEqy1YgMvAJ8AOT8MJQ@mail.gmail.com>
Message-ID: <CALCETrWy3v-DiCNJs=wkym_q4U07-mtmEqy1YgMvAJ8AOT8MJQ@mail.gmail.com>
Subject: Re: Flushing user entries for kernel mappings in x86
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 6:46 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> Hello Andy,
>
> Is there a reason for __flush_tlb_one_kernel() to flush the PTE not only in
> the kernel address space, but also in the user one (as part of
> __flush_tlb_one_user)? [ I obviously regard the case when PTI is on ].

In most cases, probably not, but it's fairly cheap, I think.  And it
makes it so that we're okay if the TLB entry we're flushing is used by
the entry code.
