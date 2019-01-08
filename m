Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0EF2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uhGTmSE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfAHDJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:09:14 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:17859 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfAHDJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:09:14 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x0838WCh015986;
        Tue, 8 Jan 2019 12:08:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x0838WCh015986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546916913;
        bh=m5WV52/VwpLTcERxr6/ZtnxvtYDgEHjN4n2QvQD/Zi0=;
        h=From:To:Cc:Subject:Date:From;
        b=uhGTmSE8yLGEYT0nMFVMoLymcidbDud4eTVfZKj+gCrVRFNs19hU0eLItim0sJTtg
         39i1mwrX7+dBuYugVn5pQqZW1Xy7Cqgk73G1JnpAVNcA6ObNykJF0Dm6joWWktHdLV
         teioFZqFqAbSfZIB+UHxYx4hXYD9Vt4+1vO5fjqYrOLN+m4cA6mAo3K4eXGn2YGCgE
         hirR82stTjemdYY1nZHM3cjbdzSizganSvZy+HsIHvcuaECOLxYoL+XXCqgxCTO162
         Yjf1REUmXOyChhAXtUkQH5RwXgrxwgsmIdmI+scANTvbGfZ6gqYxb/biLTlaX9+vUD
         rdKPU5izt0Deg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Cornelia Huck <cohuck@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vfio_pci: set TRACE_INCLUDE_PATH to fix the build error
Date:   Tue,  8 Jan 2019 12:08:03 +0900
Message-Id: <1546916883-25911-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/vfio/pci/vfio_pci_nvlink2.c cannot be compiled for in-tree
building.

    CC      drivers/vfio/pci/vfio_pci_nvlink2.o
  In file included from drivers/vfio/pci/trace.h:102,
                   from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
  ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
                                          ^
  compilation terminated.
  make[1]: *** [scripts/Makefile.build;277: drivers/vfio/pci/vfio_pci_nvlink2.o] Error 1

To fix the build error, let's tell include/trace/define_trace.h the
location of drivers/vfio/pci/trace.h

Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
Reported-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/vfio/pci/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
index 228ccdb..4d13e51 100644
--- a/drivers/vfio/pci/trace.h
+++ b/drivers/vfio/pci/trace.h
@@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
 #endif /* _TRACE_VFIO_PCI_H */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 
-- 
2.7.4

