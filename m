Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3AAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B0F20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B0F20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbeHAQcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:32:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50666 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbeHAQcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:32:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fksNo-0008O9-85; Wed, 01 Aug 2018 14:45:48 +0000
Date:   Wed, 1 Aug 2018 15:45:48 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, arnd@arndb.de, sfr@canb.auug.org.au,
        nico@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: Can we fix samples/ dependency on headers please?
Message-ID: <20180801144548.GM30522@ZenIV.linux.org.uk>
References: <31061.1533131891@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31061.1533131891@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 02:58:11PM +0100, David Howells wrote:
> Hi,
> 
> I'm currently having to mark various userspace programs I've added to the
> samples/ directory as BROKEN in samples/Kconfig because the root Makefile
> mucks up the dependencies between building samples and headers_install.
> 
> The main culprit seems to be:
> 
> 	commit dd92478a15fa3bfd746ee08b4ef59401c1537804
> 	Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> 	Date:   Sun Feb 28 22:00:00 2016 -0500
> 	kbuild: build sample modules along with the rest of the kernel
>  
> which make the samples build in parallel with the build, thereby voiding the
> explicit dependency:
> 
> 	Documentation/ samples/: headers_install
> 
> and thereby breaking:
> 
> 	commit ddea05fa148b4d8e66498e522a616d87f9cf81e3
> 	Author: Arnd Bergmann <arnd@arndb.de>
> 	Date:   Mon Jul 4 16:39:35 2016 +0200
> 	kbuild: make samples depend on headers_install

Breaking a commit 4 months before its creation is quite a feat...  Said that,
something along the lines of Arnd's commit is needed (build of samples/*
should happen against the kernel-supplied headers; it certainly should not
depend upon having make headers_install done on the same tree in previous
build.  The problem, AFAICS, is that dependency is for explicit samples/ in
the target list, not samples/<anything> being added there.  Worse, by the
time we get to those, we don't see top-level Makefile targets, so e.g.
adding explict
$(obj)/.test-fsmount.cmd: headers_install
won't work...
