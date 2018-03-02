Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsmYRgAAVPGOmci/sqxqTJMP/BrmdtoOJO2s+v6+Ykf5dnZvXoa575XeWKKkevdj5NcQqds
ARC-Seal: i=1; a=rsa-sha256; t=1519981180; cv=none;
        d=google.com; s=arc-20160816;
        b=MNRqPwubVWTGoarQQ7lbmUR5LnhU7CifW7AO/aBuqz2tAvuxfxQBlGOhByfw7Zr+ng
         IVw7kRi/9q36BvtRkF8A2VPcmwi8vwvzynJyoc3D6ILOUinblEoCDvaq5jMaYg4aIc+9
         DwWU3q4lG8aHa7Rk+/aSF5/HpIgnSOGgHZUf1yqLQ4IVf/1IxHXmkMavwhNuoISG8ky/
         aoPxLu133JDpkWW6g3h4qC1QHZVqEV3LcwC3xY/bGt2utBJaMgdwIb2KaARIlGmr4W+P
         x+ntVVjzaXK5FxnUGppAUeFJdi4INsaK4h9pnmPSufFdcsCpGG61oYuv+PmqlBB1y2iO
         MOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qjq8ByKHjM+fDxehsZNgDjw1OagM5FCK/VHunUIPWfA=;
        b=WKCyb3MXLBjyxbgGn7jiz2s7x7R2L83Wcl1qzEy+y1TaAw9qUU7s5EoM7qTQ9gcoN9
         5Cwpnxb0nQWOOh/H/vPsWERBRhpo0PhNZylyvTVaObPL+8T4+hbtr7lAf6+X8slizq/H
         evy7PnTslM9vQqCJ5pncgbQvwO2CD/sj5mSH8JsV7MGQ5DY7NNVr7mhB5pvYdkII3XkX
         dUO8/i2/ZyzslhwA7M+URXm1FsfSQPg+vQYvUsDQREPEXv5gvPw5jMUmch1r7eLvVv2R
         jSrpdGTyTEHvT1EvaYLOI5CRcWWLI//ufggZB++hNDWbQPwnfizHJlYkoAhD7btjkFQv
         XjjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Potapenko <glider@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Ahern <dsahern@gmail.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wang Nan <wangnan0@huawei.com>,
	Yonghong Song <yhs@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 017/115] x86/asm: Allow again using asm.h when building for the bpf clang target
Date: Fri,  2 Mar 2018 09:50:20 +0100
Message-Id: <20180302084504.566477249@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815592668804141?=
X-GMAIL-MSGID: =?utf-8?q?1593815786064002200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>


[ Upstream commit ca26cffa4e4aaeb09bb9e308f95c7835cb149248 ]

Up to f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")
we were able to use x86 headers to build to the 'bpf' clang target, as
done by the BPF code in tools/perf/.

