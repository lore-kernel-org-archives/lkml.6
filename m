Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CEAC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6989222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083517;
	bh=g836qVs7FTSdQ1eq7h7ZiBcmUbHhJ5EFABGN1lOZ/EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JEt1F8y94GtwJ6Ft3EKLM/9z/RTaRrrIhcwUtD6t+VSzUiEfSCmSEfHRoJfU5hebt
	 OXINZgTXZ9UGlok3utWMEcySrsUWvIZvohcqckBjNEmQkAEmYAe14O7iX8sMAG+qb6
	 8ogTPoE2qc6znCa19Y5Xwia84ucFHC4vOoKaYPYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406207AbfBMSpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406190AbfBMSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5BA222D1;
        Wed, 13 Feb 2019 18:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083512;
        bh=g836qVs7FTSdQ1eq7h7ZiBcmUbHhJ5EFABGN1lOZ/EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfrKf9ASGGB+EfxER0jNaNkJhkWBJUgH9bx3oLs7aMadBXW8AR4Nr4fmRH5UQbFAP
         v41U5R8GvqC8dHabqSkzo9YImnQa3owyfj2qpo3LwG0FyvX8Ozu31tuCrxifj0yw8O
         7qY4obBFDqaehPkE5Lr0jb+X2tM+QsMOG7w0JZr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kelly <mkelly@xevo.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.20 06/50] tools: iio: iio_generic_buffer: make num_loops signed
Date:   Wed, 13 Feb 2019 19:38:11 +0100
Message-Id: <20190213183656.291941329@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kelly <mkelly@xevo.com>

commit b119d3bc328e7a9574861ebe0c2110e2776c2de1 upstream.

Currently, num_loops is unsigned, but it's set by strtoll, which returns a
(signed) long long int. This could lead to overflow, and it also makes the
check "num_loops < 0" always be false, since num_loops is unsigned.
Setting num_loops to -1 to loop forever is almost working because num_loops
is getting set to a very high number, but it's technically still incorrect.

Fix this issue by making num_loops signed. This also fixes an error found
by Smatch.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 55dda0abcf9d ("tools: iio: iio_generic_buffer: allow continuous looping")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/iio/iio_generic_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -330,7 +330,7 @@ static const struct option longopts[] =
 
 int main(int argc, char **argv)
 {
-	unsigned long long num_loops = 2;
+	long long num_loops = 2;
 	unsigned long timedelay = 1000000;
 	unsigned long buf_len = 128;
 


