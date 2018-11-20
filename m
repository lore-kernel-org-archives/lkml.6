Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0DEC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC262075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC262075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeKTUF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:05:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbeKTUF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:05:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0ED87A7ED;
        Tue, 20 Nov 2018 09:37:17 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0FD74523;
        Tue, 20 Nov 2018 09:37:16 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A38E11800533;
        Tue, 20 Nov 2018 09:37:16 +0000 (UTC)
Date:   Tue, 20 Nov 2018 04:37:16 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devel@linuxdriverproject.org,
        linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Kairui Song <kasong@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1380154502.35259416.1542706636322.JavaMail.zimbra@redhat.com>
In-Reply-To: <6258a58b-28c7-c055-0752-e8bd085b835f@redhat.com>
References: <20181119101616.8901-1-david@redhat.com> <20181119101616.8901-6-david@redhat.com> <1747228.35250472.1542703532881.JavaMail.zimbra@redhat.com> <6258a58b-28c7-c055-0752-e8bd085b835f@redhat.com>
Subject: Re: [PATCH v1 5/8] hv_balloon: mark inflated pages PG_offline
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.119, 10.4.195.6]
Thread-Topic: hv_balloon: mark inflated pages PG_offline
Thread-Index: vwj8vPwTZelkM2IMC2vxi7m7cNxk+Q==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 20 Nov 2018 09:37:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >> ---
> >>  drivers/hv/hv_balloon.c | 14 ++++++++++++--
> >>  1 file changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> >> index 211f3fe3a038..47719862e57f 100644
> >> --- a/drivers/hv/hv_balloon.c
> >> +++ b/drivers/hv/hv_balloon.c
> >> @@ -681,8 +681,13 @@ static struct notifier_block hv_memory_nb = {
> >>  /* Check if the particular page is backed and can be onlined and online
> >>  it.
> >>  */
> >>  static void hv_page_online_one(struct hv_hotadd_state *has, struct page
> >>  *pg)
> >>  {
> >> -	if (!has_pfn_is_backed(has, page_to_pfn(pg)))
> >> +	if (!has_pfn_is_backed(has, page_to_pfn(pg))) {
> >> +		if (!PageOffline(pg))
> >> +			__SetPageOffline(pg);
> >>  		return;
> >> +	}
> >> +	if (PageOffline(pg))
> >> +		__ClearPageOffline(pg);
> >>  
> >>  	/* This frame is currently backed; online the page. */
> >>  	__online_page_set_limits(pg);
> >> @@ -1201,6 +1206,7 @@ static void free_balloon_pages(struct
> >> hv_dynmem_device
> >> *dm,
> >>  
> >>  	for (i = 0; i < num_pages; i++) {
> >>  		pg = pfn_to_page(i + start_frame);
> >> +		__ClearPageOffline(pg);
> > 
> > Just thinking, do we need to care for clearing PageOffline flag before
> > freeing
> > a balloon'd page?
> 
> Yes we have to otherwise the code will crash when trying to set PageBuddy.
> 
> (only one page type at a time may be set right now, and it makes sense.
> A page that is offline cannot e.g. be a buddy page)

o.k
> 
> So PageOffline is completely managed by the page owner.

Makes sense. Thanks for explaining.

Pankaj
> 
> > 
> > Thanks,
> > Pankaj
> 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
