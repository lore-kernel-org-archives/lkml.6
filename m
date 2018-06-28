Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C68C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DCC27305
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DCC27305
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeF1L5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:57:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753146AbeF1L5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:57:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 360DB8A3AB;
        Thu, 28 Jun 2018 11:57:52 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C774F1C4E7;
        Thu, 28 Jun 2018 11:57:50 +0000 (UTC)
Date:   Thu, 28 Jun 2018 13:57:48 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
Message-ID: <20180628115748.kprobde6c3joc6ll@kamzik.brq.redhat.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <cb057c6a-0eb4-581e-c259-7a31545e0ae7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb057c6a-0eb4-581e-c259-7a31545e0ae7@arm.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 11:57:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 11:57:52 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'drjones@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:38:24AM +0100, Sudeep Holla wrote:
> Hi Shunyong,
> 
> On 28/06/18 10:18, Shunyong Yang wrote:
> > As PPTT spec doesn't define the physical package id,
> > find_acpi_cpu_topology_package() will return offset of the node with
> > Physical package field set when querying physical package id. So, it
> > returns 162(0xA2) in following example.
> > 
> > [0A2h 0162   1]                Subtable Type : 00 [Processor Hierarchy
> > Node]
> > [0A3h 0163   1]                       Length : 1C
> > [0A4h 0164   2]                     Reserved : 0000
> > [0A6h 0166   4]        Flags (decoded below) : 00000003
> >                             Physical package : 1
> >                      ACPI Processor ID valid : 1
> > [0AAh 0170   4]                       Parent : 00000000
> > [0AEh 0174   4]            ACPI Processor ID : 00001000
> > [0B2h 0178   4]      Private Resource Number : 00000002
> > [0B6h 0182   4]             Private Resource : 0000006C
> > [0BAh 0186   4]             Private Resource : 00000084
> > 
> > So, when "cat physical_package" in /sys/devices/system/cpu/cpu0/topology/,
> > it will output 162(0xA2). And if some items are added before the node
> > above, the output will change to other value.
> > 
> > This patch maps the node offset to a logic package id. It maps the first
> > node offset to 0, the second to 1, and so on.
> > 
> > Then, it will not output a big value, such as 162 above. And it will
> > not change when some nodes(Physical package not set) are added.
> > 
> > And as long as the nodes with Physical package field set in PPTT keeps
> > the real hardware order, the logic id can map to hardware package id to
> > some extent.
> > 
> > Hope to get feedback from you.
> 
> Thanks for the patch, but Andrew Jones has also posted a patch[1] which
> I had a look but was not sure what is the best approach to fix it yet.
> I will think about it and respond to that.
>

I'll send a v1 yet today. The RFC version was actually OK, as the concern
with ACPI nodes not being in the expected order wasn't actually a problem.
The thread-id or core-id would only be reset to zero when a yet to be
remapped core-id (and all its peers) was found when iterating the PEs.
Since all peers were handled at the same time, the counter reset was
correct, even when the ACPI nodes were out-of-order. The code didn't make
that very obvious, though, and there was some room for other cleanups,
so I've reworked it. Once I run it through a couple more rounds of testing
I'll repost.

FYI, I'm able to easily test a variety of configs using a KVM guest and
this QEMU branch[*]. To use threads it's necessary to revert the last
QEMU patch and to hack KVM to set MPIDR.MT for the VCPUs.

Thanks,
drew

[*] https://github.com/rhdrjones/qemu/commits/virt-cpu-topology
