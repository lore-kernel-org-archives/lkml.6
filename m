Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeB1GrL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:47:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:27079 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbeB1GrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:47:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,404,1515484800";
   d="scan'208";a="33420894"
From: "Zhang, Ning A" <ning.a.zhang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: maybe a bug in SELinux: security_context_to_sid_core
Thread-Topic: maybe a bug in SELinux: security_context_to_sid_core
Thread-Index: AQHTsF/zXv0WT/3/k0CHbnK7eA84DQ==
Date: Wed, 28 Feb 2018 06:47:07 +0000
Message-ID: <1519800427.32465.22.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2239AEC609D0AB4BAD84EC4079DA1A7D@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1S6pKWo016265

Hi,

Before SELinux is initialized, get scontext by secid by using:

security_secctx_to_secid() may return wrong numbe

eg:
security_secctx_to_secid("devnull", strlen("devnull"), &sid);

sid here will be 1

because:

in security_context_to_sid_core:

...
	if (!ss_initialized) {
		int i;

		for (i = 1; i < SECINITSID_NUM; i++) {
			if (!strcmp(initial_sid_to_string[i],
scontext)) {
				*sid = i;
				return 0;
			}
		}
		*sid = SECINITSID_KERNEL;
		return 0;
	}
...

and SECINITSID_DEVNULL equals to SECINITSID_NUM, and it will never get
right secid for "devnull".

is this by design or bug?

BR.
Ning.
