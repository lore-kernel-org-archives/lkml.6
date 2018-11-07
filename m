Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C99C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9706F20883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9706F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeKHJPT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 04:15:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:35463 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeKHJPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 04:15:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 15:42:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,477,1534834800"; 
   d="scan'208";a="90296320"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2018 15:42:36 -0800
Received: from orsmsx108.amr.corp.intel.com ([169.254.2.228]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.166]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 15:42:36 -0800
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 7/8] device-dax: Add support for a dax override driver
Thread-Topic: [PATCH 7/8] device-dax: Add support for a dax override driver
Thread-Index: AQHUcMlYxFUYfFbaG0yZkuAZG4fsaqVFi6WA
Date:   Wed, 7 Nov 2018 23:42:35 +0000
Message-ID: <3501c074cf14f6a671632c6a6aaffe77cc5b9512.camel@intel.com>
References: <154095556915.3271337.12581429676272726902.stgit@dwillia2-desk3.amr.corp.intel.com>
         <154095560594.3271337.11620109886861134971.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154095560594.3271337.11620109886861134971.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.34.127]
Content-Type: text/plain; charset="utf-7"
Content-ID: <26905435016A1943B616359192FCFA31@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 20:13 -0700, Dan Williams wrote:
+AD4- Introduce the 'new+AF8-id' concept for enabling a custom device-driver attach
+AD4- policy for dax-bus drivers. The intended use is to have a mechanism for
+AD4- hot-plugging device-dax ranges into the page allocator on-demand. With
+AD4- this in place the default policy of using device-dax for performance
+AD4- differentiated memory can be overridden by user-space policy that can
+AD4- arrange for the memory range to be managed as 'System RAM' with
+AD4- user-defined NUMA and other performance attributes.
+AD4- 
+AD4- Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
+AD4- ---
+AD4-  drivers/dax/bus.c    +AHw-  145 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---
+AD4-  drivers/dax/bus.h    +AHw-   10 +-+-+-
+AD4-  drivers/dax/device.c +AHw-   11 +-+---
+AD4-  3 files changed, 156 insertions(+-), 10 deletions(-)
+AD4- 
+AD4- 

Here's an incremental fixup for the string matching in this patch, I'll
send a v2 if other review comments come in:

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 178d76504f79..17af6fbc3be5 100644
--- a/drivers/dax/bus.c
+-+-+- b/drivers/dax/bus.c
+AEAAQA- -39,7 +-39,7 +AEAAQA- static struct dax+AF8-id +ACoAXwBf-dax+AF8-match+AF8-id(struct dax+AF8-device+AF8-driver +ACo-dax+AF8-drv,
 	lockdep+AF8-assert+AF8-held(+ACY-dax+AF8-bus+AF8-lock)+ADs-
 
 	list+AF8-for+AF8-each+AF8-entry(dax+AF8-id, +ACY-dax+AF8-drv-+AD4-ids, list)
-		if (strcmp(dax+AF8-id-+AD4-dev+AF8-name, dev+AF8-name) +AD0APQ- 0)
+-		if (sysfs+AF8-streq(dax+AF8-id-+AD4-dev+AF8-name, dev+AF8-name))
 			return dax+AF8-id+ADs-
 	return NULL+ADs-
 +AH0-
+AEAAQA- -60,6 +-60,7 +AEAAQA- static ssize+AF8-t do+AF8-id+AF8-store(struct device+AF8-driver +ACo-drv, const char +ACo-buf,
 +AHs-
 	struct dax+AF8-device+AF8-driver +ACo-dax+AF8-drv +AD0- to+AF8-dax+AF8-drv(drv)+ADs-
 	unsigned int region+AF8-id, id+ADs-
+-	char devname+AFs-DAX+AF8-NAME+AF8-LEN+AF0AOw-
 	struct dax+AF8-id +ACo-dax+AF8-id+ADs-
 	ssize+AF8-t rc +AD0- count+ADs-
 	int fields+ADs-
+AEAAQA- -67,8 +-68,8 +AEAAQA- static ssize+AF8-t do+AF8-id+AF8-store(struct device+AF8-driver +ACo-drv, const char +ACo-buf,
 	fields +AD0- sscanf(buf, +ACI-dax+ACU-d.+ACU-d+ACI-, +ACY-region+AF8-id, +ACY-id)+ADs-
 	if (fields +ACEAPQ- 2)
 		return -EINVAL+ADs-
-
-	if (strlen(buf) +- 1 +AD4- DAX+AF8-NAME+AF8-LEN)
+-	sprintf(devname, +ACI-dax+ACU-d.+ACU-d+ACI-, region+AF8-id, id)+ADs-
+-	if (+ACE-sysfs+AF8-streq(buf, devname))
 		return -EINVAL+ADs-
 
 	mutex+AF8-lock(+ACY-dax+AF8-bus+AF8-lock)+ADs-
+AEAAQA- -99,7 +-100,6 +AEAAQA- static ssize+AF8-t new+AF8-id+AF8-store(struct device+AF8-driver +ACo-drv, const char +ACo-buf,
 +AH0-
 static DRIVER+AF8-ATTR+AF8-WO(new+AF8-id)+ADs-
 
-
 static ssize+AF8-t remove+AF8-id+AF8-store(struct device+AF8-driver +ACo-drv, const char +ACo-buf,
 		size+AF8-t count)
 +AHs-


