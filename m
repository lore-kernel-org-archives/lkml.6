Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeCYS2n (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:28:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39136 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeCYS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:28:36 -0400
X-Google-Smtp-Source: AG47ELvAJYTUyFN8zLwpdfb7Gqi7tiBoyuQK/cpthhjt2XGTOfit/2GuoFUBohUQLNvp6wWgugUzAw==
From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
        <avarab@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
        <avarab@gmail.com>
Subject: [PATCH 2/2] send-email: supply a --send-delay=1 by default
Date: Sun, 25 Mar 2018 18:28:03 +0000
Message-Id: <20180325182803.30036-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.37.g46b2b28759
In-Reply-To: <20180325182803.30036-1-avarab@gmail.com>
References: <20180325182803.30036-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer-Send-Delay: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The earlier change to add this option described the problem this
option is trying to solve.

This turns it on by default with a value of 1 second, which'll
hopefully solve it, and if not user reports as well as the
X-Mailer-Send-Delay header should help debug it.

I think the trade-off of slowing down E-Mail sending to turn this on
makes sense because:

 * GMail is a really common client, git.git's own unique authors by
   %aE are ~30% @gmail.com, ~20% for linux.git. That's just patch
   submitters, my guess is this it's much more common among those who
   mostly read the list, and those users who aren't using mu4e / mutt
   etc. anyway.

 * There's really no point in having this feature at all if it's not
   made the default, since the entire point is to be able to read a
   list like the git ML or the LKML and have patches from others show
   up in order.

 * I don't think anyone's really sensitive to the sending part of
   send-email taking longer. You just choose "all" and then switch to
   another terminal while it does its thing if you have a huge series,
   and for 1-3 patches I doubt anyone would notice this anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 13 ++++++++++++-
 git-send-email.perl      |  1 +
 t/t9001-send-email.sh    |  4 ++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f155d349c0..bd578642c1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3070,7 +3070,18 @@ sendemail.smtpReloginDelay::
 
 sendemail.smtpSendDelay::
 	Seconds wait in between message sending before sending another
-	message. Set it to 0 to impose no extra delay, defaults to 0.
+	message. Set it to 0 to impose no extra delay, defaults to 1
+	to wait 1 second.
++
+The reason for imposing a default delay is because certain popular
+E-Mail clients such as Google's GMail completely ignore the "Date"
+header, which format-patch is careful to set such that the patches
+will be displayed in order, and instead sort by the time the E-mail
+was received.
++
+This causes sent E-Mail to be shown completely out of order in such
+clients, imposing the delay is a workaround that should usually work
+(although it's by no means guaranteed).
 +
 See also the `--send-delay` option of linkgit:git-send-email[1].
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 013277ede2..ddbc44f1c9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -489,6 +489,7 @@ die sprintf(__("Unknown --confirm setting: '%s'\n"), $confirm)
 	unless $confirm =~ /^(?:auto|cc|compose|always|never)/;
 die sprintf(__("Invalid --send-delay setting: '%s'\n"), $send_delay)
 	if defined $send_delay and $send_delay !~ /^[0-9]+$/s;
+$send_delay = 1 unless defined $send_delay;
 
 # Debugging, print out the suppressions.
 if (0) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index fafa61c5d6..1580e00fce 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1713,7 +1713,7 @@ test_expect_success '--send-delay expects whole non-negative seconds' '
 	test_i18ngrep "Invalid --send-delay setting" errors
 '
 
-test_expect_success $PREREQ "there is no default --send-delay" '
+test_expect_success $PREREQ "there is a default --send-delay" '
 	clean_fake_sendmail &&
 	rm -fr outdir &&
 	git format-patch -3 -o outdir &&
@@ -1724,7 +1724,7 @@ test_expect_success $PREREQ "there is no default --send-delay" '
 		outdir/*.patch \
 		2>stderr >stdout &&
 	test $(grep -c "X-Mailer:" stdout) = 3 &&
-	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 0
+	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 2
 '
 
 test_expect_success $PREREQ '--send-delay adds a X-Mailer-Send-Delay header to affected E-Mails' '
-- 
2.16.2.804.g6dcf76e118
