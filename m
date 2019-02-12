Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C3FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C720700
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549961637;
	bh=G5bVZTqmi2e33Ig50TrLWrxU0vetepI/WBqpWKFaAls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PuGhZaLRL9U9OluBcUSbLGZrlN7xbDsGp968QFNgY3uls3LrPTLVjjfVkeGhSGgzb
	 qfZCK8Q+/HX9NWxHETa+604IQNFrX8gHn5Pqhngb785mb5RMpf83GvhYhYwxMklFix
	 1h49BIbMsvsUQUiybmSH6heuBPyRBPwO0dasDOLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfBLIxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:53:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46233 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfBLIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:53:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id v16so1472324ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EKvsYtgzxxN2IFq90tTBe+XystKVPP02/T9yj2UzJjs=;
        b=hg+WdV4nmFzdjWQu3lzBhn3hkXXkNBlMvTIf9Nki9pZlvlIANBh5I6llJbkXLuLoXc
         l/N81jDjO12DsQrtNJpvhrynxU0z/plzBab2gnFnWzo0LwXRvTfcaQdONeDiO0Lrhcy2
         uPyUZJxVNyKE/iqzcxMZxoszN09wNr+3WTOgigH0geM6nfgG39W0HU1LWeGc9ZrnOTlP
         8jqPkSCLV4OiRqjgk1FL02u/z8VbKi/tCp0fejA0GFQH0dnWvJqwqb0z7tE1UacHWN5k
         5njtI2MwED5nVXv4NlNhVnviiUqodLUflrHrSnorCoYCs26TF0z90UPA68im4OYlZkmK
         ZIjw==
X-Gm-Message-State: AHQUAubBzVvEys0kJInFP9cfPvGHN+XxNq3Sdham4Vlpew8hRM3GO01A
        +vWy8NnqztPsNowxrHcvmPA=
X-Google-Smtp-Source: AHgI3IYlWrp1TuyBfHAGCvZqaIRtxwLnYnl0wM5o5uEkRIm0jo1bF3N/lpWfCak+oXcWA4dRnfx23g==
X-Received: by 2002:a2e:90ca:: with SMTP id o10-v6mr1621904ljg.134.1549961632951;
        Tue, 12 Feb 2019 00:53:52 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q6sm2803135lfh.52.2019.02.12.00.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 00:53:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gtTp3-0007O1-2c; Tue, 12 Feb 2019 09:53:45 +0100
Date:   Tue, 12 Feb 2019 09:53:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 5/5] riscv: use for_each_of_cpu_node iterator
Message-ID: <20190212085345.GA28278@localhost>
References: <20190118140308.9599-1-johan@kernel.org>
 <20190118140308.9599-6-johan@kernel.org>
 <20190212071339.GL26747@infradead.org>
 <20190212082621.GA26912@localhost>
 <6518a7ff-0586-be7a-4a43-6c9a35194a05@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6518a7ff-0586-be7a-4a43-6c9a35194a05@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:47:09AM -0800, Atish Patra wrote:
> On 2/12/19 12:26 AM, Johan Hovold wrote:
> > On Mon, Feb 11, 2019 at 11:13:39PM -0800, Christoph Hellwig wrote:
> >> On Fri, Jan 18, 2019 at 03:03:08PM +0100, Johan Hovold wrote:
> >>> Use the new for_each_of_cpu_node() helper to iterate over cpu nodes
> >>> instead of open coding. Note that this will allow matching also on the
> >>> node name instead of the (for FDT) deprecated device_type property.
> >>>
> >>> Signed-off-by: Johan Hovold <johan@kernel.org>
> >>
> >> I think this is going to conflict with the ELF caps changes from
> >> Atish.  Maybe the riscv_fill_hwcap hunk should be included in his
> >> patch?
> > 
> > Since that patch had some issues (e.g. the node reference underflow) it
> > may be better to rebase it on top of this series. The changes are
> > otherwise distinct after all.
> > 
> 
> I have fixed the node reference underflow issue and made some more 
> changes based on comments.
> 
> Some other patches(1,3,4,5) in this series may conflict with my series 
> as well. I can rebase my series on top of yours and send it as one 
> series if that's okay with you and Palmer.

No need for you to resend these patches as they are reviewed any ready
to be merged. Just rebase your series and mention the dependency in the
cover letter as I did with Andreas's patch which this series depended
on.

Thanks,
Johan
