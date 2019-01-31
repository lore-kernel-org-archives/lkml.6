Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A2BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43022218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfAaKPi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:15:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:48871 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfAaKPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:15:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 02:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="271410419"
Received: from irsmsx106.ger.corp.intel.com ([163.33.3.31])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2019 02:15:34 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX106.ger.corp.intel.com ([169.254.8.161]) with mapi id 14.03.0415.000;
 Thu, 31 Jan 2019 10:12:28 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Oleg Nesterov" <oleg@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: RE: [PATCH] uprobes: convert uprobe.ref to refcount_t
Thread-Topic: [PATCH] uprobes: convert uprobe.ref to refcount_t
Thread-Index: AQHUrY2Yq0EjPRAwRUCLAKsVmClMRaWx6DQAgAc3rACAEB97sA==
Date:   Thu, 31 Jan 2019 10:12:28 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B9BCAD@IRSMSX102.ger.corp.intel.com>
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
        <20190116084452.773833d4@gandalf.local.home>
 <20190121125756.b06de37c0c52b1b882b3df67@kernel.org>
In-Reply-To: <20190121125756.b06de37c0c52b1b882b3df67@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTlkN2U2NTUtZjg2MC00MTc3LWEwMTktYjdlYzcwZWM4M2Q3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNGJSZ1U4Q0c3aFMrc2plMU1oYVdOZHp6b3RLQ0NZeTRub1JNR2t2SUJrWnV3RUZKU0dzXC93cDF2RUVzaGJiR2UifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > [ Cc'ing Masami as he maintains uprobes (we need to add uprobes to
> >   the MAINTAINERS file ]
> 
> Thanks Steve, I think it is maintained mainly by Srikar and Oleg.
> Srikar, Oleg, could you update MAINTAINERS file to add UPROBES entry?
> And ack this change?

Srikar, Oleg, could you please take a look on the change, if possible, it is
really a trivial one in this case.

Best Regards,
Elena.
