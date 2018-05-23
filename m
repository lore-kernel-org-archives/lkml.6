Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeEWAUC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:20:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44625 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbeEWATv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:19:51 -0400
X-Google-Smtp-Source: AB8JxZqXfNW1LEoJFvuXLlGsLX8uFkw3vxpL/ilPWniefjWUAbYku3sP1lGgculT3yvd1FSvZ8kPlg==
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCHv3 2/2] x86/vdso: Add build salt to the vDSO
Date: Tue, 22 May 2018 17:19:39 -0700
Message-Id: <20180523001939.9431-3-labbott@redhat.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523001939.9431-1-labbott@redhat.com>
References: <20180523001939.9431-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The vDSO is linked separately from the kernel and modules. Ensure it picks
up the comment section, if available.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Invoke the generated linker script. The ".." nightmare is pretty
ugly but I didn't see an easier way to pick up the generated file.
That was actually part of my motivation for using an #include since
paths for those are standardized.
---
 arch/x86/entry/vdso/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index d998a487c9b1..f54aa97dc9f0 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -162,7 +162,9 @@ $(obj)/vdso32.so.dbg: FORCE \
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(CC) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
+		       -Wl,-T,$(filter %.lds,$^) \
+		       -Wl,-T$(obj)/../../../../scripts/build-salt.lds \
+		       $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=both) \
-- 
2.17.0
