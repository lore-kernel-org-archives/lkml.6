Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeDWSUW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:20:22 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38092 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeDWSUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:20:21 -0400
X-Google-Smtp-Source: AIpwx4/qBw+QaoodizKK9D+/q/hXTDcSiwDkhzgBn4mEXbLn3Ne7je2Hrkigawv/+lk+s0wIzS5AyQ==
Date: Mon, 23 Apr 2018 21:20:17 +0300
From: Alexander Pateenok <pateenoc@gmail.com>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: remove uml initcalls
Message-ID: <20180423182017.oxlfhnsrekk34q3b@K55DR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__uml_initcall() is not used and .uml.initcall.init section is empty:

$ grep -r '__uml_initcall('
arch/um/include/shared/init.h:#define __uml_initcall(fn)	\
$ readelf -s ../umobj/linux | grep __uml_initcall
 23214: 00000000603b75d8     0 NOTYPE  GLOBAL DEFAULT   32 __uml_initcall_start
 25337: 00000000603b75d8     0 NOTYPE  GLOBAL DEFAULT   32 __uml_initcall_end

So it is unnecessary.

Signed-off-by: Alexander Pateenok <pateenoc@gmail.com>
---
 arch/um/include/asm/common.lds.S |  6 ------
 arch/um/include/shared/init.h    |  5 -----
 arch/um/os-Linux/main.c          | 12 ------------
 3 files changed, 23 deletions(-)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index b30d73ca29d0..7adb4e6b658a 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -53,12 +53,6 @@
 	CON_INITCALL
   }
 
-  .uml.initcall.init : {
-	__uml_initcall_start = .;
-	*(.uml.initcall.init)
-	__uml_initcall_end = .;
-  }
-
   SECURITY_INIT
 
   .exitcall : {
diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index b3f5865a92c9..c66de434a983 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -64,14 +64,10 @@ struct uml_param {
         int (*setup_func)(char *, int *);
 };
 
-extern initcall_t __uml_initcall_start, __uml_initcall_end;
 extern initcall_t __uml_postsetup_start, __uml_postsetup_end;
 extern const char *__uml_help_start, *__uml_help_end;
 #endif
 
-#define __uml_initcall(fn)					  	\
-	static initcall_t __uml_initcall_##fn __uml_init_call = fn
-
 #define __uml_exitcall(fn)						\
 	static exitcall_t __uml_exitcall_##fn __uml_exit_call = fn
 
@@ -108,7 +104,6 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
  */
 #define __uml_init_setup	__used __section(.uml.setup.init)
 #define __uml_setup_help	__used __section(.uml.help.init)
-#define __uml_init_call		__used __section(.uml.initcall.init)
 #define __uml_postsetup_call	__used __section(.uml.postsetup.init)
 #define __uml_exit_call		__used __section(.uml.exitcall.exit)
 
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 5f970ece5ac3..f1fee2b91239 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -40,17 +40,6 @@ static void set_stklim(void)
 	}
 }
 
-static __init void do_uml_initcalls(void)
-{
-	initcall_t *call;
-
-	call = &__uml_initcall_start;
-	while (call < &__uml_initcall_end) {
-		(*call)();
-		call++;
-	}
-}
-
 static void last_ditch_exit(int sig)
 {
 	uml_cleanup();
@@ -151,7 +140,6 @@ int __init main(int argc, char **argv, char **envp)
 	scan_elf_aux(envp);
 #endif
 
-	do_uml_initcalls();
 	change_sig(SIGPIPE, 0);
 	ret = linux_main(argc, argv);
 
-- 
2.16.3
