Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A707FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC1E20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC1E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeINQVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:21:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbeINQVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:21:07 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95A2981DE9;
        Fri, 14 Sep 2018 11:07:07 +0000 (UTC)
Received: from ws.net.home (ovpn-117-57.ams2.redhat.com [10.36.117.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB6D1308BE75;
        Fri, 14 Sep 2018 11:07:05 +0000 (UTC)
Date:   Fri, 14 Sep 2018 13:07:03 +0200
From:   "kzak@redhat.com" <kzak@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Eugene Korenevsky' <ekorenevsky@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2] efi: take size of partition entry from GPT header
Message-ID: <20180914110703.ishvqwcpcf5ozihy@ws.net.home>
References: <20180911161527.GA30689@vnote>
 <20180912083844.iegei2kobcz4b7ag@ws.net.home>
 <6d349d22d37041c1a2942d8ed4c76b69@AcuMS.aculab.com>
 <CAJC2YLaug4=7otnRC7x+UdDp=5ErgJFHFL_7mjRO7sdM2CrUfQ@mail.gmail.com>
 <2db38b2d1af34ab9b653c665d08872f1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db38b2d1af34ab9b653c665d08872f1@AcuMS.aculab.com>
User-Agent: NeoMutt/20170912-66-504cd9
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 14 Sep 2018 11:07:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 09:01:48AM +0000, David Laight wrote:
> From: Eugene Korenevsky
> > Sent: 13 September 2018 20:48
> > 
> > > I suspect you also need a sanity check that the value isn't too small
> > > or stupidly large.
> > 
> > What would be the criterion for too large entries?
> 
> Anything larger than the maximum size of the full GPT table
> would be a start.
> Even something like 64k would stop later calculations going wrong.
> I presume there is a check elsewhere that the GPT table entries
> are all inside the disk area that was read?

is_gpt_valid() already contains 

        pt_size = (u64)le32_to_cpu((*gpt)->num_partition_entries) *
                le32_to_cpu((*gpt)->sizeof_partition_entry);
        if (pt_size > KMALLOC_MAX_SIZE)
                pr_debug("GUID Partition Table is too large: %llu > %lu bytes\n",
                (unsigned long long)pt_size, KMALLOC_MAX_SIZE);
                goto fail;
        }      

I guess it good enough for sanity check.

If you want to be really paranoid than you can also check that array
is possible to store to the expected area on the disk:

    pt_size <= (gpt->first_usable_lba - gpt->partition_entry_lba)

Note that is_gpt_valid() already compares the another LBAs with the 
device size to be sure GPT is no out of reality...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
