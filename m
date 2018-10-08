Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7903C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B81C20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B81C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJHS0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:26:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeJHS0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C85FF83F3F;
        Mon,  8 Oct 2018 11:15:28 +0000 (UTC)
Received: from ws.net.home (ovpn-117-176.ams2.redhat.com [10.36.117.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C6F51057076;
        Mon,  8 Oct 2018 11:15:27 +0000 (UTC)
Date:   Mon, 8 Oct 2018 13:15:25 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Eugene Korenevsky <ekorenevsky@gmail.com>
Cc:     David.Laight@aculab.com, Davidlohr Bueso <dave@stgolabs.net>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2] efi: take size of partition entry from GPT header
Message-ID: <20181008111525.hm6jcnlsf7xrjre3@ws.net.home>
References: <20180911161527.GA30689@vnote>
 <20180912083844.iegei2kobcz4b7ag@ws.net.home>
 <6d349d22d37041c1a2942d8ed4c76b69@AcuMS.aculab.com>
 <CAJC2YLaug4=7otnRC7x+UdDp=5ErgJFHFL_7mjRO7sdM2CrUfQ@mail.gmail.com>
 <2db38b2d1af34ab9b653c665d08872f1@AcuMS.aculab.com>
 <20180914110703.ishvqwcpcf5ozihy@ws.net.home>
 <CAJC2YLYqb6WB43P5pJe=D7GXgUY16PS=QLVJbD8=qEH=aB9qvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJC2YLYqb6WB43P5pJe=D7GXgUY16PS=QLVJbD8=qEH=aB9qvg@mail.gmail.com>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 08 Oct 2018 11:15:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 09:41:27PM +0300, Eugene Korenevsky wrote:
> > is_gpt_valid() already contains
> >         pt_size = (u64)le32_to_cpu((*gpt)->num_partition_entries) *
> >                 le32_to_cpu((*gpt)->sizeof_partition_entry);
> >         if (pt_size > KMALLOC_MAX_SIZE)
> >                 pr_debug("GUID Partition Table is too large: %llu > %lu bytes\n",
> >                 (unsigned long long)pt_size, KMALLOC_MAX_SIZE);
> >                 goto fail;
> >         }
> > I guess it good enough for sanity check.
> >
> > If you want to be really paranoid than you can also check that array
> > is possible to store to the expected area on the disk:
> >
> >     pt_size <= (gpt->first_usable_lba - gpt->partition_entry_lba)
> >
> 
> Well, we should apply several checks for different cases:
> - primary GPT: table entries should not override gpt->first_usable_lba

 and gpt->last_usable_lba

> - alternate GPT, table entries BEFORE agpt (agpt->partition_entry_lba
> < agpt_lba): table entries should not override agpt_lba AND
> agpt->partition_entry_lba MUST BE more than agpt->last_usable_lba
> - alternate GPT, table entries AFTER agpt (agpt->partition_entry_lba >
> agpt_lba): table entries should not override the end of the disk
> 
> Is this correct?

Yes, the table defines range for all partitions (last and first usable
LBA). All partition table stuff (label and partitions array) has to be
outside this area and partitions have to point to this area.

                   
 | label | entries |    partitioned area   | backup-entries | backup-label |
 
                   ^                       ^
             first_usable_lba        last_usable_lba


and it's possible and valid if there is gap between entries array and 
first usable LBA (you can use this unused place to hide same data :-) 
And vice-versa for backup entries and last usable LBA. 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
