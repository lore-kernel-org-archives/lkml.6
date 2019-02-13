Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED0C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2505B222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083460;
	bh=pCrA9DnvXyUZCIZuZekvFr4M676JCjrG80AsUmbqbcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R5MBXgWzD8cs1sRPgbSXhBAcbI2piTZehhk5bwKqbwtXrdn5em6KhGFR9sPpc/ivK
	 N7ST6bQmSz9O2lt5INvT3h8OvT8kRKNyVpP1l+GPhfAm9V+swdN+sUccVrbpsCfYAf
	 OkEsMLrTodhe2oOAOK9GvsJT3mc6SejV70twkpl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406107AbfBMSoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406094AbfBMSoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D87820811;
        Wed, 13 Feb 2019 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083456;
        bh=pCrA9DnvXyUZCIZuZekvFr4M676JCjrG80AsUmbqbcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmGFeM8cEygpPwTIo786/0gGASMuoGg4dBdfNCjYM85wuQI73FZevhVQHqyxEX2hG
         vJQZlK5+MnDlSV7ZdHEwTFqE4kglhQQ/LwwgHDxhOUlAeJswW414oLXkHIWWG5BViK
         S/PUvJz6sLiMxFXXQqQMjrzI9OvyJnsr/YSHyBGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kelly <mkelly@xevo.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 06/44] tools: iio: iio_generic_buffer: make num_loops signed
Date:   Wed, 13 Feb 2019 19:38:07 +0100
Message-Id: <20190213183652.201907766@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 


