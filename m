Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC8AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DF22148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="RvteVn7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DF22148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeJQV43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:56:29 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:56800 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQV43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:56:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 04DD6A2F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1kQoqUF6okgE for <linux-kernel@vger.kernel.org>;
        Wed, 17 Oct 2018 09:00:37 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id C4FA3179
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:00:37 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id f18so2066696itk.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/goqZAtDD5LIfBcMbUDlFWpd0V/S3kz2A3SN5nyISS4=;
        b=RvteVn7cwqKSGvlfivw0n8oC1/riSeykNyYK0gY4Rnq/M4diMRxA9QIa7vNUv1vb9o
         o+j+TDQx3kjNHd/u9cgao1pvARTfG2iTZ4/l9RoxDYVbXqCV1JWtIv2nlu8j0297ZPj8
         9bVke/FWM1HlTXfK/AVmrbCrNum+T3zsCRlzyDCMQPGbaUC4bg1cS4KmZLwWMTmlpRKd
         DWJkytV9ZIS5dMasrttPIosvqSWUgaQIkzLy4nOJDOcFYWlbShs/4sL58sS+uEg1GtVH
         Y7MhLF8MVXZUYYhYmdbhFu0pCTQW8Y0DzpoaJVY2g+9cddJD0LN1xptXfAsqEJnqIYk2
         WEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/goqZAtDD5LIfBcMbUDlFWpd0V/S3kz2A3SN5nyISS4=;
        b=n2nkrLJIKkpBy9QcXRcguvNmPEJLoy0goc8BMHd3hBaaCrCCTXWTMAcM6q+6AXDkbe
         C33YcDpKawIscq6tc/pmLH6769M7uFhC9SA1kE1I3cwrI/5VuN/u1+J7a8gxOnljgCeV
         uKTOehOcZhz7tToQIeeVYO6zU2guv0JgxREBkzc0IFoRjI1O2L133CQEhT6TZ5VU3XWG
         HFIVJh5a+G/OHx6D7hMEYjH0X1A5c6xCm8SR5pxxGXhvreAmvBDf4bHKm5Cplp+8XPGl
         jHehIfRQreY52vMglXchFyNEqlIx4F5T9JpEIoI0ChcNG6ep3sZkmQOxq7AXmAKWnI1G
         x8Dw==
X-Gm-Message-State: ABuFfoiFA4G3u6+fHssWLMkJzXYPcaLH2yfuUGBcca8cDMYZdM6+OXTz
        7snVGTLlDxGlEsDJs31g4XhrqPnJ/rogZMnhVl3X+jndphm2AXm/YIl5hD56g0KmwYkoclbxMwY
        9wBYCG2jW03U1zdYz2NuBphR96XUB
X-Received: by 2002:a24:9287:: with SMTP id l129-v6mr1649921itd.26.1539784837330;
        Wed, 17 Oct 2018 07:00:37 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61JeB3Q55q3Bht3vSZmcjfiO7WFIv/UT5bpMsUUkrzubZM3WtADgCwtBOCIMBu3zRlyDtz/Sg==
X-Received: by 2002:a24:9287:: with SMTP id l129-v6mr1649904itd.26.1539784837067;
        Wed, 17 Oct 2018 07:00:37 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id 184-v6sm837438itk.41.2018.10.17.07.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 07:00:36 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thunderbolt: Fix a missing-check bug
Date:   Wed, 17 Oct 2018 09:00:29 -0500
Message-Id: <1539784829-1159-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tb_cfg_copy(), the header of the received control package, which is in
the buffer 'pkg->buffer', is firstly parsed through parse_header() to make
sure the header is in the expected format. In parse_header(), the header is
actually checked by invoking check_header(), which checks the 'unknown'
field of the header and the response route acquired through
'tb_cfg_get_route(header)'. If there is no error in this checking process,
the package, including the header, is then copied to 'req->response' in
tb_cfg_copy() through memcpy() and the parsing result is saved to
'req->result'.

The problem here is that the whole parsing and checking process is
conducted directly on the buffer 'pkg->buffer', which is actually a DMA
region and allocated through dma_pool_alloc() in tb_ctl_pkg_alloc(). Given
that the DMA region can also be accessed directly by a device at any time,
it is possible that a malicious device can race to modify the package data
after the parsing and checking process but before memcpy() is invoked in
tb_cfg_copy(). Through this way, the attacker can bypass the parsing and
checking process and inject malicious data. This can potentially cause
undefined behavior of the kernel and introduce unexpected security risk.

