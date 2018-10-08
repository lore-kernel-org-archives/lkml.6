Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE9C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAA82077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAA82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJHKkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeJHKkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:40:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A2A640F1B;
        Mon,  8 Oct 2018 03:31:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 672E660FA6;
        Mon,  8 Oct 2018 03:31:00 +0000 (UTC)
Subject: Re: [tip:x86/mm] kdump, proc/vmcore: Enable kdumping encrypted memory
 with SME enabled
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
References: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
 <tip-992b649a3f013465d8128da02e5449def662a4c3@git.kernel.org>
 <21eab36e-d113-cf88-e497-7dd620981544@redhat.com>
 <20181007084742.GA30797@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <58270f3f-f17c-8996-09cd-6da3481beb40@redhat.com>
Date:   Mon, 8 Oct 2018 11:30:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181007084742.GA30797@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 08 Oct 2018 03:31:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月07日 16:47, Borislav Petkov 写道:
> On Sun, Oct 07, 2018 at 01:55:33PM +0800, lijiang wrote:
>> Here, it may be have a compile error.
> 
> Are you sure? The configs I tried worked fine but I'm open to being
> shown configs which fail the build.
> 

Yes. As previously mentioned, the correct patch is this one:

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 3e4ba9d753c8..84d8ddcb818e 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,6 +26,19 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+#if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_X86_64)
+extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+					  size_t csize, unsigned long offset,
+					  int userbuf);
+#else
+static inline
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+				   unsigned long offset, int userbuf)
+{
+	return 0;
+}
+#endif
+

I used the patch above to test six compile cases. All of them passed, there
was no compile error.

I'm not sure whether the kernel options or compile environment are different.
Would you like to share your kernel options(.config)? I will use your kernel
options to compile, and check whether i might also reproduce your compile error. 

1. x86_64 (CONFIG_X86_64=y)
   a.     
      CONFIG_AMD_MEM_ENCRYPT=y
      CONFIG_CRASH_DUMP=y

   b.
      # CONFIG_AMD_MEM_ENCRYPT is not set
      # CONFIG_CRASH_DUMP is not set

   c. 
      # CONFIG_AMD_MEM_ENCRYPT is not set
      CONFIG_CRASH_DUMP=y

   d. 
      CONFIG_AMD_MEM_ENCRYPT=y
      # CONFIG_CRASH_DUMP is not set

Compile command:
#make clean
#make ARCH=x86_64 -j32

2. i386 (CONFIG_X86_32=y)
   a. 
   CONFIG_CRASH_DUMP=y

   b.
   # CONFIG_CRASH_DUMP is not set

Compile command:
#make clean
#make ARCH=i386 -j32

Thanks.
Lianbo
