Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeCFEaD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 23:30:03 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33527 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeCFEaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 23:30:01 -0500
X-Google-Smtp-Source: AG47ELsrR+hYWgYgq1U96AsEaByU/Hptl2a+oSnTISSuxIBeMgFkBLXo78WR6E6TPdlCtPYOUm2gag==
Date: Tue, 6 Mar 2018 13:29:57 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180306042957.GE6713@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <20180305144846.3jommv372c73dltt@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305144846.3jommv372c73dltt@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/05/18 15:48), Petr Mladek wrote:
[..]
> 
> I hope that I did not miss anything. I could not try this at
> runtime.

I think you can. The rules are universal, you can do on x86
something like this

---

 arch/x86/kernel/dumpstack.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a2d8a3908670..5d45f406717e 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -375,3 +375,16 @@ static int __init code_bytes_setup(char *s)
 	return 1;
 }
 __setup("code_bytes=", code_bytes_setup);
+
+void dump_stack(void)
+{
+	dump_stack_print_info(KERN_DEFAULT);
+
+	pr_crit("\t\tLinux\n\n");
+
+	pr_crit("An error has occurred. To continue:\n"
+		"Press Enter to return to Linux, or\n"
+		"Press CTRL+ALT+DEL to restart your computer.\n");
+
+	pr_crit("\n\n\tPress any key to continue _");
+}

---

Should be enough for testing.

> Anyway, from my side:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks.

	-ss