This patch firstly copies the header of the package to a stack variable
'hdr' and performs the parsing and checking process on 'hdr'. If there is
no error in this process, 'hdr' is then used to rewrite the header in
'req->response' after memcpy(). This way, the above issue can be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/thunderbolt/ctl.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 37a7f4c..ae4cd61 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -166,10 +166,9 @@ tb_cfg_request_find(struct tb_ctl *ctl, struct ctl_pkg *pkg)
 
 
 static int check_header(const struct ctl_pkg *pkg, u32 len,
-			enum tb_cfg_pkg_type type, u64 route)
+			enum tb_cfg_pkg_type type, u64 route,
+			const struct tb_cfg_header *hdr)
 {
-	struct tb_cfg_header *header = pkg->buffer;
-
 	/* check frame, TODO: frame flags */
 	if (WARN(len != pkg->frame.size,
 			"wrong framesize (expected %#x, got %#x)\n",
@@ -183,12 +182,12 @@ static int check_header(const struct ctl_pkg *pkg, u32 len,
 		return -EIO;
 
 	/* check header */
-	if (WARN(header->unknown != 1 << 9,
-			"header->unknown is %#x\n", header->unknown))
+	if (WARN(hdr->unknown != 1 << 9,
+			"hdr->unknown is %#x\n", hdr->unknown))
 		return -EIO;
-	if (WARN(route != tb_cfg_get_route(header),
+	if (WARN(route != tb_cfg_get_route(hdr),
 			"wrong route (expected %llx, got %llx)",
-			route, tb_cfg_get_route(header)))
+			route, tb_cfg_get_route(hdr)))
 		return -EIO;
 	return 0;
 }
@@ -215,14 +214,15 @@ static int check_config_address(struct tb_cfg_address addr,
 	return 0;
 }
 
-static struct tb_cfg_result decode_error(const struct ctl_pkg *response)
+static struct tb_cfg_result decode_error(const struct ctl_pkg *response,
+					 const struct tb_cfg_header *hdr)
 {
 	struct cfg_error_pkg *pkg = response->buffer;
 	struct tb_cfg_result res = { 0 };
-	res.response_route = tb_cfg_get_route(&pkg->header);
+	res.response_route = tb_cfg_get_route(hdr);
 	res.response_port = 0;
 	res.err = check_header(response, sizeof(*pkg), TB_CFG_PKG_ERROR,
-			       tb_cfg_get_route(&pkg->header));
+			       tb_cfg_get_route(hdr), hdr);
 	if (res.err)
 		return res;
 
@@ -237,17 +237,17 @@ static struct tb_cfg_result decode_error(const struct ctl_pkg *response)
 }
 
 static struct tb_cfg_result parse_header(const struct ctl_pkg *pkg, u32 len,
-					 enum tb_cfg_pkg_type type, u64 route)
+					 enum tb_cfg_pkg_type type, u64 route,
+					 const struct tb_cfg_header *hdr)
 {
-	struct tb_cfg_header *header = pkg->buffer;
 	struct tb_cfg_result res = { 0 };
 
 	if (pkg->frame.eof == TB_CFG_PKG_ERROR)
-		return decode_error(pkg);
+		return decode_error(pkg, hdr);
 
 	res.response_port = 0; /* will be updated later for cfg_read/write */
-	res.response_route = tb_cfg_get_route(header);
-	res.err = check_header(pkg, len, type, route);
+	res.response_route = tb_cfg_get_route(hdr);
+	res.err = check_header(pkg, len, type, route, hdr);
 	return res;
 }
 
@@ -753,13 +753,18 @@ static bool tb_cfg_match(const struct tb_cfg_request *req,
 
 static bool tb_cfg_copy(struct tb_cfg_request *req, const struct ctl_pkg *pkg)
 {
+	struct tb_cfg_header hdr;
 	struct tb_cfg_result res;
 
+	hdr = *(struct tb_cfg_header *)pkg->buffer;
+
 	/* Now make sure it is in expected format */
 	res = parse_header(pkg, req->response_size, req->response_type,
-			   tb_cfg_get_route(req->request));
-	if (!res.err)
+			   tb_cfg_get_route(req->request), &hdr);
+	if (!res.err) {
 		memcpy(req->response, pkg->buffer, req->response_size);
+		*(struct tb_cfg_header *)req->response = hdr;
+	}
 
 	req->result = res;
 
-- 
2.7.4

