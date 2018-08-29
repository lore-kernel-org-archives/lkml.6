Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD452064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD452064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeH2VCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:02:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727856AbeH2VCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:02:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 851708076895;
        Wed, 29 Aug 2018 17:04:40 +0000 (UTC)
Received: from redhat.com (ovpn-126-69.rdu2.redhat.com [10.10.126.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 827B72026D6D;
        Wed, 29 Aug 2018 17:04:36 +0000 (UTC)
Date:   Wed, 29 Aug 2018 13:04:35 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, david@redhat.com,
        jonathan.cameron@huawei.com, Pavel.Tatashin@microsoft.com,
        yasu.isimatu@gmail.com, logang@deltatee.com, dave.jiang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC v2 0/2] Do not touch pages in remove_memory path
Message-ID: <20180829170434.GA3784@redhat.com>
References: <20180817154127.28602-1-osalvador@techadventures.net>
 <20180828114709.GA13859@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828114709.GA13859@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 17:04:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 17:04:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:47:09PM +0200, Oscar Salvador wrote:
> On Fri, Aug 17, 2018 at 05:41:25PM +0200, Oscar Salvador wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> [...]
> > 
> > The main difficulty I faced here was in regard of HMM/devm, as it really handles
> > the hot-add/remove memory particulary, and what is more important,
> > also the resources.
> > 
> > I really scratched my head for ideas about how to handle this case, and
> > after some fails I came up with the idea that we could check for the
> > res->flags.
> > 
> > Memory resources that goes through the "official" memory-hotplug channels
> > have the IORESOURCE_SYSTEM_RAM flag.
> > This flag is made of (IORESOURCE_MEM|IORESOURCE_SYSRAM).
> > 
> > HMM/devm, on the other hand, request and release the resources
> > through devm_request_mem_region/devm_release_mem_region, and 
> > these resources do not contain the IORESOURCE_SYSRAM flag.
> > 
> > So what I ended up doing is to check for IORESOURCE_SYSRAM
> > in release_mem_region_adjustable.
> > If we see that a resource does not have such a flag, we know that
> > we are dealing with a resource coming from HMM/devm, and so,
> > we do not need to do anything as HMM/dev will take care of that part.
> > 
> 
> Jerome/Dan, now that the merge window is closed, and before sending the RFCv3, could you please check
> this and see if you see something that is flagrant wrong? (about devm/HMM)
> 
> If you prefer I can send v3 spliting up even more.
> Maybe this will ease the review.
> 

This looks good to me you can add Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
