Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B7DC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F07214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F07214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJJGoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:44:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeJJGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:44:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5898ACB;
        Tue,  9 Oct 2018 23:24:41 +0000 (UTC)
Date:   Tue, 9 Oct 2018 16:24:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-next@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [BUG -next 20181008] list corruption with
 "mm/slub: remove useless condition in deactivate_slab"
Message-Id: <20181009162440.d40400a42544aced64f28572@linux-foundation.org>
In-Reply-To: <20181009063500.GB3555@osiris>
References: <20181009063500.GB3555@osiris>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 08:35:00 +0200 Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> with linux-next for 20181008 I can reliably crash my system with lot's of
> debugging options enabled on s390. List debugging triggers the list
> corruption below, which I could bisect down to this commit:
> 
> fde06e07750477f049f12d7d471ffa505338a3e7 is the first bad commit
> commit fde06e07750477f049f12d7d471ffa505338a3e7
> Author: Pingfan Liu <kernelfans@gmail.com>
> Date:   Thu Oct 4 07:43:01 2018 +1000
> 
>     mm/slub: remove useless condition in deactivate_slab
> 
>     The var l should be used to reflect the original list, on which the page
>     should be.  But c->page is not on any list.  Furthermore, the current code
>     does not update the value of l.  Hence remove the related logic
> 
>     Link: http://lkml.kernel.org/r/1537941430-16217-1-git-send-email-kernelfans@gmail.com
>     Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>     Acked-by: Christoph Lameter <cl@linux.com>
>     Cc: Pekka Enberg <penberg@kernel.org>
>     Cc: David Rientjes <rientjes@google.com>
>     Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> list_add double add: new=000003d1029ecc08, prev=000000008ff846d0,next=000003d1029ecc08.
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:31!

Thanks much.  I'll drop
mm-slub-remove-useless-condition-in-deactivate_slab.patch.

