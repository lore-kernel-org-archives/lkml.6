Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C0AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A2B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeLaRDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:03:54 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:51574 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeLaRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:03:53 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1ge0ye-0003Pl-NQ from joseph_myers@mentor.com ; Mon, 31 Dec 2018 09:03:44 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 31 Dec 2018 17:03:41 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1ge0ya-0007xD-Ke; Mon, 31 Dec 2018 17:03:40 +0000
Date:   Mon, 31 Dec 2018 17:03:40 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
CC:     Florian Weimer <fw@deneb.enyo.de>, <linux-fsdevel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>,
        <libc-alpha@sourceware.org>, <qemu-devel@nongnu.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>,
        <hpa@zytor.com>, <arnd@arndb.de>
Subject: Re: d_off field in struct dirent and 32-on-64 emulation
In-Reply-To: <ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org>
Message-ID: <alpine.DEB.2.21.1812311657050.27287@digraph.polyomino.org.uk>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de> <957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org> <87pntmu9iw.fsf@mid.deneb.enyo.de> <ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018, Adhemerval Zanella wrote:

> >> Currently we only have nios2 and csky (unfortunately).  But since generic 
> >> definition for off_t and off64_t still assumes non-LFS support, all new
> >> 32-bits ports potentially might carry the issue.
> > 
> > For csky, we could still change the type of the non-standard d_off
> > field to long long int.  This way, only telldir would have to fail
> > when truncation is necessary, as mentioned below:
> 
> I think it makes no sense to continue making non-LFS as default for
> newer 32 bits ports, the support will be emulated with LFS syscalls.

Any new 32-bit port that uses 64-bit time_t will also use 64-bit offsets 
(because we don't have any glibc configurations that support the 
combination of 64-bit time with 32-bit offsets, and don't want to add 
them).  That should apply for RISC-V 32-bit at least.

I've filed <https://sourceware.org/bugzilla/show_bug.cgi?id=24050> for 
missing overflow checks in telldir when the default off_t is wider than 
long int (currently just applies to x32; not sure why we don't see glibc 
test failures on x32 resulting from the quiet truncation, as the issue is 
certainly there in the source code).

-- 
Joseph S. Myers
joseph@codesourcery.com