With that commit, we ended up with following failure for 'perf test LLVM', this
is because "clang ... -target bpf ..." fails since 4.0 does not have bpf inline
asm support and 6.0 does not recognize the register 'esp', fix it by guarding
that part with an #ifndef __BPF__, that is defined by clang when building to
the "bpf" target.

  # perf test -v LLVM
  37: LLVM search and compile                               :
  37.1: Basic BPF llvm compile                              :
  --- start ---
  test child forked, pid 25526
  Kernel build dir is set to /lib/modules/4.14.0+/build
  set env: KBUILD_DIR=/lib/modules/4.14.0+/build
  unset env: KBUILD_OPTS
  include option is set to  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h
  set env: NR_CPUS=4
  set env: LINUX_VERSION_CODE=0x40e00
  set env: CLANG_EXEC=/usr/local/bin/clang
  set env: CLANG_OPTIONS=-xc
  set env: KERNEL_INC_OPTIONS= -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h
  set env: WORKING_DIR=/lib/modules/4.14.0+/build
  set env: CLANG_SOURCE=-
  llvm compiling command template: echo '/*
   * bpf-script-example.c
   * Test basic LLVM building
   */
  #ifndef LINUX_VERSION_CODE
  # error Need LINUX_VERSION_CODE
  # error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
  #endif
  #define BPF_ANY 0
  #define BPF_MAP_TYPE_ARRAY 2
  #define BPF_FUNC_map_lookup_elem 1
  #define BPF_FUNC_map_update_elem 2

  static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	  (void *) BPF_FUNC_map_lookup_elem;
  static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	  (void *) BPF_FUNC_map_update_elem;

  struct bpf_map_def {
	  unsigned int type;
	  unsigned int key_size;
	  unsigned int value_size;
	  unsigned int max_entries;
  };

  #define SEC(NAME) __attribute__((section(NAME), used))
  struct bpf_map_def SEC("maps") flip_table = {
	  .type = BPF_MAP_TYPE_ARRAY,
	  .key_size = sizeof(int),
	  .value_size = sizeof(int),
	  .max_entries = 1,
  };

  SEC("func=SyS_epoll_wait")
  int bpf_func__SyS_epoll_wait(void *ctx)
  {
	  int ind =0;
	  int *flag = bpf_map_lookup_elem(&flip_table, &ind);
	  int new_flag;
	  if (!flag)
		  return 0;
	  /* flip flag and store back */
	  new_flag = !*flag;
	  bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
	  return new_flag;
  }
  char _license[] SEC("license") = "GPL";
  int _version SEC("version") = LINUX_VERSION_CODE;
  ' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf -O2 -o -
  test child finished with 0
  ---- end ----
  LLVM search and compile subtest 0: Ok
  37.2: kbuild searching                                    :
  --- start ---
  test child forked, pid 25950
  Kernel build dir is set to /lib/modules/4.14.0+/build
  set env: KBUILD_DIR=/lib/modules/4.14.0+/build
  unset env: KBUILD_OPTS
  include option is set to  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h
  set env: NR_CPUS=4
  set env: LINUX_VERSION_CODE=0x40e00
  set env: CLANG_EXEC=/usr/local/bin/clang
  set env: CLANG_OPTIONS=-xc
  set env: KERNEL_INC_OPTIONS= -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h
  set env: WORKING_DIR=/lib/modules/4.14.0+/build
  set env: CLANG_SOURCE=-
  llvm compiling command template: echo '/*
   * bpf-script-test-kbuild.c
   * Test include from kernel header
   */
  #ifndef LINUX_VERSION_CODE
  # error Need LINUX_VERSION_CODE
  # error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
  #endif
  #define SEC(NAME) __attribute__((section(NAME), used))

  #include <uapi/linux/fs.h>
  #include <uapi/asm/ptrace.h>

  SEC("func=vfs_llseek")
  int bpf_func__vfs_llseek(void *ctx)
  {
	  return 0;
  }

  char _license[] SEC("license") = "GPL";
  int _version SEC("version") = LINUX_VERSION_CODE;
  ' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf -O2 -o -
  In file included from <stdin>:12:
  In file included from /home/acme/git/linux/arch/x86/include/uapi/asm/ptrace.h:5:
  In file included from /home/acme/git/linux/include/linux/compiler.h:242:
  In file included from /home/acme/git/linux/arch/x86/include/asm/barrier.h:5:
  In file included from /home/acme/git/linux/arch/x86/include/asm/alternative.h:10:
  /home/acme/git/linux/arch/x86/include/asm/asm.h:145:50: error: unknown register name 'esp' in asm
  register unsigned long current_stack_pointer asm(_ASM_SP);
                                                   ^
  /home/acme/git/linux/arch/x86/include/asm/asm.h:44:18: note: expanded from macro '_ASM_SP'
  #define _ASM_SP         __ASM_REG(sp)
                          ^
  /home/acme/git/linux/arch/x86/include/asm/asm.h:27:32: note: expanded from macro '__ASM_REG'
  #define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)
                                 ^
  /home/acme/git/linux/arch/x86/include/asm/asm.h:18:29: note: expanded from macro '__ASM_SEL_RAW'
  # define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
                              ^
  /home/acme/git/linux/arch/x86/include/asm/asm.h:11:32: note: expanded from macro '__ASM_FORM_RAW'
  # define __ASM_FORM_RAW(x)     #x
                                 ^
  <scratch space>:4:1: note: expanded from here
  "esp"
  ^
  1 error generated.
  ERROR:	unable to compile -
  Hint:	Check error message shown above.
  Hint:	You can also pre-compile it into .o using:
     		  clang -target bpf -O2 -c -
     	  with proper -I and -D options.
  Failed to compile test case: 'kbuild searching'
  test child finished with -1
  ---- end ----
  LLVM search and compile subtest 1: FAILED!

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/r/20171128175948.GL3298@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/asm.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -136,6 +136,7 @@
 #endif
 
 #ifndef __ASSEMBLY__
+#ifndef __BPF__
 /*
  * This output constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
@@ -145,5 +146,6 @@
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif
+#endif
 
 #endif /* _ASM_X86_ASM_H */
