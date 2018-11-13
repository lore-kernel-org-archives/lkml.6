Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3954EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B3D224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B3D224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbeKMKRK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:17:10 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:54783 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbeKMKRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:17:09 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wAD0LCF3022885
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Nov 2018 09:21:12 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD0LCIu027544;
        Tue, 13 Nov 2018 09:21:12 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD0I6hT019581;
        Tue, 13 Nov 2018 09:21:12 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-5489556; Tue, 13 Nov 2018 09:16:54 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Tue,
 13 Nov 2018 09:16:54 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Laurent Dufour" <ldufour@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v1 02/11] mm: soft-offline: add missing error check
 of set_hwpoison_free_buddy_page()
Thread-Topic: [RFC][PATCH v1 02/11] mm: soft-offline: add missing error
 check of set_hwpoison_free_buddy_page()
Thread-Index: AQHUd/gZ2sDE1GCoJU27soosKuzRTKVGpOuAgAWgnwA=
Date:   Tue, 13 Nov 2018 00:16:53 +0000
Message-ID: <20181113001652.GA5945@hori1.linux.bs1.fc.nec.co.jp>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-3-git-send-email-n-horiguchi@ah.jp.nec.com>
 <9ea93154-4843-231d-d72b-bf12c8807c24@arm.com>
In-Reply-To: <9ea93154-4843-231d-d72b-bf12c8807c24@arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <E2D5FBA3152315409C8D6F7D836BBB31@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Fri, Nov 09, 2018 at 03:50:41PM +0530, Anshuman Khandual wrote:
> 
> 
> On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
> > set_hwpoison_free_buddy_page() could fail, then the target page is
> > finally not isolated, so it's better to report -EBUSY for userspace
> > to know the failure and chance of retry.
> > 
> 
> IIUC set_hwpoison_free_buddy_page() could only fail if the page is not
> free in the buddy. At least for soft_offline_huge_page() that wont be
> the case otherwise dissolve_free_huge_page() would have returned non
> zero -EBUSY. Is there any other reason set_hwpoison_free_buddy_page()
> would not succeed ?

There is a race window between page freeing (after successful soft-offline
-> page migration case) and the containment by set_hwpoison_free_buddy_page().
Or a target page can be allocated just after get_any_page() decided that
the target page is a free page.
So set_hwpoison_free_buddy_page() would safely fail in such cases.

Thanks,
Naoya Horiguchi

> 
> > And for consistency, this patch moves set_hwpoison_free_buddy_page()
> > in unmap_and_move() to __soft_offline_page().
> 
> Yeah this check should be handled in soft offline functions not inside
> migrations they trigger.
> 
