Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA42C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A152064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A152064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbeGXP5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:57:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:65101 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388564AbeGXP5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:57:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 07:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,398,1526367600"; 
   d="scan'208";a="60261576"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2018 07:50:13 -0700
Date:   Tue, 24 Jul 2018 08:50:13 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH 0/5] Do not request a pointer kaddr when not required
Message-ID: <20180724145013.GA19466@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Huaisheng Ye <yehs2007@zoho.com>, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724084510.6104-1-yehs2007@zoho.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 04:45:05PM +0800, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Some functions within fs/dax and dax/super don't need to get kaddr from
> direct_access. Assigning NULL to kaddr to ->direct_access() is more
> straightforward and simple than offering a useless local pointer.
> 
> So all direct_access() need to check the validity of second rank pointer
> kaddr for NULL assignment. If kaddr equals to NULL, it doesn't need to
> calculate its value.
> 
> * This series are supplement to [PATCH v2 00/14]mm: Asynchronous +
>   multithreaded memmap init for ZONE_DEVICE. [1]
> 
> [1]: https://lkml.org/lkml/2018/7/16/828

This whole series looks good to me.  Just a few comments:

1) Does this series actually depend on the "Asynchronous multithreaded mmap
init for ZONE_DEVICE" series from Dan?  It seems totally independent to me?
I reviewed yours by applying to linux/master, which worked fine.  I ask
because Dan's series has been delayed to after v4.19, and if yours isn't
actually dependent it could possibly go in sooner.

2) I agree with Christian's comment that the changelogs could be improved
slightly.  Remember that the goal of the changelog isn't to describe *what*
the code is doing, but *why*.  We can read that the code now checks if 'kaddr'
is NULL, and if so we don't calculate it.  It's useful to say that callers may
have no need for 'kaddr', so this patch is prep for allowing them to pass in
NULL instead of having to pass in a pointer that they then just throw away.

3) I think you should make one more change to kill the unused 'dummy_addr'
variable in persistent_memory_claim().  That was the one last case of a dummy
'kaddr' type variable that I could find.
