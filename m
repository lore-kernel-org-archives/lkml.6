Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEF3C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B175C21722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B175C21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeHHLtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:49:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:45822 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbeHHLtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:49:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 02:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="61541521"
Received: from sofia.sh.intel.com (HELO sofia) ([10.239.147.112])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2018 02:30:18 -0700
Date:   Wed, 8 Aug 2018 17:29:27 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     broonie@opensource.wolfsonmicro.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        changcheng.liu@intel.com
Subject: [PATCH] ASoC: trace: track dapm type in snd_soc_dapm_widget
Message-ID: <20180808092927.GA144203@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track snd_soc_dapm_widget:id which is used as dapm
sequence index in dapm_down_seq/dapm_up_seq. It's
useful for checking dapm seq after tracking it.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 40c300f..0bc935b 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -92,16 +92,18 @@ DECLARE_EVENT_CLASS(snd_soc_dapm_widget,
 
 	TP_STRUCT__entry(
 		__string(	name,	w->name		)
+		__field(	int,	id		)
 		__field(	int,	val		)
 	),
 
 	TP_fast_assign(
 		__assign_str(name, w->name);
+		__entry->id = w->id;
 		__entry->val = val;
 	),
 
-	TP_printk("widget=%s val=%d", __get_str(name),
-		  (int)__entry->val)
+	TP_printk("widget=%s dapm_id=%d val=%d", __get_str(name),
+		  (int)__entry->id, (int)__entry->val)
 );
 
 DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_power,
-- 
2.7.4

