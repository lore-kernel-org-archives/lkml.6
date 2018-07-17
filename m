Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED10ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8848C208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8848C208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeGQHYr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:24:47 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:47493 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeGQHYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:24:47 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6H6rRPa010562
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 15:53:27 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H6rRoe012823;
        Tue, 17 Jul 2018 15:53:27 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H6rAqu031298;
        Tue, 17 Jul 2018 15:53:27 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-1989084; Tue, 17 Jul 2018 15:52:05 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Tue,
 17 Jul 2018 15:52:04 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Michal Hocko <mhocko@suse.com>, "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/13] mm, madvise_inject_error: Let memory_failure()
 optionally take a page reference
Thread-Topic: [PATCH v6 07/13] mm, madvise_inject_error: Let
 memory_failure() optionally take a page reference
Thread-Index: AQHUGy+MPceVQOK8wkK6AOOqXfBixqSSaBaA
Date:   Tue, 17 Jul 2018 06:52:03 +0000
Message-ID: <20180717065203.GA28797@hori1.linux.bs1.fc.nec.co.jp>
References: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153154380652.34503.2174920161570183766.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153154380652.34503.2174920161570183766.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <AA720C8AA8CD424B8103DFFF1357E029@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:50:06PM -0700, Dan Williams wrote:
> The madvise_inject_error() routine uses get_user_pages() to lookup the
> pfn and other information for injected error, but it does not release
> that pin. The assumption is that failed pages should be taken out of
> circulation.
> 
> However, for dax mappings it is not possible to take pages out of
> circulation since they are 1:1 physically mapped as filesystem blocks,
> or device-dax capacity. They also typically represent persistent memory
> which has an error clearing capability.
> 
> In preparation for adding a special handler for dax mappings, shift the
> responsibility of taking the page reference to memory_failure(). I.e.
> drop the page reference and do not specify MF_COUNT_INCREASED to
> memory_failure().
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
