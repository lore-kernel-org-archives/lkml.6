Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE39C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2088A2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2088A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJKUht convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeJKUht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DBD43002F45;
        Thu, 11 Oct 2018 13:10:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCA2B60191;
        Thu, 11 Oct 2018 13:10:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c7af263d-f265-7feb-8d40-0b0d773f24bf@gmail.com>
References: <c7af263d-f265-7feb-8d40-0b0d773f24bf@gmail.com> <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk> <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com> <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com> <16207.1539249451@warthog.procyon.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Thu, 11 Oct 2018 14:10:39 +0100
Message-ID: <10422.1539263439@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 11 Oct 2018 13:10:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> It sounds like you're under-estimating how we can use mnt_ns->seq (as is
> currently used in mnt_ns_loop()).  Or maybe I am over-estimating it :).

I don't see how it helps.  The duplication and attachment of the nsfs object
is already done by open_tree(), but as it's a detached tree, there are no
namespace assignments on the objects therein.  move_mount() is attaching the
subtree as a whole.

I modified my example to put everything under /a, setting up initially on /a/x
and then moving to /a/y within the namespace.  Then I made it print the mount
tree in more places.  So after setup, I see:

	[root@andromeda x]# findmnt -R /a
	TARGET                          SOURCE
	/a                              none
	\_/a/x                          none
	  \_/a/x/private_mnt            xxx
	    \_/a/x/private_mnt/child_ns nsfs[mnt:[4026532272]]

this looks fine.  Then I do:

	~/open_tree 3</a/x/private_mnt 3 \
	    nsenter --mount=/a/x/private_mnt/child_ns \
	    sh -c 'findmnt -R /a; ~/move_mount 4</a/y; findmnt -R /a'

and I see:

	TARGET               SOURCE
	/a                   none
	\_/a/x               none
	  \_/a/x/private_mnt xxx
	TARGET               SOURCE
	/a                   none
	|_/a/x               none
	| \_/a/x/private_mnt xxx
	\_/a/y               xxx
	  \_/a/y/child_ns    nsfs[mnt:[4026532272]]

in which /a/x/private_mnt got cloned and the clone mounted on "/a/y".

So, you're right, it's nothing to do with propagation.  But I'm not sure how I
check this.  Reject it in move_mount() if there's an nsfs?  I'm not sure if
the seq number is actually useful here.

David
