Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75995C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D952147E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="dsrC98N0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D952147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIMEZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:25:08 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:7135 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeIMEZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536794304; x=1568330304;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HlmKVFPFlkeYjVOQE9DPg9Bnik20VNGb0BuUYK1593g=;
  b=dsrC98N0C7Ed4l5FMfz1w9HJ4oMjNVLyJJoWDH/ZQDjK8l1WiFaXrVrw
   yQh/IB/GwuYD/Aka8mMA0hCRVaDqMt5zcFgCB1UQ/WWGH3aqUYAcqdOeq
   yJjc7+Pnfp1qzE/7MdN2mo8CUuPgbI+uny0UMYrQogEinZuDdntd6Zprc
   Q=;
X-IronPort-AV: E=Sophos;i="5.53,366,1531785600"; 
   d="scan'208";a="697388666"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Sep 2018 23:18:22 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8CNIHOx000618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 12 Sep 2018 23:18:20 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8CNIEQn011201;
        Thu, 13 Sep 2018 01:18:15 +0200
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Subject: [RFC 00/60] Coscheduling for Linux
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180912002449.GA21797@breakout>
 <c41f4e4f-30a1-5a3c-dec6-dc8f1d181c94@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <89b4f0cd-d324-14bd-3991-576de9849e34@amazon.de>
Date:   Thu, 13 Sep 2018 01:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c41f4e4f-30a1-5a3c-dec6-dc8f1d181c94@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 09:34 PM, Jan H. Schönherr wrote:
> That said, I see a hang, too. It seems to happen, when there is a
> cpu.scheduled!=0 group that is not a direct child of the root task group.
> You seem to have "/sys/fs/cgroup/cpu/machine" as an intermediate group.
> (The case ==0 within !=0 within the root task group works for me.)
> 
> I'm going to dive into the code.

With the patch below (which technically changes patch 55/60), the hang I experienced is gone.

Please let me know, if it works for you as well.

Regards
Jan


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8da2033596ff..2d8b3f9a275f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7189,23 +7189,26 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		while (!(cfs_rq = is_same_group(se, pse))) {
 			int se_depth = se->depth;
 			int pse_depth = pse->depth;
+			bool work = false;

-			if (se_depth <= pse_depth && leader_of(pse) == cpu) {
+			if (se_depth <= pse_depth && __leader_of(pse) == cpu) {
 				put_prev_entity(cfs_rq_of(pse), pse);
 				pse = parent_entity(pse);
+				work = true;
 			}
-			if (se_depth >= pse_depth && leader_of(se) == cpu) {
+			if (se_depth >= pse_depth && __leader_of(se) == cpu) {
 				set_next_entity(cfs_rq_of(se), se);
 				se = parent_entity(se);
+				work = true;
 			}
-			if (leader_of(pse) != cpu && leader_of(se) != cpu)
+			if (!work)
 				break;
 		}

-		if (leader_of(pse) == cpu)
-			put_prev_entity(cfs_rq, pse);
-		if (leader_of(se) == cpu)
-			set_next_entity(cfs_rq, se);
+		if (__leader_of(pse) == cpu)
+			put_prev_entity(cfs_rq_of(pse), pse);
+		if (__leader_of(se) == cpu)
+			set_next_entity(cfs_rq_of(se), se);
 	}

 	goto done;
