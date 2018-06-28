Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7152B26FB9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7152B26FB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeF1GjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:39:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751986AbeF1GjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:39:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA9528A3AB;
        Thu, 28 Jun 2018 06:39:05 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D211111166F1;
        Thu, 28 Jun 2018 06:39:04 +0000 (UTC)
Date:   Thu, 28 Jun 2018 14:39:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 4/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
Message-ID: <20180628063901.GA32539@MiWiFi-R3L-srv>
References: <20180627013116.12411-1-bhe@redhat.com>
 <20180627013116.12411-5-bhe@redhat.com>
 <CAGM2reaWkmCF_DWY1jETsC=NOPC7TGFq3VX06YrTDLAp+X2+AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reaWkmCF_DWY1jETsC=NOPC7TGFq3VX06YrTDLAp+X2+AQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 06:39:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 06:39:05 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/18 at 11:19pm, Pavel Tatashin wrote:
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Please remove duplicated signed-off

Done.
> 
> >                 if (!usemap) {
> >                         ms->section_mem_map = 0;
> > +                       nr_consumed_maps++;
> 
> Currently, we do not set ms->section_mem_map to 0 when fail to
> allocate usemap, only when fail to allocate mmap we set
> section_mem_map to 0. I think this is an existing bug.

Yes, found it when changing code. Later in sparse_init(), added checking
to see if usemap is available, otherwise also do "ms->section_mem_map = 0;"
to clear its ->section_mem_map.

Here if want to be perfect, we may need to free the relevant memmap
because usemap is allocated together, memmap could be allocated one
section by one section. I didn't do that because usemap allocation is
smaller one, if that allocation even failed in this early system
initializaiton stage, the kernel won't live long, so don't bother to do
that to complicate code.

> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
