Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D81C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B9B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCWWrozD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B9B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeK0OJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:09:21 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:46452 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeK0OJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:09:20 -0500
Received: by mail-io1-f50.google.com with SMTP id v10so10145294ios.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 19:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGt0nwknXf8js5Tv9n0b8MS3AqmG0XFqvIR4lkoqZTw=;
        b=QCWWrozDLm9AGnpjiOXGa4PFMJN2Pf/cim+RMMzNvMJ6syz7bMXCxXmB1XpvnddaUo
         1lqSL6yjBjp4deDVpxQ1qlTg7UY+QRMefZozjSETvA/H41P2GdddstjILPBPbkYrabJn
         IICVT3FKOS8AGAsa8nCYLIovyU2tcPKNOJmlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGt0nwknXf8js5Tv9n0b8MS3AqmG0XFqvIR4lkoqZTw=;
        b=AKqrTvK9EMaXJkEXtsL5SZBxCIOKSbQaesLGjvReQu+nBlyKy0Qc50v1E34jgNdsrx
         lUoPbYnadm0mRK8ooM7jMMUpNfIKgc16ZTJwHFVgssc4ODHHSS0ijXgMyzDyX7kth1vM
         T+xNQoCqIRdy4m//5t/JFw1cR5wY3hRsuoTcucHw6nO88buxQMAtoEC5XDm+ZiPL0uFX
         G7Gs/mQrT2Cl5+MH/NZmJzFNP4bitM5vxnIVqnxnuJgpF7U3GqKoPB+0suEmkNhX3fdM
         PYb5d+f/ZvPxno3yAktfjlPQoIipgqqJpNSPhGZLm71k4Ud7PRHxbSARSEalZclIzcES
         5Eag==
X-Gm-Message-State: AA+aEWY3T+V81ugy1HfK+yTKYbKKbyewQEWypKcCm+yGPGUZYQDC7yRu
        Uei+YU5tumjHePnF7cF+fEF8sCh3sKA=
X-Google-Smtp-Source: AFSGD/UMJ8pPtIU5vLa2r3TkJVC5NfColD3DTzPvA5gdtMWD8pCL2/4rj9UkRxmGlR6JW8C+PJc8tw==
X-Received: by 2002:a5d:8b8d:: with SMTP id p13mr16027638iol.223.1543288376162;
        Mon, 26 Nov 2018 19:12:56 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id w186sm1149449itb.15.2018.11.26.19.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 19:12:55 -0800 (PST)
From:   Dan Rue <dan.rue@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Rue <dan.rue@linaro.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests: firmware: remove use of non-standard diff -Z option
Date:   Mon, 26 Nov 2018 21:12:15 -0600
Message-Id: <20181127031218.24419-2-dan.rue@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181127031218.24419-1-dan.rue@linaro.org>
References: <20181127031218.24419-1-dan.rue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Z is used to trim the trailing whitespace when comparing the
loaded firmware file with the source firmware file. However, per the
comment in the source code, -Z should not be necessary. In testing, the
input and output files are identical.

Additionally, -Z is not a standard option and is not available in
environments such as busybox. When -Z is not supported, diff fails with
a usage error, which is suppressed, but then causes read_firmwares() to
exit with a false failure message.

Signed-off-by: Dan Rue <dan.rue@linaro.org>
---
 tools/testing/selftests/firmware/fw_filesystem.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index a4320c4b44dc..466cf2f91ba0 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -155,11 +155,8 @@ read_firmwares()
 {
 	for i in $(seq 0 3); do
 		config_set_read_fw_idx $i
-		# Verify the contents are what we expect.
-		# -Z required for now -- check for yourself, md5sum
-		# on $FW and DIR/read_firmware will yield the same. Even
-		# cmp agrees, so something is off.
-		if ! diff -q -Z "$FW" $DIR/read_firmware 2>/dev/null ; then
+		# Verify the contents match
+		if ! diff -q "$FW" $DIR/read_firmware 2>/dev/null ; then
 			echo "request #$i: firmware was not loaded" >&2
 			exit 1
 		fi
@@ -171,7 +168,7 @@ read_firmwares_expect_nofile()
 	for i in $(seq 0 3); do
 		config_set_read_fw_idx $i
 		# Ensures contents differ
-		if diff -q -Z "$FW" $DIR/read_firmware 2>/dev/null ; then
+		if diff -q "$FW" $DIR/read_firmware 2>/dev/null ; then
 			echo "request $i: file was not expected to match" >&2
 			exit 1
 		fi
-- 
2.19.1

