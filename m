Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBEFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C4F2089C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C4F2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbeGYSfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:35:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:58085 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728741AbeGYSfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:35:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 10:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,401,1526367600"; 
   d="scan'208";a="59425294"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2018 10:23:16 -0700
Date:   Wed, 25 Jul 2018 11:23:16 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.cz, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, colyli@suse.de,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH v2 0/6] kaddr and pfn can be NULL to ->direct_access()
Message-ID: <20180725172316.GA12896@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Huaisheng Ye <yehs2007@zoho.com>, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com,
        jack@suse.cz, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chengnt@lenovo.com, colyli@suse.de, Huaisheng Ye <yehs1@lenovo.com>
References: <20180725162849.8320-1-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725162849.8320-1-yehs2007@zoho.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:28:43AM +0800, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Changes since v1 [1]:
> * Involve the previous patches for pfn can be NULL.
> * Reword the patch descriptions according to Christian's comment.
> * According to Ross's suggestion, replace local pointer dummy_addr
>   with NULL within md/dm-writecache for direct_access.
> 
> [1]: https://lkml.org/lkml/2018/7/24/199
> 
> Some functions within fs/dax, dax/super and md/dm-writecache don't
> need to get local pointer kaddr or variable pfn from direct_access.
> Assigning NULL to kaddr or pfn to ->direct_access() is more
> straightforward and simple than offering a useless local pointer or
> variable.
> 
> So all ->direct_access() need to check the validity of pointer kaddr
> and pfn for NULL assignment. If either of them is equal to NULL, that
> is to say callers may have no need for kaddr or pfn, so this series of
> patch are prepared for allowing them to pass in NULL instead of having
> to pass in a local pointer or variable that they then just throw away.

Looks good.  For the series:

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
