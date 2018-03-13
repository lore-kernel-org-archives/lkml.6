Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeCMNXE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:23:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeCMNTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:19:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] debugobjects: avoid another unused variable warning.
Date: Tue, 13 Mar 2018 14:18:46 +0100
Message-Id: <20180313131857.158876-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:Y0R+d5wy/OEQ52CnrUhtAamEQPfBMlTSBNnkqBSBxFqJn5gYQfV
 dKRzakRHYfFKfVeQWIda60ytm+v6oL1xI/iAXeip0UwxasvDY0DOe5LVHzJXdDvqDHsqIcp
 QUpH4qs7nTUtvRybbI3o8wfwyFyT2T3d5/cfkbGZW4sMBKovRjwRtSJ/5qKyh0lAL0c8NF3
 uYmbAGdBxuqVWw4RGt6Xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nu3siHqP9fg=:R4GoMU7fv2U1yKgWUMTMy1
 2Yi3IzATZylh4rHOC+TcNFJbFVQDXPAjQ35PzYay80/Elrpt5f/xka8cOppzLiZeTEMvfxV0b
 01d0MhJUfaqvfSoZ03D6/UP0DH2+z63ISw3QmUh1dy4nCtishHsFGXKidquEpzRjEE1XDKe/j
 gqvOcpSTbKhdYHdGFAEEDQhGGW3w08IZqgYwGgoICVDHC4zq9BbwINk3j2fpF94BvCvVWaQxZ
 B1NVN4zFjnpxm4+pNwPN5ixredSVhxsT4ySvBKVdtMh9ySYNRhZ9hLLBEHexv9pMjMggeyb3L
 HLz1wdtjxP3w+py42aqj0BiMG3mav8RhMvKQaGRfmYQVqd8ppPuxlfAx+Ltm52foUJJH/trDg
 9U7DIlgGnQEn/omvtCArZC96yxcsAjd2GvDJK+OVJ3a8SCkKy/dmKuLqqt+NnIlrSVqY08Nrr
 yLCANsGtgOCAbnhuCyE47b0587yBneXZ9/016PK2RWzQUnW0xkhwONzCf2jo2IHRASF5j4+Ms
 Co6fkAtR08W8YC2LMIYV62mpSz6SqQ5qEDJ7WxNphSOwGZf8yuPqWuT5vgM8ZMmR0yeM6xNH+
 TZEXHPY5LG7jXgNrYJ0riFL96CgBzB3jsxPjW+wLyMl7XoxcZ+tDjlPSMTuLB2teatZ5kMUU0
 Tg2onMb17B9xJfvhLTTA3/NBKrVTWnwUTH6AgMWtRfz3wH0vSA8eXovFt5YfOEgQo0VCxy5WR
 DRcUMIhyKIkgq8P+Ssw+7fr/YR360LXoeS11EQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debug_objects_maxchecked is only updated in __debug_check_no_obj_freed(),
and only read in debug_objects_maxchecked, unfortunately both of
these are optional and depend on different Kconfig symbols. When both
CONFIG_DEBUG_OBJECTS_FREE and CONFIG_DEBUG_FS are disabled, we get
this warning:

lib/debugobjects.c:56:14: error: 'debug_objects_maxchecked' defined but not used [-Werror=unused-variable]

Rather than trying to add more complex #ifdef protections, this marks
the variable as __maybe_unused so it can be silently dropped when
usused.

Fixes: bd9dcd046509 ("debugobjects: Export max loops counter")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 105ecfc47d8c..994be4805cec 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -53,7 +53,7 @@ static int			obj_nr_tofree;
 static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
-static int			debug_objects_maxchecked __read_mostly;
+static int __maybe_unused	debug_objects_maxchecked __read_mostly;
 static int			debug_objects_fixups __read_mostly;
 static int			debug_objects_warnings __read_mostly;
 static int			debug_objects_enabled __read_mostly
-- 
2.9.0
