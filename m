Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A019C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DF92087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeAeh6pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DF92087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeJIB7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:11 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF44C2087D;
        Mon,  8 Oct 2018 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024364;
        bh=2+KlC7iL2zHvNbSlx68oBfng4rnqWxhRdTHXZWPrHXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeAeh6peHdFeRZmimibLmfHoizfLXklihwMbD5G8dbhehCoRQ8Xiblube3hu3foVF
         ihDnCLu4BuYqlTBwk36bAAMQ+OI3cGFLG7m4f3WwnV7fum838lIQJS7/ZA2dZQ2OKB
         iscuvWpG0M0fBnPV4b0IABfcf1nFPrmnhS3ylnck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 017/168] cfg80211: make wmm_rule part of the reg_rule structure
Date:   Mon,  8 Oct 2018 20:29:57 +0200
Message-Id: <20181008175620.708806589@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <sgruszka@redhat.com>

[ Upstream commit 38cb87ee47fb825f6c9d645c019f75b3905c0ab2 ]

Make wmm_rule be part of the reg_rule structure. This simplifies the
code a lot at the cost of having bigger memory usage. However in most
cases we have only few reg_rule's and when we do have many like in
iwlwifi we do not save memory as it allocates a separate wmm_rule for
each channel anyway.

This also fixes a bug reported in various places where somewhere the
pointers were corrupted and we ended up doing a null-dereference.

