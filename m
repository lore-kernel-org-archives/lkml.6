Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DB1C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE2120673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e6Z0vEEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE2120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeGSPni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:43:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41124 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeGSPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:43:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so4001326pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I5Il+BDpYSOz95oOz36w4P1wpHZNzoyBlqztOSibsi0=;
        b=e6Z0vEExqzi01t1sLakJmuEMpe2gZMkyHaqXd6jTse5fQhhc7YG+U4EThNwIFhrjNS
         N7WwpTQDUPXQJ6xyYDSBJ7Iszn16zOSy4unXpuZOT0Gv6UO15lVNLwWEkBwxPmNdjX8v
         9Omb1OMt94VJ1cICRvK10hDDmF0VzYXJlSh/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I5Il+BDpYSOz95oOz36w4P1wpHZNzoyBlqztOSibsi0=;
        b=JG4+XVU+HOnItl6IhzIGkxOUj7WduQvZkPuSvp7jhR5k/M8pihnixdK8n8kIunYIT+
         zit08WCBtTApYOFrBN8FqysukouCao/GiDqXJWG+8qph+yYCPGgQ080hl5uU9PrBZhXV
         365z3fTbbP94wRn79MKEenC1ZkmSoPbB/A7T4/nXCZH1rJ53ZI/kq/aps5SNnNOMJgoQ
         cBt7FDBdkJY295pTdorrSvOCdC9+VHUXPxcMnvZAyhBiHKJpqedhpb4s247j99A5vhJI
         7c3/tR9glq+IVsL76p/9UQjA02OvgeuD/N2FnUUid5Qcb6MSBx6Ly85z3giYTP2+1e/h
         bhGA==
X-Gm-Message-State: AOUpUlFwKotMcrLyMCliVK1wieLbk2jMVeFtQI0DDW76/4SKDxvCcd4W
        v5iSb2rqSwyPti1MGHF34+UpIIx81d4=
X-Google-Smtp-Source: AAOMgpe36iOFZ1RxXUrtcP6c/1OKqNElSjUMZyngx0sBMmlKgqXDC2jO4FtMoUtsh1Uy5jtF5/P7UQ==
X-Received: by 2002:a63:ba10:: with SMTP id k16-v6mr10508828pgf.145.1532012403149;
        Thu, 19 Jul 2018 08:00:03 -0700 (PDT)
Received: from [192.168.1.180] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
        by smtp.gmail.com with ESMTPSA id t78-v6sm10238964pfa.160.2018.07.19.08.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:00:02 -0700 (PDT)
Subject: Re: [PATCH 0/4] Rework NVMe abort handling
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <d8da8faf-187e-6e19-7162-d6b5caddb563@broadcom.com>
Date:   Thu, 19 Jul 2018 08:00:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/2018 7:10 AM, Johannes Thumshirn wrote:
> On Thu, Jul 19, 2018 at 03:42:03PM +0200, Christoph Hellwig wrote:
>> Without even looking at the code yet:  why?  The nvme abort isn't
>> very useful, and due to the lack of ordering between different
>> queues almost harmful on fabrics.  What problem do you try to
>> solve?
> The problem I'm trying to solve here is really just single commands
> timing out because of i.e. a bad switch in between which causes frame
> loss somewhere.
>
> I know RDMA and FC are defined to be lossless but reality sometimes
> has a different view on this (can't talk too much for RDMA but I've
> had some nice bugs in SCSI due to faulty switches dropping odd
> frames).
>
> Of cause we can still do the big hammer if one command times out due
> to a misbehaving switch but we can also at least try to abort it. I
> know aborts are defined as best effort, but as we're in the error path
> anyways it doesn't hurt to at least try.
>
> This would give us a chance to recover from such situations, of cause
> given the target actually does something when receiving an abort.
>
> In the FC case we can even send an ABTS and try to abort the command
> on the FC side first, before doing it on NVMe. I'm not sure if we can
> do it on RDMA or PCIe as well.
>
> So the issue I'm trying to solve is easy, if one command times out for
> whatever reason, there's no need to go the big transport reset route
> before not even trying to recover from it. Possibly we should also try
> doing a queue reset if aborting failed before doing the transport
> reset.
>
> Byte,
> 	Johannes

I'm with Christoph.

It doesn't work that way... command delivery is very much tied to any 
command ordering delivery requirements as well as sqhd increment on the 
target, and response delivery is tied similarly tied to sqhd delivery to 
the host as well as ordering requirements on responses. With aborts as 
you're implementing, you drop those things.  Granted, Linux's lack of 
paying attention to SQHD (a problem waiting to happen in my mind) as 
well as not using fused commands (and no other commands yet requiring 
order) make it believe it can get away without it.

You're going to confuse transports as there's no understanding in the 
transport protocol on what it means to abort/cancel a single io.   The 
specs are rather clear, and for a good reason, that non-delivery (the 
abort or cancellation) mandates connection teardown which in turn 
mandates association teardown. You will be creating non-standard 
implementations that will fail interoperability and compliance.

If you really want single io abort - implement it in the NVMe standard 
way with Aborts to the admin queue, subject to the ACL limit.  Then push 
on the targets to support deep ACL counts and honestly responding to 
ABORT, and there will still be race conditions between the ABORT and its 
command that will make an interesting retry policy. Or, wait for Fred 
Knights, new proposal on ABORTS.

-- james


