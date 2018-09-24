Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D20ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DB0208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DB0208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeIXRjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:39:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeIXRjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:39:10 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03F15106B;
        Mon, 24 Sep 2018 11:37:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 3.18 027/105] kbuild: make missing $DEPMOD a Warning instead of an Error
Date:   Mon, 24 Sep 2018 13:33:13 +0200
Message-Id: <20180924113116.420213832@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 914b087ff9e0e9a399a4927fa30793064afc0178 upstream.

When $DEPMOD is not found, only print a warning instead of exiting
with an error message and error status:

Warning: 'make modules_install' requires /sbin/depmod. Please install it.
This is probably in the kmod package.

Change the Error to a Warning because "not all build hosts for cross
compiling Linux are Linux systems and are able to provide a working
port of depmod, especially at the file patch /sbin/depmod."

I.e., "make modules_install" may be used to copy/install the
loadable modules files to a target directory on a build system and
then transferred to an embedded device where /sbin/depmod is run
instead of it being run on the build system.

Fixes: 934193a654c1 ("kbuild: verify that $DEPMOD is installed")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/depmod.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -15,9 +15,9 @@ if ! test -r System.map ; then
 fi
 
 if [ -z $(command -v $DEPMOD) ]; then
-	echo "'make modules_install' requires $DEPMOD. Please install it." >&2
+	echo "Warning: 'make modules_install' requires $DEPMOD. Please install it." >&2
 	echo "This is probably in the kmod package." >&2
-	exit 1
+	exit 0
 fi
 
 # older versions of depmod don't support -P <symbol-prefix>


