Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9kakYjX275HgXaw+U4/bobsg+k5pKed278ObbjF6+Du86WgrrOCtdhycli3QDXYrXVLH1
ARC-Seal: i=1; a=rsa-sha256; t=1524652864; cv=none;
        d=google.com; s=arc-20160816;
        b=Mua38L7Ev6A1Gmzio6REF+P9wv7SWlfZxqEwvdC7Ucs5UDxISqP5wZ6/cNKMSdQwuF
         LoLSjguiApS3tVXKy4dbVSiq2l63ileXruh6wqozhmo3/o97IYIJVOMCC01sJuf1SdMR
         dVLfi1AOijGTylIj38aopS7HAmOJvPZw36ai73wZB9QcVcOjm0Qo9eYHfKOZFOACc9ax
         KK8ocnd/A2DQ55qH5m2yXBH3fApjdt5wjJFa7tivtAcEtA9OGBiLGmx9Nn1qnHc1f/Jp
         L6Q1/1/eRoGQU3UI2iSOas95BzT/w+004pi70EDmaHEi4FRTTBABt8J8lWEPSRVGLV0M
         9MMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lJmydBfOWMjos57AYQ0W1ZOVQ4nQMVz9nRcCVtaoWh8=;
        b=nnuDOfQCwBBGIOp2cZE6l0mytaeXR27BzgJaun4hicib1jSzWyCWy+8H0nrHY8EQ1e
         udssusphOlWYROFmP1OPsJKIAIlEIzbXuxHavcEa/WUBmn4jz9Eo9x8AsmTcq+DUJTXg
         tNuxSQY+T8KcHwO6M6DELWClCv2dBR0vg9FePF9g7sAnKbEHdVFZ9+vPOWhC0zIbiv/B
         eolZ8NmY+DOuCjLX6fwdyu1MsJdq7+df7zsomCZvG6CjGc6/D4RUqOovrh1UeDfkfO4g
         z0NDhzRsvRI49BxHSuh2mgioPDYuuTqBset4N8AwBA9QNmL5XVQSlnrEKfMSfIEiKMXI
         VrYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 096/183] samples/bpf: Partially fixes the bpf.o build
Date: Wed, 25 Apr 2018 12:35:16 +0200
Message-Id: <20180425103246.329733530@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714402257298586?=
X-GMAIL-MSGID: =?utf-8?q?1598714402257298586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Mickaël Salaün" <mic@digikod.net>


[ Upstream commit c25ef6a5e62fa212d298ce24995ce239f29b5f96 ]

Do not build lib/bpf/bpf.o with this Makefile but use the one from the
library directory.  This avoid making a buggy bpf.o file (e.g. missing
symbols).

This patch is useful if some code (e.g. Landlock tests) needs both the
bpf.o (from tools/lib/bpf) and the bpf_load.o (from samples/bpf).

Signed-off-by: MickaÃ«l SalaÃ¼n <mic@digikod.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 samples/bpf/Makefile |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -179,13 +179,16 @@ LLC ?= llc
 CLANG ?= clang
 
 # Trick to allow make to be run from this directory
-all:
+all: $(LIBBPF)
 	$(MAKE) -C ../../ $(CURDIR)/
 
 clean:
 	$(MAKE) -C ../../ M=$(CURDIR) clean
 	@rm -f *~
 
+$(LIBBPF): FORCE
+	$(MAKE) -C $(dir $@) $(notdir $@)
+
 $(obj)/syscall_nrs.s:	$(src)/syscall_nrs.c
 	$(call if_changed_dep,cc_s_c)
 
