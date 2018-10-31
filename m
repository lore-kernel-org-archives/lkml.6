Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E3ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E77205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E77205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeJaXaD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbeJaXaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:30:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 752F788308;
        Wed, 31 Oct 2018 14:31:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F7BA5C1B2;
        Wed, 31 Oct 2018 14:31:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <8a65d1322e08b9590d18a53cd623f71b0fe559e8.1540989230.git.leonard.crestez@nxp.com>
References: <8a65d1322e08b9590d18a53cd623f71b0fe559e8.1540989230.git.leonard.crestez@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] sunrpc: Fix flood of warnings from iov_iter_kvec in linux-next
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23289.1540996303.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 31 Oct 2018 14:31:43 +0000
Message-ID: <23290.1540996303@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 31 Oct 2018 14:31:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leonard Crestez <leonard.crestez@nxp.com> wrote:

> Since commit aa563d7bca6e ("iov_iter: Separate type from direction and
> use accessor functions") the iov_iter_kvec and iov_iter_bvec functions
> warn if the direction parameter contains anything other than READ/WRITE.
> 
> That commit also updated users of iov_iter_kvec/bvec but a new call was
> added on a different branch by commit 277e4ab7d530 ("SUNRPC: Simplify
> TCP receive code by switching to using iterators")
> 
> This causes a flood of warnings in linux-next like this:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 110 at ../lib/iov_iter.c:1082 iov_iter_kvec+0x4c/0x5c
> Modules linked in:
> CPU: 0 PID: 110 Comm: kworker/u3:2 Tainted: G        W         4.19.0-next-20181031 #157
> Hardware name: Freescale i.MX6 SoloLite (Device Tree)
> Workqueue: xprtiod xs_stream_data_receive_workfn
> [<c0112908>] (unwind_backtrace) from [<c010d238>] (show_stack+0x10/0x14)
> [<c010d238>] (show_stack) from [<c0b3894c>] (dump_stack+0xb0/0xe8)
> [<c0b3894c>] (dump_stack) from [<c0126e14>] (__warn+0xe0/0x10c)
> [<c0126e14>] (__warn) from [<c0126f54>] (warn_slowpath_null+0x3c/0x48)
> [<c0126f54>] (warn_slowpath_null) from [<c04b225c>] (iov_iter_kvec+0x4c/0x5c)
> [<c04b225c>] (iov_iter_kvec) from [<c0a2c650>] (xs_stream_data_receive_workfn+0x538/0x8e0)
> [<c0a2c650>] (xs_stream_data_receive_workfn) from [<c014609c>] (process_one_work+0x2ac/0x6fc)
> [<c014609c>] (process_one_work) from [<c014678c>] (worker_thread+0x2a0/0x574)
> [<c014678c>] (worker_thread) from [<c014c43c>] (kthread+0x134/0x14c)
> [<c014c43c>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> Exception stack(0xec9fbfb0 to 0xec9fbff8)
> bfa0:                                     00000000 00000000 00000000 00000000
> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> irq event stamp: 91225
> hardirqs last  enabled at (91233): [<c0186630>] console_unlock+0x3e4/0x5d0
> hardirqs last disabled at (91250): [<c01862c8>] console_unlock+0x7c/0x5d0
> softirqs last  enabled at (91266): [<c0102500>] __do_softirq+0x360/0x524
> softirqs last disabled at (91277): [<c012e66c>] irq_exit+0xf8/0x1a4
> ---[ end trace bc12311e869d672a ]---
> 
> This fix updates sunrpc code and make nfs boot cleanly.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: David Howells <dhowells@redhat.com>
