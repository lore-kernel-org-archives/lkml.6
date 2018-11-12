Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D318C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0AE224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="SGulNnAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0AE224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeKMFbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:31:17 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:58920 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbeKMFbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:31:16 -0500
X-Greylist: delayed 2347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 00:31:16 EST
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id wACIvVgI027705;
        Mon, 12 Nov 2018 18:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=jan2016.eng; bh=fMZiJ0p13XxGxV1rWLgOdxKlJa8Dqn5g/BZhv/7maKg=;
 b=SGulNnAjh45ESVUZwZPbNXrWV0EjD10ewvXiqBGlLLY1hKrq1SLEOCUaNTOYszdtKzMX
 eIDRjFnqIQVzdE1WGeiQn/fAYCM+psVGIeGiUeY7CWMK4TnBkkYnSK/5jiS9YXRrXE0Q
 Cce21j71j3UmvDq3adgin/a+w5N8x2bKKO5NsZ7C8nxVPwVQKQCI79gVb6ak5EUkdjZH
 vh1r9HQr1AB5IH+NG2SN6gsUHqZxbXlbX8urZP8fZCZPtpOMuJgg3B17KqsMvy6l8n/D
 uZxL7tq8X8f1XUXrh4e/bS3ejlR2RAtRJ/MZNQk8UXI4JK/CdKvycl/AprnvajdmJDDD Bg== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
        by m0050093.ppops.net-00190b01. with ESMTP id 2nqax6gu5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Nov 2018 18:57:30 +0000
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.21/8.16.0.21) with SMTP id wACIoLV7014651;
        Mon, 12 Nov 2018 13:57:28 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2nnujej314-1;
        Mon, 12 Nov 2018 13:57:28 -0500
Received: from bos-lpo4l.kendall.corp.akamai.com (bos-lpo4l.kendall.corp.akamai.com [172.28.13.75])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 168981FCDD;
        Mon, 12 Nov 2018 18:57:28 +0000 (GMT)
Received: from mzhivich by bos-lpo4l.kendall.corp.akamai.com with local (Exim 4.86_2)
        (envelope-from <mzhivich@akamai.com>)
        id 1gMHOq-0004TC-07; Mon, 12 Nov 2018 13:57:28 -0500
From:   Michael Zhivich <mzhivich@akamai.com>
To:     linux-kernel@vger.kernel.org
Cc:     omosnace@redhat.com, arnd@arndb.de, jason.wessel@windriver.com,
        john.stultz@linaro.org, Michael Zhivich <mzhivich@akamai.com>
Subject: [PATCH] Revert "clocksource: Make clocksource validation work for all clocksources"
Date:   Mon, 12 Nov 2018 13:56:51 -0500
Message-Id: <20181112185651.17138-1-mzhivich@akamai.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811120164
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=918 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811120165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert commit 1f45f1f33c8c ("clocksource: Make clocksource validation work
for all clocksources") to restore correct clocksource_delta() computation
for clocksources that wrap frequently, while retaining the check for tsc
drifting.

Truncating result of clocksource_delta() to 0 causes incorrect behavior for
clocksources that wrap frequently (e.g. acpi_pm which is only 24-bit wide).
In particular, large time deltas (e.g. last = 0x000000, now = 0x800000)
will be incorrectly computed as 0.

If acpi_pm is used as the clocksource watchdog, and machine is under heavy
load, the time period for the watchdog check may be significantly longer
than the requested 0.5 seconds.  If the watchdog check is delayed by 2
seconds (observed behavior), then acpi_pm time delta will be 

	2.5 sec * 3579545 ticks/sec = 8948863 = 0x888c3f

which will be treated as negative and truncated to 0.  This behavior will
cause tsc to be incorrectly declared unstable in clocksource_watchdog(), as
it no longer agrees with acpi_pm.

Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
---
 kernel/time/timekeeping_internal.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index bcbb52db2256..21463e20d008 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -18,11 +18,7 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 {
 	u64 ret = (now - last) & mask;
 
-	/*
-	 * Prevent time going backwards by checking the MSB of mask in
-	 * the result. If set, return 0.
-	 */
-	return ret & ~(mask >> 1) ? 0 : ret;
+	return (s64) ret > 0 ? ret : 0;
 }
 #else
 static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
-- 
2.19.1

