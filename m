Return-Path: <richard@nod.at>
X-Google-Smtp-Source: AH8x224/ubiOYqqcnAE+2GLlkRSWQVM6YB4W6tHQTaOVFhVVouIc1FJJugxjr6xBMFG74IVlNRrf
ARC-Seal: i=1; a=rsa-sha256; t=1518899929; cv=none;
        d=google.com; s=arc-20160816;
        b=l/tuZUKzENQ0zFJ8WLy9S2zGABw7eNuz6joXg7x4qLjQzPw+N0j42dXfEMecz7COu8
         G10ta0zGxxGs1UdanqyKl5blQpIEO9jLDJewbfys4a4wA+OnRP45Ki+R2tIEqJkaWwP9
         0zceGV7K087BKDSC7CyhVseciZ+lolwMsH1aGQZznQyjMHNkb8QEIcTiKPHdIFsQa5+C
         dyPTiWAOvCWM9B4Hp2FEbDF2XUXQmeP4C9qnYH2amqydZgmOf0IUKSyxbHpv6QNq9ttg
         Kcdj5x5cT/D+JN0iXJyFsZOtyjMo2LnRfFsHKJhxlc+c5zXFtauwOoi6Tm5duHTrWMR2
         0wMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Skoj2i2kHS7RhEyngRxZYbFmk7gVbmpGi8k6Zfm+F2g=;
        b=M5z8kz8FdSzyX9GbfLNJROStNmabswthDs2WtH8EN7u8PZGDqZsZTlfcUJKyuEqfkx
         uaU6tTCXuHgDBd+R99XGBZxUAch8tN/gYSTDDp7o+Py3T1kHXu1jsu82oSiNofTOL8YM
         KeC0znzx8jjY24jDA7uwp9hfpdvVhykxNvG8ZCQqfi++D981EQ9WV3pfdGZ53YU5hMNf
         JHtjiNE4/trWUXUFs3QkoAJX6NLjdTJf1laoZAUDVCXWm/hTZ+I1hKYZvgIc8axAxO9z
         wX7/SjrGmMsf0Z0vB5cEPnohH8aaYHT+s9iX4mMbcW7nuXDovO/Xy3Ftoz7GkcKFBg12
         XLMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	kstewart@linuxfoundation.org,
	npiggin@gmail.com,
	yamada.masahiro@socionext.com,
	keescook@chromium.org,
	akpm@linux-foundation.org,
	david@sigma-star.at,
	Richard Weinberger <richard@nod.at>,
	Sam Ravnborg <sam@ravnborg.org>,
	Arnaud Lacombe <lacombar@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>,
	Michal Marek <mmarek@suse.cz>,
	Nicolas Pitre <nico@linaro.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] kbuild: Don't source kernel config
Date: Sat, 17 Feb 2018 21:39:45 +0100
Message-Id: <20180217203945.2515-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592682011895749448?=
X-GMAIL-MSGID: =?utf-8?q?1592682011895749448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Don't source the kernel config file in shell scripts.
The config file is not a shell script and often imported from untrusted
sources.
What could possible go wrong? ;-)

Instead, read config file line by line and access config entries using a bash
array.

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnaud Lacombe <lacombar@gmail.com>
Cc: Nick Bowler <nbowler@elliptictech.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Fixes: 23121ca2b56b ("kbuild: create/adjust generated/autoksyms.h")
Fixes: 1f2bfbd00e46 ("kbuild: link of vmlinux moved to a script")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/adjust_autoksyms.sh | 13 +++----------
 scripts/importkconf.sh      | 14 ++++++++++++++
 scripts/link-vmlinux.sh     | 23 ++++++++---------------
 3 files changed, 25 insertions(+), 25 deletions(-)
 create mode 100755 scripts/importkconf.sh

diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 513da1a4a2da..632abcd0dc69 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -39,14 +39,7 @@ case "$KBUILD_VERBOSE" in
 esac
 
 # We need access to CONFIG_ symbols
