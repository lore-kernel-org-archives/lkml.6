Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D22ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D437520833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D437520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbeGTNWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:22:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728029AbeGTNWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:22:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8B6B40200AA;
        Fri, 20 Jul 2018 12:34:34 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F62C111AF1D;
        Fri, 20 Jul 2018 12:34:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v1 0/2] mm/kdump: exclude reserved pages in dumps
Date:   Fri, 20 Jul 2018 14:34:20 +0200
Message-Id: <20180720123422.10127-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 12:34:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 12:34:34 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dumping tools (like makedumpfile) right now don't exclude reserved pages.
So reserved pages might be access by dump tools although nobody except
the owner should touch them.

This is relevant in virtual environments where we soon might want to
report certain reserved pages to the hypervisor and they might no longer
be accessible - what already was documented for reserved pages a long
time ago ("might not even exist").

David Hildenbrand (2):
  mm: clarify semantics of reserved pages
  kdump: include PG_reserved value in VMCOREINFO

 include/linux/page-flags.h | 4 ++--
 kernel/crash_core.c        | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.1

