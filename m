Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48gJVnjfu5sOoyTfTDmIzRbb/NlrIoQd1MkiEkfP50013rxsfSscnD+imI5CjtwPJK33RTB
ARC-Seal: i=1; a=rsa-sha256; t=1522168415; cv=none;
        d=google.com; s=arc-20160816;
        b=Y5rMQYDtNhAM7mmXSqmjNxMGPdNXmiCamcVF0VlvgJ1dZmUxGoP+EtH/C0yjvnAZQL
         PNImgBkZkwYlO53TfENS7DaEUDx8Y2ph+unsVCBenhjcHVNu/evscCDcV30+Z/Qcq091
         vEUPnWN6rgxa3bhO2A8HfmgYxuadsrWHv9eYFrfa3pI9Rc5mwFwISwJXACLn0XA4cldS
         1dX2bbzXx8Lr1Oae7Rse5bJtWwEZMtH5/jAJFZ+XM49SNVqNThGO86kLW3l6T0mDyWcF
         wafZP4EcuPN3qeTTnNBNLMqscMGJWJSRNenXT8YJFPAorXaeqsb0vUUb0sjml4w/P2pY
         bwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h4fsSj6CFu/Sm3WDtea7X9YwuOX5baAMXkW58iPwMSY=;
        b=SDfFoFGKeKcJj+Sq9SRiqlmvELtKJ8cOhbLke3xfV4aCXe4FEQwjDtbqPa5Z6PU7cN
         HWy6Mc2OoismjDiiUa15UcOspQ3LqW09XDHVmImNQ4BNenzTFKOcG8+e8mbn0L2fU2Ck
         eKn4c7wSbETbxhpodqk5qHYbL9ZdeTu52Pg7lhut8F0Vzcqhj4nqVhQzIYzpduxWhkwD
         QlfDaKru0vA7aBW0HmLo8lcUBGi7KxdB64U1vv7lR8hihP65HrHoB4/opl+T38lNjpbD
         LtVhACv0geLL3k5NDTGuyNJuaxZ+GTjF92/u/xQhb9IRzl8cvsbMQGmnWCm5lDanELz0
         dZ7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 64/67] selftests: x86: sysret_ss_attrs doesnt build on a PIE build
Date: Tue, 27 Mar 2018 18:27:56 +0200
Message-Id: <20180327162731.207896067@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109267899820070?=
X-GMAIL-MSGID: =?utf-8?q?1596109267899820070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 3346a6a4e5ba8c040360f753b26938cec31a4bdc upstream.

sysret_ss_attrs fails to compile leading x86 test run to fail on systems
configured to build using PIE by default. Add -no-pie fix it.

Relocation might still fail if relocated above 4G. For now this change
fixes the build and runs x86 tests.

tools/testing/selftests/x86$ make
gcc -m64 -o .../tools/testing/selftests/x86/single_step_syscall_64 -O2
-g -std=gnu99 -pthread -Wall  single_step_syscall.c -lrt -ldl
gcc -m64 -o .../tools/testing/selftests/x86/sysret_ss_attrs_64 -O2 -g
-std=gnu99 -pthread -Wall  sysret_ss_attrs.c thunks.S -lrt -ldl
/usr/bin/ld: /tmp/ccS6pvIh.o: relocation R_X86_64_32S against `.text'
can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: final link failed: Nonrepresentable section on output
collect2: error: ld returned 1 exit status
Makefile:49: recipe for target
'.../tools/testing/selftests/x86/sysret_ss_attrs_64' failed
make: *** [.../tools/testing/selftests/x86/sysret_ss_attrs_64] Error 1

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -17,7 +17,7 @@ TARGETS_C_64BIT_ALL := $(TARGETS_C_BOTHB
 BINARIES_32 := $(TARGETS_C_32BIT_ALL:%=%_32)
 BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 
-CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
+CFLAGS := -O2 -g -std=gnu99 -pthread -Wall -no-pie
 
 UNAME_M := $(shell uname -m)
 CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
