Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1792C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782262087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542973;
	bh=ged9Gv3SDWxAtzQMGLbjKOP3hxHX+H7arg2rD7vlsCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z7vgbaE1/PVimh+6JzTv0QWsuA82FN0FxKL02OutxFPRlhOsn8xGC19uzfWY3XBJU
	 /qcH1/IvNSrvs0AMTtF20AZ3BL7U1iUlpz9Wsz8o7bxYujp1PTl9GDi30T9t/z2C4Y
	 xF2sVffxCA79Sv7z09EphnfBA6P3DvSXfqnF6uWk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782262087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeLKPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:42:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbeLKPmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:42:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCE420870;
        Tue, 11 Dec 2018 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542968;
        bh=ged9Gv3SDWxAtzQMGLbjKOP3hxHX+H7arg2rD7vlsCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kt6guhFxvmSiCSIOtxUWGAtqTAaGFJH00cJli+ZZkQvaYjO2S660EGLnqLzNP0RoL
         cqQ0rm8DjtMMT5MFr1UBfPahgviABmMYCDhkWEeZNZSLCVnEc00QNqluMkQwu66X06
         bvsKzVaLIAAkvUmVjB+rZ/JCXTkdnJlAjc9PMIO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3.18 17/54] kernfs: Replace strncpy with memcpy
Date:   Tue, 11 Dec 2018 16:41:05 +0100
Message-Id: <20181211151546.944395296@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 166126c1e54d927c2e8efa2702d420e0ce301fd9 upstream.

gcc 8.1.0 complains:

fs/kernfs/symlink.c:91:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length
fs/kernfs/symlink.c: In function 'kernfs_iop_get_link':
fs/kernfs/symlink.c:88:14: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/symlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -88,7 +88,7 @@ static int kernfs_get_target_path(struct
 		int slen = strlen(kn->name);
 
 		len -= slen;
-		strncpy(s + len, kn->name, slen);
+		memcpy(s + len, kn->name, slen);
 		if (len)
 			s[--len] = '/';
 


