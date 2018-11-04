Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E367DECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08D720854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08D720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeKECb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:31:28 -0500
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:52723 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729332AbeKECb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:31:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 538E1100E86C2;
        Sun,  4 Nov 2018 17:15:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: son64_6ca1de553b91e
X-Filterd-Recvd-Size: 1773
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Nov 2018 17:15:46 +0000 (UTC)
Message-ID: <fd0ac892e8a290d808adb4ee025778660539afc6.camel@perches.com>
Subject: Re: may I ignore "net/core/rtnetlink.c:3156:1: warning: the frame
 size of 1280 bytes ..."?
From:   Joe Perches <joe@perches.com>
To:     Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
        netdev@vger.kernel.org, Kees Cook <kees.cook@canonical.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 04 Nov 2018 09:15:45 -0800
In-Reply-To: <0cfb892c-b358-4bd6-f7c9-071a0039bc71@gmx.de>
References: <0cfb892c-b358-4bd6-f7c9-071a0039bc71@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 17:14 +0100, Toralf Förster wrote:
> compiling recent kernel (4.18.x, 4.19.1) at my server I do still get :
> 
> 
> net/core/rtnetlink.c: In function ‘rtnl_newlink’:
> net/core/rtnetlink.c:3156:1: warning: the frame size of 1280 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> 
> with "gcc version 7.3.0 (Gentoo Hardened 7.3.0-r3 p1.4) " and do wonder whether it is safe to ignore it?
> 

This was introduce by a desire to eliminate variable length array
declarations by

commit ccf8dbcd062a930e64741c939ca784d15316aa0c
Author: Kees Cook <
keescook@chromium.org>
Date:   Wed May 30 15:20:52 2018 -0700

    rtnetlink: Remove VLA usage

It does make the stack use here unfortunately obviously large, but
it could have been this large, just unreported.

Perhaps no obvious solution here as an alloc instead of stack use
may be costly.

