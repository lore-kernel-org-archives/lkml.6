Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE03C20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="okmlp/sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE03C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeICOWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:22:53 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:36748 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeICOWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:22:52 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w83A2Asa026175;
        Mon, 3 Sep 2018 19:02:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w83A2Asa026175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535968934;
        bh=jZz5vEBBKyoS8DPA04R5YUMr9afvaUUY3YFW6xxEhdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okmlp/sPEceMa+T+GWBmmLxKXVscTZVf7nYVz2Mqw9umCmfNP1ZikxrLHC0t2FPW7
         9e3IxzCdg1eikUht0dDaLhzGmGjvV9+gvxz+DzerECZPFXGCB9416h2CsBL3E32DeQ
         6mlNaW9SRFBG+z/Uli8QII8nKK9CW40N5tuvjQAUm8NbzMfNXc6B2NzTLJnwrZExpQ
         Mdco0ad7jedpmzdS/CaQXgyWjqcaDZAmLnnTrgA1oF7VMQQqlK2/huM8aEgXvCZAbW
         md720HH62h/rQm12pQiV6ZtCmlqRA4o5jqzNLGgTWSIUBagDXo4A8kWQtWLrMOEKTf
         4c8uzYlOuWISA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        =?UTF-8?q?Michal=20Such=8F=AB=A1nek?= <msuchanek@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] kbuild: rpm-pkg: set KCONFIG_NONINTERACTIVE_UPDATE
Date:   Mon,  3 Sep 2018 19:01:56 +0900
Message-Id: <1535968916-9159-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535968916-9159-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535968916-9159-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent "make syncconfig" from prompting user inputs when new symbols
become available due to build environment changes.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/mkspec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index f72c46a..86986c1 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -87,7 +87,7 @@ $S	%prep
 $S	%setup -q
 $S
 $S	%build
-$S	make %{?_smp_mflags} ARCH=$ARCH KBUILD_BUILD_VERSION=%{release}
+$S	make %{?_smp_mflags} ARCH=$ARCH KBUILD_BUILD_VERSION=%{release} KCONFIG_NONINTERACTIVE_UPDATE=1
 $S
 	%install
 	mkdir -p %{buildroot}/boot
-- 
2.7.4