Fixes: 230ebaa189af ("cfg80211: read wmm rules from regulatory database")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
[rephrase commit message slightly]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   50 +----------
 include/net/cfg80211.h                             |    4 
 include/net/regulatory.h                           |    4 
 net/mac80211/util.c                                |    8 -
 net/wireless/nl80211.c                             |   10 +-
 net/wireless/reg.c                                 |   92 +++------------------
 6 files changed, 32 insertions(+), 136 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -877,15 +877,12 @@ iwl_parse_nvm_mcc_info(struct device *de
 	const u8 *nvm_chan = cfg->nvm_type == IWL_NVM_EXT ?
 			     iwl_ext_nvm_channels : iwl_nvm_channels;
 	struct ieee80211_regdomain *regd, *copy_rd;
-	int size_of_regd, regd_to_copy, wmms_to_copy;
-	int size_of_wmms = 0;
+	int size_of_regd, regd_to_copy;
 	struct ieee80211_reg_rule *rule;
-	struct ieee80211_wmm_rule *wmm_rule, *d_wmm, *s_wmm;
 	struct regdb_ptrs *regdb_ptrs;
 	enum nl80211_band band;
 	int center_freq, prev_center_freq = 0;
-	int valid_rules = 0, n_wmms = 0;
-	int i;
+	int valid_rules = 0;
 	bool new_rule;
 	int max_num_ch = cfg->nvm_type == IWL_NVM_EXT ?
 			 IWL_NVM_NUM_CHANNELS_EXT : IWL_NVM_NUM_CHANNELS;
@@ -904,11 +901,7 @@ iwl_parse_nvm_mcc_info(struct device *de
 		sizeof(struct ieee80211_regdomain) +
 		num_of_ch * sizeof(struct ieee80211_reg_rule);
 
-	if (geo_info & GEO_WMM_ETSI_5GHZ_INFO)
-		size_of_wmms =
-			num_of_ch * sizeof(struct ieee80211_wmm_rule);
-
-	regd = kzalloc(size_of_regd + size_of_wmms, GFP_KERNEL);
+	regd = kzalloc(size_of_regd, GFP_KERNEL);
 	if (!regd)
 		return ERR_PTR(-ENOMEM);
 
@@ -922,8 +915,6 @@ iwl_parse_nvm_mcc_info(struct device *de
 	regd->alpha2[0] = fw_mcc >> 8;
 	regd->alpha2[1] = fw_mcc & 0xff;
 
-	wmm_rule = (struct ieee80211_wmm_rule *)((u8 *)regd + size_of_regd);
-
 	for (ch_idx = 0; ch_idx < num_of_ch; ch_idx++) {
 		ch_flags = (u16)__le32_to_cpup(channels + ch_idx);
 		band = (ch_idx < NUM_2GHZ_CHANNELS) ?
@@ -977,26 +968,10 @@ iwl_parse_nvm_mcc_info(struct device *de
 		    band == NL80211_BAND_2GHZ)
 			continue;
 
-		if (!reg_query_regdb_wmm(regd->alpha2, center_freq,
-					 &regdb_ptrs[n_wmms].token, wmm_rule)) {
-			/* Add only new rules */
-			for (i = 0; i < n_wmms; i++) {
-				if (regdb_ptrs[i].token ==
-				    regdb_ptrs[n_wmms].token) {
-					rule->wmm_rule = regdb_ptrs[i].rule;
-					break;
-				}
-			}
-			if (i == n_wmms) {
-				rule->wmm_rule = wmm_rule;
-				regdb_ptrs[n_wmms++].rule = wmm_rule;
-				wmm_rule++;
-			}
-		}
+		reg_query_regdb_wmm(regd->alpha2, center_freq, rule);
 	}
 
 	regd->n_reg_rules = valid_rules;
-	regd->n_wmm_rules = n_wmms;
 
 	/*
 	 * Narrow down regdom for unused regulatory rules to prevent hole
@@ -1005,28 +980,13 @@ iwl_parse_nvm_mcc_info(struct device *de
 	regd_to_copy = sizeof(struct ieee80211_regdomain) +
 		valid_rules * sizeof(struct ieee80211_reg_rule);
 
-	wmms_to_copy = sizeof(struct ieee80211_wmm_rule) * n_wmms;
-
-	copy_rd = kzalloc(regd_to_copy + wmms_to_copy, GFP_KERNEL);
+	copy_rd = kzalloc(regd_to_copy, GFP_KERNEL);
 	if (!copy_rd) {
 		copy_rd = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
 	memcpy(copy_rd, regd, regd_to_copy);
-	memcpy((u8 *)copy_rd + regd_to_copy, (u8 *)regd + size_of_regd,
-	       wmms_to_copy);
-
-	d_wmm = (struct ieee80211_wmm_rule *)((u8 *)copy_rd + regd_to_copy);
-	s_wmm = (struct ieee80211_wmm_rule *)((u8 *)regd + size_of_regd);
-
-	for (i = 0; i < regd->n_reg_rules; i++) {
-		if (!regd->reg_rules[i].wmm_rule)
-			continue;
-
-		copy_rd->reg_rules[i].wmm_rule = d_wmm +
-			(regd->reg_rules[i].wmm_rule - s_wmm);
-	}
 
 out:
 	kfree(regdb_ptrs);
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4763,8 +4763,8 @@ const char *reg_initiator_name(enum nl80
  *
  * Return: 0 on success. -ENODATA.
  */
-int reg_query_regdb_wmm(char *alpha2, int freq, u32 *ptr,
-			struct ieee80211_wmm_rule *rule);
+int reg_query_regdb_wmm(char *alpha2, int freq,
+			struct ieee80211_reg_rule *rule);
 
 /*
  * callbacks for asynchronous cfg80211 methods, notification
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -217,15 +217,15 @@ struct ieee80211_wmm_rule {
 struct ieee80211_reg_rule {
 	struct ieee80211_freq_range freq_range;
 	struct ieee80211_power_rule power_rule;
-	struct ieee80211_wmm_rule *wmm_rule;
+	struct ieee80211_wmm_rule wmm_rule;
 	u32 flags;
 	u32 dfs_cac_ms;
+	bool has_wmm;
 };
 
 struct ieee80211_regdomain {
 	struct rcu_head rcu_head;
 	u32 n_reg_rules;
-	u32 n_wmm_rules;
 	char alpha2[3];
 	enum nl80211_dfs_regions dfs_region;
 	struct ieee80211_reg_rule reg_rules[];
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1120,7 +1120,7 @@ void ieee80211_regulatory_limit_wmm_para
 {
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	const struct ieee80211_reg_rule *rrule;
-	struct ieee80211_wmm_ac *wmm_ac;
+	const struct ieee80211_wmm_ac *wmm_ac;
 	u16 center_freq = 0;
 
 	if (sdata->vif.type != NL80211_IFTYPE_AP &&
@@ -1139,15 +1139,15 @@ void ieee80211_regulatory_limit_wmm_para
 
 	rrule = freq_reg_info(sdata->wdev.wiphy, MHZ_TO_KHZ(center_freq));
 
-	if (IS_ERR_OR_NULL(rrule) || !rrule->wmm_rule) {
+	if (IS_ERR_OR_NULL(rrule) || !rrule->has_wmm) {
 		rcu_read_unlock();
 		return;
 	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
-		wmm_ac = &rrule->wmm_rule->ap[ac];
+		wmm_ac = &rrule->wmm_rule.ap[ac];
 	else
-		wmm_ac = &rrule->wmm_rule->client[ac];
+		wmm_ac = &rrule->wmm_rule.client[ac];
 	qparam->cw_min = max_t(u16, qparam->cw_min, wmm_ac->cw_min);
 	qparam->cw_max = max_t(u16, qparam->cw_max, wmm_ac->cw_max);
 	qparam->aifs = max_t(u8, qparam->aifs, wmm_ac->aifsn);
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -667,13 +667,13 @@ static int nl80211_msg_put_wmm_rules(str
 			goto nla_put_failure;
 
 		if (nla_put_u16(msg, NL80211_WMMR_CW_MIN,
-				rule->wmm_rule->client[j].cw_min) ||
+				rule->wmm_rule.client[j].cw_min) ||
 		    nla_put_u16(msg, NL80211_WMMR_CW_MAX,
-				rule->wmm_rule->client[j].cw_max) ||
+				rule->wmm_rule.client[j].cw_max) ||
 		    nla_put_u8(msg, NL80211_WMMR_AIFSN,
-			       rule->wmm_rule->client[j].aifsn) ||
+			       rule->wmm_rule.client[j].aifsn) ||
 		    nla_put_u8(msg, NL80211_WMMR_TXOP,
-			       rule->wmm_rule->client[j].cot))
+			       rule->wmm_rule.client[j].cot))
 			goto nla_put_failure;
 
 		nla_nest_end(msg, nl_wmm_rule);
@@ -766,7 +766,7 @@ static int nl80211_msg_put_channel(struc
 		const struct ieee80211_reg_rule *rule =
 			freq_reg_info(wiphy, chan->center_freq);
 
-		if (!IS_ERR(rule) && rule->wmm_rule) {
+		if (!IS_ERR_OR_NULL(rule) && rule->has_wmm) {
 			if (nl80211_msg_put_wmm_rules(msg, rule))
 				goto nla_put_failure;
 		}
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -425,35 +425,23 @@ static const struct ieee80211_regdomain
 reg_copy_regd(const struct ieee80211_regdomain *src_regd)
 {
 	struct ieee80211_regdomain *regd;
-	int size_of_regd, size_of_wmms;
+	int size_of_regd;
 	unsigned int i;
-	struct ieee80211_wmm_rule *d_wmm, *s_wmm;
 
 	size_of_regd =
 		sizeof(struct ieee80211_regdomain) +
 		src_regd->n_reg_rules * sizeof(struct ieee80211_reg_rule);
-	size_of_wmms = src_regd->n_wmm_rules *
-		sizeof(struct ieee80211_wmm_rule);
 
-	regd = kzalloc(size_of_regd + size_of_wmms, GFP_KERNEL);
+	regd = kzalloc(size_of_regd, GFP_KERNEL);
 	if (!regd)
 		return ERR_PTR(-ENOMEM);
 
 	memcpy(regd, src_regd, sizeof(struct ieee80211_regdomain));
 
-	d_wmm = (struct ieee80211_wmm_rule *)((u8 *)regd + size_of_regd);
-	s_wmm = (struct ieee80211_wmm_rule *)((u8 *)src_regd + size_of_regd);
-	memcpy(d_wmm, s_wmm, size_of_wmms);
-
-	for (i = 0; i < src_regd->n_reg_rules; i++) {
+	for (i = 0; i < src_regd->n_reg_rules; i++)
 		memcpy(&regd->reg_rules[i], &src_regd->reg_rules[i],
 		       sizeof(struct ieee80211_reg_rule));
-		if (!src_regd->reg_rules[i].wmm_rule)
-			continue;
 
-		regd->reg_rules[i].wmm_rule = d_wmm +
-			(src_regd->reg_rules[i].wmm_rule - s_wmm);
-	}
 	return regd;
 }
 
@@ -859,9 +847,10 @@ static bool valid_regdb(const u8 *data,
 	return true;
 }
 
-static void set_wmm_rule(struct ieee80211_wmm_rule *rule,
+static void set_wmm_rule(struct ieee80211_reg_rule *rrule,
 			 struct fwdb_wmm_rule *wmm)
 {
+	struct ieee80211_wmm_rule *rule = &rrule->wmm_rule;
 	unsigned int i;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
@@ -875,11 +864,13 @@ static void set_wmm_rule(struct ieee8021
 		rule->ap[i].aifsn = wmm->ap[i].aifsn;
 		rule->ap[i].cot = 1000 * be16_to_cpu(wmm->ap[i].cot);
 	}
+
+	rrule->has_wmm = true;
 }
 
 static int __regdb_query_wmm(const struct fwdb_header *db,
 			     const struct fwdb_country *country, int freq,
-			     u32 *dbptr, struct ieee80211_wmm_rule *rule)
+			     struct ieee80211_reg_rule *rule)
 {
 	unsigned int ptr = be16_to_cpu(country->coll_ptr) << 2;
 	struct fwdb_collection *coll = (void *)((u8 *)db + ptr);
@@ -900,8 +891,6 @@ static int __regdb_query_wmm(const struc
 			wmm_ptr = be16_to_cpu(rrule->wmm_ptr) << 2;
 			wmm = (void *)((u8 *)db + wmm_ptr);
 			set_wmm_rule(rule, wmm);
-			if (dbptr)
-				*dbptr = wmm_ptr;
 			return 0;
 		}
 	}
@@ -909,8 +898,7 @@ static int __regdb_query_wmm(const struc
 	return -ENODATA;
 }
 
-int reg_query_regdb_wmm(char *alpha2, int freq, u32 *dbptr,
-			struct ieee80211_wmm_rule *rule)
+int reg_query_regdb_wmm(char *alpha2, int freq, struct ieee80211_reg_rule *rule)
 {
 	const struct fwdb_header *hdr = regdb;
 	const struct fwdb_country *country;
@@ -924,8 +912,7 @@ int reg_query_regdb_wmm(char *alpha2, in
 	country = &hdr->country[0];
 	while (country->coll_ptr) {
 		if (alpha2_equal(alpha2, country->alpha2))
-			return __regdb_query_wmm(regdb, country, freq, dbptr,
-						 rule);
+			return __regdb_query_wmm(regdb, country, freq, rule);
 
 		country++;
 	}
@@ -934,32 +921,13 @@ int reg_query_regdb_wmm(char *alpha2, in
 }
 EXPORT_SYMBOL(reg_query_regdb_wmm);
 
-struct wmm_ptrs {
-	struct ieee80211_wmm_rule *rule;
-	u32 ptr;
-};
-
-static struct ieee80211_wmm_rule *find_wmm_ptr(struct wmm_ptrs *wmm_ptrs,
-					       u32 wmm_ptr, int n_wmms)
-{
-	int i;
-
-	for (i = 0; i < n_wmms; i++) {
-		if (wmm_ptrs[i].ptr == wmm_ptr)
-			return wmm_ptrs[i].rule;
-	}
-	return NULL;
-}
-
 static int regdb_query_country(const struct fwdb_header *db,
 			       const struct fwdb_country *country)
 {
 	unsigned int ptr = be16_to_cpu(country->coll_ptr) << 2;
 	struct fwdb_collection *coll = (void *)((u8 *)db + ptr);
 	struct ieee80211_regdomain *regdom;
-	struct ieee80211_regdomain *tmp_rd;
-	unsigned int size_of_regd, i, n_wmms = 0;
-	struct wmm_ptrs *wmm_ptrs;
+	unsigned int size_of_regd, i;
 
 	size_of_regd = sizeof(struct ieee80211_regdomain) +
 		coll->n_rules * sizeof(struct ieee80211_reg_rule);
@@ -968,12 +936,6 @@ static int regdb_query_country(const str
 	if (!regdom)
 		return -ENOMEM;
 
-	wmm_ptrs = kcalloc(coll->n_rules, sizeof(*wmm_ptrs), GFP_KERNEL);
-	if (!wmm_ptrs) {
-		kfree(regdom);
-		return -ENOMEM;
-	}
-
 	regdom->n_reg_rules = coll->n_rules;
 	regdom->alpha2[0] = country->alpha2[0];
 	regdom->alpha2[1] = country->alpha2[1];
@@ -1012,37 +974,11 @@ static int regdb_query_country(const str
 				1000 * be16_to_cpu(rule->cac_timeout);
 		if (rule->len >= offsetofend(struct fwdb_rule, wmm_ptr)) {
 			u32 wmm_ptr = be16_to_cpu(rule->wmm_ptr) << 2;
-			struct ieee80211_wmm_rule *wmm_pos =
-				find_wmm_ptr(wmm_ptrs, wmm_ptr, n_wmms);
-			struct fwdb_wmm_rule *wmm;
-			struct ieee80211_wmm_rule *wmm_rule;
-
-			if (wmm_pos) {
-				rrule->wmm_rule = wmm_pos;
-				continue;
-			}
-			wmm = (void *)((u8 *)db + wmm_ptr);
-			tmp_rd = krealloc(regdom, size_of_regd + (n_wmms + 1) *
-					  sizeof(struct ieee80211_wmm_rule),
-					  GFP_KERNEL);
-
-			if (!tmp_rd) {
-				kfree(regdom);
-				kfree(wmm_ptrs);
-				return -ENOMEM;
-			}
-			regdom = tmp_rd;
-
-			wmm_rule = (struct ieee80211_wmm_rule *)
-				((u8 *)regdom + size_of_regd + n_wmms *
-				sizeof(struct ieee80211_wmm_rule));
-
-			set_wmm_rule(wmm_rule, wmm);
-			wmm_ptrs[n_wmms].ptr = wmm_ptr;
-			wmm_ptrs[n_wmms++].rule = wmm_rule;
+			struct fwdb_wmm_rule *wmm = (void *)((u8 *)db + wmm_ptr);
+
+			set_wmm_rule(rrule, wmm);
 		}
 	}
-	kfree(wmm_ptrs);
 
 	return reg_schedule_apply(regdom);
 }


