Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D38C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F72077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3F72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeJKTmH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:42:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeJKTmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:42:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C061D30DF71F;
        Thu, 11 Oct 2018 12:15:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B0A88453C;
        Thu, 11 Oct 2018 12:15:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <16207.1539249451@warthog.procyon.org.uk>
References: <16207.1539249451@warthog.procyon.org.uk> <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk> <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com> <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6532.1539260096.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 11 Oct 2018 13:14:56 +0100
Message-ID: <6533.1539260096@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 11 Oct 2018 12:15:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> The reason that you can do this with open_tree()/move_mount() is that it
> allows you to create a mount tree (OPEN_TREE_CLONE) that has no namespace
> assignment, pass it through the namespace switch and then attach it inside the
> child namespace.  The cross-namespace checks in do_move_mount() are bypassed
> because the root of the newly-cloned mount tree doesn't have one.

It's worse than that.  The apparently disconnected tree given you by
open_tree(OPEN_TREE_CLONE) is still subject to modification by outside
forces.  All it takes is one shared object within that tree.

So I do wonder if it's possible to form a ring, even in an upstream kernel, by
using the propagation mechanism to push through an nsfs mount into itself,
possibly with a layer of indirection (ie. having two mutually-referential
namespaces).

David
