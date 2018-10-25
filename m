Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9575ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D62920831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D62920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeJYIbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYIbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:31:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D33AC05090A;
        Thu, 25 Oct 2018 00:01:29 +0000 (UTC)
Received: from agk-dp.fab.redhat.com (agk-dp.fab.redhat.com [10.33.15.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 274775D75D;
        Thu, 25 Oct 2018 00:01:25 +0000 (UTC)
Received: from agk by agk-dp.fab.redhat.com with local (Exim 4.69)
        (envelope-from <agk@redhat.com>)
        id 1gFT5X-00067Y-Qf; Thu, 25 Oct 2018 01:01:23 +0100
Date:   Thu, 25 Oct 2018 01:01:23 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Shaohua Li <shli@kernel.org>
Subject: Re: [dm-devel] [RFC] dm-bow working prototype
Message-ID: <20181025000123.GB22722@agk-dp.fab.redhat.com>
Mail-Followup-To: Paul Lawrence <paullawrence@google.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        linux-doc@vger.kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>
References: <20181023212358.60292-1-paullawrence@google.com> <20181023221819.GB17552@agk-dp.fab.redhat.com> <296148c2-f2d9-5818-ea76-d71a0d6f5cd4@google.com> <alpine.LRH.2.02.1810241514310.4080@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1810241514310.4080@file01.intranet.prod.int.rdu2.redhat.com>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
        03798903. Registered Office: Peninsular House, 30-36 Monument
        Street, 4th Floor, London, England, EC3R 8NB.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 25 Oct 2018 00:01:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 03:24:29PM -0400, Mikulas Patocka wrote:
> What about allocating a big file, using the FIEMAP ioctl to find the 

For reference, dmfilemapd in the lvm2 tree (in daemons/) uses FIEMAP
(in libdm/libdm-stats.c) for monitoring I/O by file.

> If you decide that rollback is no longer needed, you just unload the 
> snapshot target and delete the big file. If you decide that you want to 
> rollback, you can use the snapshot merge functionality (or you can write a 
> userspace utility that does offline merge).
 
There's some old code from Mark McLoughlin for userspace snapshot merging here:
  https://people.gnome.org/~markmc/code/merge-dm-snapshot.c

Alasdair

