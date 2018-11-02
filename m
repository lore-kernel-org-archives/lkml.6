Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018CBC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDA920831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDA920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeKBJza convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:55:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbeKBJza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:55:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7959307D856;
        Fri,  2 Nov 2018 00:50:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F12925D6A6;
        Fri,  2 Nov 2018 00:50:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181102001633.GD24195@shao2-debian>
References: <20181102001633.GD24195@shao2-debian>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     dhowells@redhat.com, Leonard Crestez <leonard.crestez@nxp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] [sunrpc] 6a7da2a288: kernel_BUG_at_lib/iov_iter.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7957.1541119812.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 02 Nov 2018 00:50:12 +0000
Message-ID: <7958.1541119812@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Nov 2018 00:50:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <rong.a.chen@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 6a7da2a288ce412d7ac117a2912a7b0d9104ee6d ("[RFC] sunrpc: Fix flood of warnings from iov_iter_kvec in linux-next")
> url: https://github.com/0day-ci/linux/commits/Leonard-Crestez/sunrpc-Fix-flood-of-warnings-from-iov_iter_kvec-in-linux-next/20181101-070713
> base: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3 -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Ummm...  You can't just apply that commit to Trond's linux-next branch unless
that branch also includes the iov_iter changes from my afs-next branch.

Before those changes, ITER_KVEC is required:

	BUG_ON(!(direction & ITER_KVEC));

and after, it will be prohibited:

	WARN_ON(direction & ~(READ | WRITE));

The reason for this is that have yet more patches that split the direction
from the iov_iter::type member into their own member and turn the types into a
simple integer sequence instead of a bit mask.

David
