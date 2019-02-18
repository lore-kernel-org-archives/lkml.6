Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F53421902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498736;
	bh=R49b2dskifUW+hW2ZzMC1TYKj2HjCIxwv/17qx9rknc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCxwoo0vjDMeIgQfAFb1hvvHm/IF1L/sHrFQKBmGpqByKNUVzI4Fcp+1cfo8brPns
	 U9mtglGgO1Yt5KpkkO2jNBSKyYMw+lUxTaQ+gJl7Gw829G/bhIf6+clat64yzFt9jQ
	 /U3XFXu0vLOFvEDVmrem96gxdo0JAMILQ9HmA/KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbfBROFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390152AbfBROFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359E0204FD;
        Mon, 18 Feb 2019 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498728;
        bh=R49b2dskifUW+hW2ZzMC1TYKj2HjCIxwv/17qx9rknc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZecZnwgJWliGqmfpY8MZVlb2L/mNzhl17Na6jeajor7nC+e8vj5seHXseLFeghDS
         HWJzpN+6CECV2Vs5R+QwDyE0Dzx7mt05KptHD/P4UgF0Y3AxciZMl+8I2stCELr+e7
         KcEgPn0zUlYpgwrMY73EBIxIHZgbCMZc9FUd92SY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Metcalf <cmetcalf@ezchip.com>
Subject: [PATCH 4.4 076/143] string: drop __must_check from strscpy() and restore strscpy() usages in cgroup
Date:   Mon, 18 Feb 2019 14:43:24 +0100
Message-Id: <20190218133531.865846132@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 08a77676f9c5fc69a681ccd2cd8140e65dcb26c7 upstream.

e7fd37ba1217 ("cgroup: avoid copying strings longer than the buffers")
converted possibly unsafe strncpy() usages in cgroup to strscpy().
However, although the callsites are completely fine with truncated
copied, because strscpy() is marked __must_check, it led to the
following warnings.

  kernel/cgroup/cgroup.c: In function ‘cgroup_file_name’:
  kernel/cgroup/cgroup.c:1400:10: warning: ignoring return value of ‘strscpy’, declared with attribute warn_unused_result [-Wunused-result]
     strscpy(buf, cft->name, CGROUP_FILE_NAME_MAX);
	       ^

To avoid the warnings, 50034ed49645 ("cgroup: use strlcpy() instead of
strscpy() to avoid spurious warning") switched them to strlcpy().

strlcpy() is worse than strlcpy() because it unconditionally runs
strlen() on the source string, and the only reason we switched to
strlcpy() here was because it was lacking __must_check, which doesn't
reflect any material differences between the two function.  It's just
that someone added __must_check to strscpy() and not to strlcpy().

These basic string copy operations are used in variety of ways, and
one of not-so-uncommon use cases is safely handling truncated copies,
where the caller naturally doesn't care about the return value.  The
__must_check doesn't match the actual use cases and forces users to
opt for inferior variants which lack __must_check by happenstance or
spread ugly (void) casts.

Remove __must_check from strscpy() and restore strscpy() usages in
cgroup.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
[backport only the string.h portion to remove build warnings starting to show up - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/string.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -26,7 +26,7 @@ extern char * strncpy(char *,const char
 size_t strlcpy(char *, const char *, size_t);
 #endif
 #ifndef __HAVE_ARCH_STRSCPY
-ssize_t __must_check strscpy(char *, const char *, size_t);
+ssize_t strscpy(char *, const char *, size_t);
 #endif
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);


