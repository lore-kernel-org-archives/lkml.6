Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8311EC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AA324FC0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AA324FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754843AbeFXPba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:31:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeFXPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:31:28 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0BDC92C;
        Sun, 24 Jun 2018 15:31:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 39/52] cpufreq: Fix new policy initialization during limits updates via sysfs
Date:   Sun, 24 Jun 2018 23:21:32 +0800
Message-Id: <20180624142746.780465691@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tao Wang <kevin.wangtao@hisilicon.com>

commit c7d1f119c48f64bebf0fa1e326af577c6152fe30 upstream.

If the policy limits are updated via cpufreq_update_policy() and
subsequently via sysfs, the limits stored in user_policy may be
set incorrectly.

For example, if both min and max are set via sysfs to the maximum
available frequency, user_policy.min and user_policy.max will also
be the maximum.  If a policy notifier triggered by
cpufreq_update_policy() lowers both the min and the max at this
point, that change is not reflected by the user_policy limits, so
if the max is updated again via sysfs to the same lower value,
then user_policy.max will be lower than user_policy.min which
shouldn't happen.  In particular, if one of the policy CPUs is
then taken offline and back online, cpufreq_set_policy() will
fail for it due to a failing limits check.

To prevent that from happening, initialize the min and max fields
of the new_policy object to the ones stored in user_policy that
were previously set via sysfs.

Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Subject & changelog ]
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cpufreq.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -693,6 +693,8 @@ static ssize_t store_##file_name					\
 	struct cpufreq_policy new_policy;				\
 									\
 	memcpy(&new_policy, policy, sizeof(*policy));			\
+	new_policy.min = policy->user_policy.min;			\
+	new_policy.max = policy->user_policy.max;			\
 									\
 	ret = sscanf(buf, "%u", &new_policy.object);			\
 	if (ret != 1)							\


