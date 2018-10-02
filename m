Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8BAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D0820666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D0820666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeJBVgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:36:46 -0400
Received: from a3.inai.de ([88.198.85.195]:34280 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:36:46 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id AE7233BACCDC; Tue,  2 Oct 2018 16:52:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id A27303BACCD0;
        Tue,  2 Oct 2018 16:52:56 +0200 (CEST)
Date:   Tue, 2 Oct 2018 16:52:56 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     David Howells <dhowells@redhat.com>
cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] UAPI: bcache: Fix use of embedded flexible array
In-Reply-To: <153616290368.23468.7806230605345568524.stgit@warthog.procyon.org.uk>
Message-ID: <nycvar.YFH.7.76.1810021622320.11696@n3.vanv.qr>
References: <153616290368.23468.7806230605345568524.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Sep 2018 16:55:03 +0100, David Howells wrote:
>
>The bkey struct defined by bcache is embedded in the jset struct. However,
>this is illegal in C++ as there's a "flexible array" at the end of the struct.
>Change this to be a 0-length struct instead.
>
>-	__u64	ptr[];
>+	__u64	ptr[0];

As per the C++ standard, it is _also_ illegal to declare an array of size zero.

"""it [the array size expression] shall be a converted constant expression of
type std::size_t and its value shall be greater than zero."""
—http://eel.is/c++draft/dcl.array

That makes both "__u64 ptr[]" and "__u64 ptr[0]" *implementation-specific
extensions*.


3rd party tooling (concerns both C and C++):

Coverity Scan (IIRC) treats "__u64 ptr[0]" as an array of "definitely-zero"
size. Writing to any element will outright flag an out-of-bounds violation.
That is sensible, since only "ptr[]" was standardized.


Conclusion:

So please, do never use __u64 ptr[0].
