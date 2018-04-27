Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrLjPrgDJ6eYLY1nqaW0uFgaSYzc91ACt8NjkPC5TOrFj540NV2Q2zebba3ri32mOUb9way
ARC-Seal: i=1; a=rsa-sha256; t=1524838372; cv=none;
        d=google.com; s=arc-20160816;
        b=RFlU+mqjkw7YiblEDjGUq7q+OSrqvqrwCFxuiCk3Oyx2hp0momcc3zqMkxtNhI7gqF
         F/i9WlxnZ6/ag1R9FAeR9mNHbJ2STuF7H4uimOyt9n3zTvjCCTSt8JjDfIUCYSyiqkXr
         Hb2qAYboTVj4eHebsjueIfxOzEzv0MtM8TrsNBUx1mcPWnNGuUhiPiETft5yBD2WA7fp
         2xrmLQ0q8VMit1o6zFVBzZ3G/qD3oh2Gkyyjq+Hwd8LIeDdDMecDXukLEKNAHeU68UEs
         D4ca+6pzCE1fQbdVojGgOX01hh4eZ1/OB9affCuzG9CHIFekh8hrbI9m/0WJhDBzVyzs
         cBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kSKr6z/OYGYo0BDdyvbRwP567kW3+zwSQv0SSs5gIg0=;
        b=AhVGJY3VY3fUAKdue5ZPuAGgy5CAA0u7fBpL6sGT62Q3EBSKV6uNvVTSBXUXUg8Epc
         igVwoanlWIcY/xDWrXvrvkJWAlSXpYoabzjCPEhxhOUma42jZDhMdKDucfkASFuRV3VK
         5jQ1qKSmaQfmH2TubSofAr8CuGuImrDxs7rL54Yf6RzEfzUC2ZipoTnszvma1CTdaY9k
         Np6iy99X0OutKlp/L191PesKXo8LhqJ198qWSxngqh4UhilfQOSUGPwJ8uXRMpCWn95b
         P3fN54qUAEIKZy9hz4IZ66iyezeTcoYpCLJn57tEKsP2z3jB6xE8tPY5JNZJS1tXkON2
         7jqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BE12189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	acme@kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.16 80/81] kprobes: Fix random address output of blacklist file
Date: Fri, 27 Apr 2018 15:59:22 +0200
Message-Id: <20180427135747.861646355@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908921547686913?=
X-GMAIL-MSGID: =?utf-8?q?1598908921547686913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

commit bcbd385b61bbdef3491d662203ac2e8186e5be59 upstream.

File /sys/kernel/debug/kprobes/blacklist displays random addresses:

[root@s8360046 linux]# cat /sys/kernel/debug/kprobes/blacklist
0x0000000047149a90-0x00000000bfcb099a	print_type_x8
....

This breaks 'perf probe' which uses the blacklist file to prohibit
probes on certain functions by checking the address range.

Fix this by printing the correct (unhashed) address.

The file mode is read all but this is not an issue as the file
hierarchy points out:
 # ls -ld /sys/ /sys/kernel/ /sys/kernel/debug/ /sys/kernel/debug/kprobes/
	/sys/kernel/debug/kprobes/blacklist
dr-xr-xr-x 12 root root 0 Apr 19 07:56 /sys/
drwxr-xr-x  8 root root 0 Apr 19 07:56 /sys/kernel/
drwx------ 16 root root 0 Apr 19 06:56 /sys/kernel/debug/
drwxr-xr-x  2 root root 0 Apr 19 06:56 /sys/kernel/debug/kprobes/
-r--r--r--  1 root root 0 Apr 19 06:56 /sys/kernel/debug/kprobes/blacklist

Everything in and below /sys/kernel/debug is rwx to root only,
no group or others have access.

Background:
Directory /sys/kernel/debug/kprobes is created by debugfs_create_dir()
which sets the mode bits to rwxr-xr-x. Maybe change that to use the
parent's directory mode bits instead?

Link: http://lkml.kernel.org/r/20180419105556.86664-1-tmricht@linux.ibm.com

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: stable@vger.kernel.org
Cc: <stable@vger.kernel.org> # v4.15+
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S Miller <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: acme@kernel.org

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2428,7 +2428,7 @@ static int kprobe_blacklist_seq_show(str
 	struct kprobe_blacklist_entry *ent =
 		list_entry(v, struct kprobe_blacklist_entry, list);
 
-	seq_printf(m, "0x%p-0x%p\t%ps\n", (void *)ent->start_addr,
+	seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
 		   (void *)ent->end_addr, (void *)ent->start_addr);
 	return 0;
 }
