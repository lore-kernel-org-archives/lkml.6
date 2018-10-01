Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF259C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A008B208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A008B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeJASTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbeJASTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:19:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE0BF300197E;
        Mon,  1 Oct 2018 11:41:50 +0000 (UTC)
Received: from work-vm (ovpn-117-221.ams2.redhat.com [10.36.117.221])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C15E60162;
        Mon,  1 Oct 2018 11:41:49 +0000 (UTC)
Date:   Mon, 1 Oct 2018 12:41:47 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Feng Li <lifeng1519@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        qemu-discuss@nongnu.org, qemu-devel@nongnu.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [Qemu-devel] virtio-console downgrade the virtio-pci-blk
 performance
Message-ID: <20181001114146.GA2508@work-vm>
References: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 01 Oct 2018 11:41:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Feng Li (lifeng1519@gmail.com) wrote:
> Hi,
> I found an obvious performance downgrade when virtio-console combined
> with virtio-pci-blk.
> 
> This phenomenon exists in nearly all Qemu versions and all Linux
> (CentOS7, Fedora 28, Ubuntu 18.04) distros.
> 
> This is a disk cmd:
> -drive file=iscsi://127.0.0.1:3260/iqn.2016-02.com.test:system:fl-iscsi/1,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native
> -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on
> 
> If I add "-device
> virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x5  ", the virtio
> disk 4k iops (randread/randwrite) would downgrade from 60k to 40k.
> 
> In VM, if I rmmod virtio-console, the performance will back to normal.
> 
> Any idea about this issue?
> 
> I don't know this is a qemu issue or kernel issue.

It sounds odd;  can you provide more details on:
  a) The benchmark you're using.
  b) the host and the guest config (number of cpus etc)
  c) Why are you running it with iscsi back to the same host - why not
     just simplify the test back to a simple file?

Dave

> 
> Thanks in advance.
> -- 
> Thanks and Best Regards,
> Alex
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
