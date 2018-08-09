Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EFC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040D921C1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040D921C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeHIFUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:20:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:47955 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeHIFUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:20:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 19:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,213,1531810800"; 
   d="scan'208";a="63707131"
Received: from sofia.sh.intel.com (HELO sofia) ([10.239.147.112])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2018 19:57:54 -0700
Date:   Thu, 9 Aug 2018 10:57:03 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     broonie@opensource.wolfsonmicro.com, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        changcheng.liu@intel.com
Subject: [PATCH v2 2/2] ASoC: trace: track dapm type in snd_soc_dapm_widget
Message-ID: <20180809025703.GF161967@sofia>
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
index bf17edc..7c4e8de 100644
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
+		__entry->id = (int)w->id;
 		__entry->val = val;
 	),
 
-	TP_printk("widget=%s val=%d", __get_str(name),
-		__entry->val)
+	TP_printk("widget=%s dapm_id=%d val=%d", __get_str(name),
+		__entry->id, __entry->val)
 );
 
 DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_power,
-- 
2.7.4

