Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD1C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08523DCD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE08523DCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeGDUmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:42:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37586 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbeGDUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:42:39 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so219779plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 13:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6qIl3+wIe6l9iYsf32mSb7g8nXOt0C2OgSXeoi4wXM=;
        b=pOFyuTEU/iRkzxY2zJjH8FY3nYPszvVzVfuy+BjMZRFPRWhYQKTXIv1rYObgWJ2jbh
         9wESIUuOC0zFvq5+rcaI1OPjtLyL/cCAHoWl5Z0vyqdmkONtq57IS3kLjcJST1Mr5Z0q
         BMvXrBszu0a1TvyhINTwsORDsgCOdiuSFCAEal0jr3JJvWogn5lFBzW0MGXeeF40w9bn
         cdTTVpzxhck7EhmxVqj+2sk3d+M+hytB4f1Ppf/gEfmZeK7WtoVEhlKln1bpUuvop1Bb
         iSFG4DOM3aSIZXEA4do0//yfnKjBaTqtwG31fGjpVuIq6V0PjxuuaQVzem5fBk4tqilT
         vqaQ==
X-Gm-Message-State: APt69E3S9KrNf8fQyYEuAU8dbYGCO0zRxkkQ9KvLS2JVb4dxIM0x3rcB
        ztWjL5CE7twPlAH8A5XwtcwFkA==
X-Google-Smtp-Source: AAOMgpfrp/SMyT22s9+xVgqAwKpl+PXW1ZrjKyPYMcIlUE8Hqghs6qgJlLpewIDxQy9EWR2GUOyQ+g==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr3537680plo.100.1530736959019;
        Wed, 04 Jul 2018 13:42:39 -0700 (PDT)
Received: from trogon.sfo.coreos.systems ([2604:2000:80c5:4400:140c:73de:b623:c90])
        by smtp.gmail.com with ESMTPSA id k13-v6sm14361567pfg.130.2018.07.04.13.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 13:42:38 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:42:33 -0400
From:   Benjamin Gilbert <bgilbert@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Gabriel C <nix.or.die@gmail.com>, linux-x86_64@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180704204233.GA23570@trogon.sfo.coreos.systems>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 06:08:57PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jul 03, 2018 at 05:21:50PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Jul 03, 2018 at 03:44:03PM +0300, Kirill A. Shutemov wrote:
> > > On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> > > > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > > > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > > > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> > > > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> > > > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> > > > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> > > > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> > > > >> config for reference, and am happy to test patches, provide sample QCOW
> > > > >> images, etc.
> > > > >
> > > > 
> > > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> > > > 
> > > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> > > > too with the same symptoms
> > > 
> > > I tracked it down to -flto in LDFLAGS. I'll look more into this.
> > 
> > -flto in LDFLAGS screws up this part of paging_prepare():
> 
> I've got it wrong. *Any* LDFLAGS option passed to make this way:
> 
>   make LDFLAGS="..."
> 
> would cause a issue. Even empty.
> 
> It overrides all assignments to the variable in the makefile.
> As result the image is built without -pie and linker doesn't generate
> position independed code.
> 
> Looks like the patch below helps, but my make-fu is poor.

Sure enough, we're passing LDFLAGS="" to make.  Your patch fixes the boot
failure for me.

--Benjamin Gilbert