-case "${KCONFIG_CONFIG}" in
-*/*)
-	. "${KCONFIG_CONFIG}"
-	;;
-*)
-	# Force using a file from the current directory
-	. "./${KCONFIG_CONFIG}"
-esac
+. scripts/importkconf.sh
 
 # In case it doesn't exist yet...
 if [ -e "$cur_ksyms_file" ]; then touch "$cur_ksyms_file"; fi
@@ -62,14 +55,14 @@ EOT
 [ "$(ls -A "$MODVERDIR")" ] &&
 sed -ns -e '3{s/ /\n/g;/^$/!p;}' "$MODVERDIR"/*.mod | sort -u |
 while read sym; do
-	if [ -n "$CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX" ]; then
+	if [ -n "${KERNEL_CONFIG[CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX]}" ]; then
 		sym="${sym#_}"
 	fi
 	echo "#define __KSYM_${sym} 1"
 done >> "$new_ksyms_file"
 
 # Special case for modversions (see modpost.c)
-if [ -n "$CONFIG_MODVERSIONS" ]; then
+if [ -n "${KERNEL_CONFIG[CONFIG_MODVERSIONS]}" ]; then
 	echo "#define __KSYM_module_layout 1" >> "$new_ksyms_file"
 fi
 
diff --git a/scripts/importkconf.sh b/scripts/importkconf.sh
new file mode 100755
index 000000000000..755a9a2e9c65
--- /dev/null
+++ b/scripts/importkconf.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+#
+# helper script which reads all kconfig keys from the kernel .config file into
+# a bash associative array.
+# By testing ${KERNEL_CONFIG[CONFIG_FOO_BAR]} shell scripts can check whether
+# CONFIG_FOO_BAR is set in .config or not.
+#
+
+declare -A KERNEL_CONFIG
+
+for cfg_ent in $(awk -F= '/^CONFIG_[A-Z0-9_]+=/{print $1}' < ${KCONFIG_CONFIG})
+do
+	KERNEL_CONFIG[${cfg_ent}]="$cfg_ent"
+done
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c0d129d7f430..c094dd8f19a2 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -55,7 +55,7 @@ info()
 #
 archive_builtin()
 {
-	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+	if [ -n "${KERNEL_CONFIG[CONFIG_THIN_ARCHIVES]}" ]; then
 		info AR built-in.o
 		rm -f built-in.o;
 		${AR} rcsTP${KBUILD_ARFLAGS} built-in.o			\
@@ -70,7 +70,7 @@ modpost_link()
 {
 	local objects
 
-	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+	if [ -n "${KERNEL_CONFIG[CONFIG_THIN_ARCHIVES]}" ]; then
 		objects="--whole-archive				\
 			built-in.o					\
 			--no-whole-archive				\
@@ -96,7 +96,7 @@ vmlinux_link()
 	local objects
 
 	if [ "${SRCARCH}" != "um" ]; then
-		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+		if [ -n "${KERNEL_CONFIG[CONFIG_THIN_ARCHIVES]}" ]; then
 			objects="--whole-archive			\
 				built-in.o				\
 				--no-whole-archive			\
@@ -116,7 +116,7 @@ vmlinux_link()
 		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}		\
 			-T ${lds} ${objects}
 	else
-		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+		if [ -n "${KERNEL_CONFIG[CONFIG_THIN_ARCHIVES]}" ]; then
 			objects="-Wl,--whole-archive			\
 				built-in.o				\
 				-Wl,--no-whole-archive			\
@@ -226,14 +226,7 @@ if [ "$1" = "clean" ]; then
 fi
 
 # We need access to CONFIG_ symbols
-case "${KCONFIG_CONFIG}" in
-*/*)
-	. "${KCONFIG_CONFIG}"
-	;;
-*)
-	# Force using a file from the current directory
-	. "./${KCONFIG_CONFIG}"
-esac
+. scripts/importkconf.sh
 
 # Update version
 info GEN .version
@@ -259,7 +252,7 @@ ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
 
 kallsymso=""
 kallsyms_vmlinux=""
-if [ -n "${CONFIG_KALLSYMS}" ]; then
+if [ -n "${KERNEL_CONFIG[CONFIG_KALLSYMS]}" ]; then
 
 	# kallsyms support
 	# Generate section listing all symbols and add it into vmlinux
@@ -312,7 +305,7 @@ fi
 info LD vmlinux
 vmlinux_link "${kallsymso}" vmlinux
 
-if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
+if [ -n "${KERNEL_CONFIG[CONFIG_BUILDTIME_EXTABLE_SORT]}" ]; then
 	info SORTEX vmlinux
 	sortextable vmlinux
 fi
@@ -321,7 +314,7 @@ info SYSMAP System.map
 mksysmap vmlinux System.map
 
 # step a (see comment above)
-if [ -n "${CONFIG_KALLSYMS}" ]; then
+if [ -n "${KERNEL_CONFIG[CONFIG_KALLSYMS]}" ]; then
 	mksysmap ${kallsyms_vmlinux} .tmp_System.map
 
 	if ! cmp -s System.map .tmp_System.map; then
-- 
2.13.6
