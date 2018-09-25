Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56FBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B25820671
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B25820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeIYR11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:27:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbeIYR11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:27:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C07A31500B4;
        Tue, 25 Sep 2018 11:20:23 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55AEB5C5E1;
        Tue, 25 Sep 2018 11:20:19 +0000 (UTC)
Date:   Tue, 25 Sep 2018 19:20:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lianbo Jiang <lijiang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, bp@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com
Subject: Re: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
Message-ID: <20180925112016.GZ2555@MiWiFi-R3L-srv>
References: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153782730364.130337.17794279728329113665.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180925085846.GY2555@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925085846.GY2555@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 25 Sep 2018 11:20:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/18 at 04:58pm, Baoquan He wrote:
> Hi Bjorn,
> 
> On 09/24/18 at 05:15pm, Bjorn Helgaas wrote:
> > @@ -359,32 +362,31 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
> >  	read_unlock(&resource_lock);
> >  	if (!p)
> >  		return -1;
> > +
> >  	/* copy data */
> > -	if (res->start < p->start)
> > -		res->start = p->start;
> > -	if (res->end > p->end)
> > -		res->end = p->end;
> > +	res->start = max(start, p->start);
> > +	res->end = min(end, p->end);
> >  	res->flags = p->flags;
> 
> I think this fix is good. However, is it OK to keep res->flags always,
> never touch it in find_next_iomem_res()? We just iterate and update
> region, its start and end. So just removing that "res->flags = p->flags;"
> line might involve much less code changes.

Rethink about it, I was wrong. Please ignore my comment.

