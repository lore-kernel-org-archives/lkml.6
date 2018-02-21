Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224X26yciFBSu4jGcg5jkb3XfcMRvsnrFSL/KWxQO811lDgQjBWO1N5YgXM0E5acIwwusb7K
ARC-Seal: i=1; a=rsa-sha256; t=1519217875; cv=none;
        d=google.com; s=arc-20160816;
        b=P2JyEZbfg89FmYvZwvF7YfxZX/mKmgygLHZftlMLPMO9OayYa1NUm1C9G8oidFFMFg
         gAFKYiIdVALi9LXB+1/5TrBVwXDyPca5ZL1TzbBO2EYIF9lw4AxWj5ljRPhoTXoylUii
         JrVmd4ePhaWRVaNryXsEyaMZLcWTeRbN6ovKfwBUNBHSE009sRYx7H0Y3O+qxxYKiYuX
         QzmJ5/J9cEilmMpgW45NakGk9rczTwxhxCf/CqRWuTwiEY7ufPupm20Bc75e1OgmDmjj
         ltOwLPXM565EN+i7dxZsvCPPvp/BmZ9jBGwf+iYN3xoukQ2QQfoxOQ0z11RyijjgNxMT
         om5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+fotsc9EUA++xrPCQbYUAtzrZFmv2zddeN3kZCZu54M=;
        b=bsYxxCEfzCGuQCFuJeyfBXSnnjIPg1lOYVEwvy7666C3Q0St9xzlq7WchW96Wk2v/c
         4CXFGAKci4LpnlqpbKX61Mpiy/UCPiXdp+yj5Z/ViLNJJPO5VVmlFfRF+cyhBjfz3CDK
         BEtAo6GpehicXPZC6GjUBIVMTOq4ctidI8PD+AD3K8p2YvEpgh2N/YmHJfTxvNutDadm
         JGyiWlREGJjhQIDrdFv9bJ0eJFu+YYyaf3coSr174HDeC3eJ5lP9YLaUxobZAliF3oXm
         rMU43rIgiL797jkNZQ5iwYmeaolCUP2lVXPj4EQqEt9MuRaTX2JK7X/UfX+b/WnKl2er
         7P/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 001/167] tracing: Prevent PROFILE_ALL_BRANCHES when FORTIFY_SOURCE=y
Date: Wed, 21 Feb 2018 13:46:52 +0100
Message-Id: <20180221124524.709899387@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015402937560884?=
X-GMAIL-MSGID: =?utf-8?q?1593015402937560884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 68e76e034b6b1c1ce2eece1ab8ae4008e14be470 upstream.

I regularly get 50 MB - 60 MB files during kernel randconfig builds.
These large files mostly contain (many repeats of; e.g., 124,594):

In file included from ../include/linux/string.h:6:0,
                 from ../include/linux/uuid.h:20,
                 from ../include/linux/mod_devicetable.h:13,
                 from ../scripts/mod/devicetable-offsets.c:3:
../include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static [enabled by default]
    ______f = {     \
    ^
../include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
                       ^
../include/linux/string.h:425:2: note: in expansion of macro 'if'
  if (p_size == (size_t)-1 && q_size == (size_t)-1)
  ^

This only happens when CONFIG_FORTIFY_SOURCE=y and
CONFIG_PROFILE_ALL_BRANCHES=y, so prevent PROFILE_ALL_BRANCHES if
FORTIFY_SOURCE=y.

Link: http://lkml.kernel.org/r/9199446b-a141-c0c3-9678-a3f9107f2750@infradead.org

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -343,7 +343,7 @@ config PROFILE_ANNOTATED_BRANCHES
 	  on if you need to profile the system's use of these macros.
 
 config PROFILE_ALL_BRANCHES
-	bool "Profile all if conditionals"
+	bool "Profile all if conditionals" if !FORTIFY_SOURCE
 	select TRACE_BRANCH_PROFILING
 	help
 	  This tracer profiles all branch conditions. Every if ()
