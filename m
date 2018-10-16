Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F3C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DA42089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7Pm+4T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DA42089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeJQBHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbeJQBHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:07:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0648A20866;
        Tue, 16 Oct 2018 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710150;
        bh=fAPK7RD7/GUcnpPUdBzqdRvmiGz9uxnGIBOcgQK6HnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7Pm+4T2jHap0DbbQW1MkQ1m0tM+l340dl8lyw6kPNrgChryi4nvZsH1JkaftTuks
         +dFiuXEDOzBm5sc3+cWVq5U+nUJuUECyWJynpamb5Td/qn143ZtqqrPzRrQQ5XwFZz
         WofheuTQ6kkDluJYWFoEJv/npuzMuvDjSfnwRb0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.18 118/135] perf script python: Fix export-to-postgresql.py occasional failure
Date:   Tue, 16 Oct 2018 19:05:48 +0200
Message-Id: <20181016170523.442001717@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 25e11700b54c7b6b5ebfc4361981dae12299557b upstream.

Occasional export failures were found to be caused by truncating 64-bit
pointers to 32-bits. Fix by explicitly setting types for all ctype
arguments and results.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180911114504.28516-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/scripts/python/export-to-postgresql.py |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -204,14 +204,23 @@ from ctypes import *
 libpq = CDLL("libpq.so.5")
 PQconnectdb = libpq.PQconnectdb
 PQconnectdb.restype = c_void_p
+PQconnectdb.argtypes = [ c_char_p ]
 PQfinish = libpq.PQfinish
+PQfinish.argtypes = [ c_void_p ]
 PQstatus = libpq.PQstatus
+PQstatus.restype = c_int
+PQstatus.argtypes = [ c_void_p ]
 PQexec = libpq.PQexec
 PQexec.restype = c_void_p
+PQexec.argtypes = [ c_void_p, c_char_p ]
 PQresultStatus = libpq.PQresultStatus
+PQresultStatus.restype = c_int
+PQresultStatus.argtypes = [ c_void_p ]
 PQputCopyData = libpq.PQputCopyData
+PQputCopyData.restype = c_int
 PQputCopyData.argtypes = [ c_void_p, c_void_p, c_int ]
 PQputCopyEnd = libpq.PQputCopyEnd
+PQputCopyEnd.restype = c_int
 PQputCopyEnd.argtypes = [ c_void_p, c_void_p ]
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \


