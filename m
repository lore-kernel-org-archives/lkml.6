Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeBUTxp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:53:45 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38029 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBUTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:53:44 -0500
X-Google-Smtp-Source: AH8x224RbyLTefWVbu1RCRoCJgEIRz/ftj/WeIpRt2tyPnaQsTKWh+VZq6ZLn0jw9xPLkt3vXpTaZg==
Date: Wed, 21 Feb 2018 22:53:40 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2] proc: fix /proc/*/map_files lookup some more
Message-ID: <20180221195340.GA28911@avx2>
References: <20180221184411.GA25924@avx2>
 <20180221185143.GJ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221185143.GJ30522@ZenIV.linux.org.uk>
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

 fs/proc/base.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1916,6 +1916,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
 	unsigned long long sval, eval;
 	unsigned int len;
 
+	if (str[0] == '0' && str[1])
+		return -EINVAL;
 	len = _parse_integer(str, 16, &sval);
 	if (len & KSTRTOX_OVERFLOW)
 		return -EINVAL;
@@ -1927,6 +1929,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
 		return -EINVAL;
 	str++;
 
+	if (str[0] == '0' && str[1])
+		return -EINVAL;
 	len = _parse_integer(str, 16, &eval);
 	if (len & KSTRTOX_OVERFLOW)
 		return -EINVAL;
