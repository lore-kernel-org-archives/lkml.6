Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeENSob (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:44:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751449AbeENSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:44:28 -0400
Date: Mon, 14 May 2018 21:44:16 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org, bamv2005@gmail.com, brgl@bgdev.pl,
        pbonzini@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] selftests: add headers_install to lib.mk
References: <20180413090351.25662-1-anders.roxell@linaro.org>
 <20180514115809.9803-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514115809.9803-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18051418-0020-0000-0000-0000041D25B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051418-0021-0000-0000-000042B23654
Message-Id: <20180514184415.GA24300@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 01:58:09PM +0200, Anders Roxell wrote:
> If the kernel headers aren't installed we can't build all the tests.
> Add a new make target rule 'khdr' in the file lib.mk to generate the
> kernel headers and that gets include for every test-dir Makefile that
> includes lib.mk If the testdir in turn have its own sub-dirs the
> top_srcdir needs to be set to the linux-rootdir to be able to generate
> the kernel headers.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>

Ack for the userfaultfd part.

> ---
>  Makefile                                          | 14 +-------------
>  scripts/subarch.include                           | 13 +++++++++++++
>  tools/testing/selftests/android/Makefile          |  2 +-
>  tools/testing/selftests/android/ion/Makefile      |  1 +
>  tools/testing/selftests/bpf/Makefile              |  5 ++---
>  tools/testing/selftests/futex/functional/Makefile |  1 +
>  tools/testing/selftests/gpio/Makefile             |  7 ++-----
>  tools/testing/selftests/kvm/Makefile              |  7 ++-----
>  tools/testing/selftests/lib.mk                    | 10 ++++++++++
>  tools/testing/selftests/vm/Makefile               |  4 ----
>  10 files changed, 33 insertions(+), 31 deletions(-)
>  create mode 100644 scripts/subarch.include
> 
> diff --git a/Makefile b/Makefile
> index 6395c79ffe40..bad0a8f6e874 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> 
> -# SUBARCH tells the usermode build what the underlying arch is.  That is set
> -# first, and if a usermode build is happening, the "ARCH=um" on the command
> -# line overrides the setting of ARCH below.  If a native build is happening,
> -# then ARCH is assigned, getting whatever value it gets normally, and
> -# SUBARCH is subsequently ignored.
> -
> -SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
> -				  -e s/sun4u/sparc64/ \
> -				  -e s/arm.*/arm/ -e s/sa110/arm/ \
> -				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
> -				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
> -				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
> -				  -e s/riscv.*/riscv/)
> +include scripts/subarch.include
> 
>  # Cross compiling and selecting different set of gcc/bin-utils
>  # ---------------------------------------------------------------------------
> diff --git a/scripts/subarch.include b/scripts/subarch.include
> new file mode 100644
> index 000000000000..650682821126
> --- /dev/null
> +++ b/scripts/subarch.include
> @@ -0,0 +1,13 @@
> +# SUBARCH tells the usermode build what the underlying arch is.  That is set
> +# first, and if a usermode build is happening, the "ARCH=um" on the command
> +# line overrides the setting of ARCH below.  If a native build is happening,
> +# then ARCH is assigned, getting whatever value it gets normally, and
> +# SUBARCH is subsequently ignored.
> +
> +SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
> +				  -e s/sun4u/sparc64/ \
> +				  -e s/arm.*/arm/ -e s/sa110/arm/ \
> +				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
> +				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
> +				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
> +				  -e s/riscv.*/riscv/)
> diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
> index 72c25a3cb658..d9a725478375 100644
> --- a/tools/testing/selftests/android/Makefile
> +++ b/tools/testing/selftests/android/Makefile
> @@ -6,7 +6,7 @@ TEST_PROGS := run.sh
> 
>  include ../lib.mk
> 
> -all:
> +all: khdr
>  	@for DIR in $(SUBDIRS); do		\
>  		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
>  		mkdir $$BUILD_TARGET  -p;	\
> diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
> index e03695287f76..f3be7dcc060a 100644
> --- a/tools/testing/selftests/android/ion/Makefile
> +++ b/tools/testing/selftests/android/ion/Makefile
> @@ -10,6 +10,7 @@ $(TEST_GEN_FILES): ipcsocket.c ionutils.c
> 
>  TEST_PROGS := ion_test.sh
> 
> +top_srcdir = ../../../../..
>  include ../../lib.mk
> 
>  $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 438d4f93875b..9741609a0eb1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -16,9 +16,8 @@ LDLIBS += -lcap -lelf -lrt -lpthread
>  TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
>  all: $(TEST_CUSTOM_PROGS)
> 
> -$(TEST_CUSTOM_PROGS): urandom_read
> -
> -urandom_read: urandom_read.c
> +$(TEST_CUSTOM_PROGS):| khdr
> +$(TEST_CUSTOM_PROGS): urandom_read.c
>  	$(CC) -o $(TEST_CUSTOM_PROGS) -static $<
> 
>  # Order correspond to 'make run_tests' order
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index ff8feca49746..ad1eeb14fda7 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -18,6 +18,7 @@ TEST_GEN_FILES := \
> 
>  TEST_PROGS := run.sh
> 
> +top_srcdir = ../../../../..
>  include ../../lib.mk
> 
>  $(TEST_GEN_FILES): $(HEADERS)
> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
> index 1bbb47565c55..4665cdbf1a8d 100644
> --- a/tools/testing/selftests/gpio/Makefile
> +++ b/tools/testing/selftests/gpio/Makefile
> @@ -21,11 +21,8 @@ endef
>  CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
>  LDLIBS += -lmount -I/usr/include/libmount
> 
> -$(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
> +$(BINARIES):| khdr
> +$(BINARIES): ../../../gpio/gpio-utils.o
> 
>  ../../../gpio/gpio-utils.o:
>  	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
> -
> -../../../../usr/include/linux/gpio.h:
> -	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
> -
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index d9d00319b07c..bcb69380bbab 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -32,9 +32,6 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
>  $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
>  	$(AR) crs $@ $^
> 
> -$(LINUX_HDR_PATH):
> -	make -C $(top_srcdir) headers_install
> -
> -all: $(STATIC_LIBS) $(LINUX_HDR_PATH)
> +all: $(STATIC_LIBS)
>  $(TEST_GEN_PROGS): $(STATIC_LIBS)
> -$(TEST_GEN_PROGS) $(LIBKVM_OBJ): | $(LINUX_HDR_PATH)
> +$(STATIC_LIBS):| khdr
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 6466294366dc..9515af872e16 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -16,8 +16,18 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
> 
> +top_srcdir ?= ../../../..
> +include $(top_srcdir)/scripts/subarch.include
> +ARCH		?= $(SUBARCH)
> +
>  all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> 
> +.PHONY: khdr
> +khdr:
> +	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
> +
> +$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES):| khdr
> +
>  .ONESHELL:
>  define RUN_TEST_PRINT_RESULT
>  	TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index fdefa2295ddc..58759454b1d0 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -25,10 +25,6 @@ TEST_PROGS := run_vmtests
> 
>  include ../lib.mk
> 
> -$(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
>  $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
> 
>  $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
> -
> -../../../../usr/include/linux/kernel.h:
> -	make -C ../../../.. headers_install
> -- 
> 2.17.0
> 

-- 
Sincerely yours,
Mike.
