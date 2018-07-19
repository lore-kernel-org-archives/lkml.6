Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07826ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61F22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61F22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeGSNlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:41:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730521AbeGSNlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:41:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A3CF40201CA;
        Thu, 19 Jul 2018 12:58:02 +0000 (UTC)
Received: from doriath (ovpn-116-197.phx2.redhat.com [10.3.116.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FEC82026D6B;
        Thu, 19 Jul 2018 12:57:57 +0000 (UTC)
Date:   Thu, 19 Jul 2018 08:57:56 -0400
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>, kwolf@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org,
        david@redhat.com, ross zwisler <ross.zwisler@intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        hch@infradead.org, imammedo@redhat.com, mst@redhat.com,
        niteshnarayanlal@hotmail.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, nilal@redhat.com
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
Message-ID: <20180719085756.1b1f9678@doriath>
In-Reply-To: <20180719084819.730b7971@doriath>
References: <20180713075232.9575-1-pagupta@redhat.com>
        <20180713075232.9575-4-pagupta@redhat.com>
        <20180718085529.133a0a22@doriath>
        <367397176.52317488.1531979293251.JavaMail.zimbra@redhat.com>
        <20180719121635.GA28107@stefanha-x1.localdomain>
        <20180719084819.730b7971@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 19 Jul 2018 12:58:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 19 Jul 2018 12:58:02 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lcapitulino@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 08:48:19 -0400
Luiz Capitulino <lcapitulino@redhat.com> wrote:

> > It will be necessary to define specific constants for virtio-pmem
> > instead of passing errno from the host to guest.  
> 
> Yes, defining your own constants work. But I think the only fsync()
> error that will make sense for the guest is EIO. The other errors
> only make sense for the host.

Just to clarify: of course you'll return an error to guest on any
fsync() error. But maybe you should always return EIO even if the error
was EBADF for example. Or just signal the error with some constant,
and let the guest implementation pick any errno it prefers (this was
my first suggestion).
