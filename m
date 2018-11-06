Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CDDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850E02083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850E02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbeKGHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:18:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56612 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeKGHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:18:42 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F827A48;
        Tue,  6 Nov 2018 21:51:23 +0000 (UTC)
Date:   Tue, 6 Nov 2018 13:51:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     miles.chen@mediatek.com, Michal Hocko <mhocko@suse.com>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
Message-Id: <20181106135121.dd015f188709c4ccb2bff52c@linux-foundation.org>
In-Reply-To: <FD1082D9-916E-47A4-95D3-59F308AD6D55@oracle.com>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
        <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
        <FD1082D9-916E-47A4-95D3-59F308AD6D55@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 18:41:33 -0600 William Kucharski <william.kucharski@oracle.com> wrote:

> 
> 
> > On Nov 1, 2018, at 3:47 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > -	count = count > PAGE_SIZE ? PAGE_SIZE : count;
> > +	count = min_t(size_t, count, PAGE_SIZE);
> > 	kbuf = kmalloc(count, GFP_KERNEL);
> > 	if (!kbuf)
> > 		return -ENOMEM;
> 
> Is the use of min_t vs. the C conditional mostly to be more self-documenting?

Yup.  It saves the reader from having to parse the code to figure out
"this is a min operation".

