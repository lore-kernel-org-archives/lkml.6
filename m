Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0387C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E5523E23
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbFQT+9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E5523E23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937399AbeF2UmQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:42:16 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45911 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754453AbeF2UmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:42:14 -0400
Received: by mail-ot0-f194.google.com with SMTP id k3-v6so11266914otl.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5TJVGt/+q9iQ0OrmDP8z63hOFyc3OPIhbvop/RPCDgA=;
        b=WbFQT+9sBQVrCwNuWZEdSaEBERPdfx4XF0OFwu0KYA8E58wqXKkvJtP2uH0mdJEIpA
         cpODbHZy5lbzbwAaI4JTf/YZy2/X1/rXJ3EAXlr0vH7iNlhNgPhWqVhK8WpE93jqoS/Q
         oPQaQdHREEVt1hLKWKrWuGtDKLwtc/8pYz2zcEaE0n25Zpu475AEsuWGPEfuYkITju/Y
         Hjaf5SOY/io392T+mJsyG7PX4FVDv43vEwFBbrVP4QKPkVekQr+lP4SpxGr3u1B3tjTs
         fyzgEMv2xU9MwY+7ZUOrX0qnxsmPZRtp8GRhOqsxeXAk4f3MwRW52x/GOzlPaxBgsKsA
         qS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=5TJVGt/+q9iQ0OrmDP8z63hOFyc3OPIhbvop/RPCDgA=;
        b=Zzxa6oop4v6H+zNZSLP2yRezuHpwM6Cgv8TvIGI9jnyOyMSSnsKqWbrt53ZeeYazLr
         rKcetVN5IjeNLZkG58VgASV+ot7hq1Xl96SzwUygI214YxlTs8oGkqf2vT8Bw/TFuxmw
         zDtJSaiQcdaqtK85wzoWAFuobadJFLCc1ROJU8Q3KUBHi4JEGjjTmg3yoRcY/rP0t+Qe
         vjyOGLvxCtSYOxo2EYqeIjBDuZCwfa/gsphbqW+NRpMFFEyFREvj5fXMGk0gMA+f4kQj
         Tx4ocLp/o7ItvCSq02I7ZcHy8G7+CM0A9uwj52MHVfz64w7ZWr+jkszExORoRrvlHVdf
         wftw==
X-Gm-Message-State: APt69E2E0D/d0fun0v18yXNGyKEfxVrOAH/ee0YlHVp3MhEcT10D96p6
        qifZPrcwpQO8os0XAJMeWFgmAw==
X-Google-Smtp-Source: AAOMgpeQVIIftirPJZirjXMzUEbF2tnAVat57dfD7Qxrg/9INgD5FtiWEDpN6WnoFa9ZStPhBoQj/A==
X-Received: by 2002:a9d:6314:: with SMTP id q20-v6mr10502970otk.12.1530304934344;
        Fri, 29 Jun 2018 13:42:14 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id t196-v6sm5314201oie.1.2018.06.29.13.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 13:42:13 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
Date:   Fri, 29 Jun 2018 15:42:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My PowerBook G4 Aluminum crashes on boot with 4.18-rcX kernels with a kernel BUG 
at include/linux/page-flags.h:700! The problem was bisected to commit 
1d40a5ea01d5 ("mm: mark pages in use for page tables"). It is not possible to 
capture the bug with anything other than a camera. The first few lines of the 
traceback are as follows:

free_pgd_range+0x19c/0x30c (unreliable)
free_pgtables_0xa0/0xb0
exit_pmap+0xf4/0x16c
mmput+0x64/0xf0
do_exit+0x33c/0x89c
oops_end+0x13c/0x144
_exception_pkey+0x58/0x128
ret_from_except_full+0x0/0x4
--- interrupt: 700 at free_pgd_range+0x19c/0x30c
     LR = free_pgd_range+0x19c/0x30c
free_pgtables+0xa/0xb
exit_mnap+0xf4/0x16c
mmput+0x64/0xf0
flush_old_exec+0x490/0x550

I have more information regarding this BUG. Line 700 of page-flags.h is the 
macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded 
the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page) 
in routine __ClearPageTable(), which is called from pgtable_page_dtor() in 
include/linux/mm.h. I also added a printk call to PageTable() that logs 
page->page_type. The routine was called twice. The first had page_type of 
0xfffffbff, which would have been expected for a . The second call had 
0xffffffff, which led to the BUG.

Larry
