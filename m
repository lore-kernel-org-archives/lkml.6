Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9334C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6172086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570690;
	bh=DUdMgrn23iQlZWEpspHy7p6phNYBV2dSogT5ULN72RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zxtLw2ruSsK26ZdVX4RQyHk7+6RFqWzHJtd4t/NtRuG2wZWYmFrZE9S/WpkNsGa45
	 vg5MynRBtEejFh1IaeCzi8aDaply+9q9dFv/otE9xj9Rwm34304Sdl/TclEDTmkGaZ
	 nZ8xWu2htJO8B5GtzPoq18wFGAXspJTlXcLB6YxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfAOQot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbfAOQop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6D32054F;
        Tue, 15 Jan 2019 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570684;
        bh=DUdMgrn23iQlZWEpspHy7p6phNYBV2dSogT5ULN72RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2nB42Mj/LQbJAuSkHLpcDsgNpzcyGQdOJnqqQOip4bJ4V051vLi/JVnrXHhe5Id1n
         XSX5/QSdDHSpKRU4bkUqftJ8HrzlK837F8ofVd6WKyTM1znzMuUM3flE8/TFVSOanj
         tQCXG5ZuZJxuJTrv4yZZJAXjio34QD2ijBaxEIR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.20 06/57] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Date:   Tue, 15 Jan 2019 17:35:47 +0100
Message-Id: <20190115154911.072176226@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 1690d8bb91e370ab772062b79bd434ce815c4729 upstream.

Since the commit 2a4eb7358aba "OPP: Don't remove dynamic OPPs from
_dev_pm_opp_remove_table()", dynamically created OPP aren't
automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
affects the scpi and scmi cpufreq drivers which no longer free OPPs on
failures or on invocations of the policy->exit() callback.

Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
called from these drivers instead of dev_pm_opp_cpumask_remove_table().

In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
opp_list isn't getting accessed simultaneously from other parts of the
OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
the opp_table->lock while traversing through the OPP list. And to
accomplish that, this patch also creates _opp_kref_release_unlocked()
which can be called from this new helper with the opp_table lock already
held.

Cc: 4.20 <stable@vger.kernel.org> # v4.20
Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Fixes: 2a4eb7358aba "OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()"
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/scmi-cpufreq.c |    4 +-
 drivers/cpufreq/scpi-cpufreq.c |    4 +-
 drivers/opp/core.c             |   63 +++++++++++++++++++++++++++++++++++++----
 include/linux/pm_opp.h         |    5 +++
 4 files changed, 67 insertions(+), 9 deletions(-)

--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -176,7 +176,7 @@ static int scmi_cpufreq_init(struct cpuf
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	dev_pm_opp_cpumask_remove_table(policy->cpus);
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
 	return ret;
 }
@@ -188,7 +188,7 @@ static int scmi_cpufreq_exit(struct cpuf
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
-	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 
 	return 0;
 }
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -177,7 +177,7 @@ out_free_cpufreq_table:
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	dev_pm_opp_cpumask_remove_table(policy->cpus);
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
 	return ret;
 }
@@ -190,7 +190,7 @@ static int scpi_cpufreq_exit(struct cpuf
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
-	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 
 	return 0;
 }
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -951,11 +951,9 @@ void _opp_free(struct dev_pm_opp *opp)
 	kfree(opp);
 }
 
-static void _opp_kref_release(struct kref *kref)
+static void _opp_kref_release(struct dev_pm_opp *opp,
+			      struct opp_table *opp_table)
 {
-	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
-	struct opp_table *opp_table = opp->opp_table;
-
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
@@ -964,7 +962,22 @@ static void _opp_kref_release(struct kre
 	opp_debug_remove_one(opp);
 	list_del(&opp->node);
 	kfree(opp);
+}
+
+static void _opp_kref_release_unlocked(struct kref *kref)
+{
+	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
+	struct opp_table *opp_table = opp->opp_table;
+
+	_opp_kref_release(opp, opp_table);
+}
 
+static void _opp_kref_release_locked(struct kref *kref)
+{
+	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
+	struct opp_table *opp_table = opp->opp_table;
+
+	_opp_kref_release(opp, opp_table);
 	mutex_unlock(&opp_table->lock);
 }
 
@@ -975,10 +988,16 @@ void dev_pm_opp_get(struct dev_pm_opp *o
 
 void dev_pm_opp_put(struct dev_pm_opp *opp)
 {
-	kref_put_mutex(&opp->kref, _opp_kref_release, &opp->opp_table->lock);
+	kref_put_mutex(&opp->kref, _opp_kref_release_locked,
+		       &opp->opp_table->lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put);
 
+static void dev_pm_opp_put_unlocked(struct dev_pm_opp *opp)
+{
+	kref_put(&opp->kref, _opp_kref_release_unlocked);
+}
+
 /**
  * dev_pm_opp_remove()  - Remove an OPP from OPP table
  * @dev:	device for which we do this operation
@@ -1022,6 +1041,40 @@ void dev_pm_opp_remove(struct device *de
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
+/**
+ * dev_pm_opp_remove_all_dynamic() - Remove all dynamically created OPPs
+ * @dev:	device for which we do this operation
+ *
+ * This function removes all dynamically created OPPs from the opp table.
+ */
+void dev_pm_opp_remove_all_dynamic(struct device *dev)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp, *temp;
+	int count = 0;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return;
+
+	mutex_lock(&opp_table->lock);
+	list_for_each_entry_safe(opp, temp, &opp_table->opp_list, node) {
+		if (opp->dynamic) {
+			dev_pm_opp_put_unlocked(opp);
+			count++;
+		}
+	}
+	mutex_unlock(&opp_table->lock);
+
+	/* Drop the references taken by dev_pm_opp_add() */
+	while (count--)
+		dev_pm_opp_put_opp_table(opp_table);
+
+	/* Drop the reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
+
 struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 {
 	struct dev_pm_opp *opp;
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -108,6 +108,7 @@ void dev_pm_opp_put(struct dev_pm_opp *o
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
 		   unsigned long u_volt);
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
+void dev_pm_opp_remove_all_dynamic(struct device *dev);
 
 int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
@@ -214,6 +215,10 @@ static inline void dev_pm_opp_remove(str
 {
 }
 
+static inline void dev_pm_opp_remove_all_dynamic(struct device *dev)
+{
+}
+
 static inline int dev_pm_opp_enable(struct device *dev, unsigned long freq)
 {
 	return 0;


