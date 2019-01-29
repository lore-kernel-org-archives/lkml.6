Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AFEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9F820882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762278;
	bh=LkDD/kWJJqXaq3qWjUEjleK8sbRJbaM8aMSnnVzATI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mHQw22yfHmKKvkgW3tTJzabPCL9DDgK1o5RtyufbcqT6lp9Frkzuahr5Q91e/U6KU
	 b8ZR3U0uGsjZCtZo+fo3KQuzjVQKPed7HiGhFFgDlnpJzda+AJO+K086x4LdKkRIWQ
	 3zs78nsdM4z8x+tfo0Q+WVgz7/7VhBGIjgmuQP6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfA2Loh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730591AbfA2Loe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863572086C;
        Tue, 29 Jan 2019 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762273;
        bh=LkDD/kWJJqXaq3qWjUEjleK8sbRJbaM8aMSnnVzATI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOdcZn1CKdyIulkeulCwua3z0U+YniK3ruVJasDU/9cavbr4cgIW/TFWl60f+QhRz
         BThR5IyF11lHeYdvnbaH8UrATzvprdWnXTYgbWQRXXF0jW9LSZ4tO4xQaEM5ILnYbu
         wNq6RdBr+0YEvxWjEj+5T3nOOgwBfMy2HT9nP/eY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        stable@kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/103] hv_balloon: avoid touching uninitialized struct page during tail onlining
Date:   Tue, 29 Jan 2019 12:35:27 +0100
Message-Id: <20190129113202.534197576@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit da8ced360ca8ad72d8f41f5c8fcd5b0e63e1555f upstream.

Hyper-V memory hotplug protocol has 2M granularity and in Linux x86 we use
128M. To deal with it we implement partial section onlining by registering
custom page onlining callback (hv_online_page()). Later, when more memory
arrives we try to online the 'tail' (see hv_bring_pgs_online()).

It was found that in some cases this 'tail' onlining causes issues:

 BUG: Bad page state in process kworker/0:2  pfn:109e3a
 page:ffffe08344278e80 count:0 mapcount:1 mapping:0000000000000000 index:0x0
 flags: 0xfffff80000000()
 raw: 000fffff80000000 dead000000000100 dead000000000200 0000000000000000
 raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 page dumped because: nonzero mapcount
 ...
 Workqueue: events hot_add_req [hv_balloon]
 Call Trace:
  dump_stack+0x5c/0x80
  bad_page.cold.112+0x7f/0xb2
  free_pcppages_bulk+0x4b8/0x690
  free_unref_page+0x54/0x70
  hv_page_online_one+0x5c/0x80 [hv_balloon]
  hot_add_req.cold.24+0x182/0x835 [hv_balloon]
  ...

Turns out that we now have deferred struct page initialization for memory
hotplug so e.g. memory_block_action() in drivers/base/memory.c does
pages_correctly_probed() check and in that check it avoids inspecting
struct pages and checks sections instead. But in Hyper-V balloon driver we
do PageReserved(pfn_to_page()) check and this is now wrong.

Switch to checking online_section_nr() instead.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/hv_balloon.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -888,12 +888,14 @@ static unsigned long handle_pg_range(uns
 			pfn_cnt -= pgs_ol;
 			/*
 			 * Check if the corresponding memory block is already
-			 * online by checking its last previously backed page.
-			 * In case it is we need to bring rest (which was not
-			 * backed previously) online too.
+			 * online. It is possible to observe struct pages still
+			 * being uninitialized here so check section instead.
+			 * In case the section is online we need to bring the
+			 * rest of pfns (which were not backed previously)
+			 * online too.
 			 */
 			if (start_pfn > has->start_pfn &&
-			    !PageReserved(pfn_to_page(start_pfn - 1)))
+			    online_section_nr(pfn_to_section_nr(start_pfn)))
 				hv_bring_pgs_online(has, start_pfn, pgs_ol);
 
 		}


