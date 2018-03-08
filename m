Return-Path: <kernel-hardening-return-12225-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELunrfalc3jLRVPJmJzK7DzvX2p/omD29hOVY/qtrV8klkAX3t5forG1eKHuVKdwQ7CjEB2w
ARC-Seal: i=1; a=rsa-sha256; t=1520479913; cv=none;
        d=google.com; s=arc-20160816;
        b=cx0QSsJPVgwzcJFuK0J/+p+zbUOQwcwiIhp9IRLp/ldjZ1nUCo2hIQFZX14jv/y/t5
         8hGhm679+oGGYV2c2okW0iZdOl+S71AB8BUbB6R2Zef7rIknyQhEqoK1U5gOD/YNbfp9
         ucMaq0w3WAud3rHE+gBJEaI9zNOJvikZ0g6RMUQbDETqDeaIxCExn0FPZF40J7QpxOWC
         u9zG7/yucREgfB3L2arFZqn6VDstJE2JjO37hGrgYbJTI8ZGXFf9un5UsCml0MlCgwMq
         peDFoUwztODBOYKmMbHcE/k5v8Fw6Zo5FSbWxRb7Dd0ab5PT2D/F3SF0e/N4nnyGo9NN
         U1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=NrJLjutDy4k2al7+BcFY3moySrOfeC+raQ5OjH9MQCE=;
        b=EtC8NvUHQSnW8urHbxPd0sNeyXb9KWtqiN8b51wGg4/9kQshnSR/RwZri/HTtKaM1J
         nRwUC9zXmRSq1fM6gX6OCDXzR4A/NaKTTfK6+QaOIrLSNW0w85xNwGoMEN9vW4ZG6/WB
         W13n0AOj8y80+TIEk/wzWkB6E8fh2kF/WMKCblG+13Kj3ryrx9rCnxKx/s88/GOovAr1
         HX4YHyNM4hWlM8tnc0ePMSI3cpfKowasSLPn4scgBUWX6U02F0DON6oYWU/yaoCuct0e
         ddR1xmyfbONXsvGJZ0ng9BC+IshmdsXftRmUGKS0lexuYMp9z/aJGODHuQ6r4Ja0zFyL
         F3Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=XvPQbzxA;
       spf=pass (google.com: domain of kernel-hardening-return-12225-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12225-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=XvPQbzxA;
       spf=pass (google.com: domain of kernel-hardening-return-12225-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12225-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	gustavo@embeddedor.com,
	rostedt@goodmis.org,
	Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Borislav Petkov <bp@suse.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	"Tobin C. Harding" <me@tobin.cc>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	linux-btrfs@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH 0/3] Remove accidental VLA usage
Date: Wed,  7 Mar 2018 19:30:44 -0800
Message-Id: <1520479847-39174-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338745857869070?=
X-GMAIL-MSGID: =?utf-8?q?1594338745857869070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series adds SIMPLE_MAX() to be used in places where a stack array
is actually fixed, but the compiler still warns about VLA usage due to
confusion caused by the safety checks in the max() macro.

I'm sending these via -mm since that's where I've introduced SIMPLE_MAX(),
and they should all have no operational differences.

-Kees
