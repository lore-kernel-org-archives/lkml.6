Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EB5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD6D208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emc.com header.i=@emc.com header.b="rGPPXBbg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emc.com header.i=@emc.com header.b="uhUB5CkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD6D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936402AbeFOTNr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:13:47 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:13502 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936358AbeFOTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=emc.com; i=@emc.com; q=dns/txt; s=jan2013;
  t=1529090026; x=1560626026;
  h=cc:from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=MKWFSVBRqANK+SeuD7BTh+k00tXDL4yJRCvoEl/ApmI=;
  b=rGPPXBbgef8/VqtMSHiv2+dliQVlXlov9VkdP9NeDv04H7aYgGGlHLG9
   ETlfCqGudrOB1Yhcxpy3yMoXutff5CDsfUfFcmWn9Z8XCv6Fr1Ocl7Vls
   DI73u6IfjClLtU+DD4uK1CLIB9/jpFUUWQrcLXSdgYFI2qQ1LjsYGstJv
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FbAQDlDiRbhz+a6ERbHAEBAQQBAQoBA?=
 =?us-ascii?q?YJ1gSeBDSgKi3OMUoVekRCBPTsLLoQ+AoJTITQYAQIBAQEBAQECAQECEAEBAQo?=
 =?us-ascii?q?LCQgpIwyCNSQBDkshCDMBAQEBAQEBAQEBAQEBAQEBAQEXAkMTWwYfGgERASoUQ?=
 =?us-ascii?q?iYBBAEagxqCAQGsMoJ4hVGBYAiHQ4EJgVU+gQ+DDIR3gzCCJJkQAwQCApAwAYw?=
 =?us-ascii?q?GkRoCBAIEBQIUgUGCC3CDE4Ivg06KUm+PP4EaAQE?=
X-IPAS-Result: =?us-ascii?q?A2FbAQDlDiRbhz+a6ERbHAEBAQQBAQoBAYJ1gSeBDSgKi3O?=
 =?us-ascii?q?MUoVekRCBPTsLLoQ+AoJTITQYAQIBAQEBAQECAQECEAEBAQoLCQgpIwyCNSQBD?=
 =?us-ascii?q?kshCDMBAQEBAQEBAQEBAQEBAQEBAQEXAkMTWwYfGgERASoUQiYBBAEagxqCAQG?=
 =?us-ascii?q?sMoJ4hVGBYAiHQ4EJgVU+gQ+DDIR3gzCCJJkQAwQCApAwAYwGkRoCBAIEBQIUg?=
 =?us-ascii?q?UGCC3CDE4Ivg06KUm+PP4EaAQE?=
Received: from esa3.dell-outbound2.iphmx.com ([68.232.154.63])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 14:13:45 -0500
Cc:     "Somarouthu, Murali" <Murali.Somarouthu@dell.com>
Received: from mailuogwhop.emc.com ([168.159.213.141])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2018 01:11:12 +0600
Received: from maildlpprd03.lss.emc.com (maildlpprd03.lss.emc.com [10.253.24.35])
        by mailuogwprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w5FJDfLB025212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Jun 2018 15:13:44 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd04.lss.emc.com w5FJDfLB025212
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
        t=1529090024; bh=O34Dt+5VWvIdziLZzi/fSVHVqjY=;
        h=From:To:CC:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=uhUB5CkR3Jg/o0OfKnmCxWP1Hlibolgu2yIMzo2xCSIOyafuwIINugt6zXfx53n92
         G6prQt+pvDrUJg0j2jO4Bz6H/2z6DqoKZf0Xv7ORVk6tHFXS2XJLfcFfkb2ysa6Odm
         qVfpIESLsaNq9eC/XRBHoiV7dh6kdlrdlTSkCTmw=
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd04.lss.emc.com w5FJDfLB025212
Received: from mailusrhubprd52.lss.emc.com (mailusrhubprd52.lss.emc.com [10.106.48.25]) by maildlpprd03.lss.emc.com (RSA Interceptor); Fri, 15 Jun 2018 15:13:32 -0400
Received: from MXHUB203.corp.emc.com (MXHUB203.corp.emc.com [10.253.68.29])
        by mailusrhubprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w5FJDVh1017723
        (version=TLSv1.2 cipher=AES128-SHA256 bits=128 verify=FAIL);
        Fri, 15 Jun 2018 15:13:32 -0400
Received: from MX202CL04.corp.emc.com ([fe80::2c45:625c:d914:779]) by
 MXHUB203.corp.emc.com ([10.253.68.29]) with mapi id 14.03.0382.000; Fri, 15
 Jun 2018 15:13:31 -0400
From:   "Veluthakkal, Sreeram" <Sreeram.Veluthakkal@emc.com>
To:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Recall: PROBLEM: JFFS2 Empty summary info causes OOPS
Thread-Topic: PROBLEM: JFFS2 Empty summary info causes OOPS
Thread-Index: AdQE3PI8iorCtr0MSpWcP8pS9Zw+Kw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Fri, 15 Jun 2018 19:13:31 +0000
Message-ID: <CD71A13FD89021478C0F0D323D55243A015AF10A@MX202CL04.corp.emc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.168.21.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd52.lss.emc.com
X-RSA-Classifications: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Veluthakkal, Sreeram would like to recall the message, "PROBLEM: JFFS2 Empt=
y summary info causes OOPS".=
