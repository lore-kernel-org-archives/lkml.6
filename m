Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBUSoR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:44:17 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41630 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeBUSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:44:15 -0500
X-Google-Smtp-Source: AH8x226lJLt0+eS/0Fc0LU3mOgraRtg7XE0K8Izj9V0qPsqiRMY7KtXcvDvsaI5+N5PeiogLyKUQ4A==
Date: Wed, 21 Feb 2018 21:44:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, avagin@virtuozzo.com
Subject: [PATCH] proc: fix /proc/*/map_files lookup some more
Message-ID: <20180221184411.GA25924@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I totally forgot that _parse_integer() accepts arbitrary amount of
leading zeroes leading to the following:

		OK
	# readlink /proc/1/map_files/56427ecba000-56427eddc000
	/lib/systemd/systemd

		bogus
	# readlink /proc/1/map_files/00000000000056427ecba000-56427eddc000
	/lib/systemd/systemd
	# readlink /proc/1/map_files/56427ecba000-00000000000056427eddc000
	/lib/systemd/systemd

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1913,9 +1913,11 @@ static int dname_to_vma_addr(struct dentry *dentry,
 			     unsigned long *start, unsigned long *end)
 {
 	const char *str = dentry->d_name.name;
+	unsigned int len = dentry->d_name.len;
 	unsigned long long sval, eval;
-	unsigned int len;
 
+	if (len > 1 && *str == '0')
+		return -EINVAL;
 	len = _parse_integer(str, 16, &sval);
 	if (len & KSTRTOX_OVERFLOW)
 		return -EINVAL;
@@ -1927,6 +1929,9 @@ static int dname_to_vma_addr(struct dentry *dentry,
 		return -EINVAL;
 	str++;
 
+	len = strlen(str);
+	if (len > 1 && *str == '0')
+		return -EINVAL;
 	len = _parse_integer(str, 16, &eval);
 	if (len & KSTRTOX_OVERFLOW)
 		return -EINVAL;
