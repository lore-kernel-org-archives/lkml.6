Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D85ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7228C20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0GQRoM/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7228C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbeGWMNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbeGWMNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:13:40 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0BD20846;
        Mon, 23 Jul 2018 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532344378;
        bh=53Bms48kLbc+Q2hZq9XbxepqTQh/eklUn7b6ooiplh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0GQRoM/Y7IQ7fhjc0Qsqud8ntt+Qju/XWKEhjbzXvyK08S7nIf1igRhneFlUERCup
         tax0/FIUAlLR8EQkElEUhNNK43pH2OGbZKdYxCplO/PIDUdx+YAMTSIrvNTTQ7whyX
         xjKTwhS2nmhFNPh+5TBnxCzz4NWUjomQhifTGyPo=
Date:   Mon, 23 Jul 2018 13:12:51 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Martijn Coenen <maco@android.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        linux-scsi@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Iliyan Malchev <malchev@google.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 2/6] module: add support for symbol namespaces.
Message-ID: <20180723111251.x2cam6bcuglr4hhz@linux-8ccs>
References: <20180716122125.175792-1-maco@android.com>
 <20180716122125.175792-3-maco@android.com>
 <20180719163208.5xvrafugpcbhh7kj@linux-8ccs>
 <CAB0TPYFVSWtJ6RPRUZ1bpS-rBaV7YyPR-4B2Ogxs+FNAbiScNw@mail.gmail.com>
 <20180720144916.fyqpmrtgt23sax6n@linux-8ccs>
 <CAB0TPYFQvkTsMvfJCTSFSJAoCbmOUJz7mCQGoORs6nRcC3Fhdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAB0TPYFQvkTsMvfJCTSFSJAoCbmOUJz7mCQGoORs6nRcC3Fhdg@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.11-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Martijn Coenen [20/07/18 17:42 +0200]:
>On Fri, Jul 20, 2018 at 4:49 PM, Jessica Yu <jeyu@kernel.org> wrote:
>> Thanks. Also, it looks like we're currently just warning (in both
>> modpost and on module load) if a module uses symbols from a namespace
>> it doesn't import. Are you also planning to eventually introduce
>> namespace enforcement?
>
>This is something I've definitely been thinking about, and was curious
>what others would think. My main concern with enforcement is that it
>will start failing to load out-of-tree modules that use newly
>namespaced symbols. On the other hand, I think those modules will need
>to be rebuilt anyway to be able to load, because the changes to struct
>kernel_symbol make them incompatible with the current kernel. That
>could be another reason for having these symbols in a special section
>(with its own struct namespaced_kernel_symbol); but on the other hand,
>it would make the module loader more complex just to facilitate
>out-of-tree drivers, and I'm not sure where the trade-off between
>those two falls.

IMO I don't think we should bend over backwards to accommodate
out-of-tree modules - modifying the module loader to recognize even
more special sections to accommodate these OOT modules would be where
we'd draw the line I think.

>> It'd be trivial to fail the module build in
>> modpost as well as reject the module on load if it uses an exported
>> symbol belonging to a namespace it doesn't import. Although, I'd go
>> with the warnings for a development cycle or two, to gently introduce
>> the change in API and let other subsystems as well as out-of-tree
>> module developers catch up.
>
>An approach like that makes sense to me. Another alternative would be
>to make it a CONFIG_ option, and let distros/etc. decide what they are
>comfortable with.

I think going forward I would prefer to have export namespaces to be a
normal and regular part of kernel API (as in, we shouldn't require a
new option for it), and that the warnings for 1-2 cycles are courteous
enough - but anyone with stronger opinions about this should speak up.

Thanks,

Jessica
