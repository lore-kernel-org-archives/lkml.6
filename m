Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F0AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1751F20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1751F20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbeFROIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:08:35 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752835AbeFROIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:08:34 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MfYYl-1fsKpY3PKt-00P2Sb; Mon, 18 Jun 2018 16:08:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] time: use ktime_get_real_seconds() in time syscall
Date:   Mon, 18 Jun 2018 16:08:00 +0200
Message-Id: <20180618140811.2998503-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180618140811.2998503-1-arnd@arndb.de>
References: <20180618140811.2998503-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ILctjl/yi2BLphw2pskkao6oJ1ToCOp+B/AJwZs18nQpYNtvlOe
 9mNdKLmwZU1Yy8ZjGLfqu23CdJmz1ci8C0eQRtkTe4MMW0LCweOgkYrP5I4KPixq6sXGGkG
 t1dcn2q+bWodb8KOoY67m7OB2hfm4nyr2yN2beoMYW2YmhGmSKsIuNmrNakHHHU/t/KrH+s
 KnxJDxHjyeqKmpMqcO4bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2OuSd07hyLY=:5HYrRiud3+Bbs0BYbiQsiE
 rNPhy+4ujHOtjNxdaKBS/3lUyaYv/2xnn9xj4dxcGM49CXMjf2oiYzc8tfoW1jN5GZXbj/ot6
 D1s66894aKieyog88EBhwbmjt1U2+RitfY7V/38xJFbmV5lI9tFBjEtFMNJ62INcBp/hGGjkz
 g9reXhkZLcsZdV17br26pJo8VMfID+hU241BpR5hpRtlXKBdhEpCiSDFOa/YtCxGZLcI5NMDb
 NhesmhMoV5VRzFMc+PGlkWX7DLB6bP5UggTJrWw4epRFufKcM9jV+R+hlZmHASHzxFBdlrR5h
 i3Qbz/wnvLKwegAS1ZFFwhqgepAjq9Apfekyya81mwWX1wvgplyjBhxXo+R4vIIqLLRb+VJ5f
 PfhGhnfItg49VmgEJDsBTaknTPxNcbQdCEiIAYrY3CGxXyH1DSdtjyfzVEpP9YdPm2I1MIMLv
 paK7YarypxGpN9n/MbxJtjMRdsy8KMnZPbS37/kS5AoFNG3YdaY5lpvG/SQ/xl2VCLJVVnSsG
 czzoDei7iliBbfwlztCasB9vS2D2Z2f+1XOBc1/MOoSq6Ifb5b6maJmlIHMX4xGOeNiHFjmg7
 dHtMa9M594G/dkRc4q6fPgKOdKjZPxKByyMFZPEp+NbkwqfX9QSo0/KpSTL0YnZx4snC/Y2+8
 G9XgZ0zHIJXvbDdkgPqiQbUT6vIdMKcBqUDYT8msRdkztfM9CzRntddoysWZ3TdrqdxY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both get_seconds() and do_gettimeofday() are deprecated. Let's
change the time() implementation to use the replacement function
instead.

Obviously the system call will still overflow in 2038, but this
gets us closer to removing the old helper functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/time.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 8e4f3fd2f84b..90867ece5c09 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -63,7 +63,7 @@ EXPORT_SYMBOL(sys_tz);
  */
 SYSCALL_DEFINE1(time, time_t __user *, tloc)
 {
-	time_t i = get_seconds();
+	time_t i = (time_t)ktime_get_real_seconds();
 
 	if (tloc) {
 		if (put_user(i,tloc))
@@ -106,11 +106,9 @@ SYSCALL_DEFINE1(stime, time_t __user *, tptr)
 /* compat_time_t is a 32 bit "long" and needs to get converted. */
 COMPAT_SYSCALL_DEFINE1(time, compat_time_t __user *, tloc)
 {
-	struct timeval tv;
 	compat_time_t i;
 
-	do_gettimeofday(&tv);
-	i = tv.tv_sec;
+	i = (compat_time_t)ktime_get_real_seconds();
 
 	if (tloc) {
 		if (put_user(i,tloc))
-- 
2.9.0

