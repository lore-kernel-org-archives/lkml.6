Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C691C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698DB2176F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfACRSv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:18:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:47092 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732548AbfACRSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:18:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 09:18:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="115225824"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2019 09:18:50 -0800
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 3 Jan 2019 09:18:50 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.158]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.53]) with mapi id 14.03.0415.000;
 Thu, 3 Jan 2019 09:18:50 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v4 0/3] pstore/rom: new support logger for block devices
Thread-Topic: [RFC v4 0/3] pstore/rom: new support logger for block devices
Thread-Index: AQHUozhqO1w/2T4wnE2emvMOu7brUqWdyBJA
Date:   Thu, 3 Jan 2019 17:18:49 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D4B623C@ORSMSX110.amr.corp.intel.com>
References: <1546501533-1855-1-git-send-email-liaoweixiong@allwinnertech.com>
In-Reply-To: <1546501533-1855-1-git-send-email-liaoweixiong@allwinnertech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjU0YzA2N2EtNWY1NS00MGNlLWFhMWUtZWVmZDRmMTM1ZDJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWEU0XC9xMnZXZm5TcmhqWUV0K05sTmMxd0RHWVlzdU5vQWdhOXhVQW1wR3NSTStmRlBpMWxaZk05K3NWRXpCQkUifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious why you call this "pstore/rom" rather than the more descriptive "pstore/block".

It looks to be a really good idea.

I think you need to document how the "write" function for the block device must be written.
Since pstore calls this at "panic" time, the write path:

+ Cannot allocate any memory
+ Must be polled, not interrupt driven
+ Cannot take any locks that may be held by regular code
+ ... perhaps other restrictions that I can't think of right now

The memory allocation restriction is likely easy to get around. Just allocate anything
you need at pstore "init" time rather than waiting until the panic.

-Tony

