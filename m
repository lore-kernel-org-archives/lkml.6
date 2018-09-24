Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5E7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CEF0kSMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5E7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeIXVOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:14:39 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730578AbeIXUum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJyYTKgOE2fNF1gD4vPoAKwWZ+Ru9NQBTbQj7UVZJQU=;
 b=CEF0kSMvJ71LoRTxEb7qAcSwtlb48uvj1Gu3ZtqBKHJXE8kOll77FmmRI8DbH4gPpZaJgQPZN3qOXzXcWfESXHN0AD4Z1gF7nMKCQ0/vecBd9gL42BxFFk8B4RLk7+vnddOc5yeaYfT61mX036wAQyhzKn+V20/b7/vxhYPMkCw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stanislaw Gruszka <sgruszka@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 16/76] cfg80211: make wmm_rule part of the
 reg_rule structure
Thread-Topic: [PATCH AUTOSEL 4.18 16/76] cfg80211: make wmm_rule part of the
 reg_rule structure
Thread-Index: AQHUVBWc9MSNBrfEG0iZ9UdFzwxsGg==
Date:   Mon, 24 Sep 2018 14:48:09 +0000
Message-ID: <20180924144751.164410-16-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:YLJSKJVW9RT9/4BQ2WJUazta4biUJ66K+NDXjTmG9UFILR3NFPbOO6vXOpHVfGfE1r+LD2cDXiJ1NoMkk8qft9CWuww+BBnG1Jwkv8zX7RjKySd9tCgGTfnO5Iz/WlsuECxJURdTNKC136g2Al64pfFiKqCLvRAM+RFozvEvmD22YZgbLFeoQCFKNYYbuAlFg9/gBkxLq+j2eq5MNdtWYQhaLQhT/uaZsCXKp6OU7ul+eUVnyoMM/MR1wybi4ksTDr0ihSvfGMIgMYuTSpFwuzmQTgU99E6O31VnJEAvRIXTQfD98j+F5dSi7SMbD0bcjXwl8BbBcSCk76zLOqOjstLW6OrXURjygUXEb1mWwA2lSfYRVbUytEGEht544qrigzYRlGsXa2VsHXxlJnO4aYOMfS0iDSI76KakoeZ5ykprw0KOVKsPVNW2aw6VcoLW0hFHyG3PNafr1DvLlS9s7Q==;5:XZlCLRLTb/9u7kLEUlnm3zV60LmjcsKcQiAwmdptJGNp9zBP5RwEkdqXKLjuYjT1QRvi9OdqITxwfLNQ+d+xIdnPMGqGVna6kZeLex7tHn0YixuAAU5+a4Vs/pjDEUqIeokUzwGAxUJW3qDopkyRa8XsBKd7WQpkOfZ9tGfHTBg=;7:zVHpLlh3sXbNsoztOoCmv9JSCxulWe1CTjIh1F1CLuMNj/NQ2GdnzpUC18uPPu3ceBtIjBUvKfsr4cQ1f+9yWsnNgnm9jsPRbTyvPHFEoeS/65fQddI1vY/YdTZgxo+P69+AJu8N40s2VVxf9x4t2scAWuUOguYfa75z3Xl1R+mrIzAjGmJJMIC63TMtKlSjp0TyyFgNzdOna8soHHxTiSVidyPzQlWe786NJFCK/9blMQIKjlDvPYfD6JmPmYX2
x-ms-office365-filtering-correlation-id: c2a8b780-8cd1-4062-eade-08d6222cbf01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08218C090EE8D6E3CB476AA6FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(575784001)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JwD3OJQMXPyeFzAI6LThnIIMna2z7PiUXU0Rq/QOcd439MnEtiSImUd0QLAkGw+OyYc4YczBGmsJttS79xiCI7R38sTa7HUexqIuJTXxhRuIeSRWqjgr+QXRR79fKe1cu9T1WrcnPIIWljfl7b5TTYlt+T2c2c4KflpFKw9OvWgSMWCzylsmi73EkjWbJ4+ZgjbLEVxAh0yZuwDEetLbayTh4JmMzzjoBLPEJ3OBrw624T3hQ3X14+3xyk26jbtau3EWkisWgHRwidzZCmeFwZis7JpuNoNsUXKNklf4ZysrmiB4FHn64o6RaFElCwjIJ2QDY/U+V/DCquc28BJ5oqPpXqGAqWkj17lB8ZZkTZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a8b780-8cd1-4062-eade-08d6222cbf01
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:09.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 50 ++---------
 include/net/cfg80211.h                        |  4 +-
 include/net/regulatory.h                      |  4 +-
 net/mac80211/util.c                           |  8 +-
 net/wireless/nl80211.c                        | 10 +--
 net/wireless/reg.c                            | 90 +++----------------
 6 files changed, 31 insertions(+), 135 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/n=
et/wireless/intel/iwlwifi/iwl-nvm-parse.c
index b815ba38dbdb..88121548eb9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -877,15 +877,12 @@ iwl_parse_nvm_mcc_info(struct device *dev, const stru=
ct iwl_cfg *cfg,
 	const u8 *nvm_chan =3D cfg->nvm_type =3D=3D IWL_NVM_EXT ?
 			     iwl_ext_nvm_channels : iwl_nvm_channels;
 	struct ieee80211_regdomain *regd, *copy_rd;
-	int size_of_regd, regd_to_copy, wmms_to_copy;
-	int size_of_wmms =3D 0;
+	int size_of_regd, regd_to_copy;
 	struct ieee80211_reg_rule *rule;
-	struct ieee80211_wmm_rule *wmm_rule, *d_wmm, *s_wmm;
 	struct regdb_ptrs *regdb_ptrs;
 	enum nl80211_band band;
 	int center_freq, prev_center_freq =3D 0;
-	int valid_rules =3D 0, n_wmms =3D 0;
-	int i;
+	int valid_rules =3D 0;
 	bool new_rule;
 	int max_num_ch =3D cfg->nvm_type =3D=3D IWL_NVM_EXT ?
 			 IWL_NVM_NUM_CHANNELS_EXT : IWL_NVM_NUM_CHANNELS;
@@ -904,11 +901,7 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struc=
t iwl_cfg *cfg,
 		sizeof(struct ieee80211_regdomain) +
 		num_of_ch * sizeof(struct ieee80211_reg_rule);
=20
-	if (geo_info & GEO_WMM_ETSI_5GHZ_INFO)
-		size_of_wmms =3D
-			num_of_ch * sizeof(struct ieee80211_wmm_rule);
-
-	regd =3D kzalloc(size_of_regd + size_of_wmms, GFP_KERNEL);
+	regd =3D kzalloc(size_of_regd, GFP_KERNEL);
 	if (!regd)
 		return ERR_PTR(-ENOMEM);
=20
@@ -922,8 +915,6 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct=
 iwl_cfg *cfg,
 	regd->alpha2[0] =3D fw_mcc >> 8;
 	regd->alpha2[1] =3D fw_mcc & 0xff;
=20
-	wmm_rule =3D (struct ieee80211_wmm_rule *)((u8 *)regd + size_of_regd);
-
 	for (ch_idx =3D 0; ch_idx < num_of_ch; ch_idx++) {
 		ch_flags =3D (u16)__le32_to_cpup(channels + ch_idx);
 		band =3D (ch_idx < NUM_2GHZ_CHANNELS) ?
@@ -977,26 +968,10 @@ iwl_parse_nvm_mcc_info(struct device *dev, const stru=
ct iwl_cfg *cfg,
 		    band =3D=3D NL80211_BAND_2GHZ)
 			continue;
=20
-		if (!reg_query_regdb_wmm(regd->alpha2, center_freq,
-					 &regdb_ptrs[n_wmms].token, wmm_rule)) {
-			/* Add only new rules */
-			for (i =3D 0; i < n_wmms; i++) {
-				if (regdb_ptrs[i].token =3D=3D
-				    regdb_ptrs[n_wmms].token) {
-					rule->wmm_rule =3D regdb_ptrs[i].rule;
-					break;
-				}
-			}
-			if (i =3D=3D n_wmms) {
-				rule->wmm_rule =3D wmm_rule;
-				regdb_ptrs[n_wmms++].rule =3D wmm_rule;
-				wmm_rule++;
-			}
-		}
+		reg_query_regdb_wmm(regd->alpha2, center_freq, rule);
 	}
=20
 	regd->n_reg_rules =3D valid_rules;
-	regd->n_wmm_rules =3D n_wmms;
=20
 	/*
 	 * Narrow down regdom for unused regulatory rules to prevent hole
@@ -1005,28 +980,13 @@ iwl_parse_nvm_mcc_info(struct device *dev, const str=
uct iwl_cfg *cfg,
 	regd_to_copy =3D sizeof(struct ieee80211_regdomain) +
 		valid_rules * sizeof(struct ieee80211_reg_rule);
=20
-	wmms_to_copy =3D sizeof(struct ieee80211_wmm_rule) * n_wmms;
-
-	copy_rd =3D kzalloc(regd_to_copy + wmms_to_copy, GFP_KERNEL);
+	copy_rd =3D kzalloc(regd_to_copy, GFP_KERNEL);
 	if (!copy_rd) {
 		copy_rd =3D ERR_PTR(-ENOMEM);
 		goto out;
 	}
=20
 	memcpy(copy_rd, regd, regd_to_copy);
-	memcpy((u8 *)copy_rd + regd_to_copy, (u8 *)regd + size_of_regd,
-	       wmms_to_copy);
-
-	d_wmm =3D (struct ieee80211_wmm_rule *)((u8 *)copy_rd + regd_to_copy);
-	s_wmm =3D (struct ieee80211_wmm_rule *)((u8 *)regd + size_of_regd);
-
-	for (i =3D 0; i < regd->n_reg_rules; i++) {
-		if (!regd->reg_rules[i].wmm_rule)
-			continue;
-
-		copy_rd->reg_rules[i].wmm_rule =3D d_wmm +
-			(regd->reg_rules[i].wmm_rule - s_wmm);
-	}
=20
 out:
 	kfree(regdb_ptrs);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1beb3ead0385..7229c186d199 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4763,8 +4763,8 @@ const char *reg_initiator_name(enum nl80211_reg_initi=
ator initiator);
  *
  * Return: 0 on success. -ENODATA.
  */
-int reg_query_regdb_wmm(char *alpha2, int freq, u32 *ptr,
-			struct ieee80211_wmm_rule *rule);
+int reg_query_regdb_wmm(char *alpha2, int freq,
+			struct ieee80211_reg_rule *rule);
=20
 /*
  * callbacks for asynchronous cfg80211 methods, notification
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 60f8cc86a447..3469750df0f4 100644
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
=20
 struct ieee80211_regdomain {
 	struct rcu_head rcu_head;
 	u32 n_reg_rules;
-	u32 n_wmm_rules;
 	char alpha2[3];
 	enum nl80211_dfs_regions dfs_region;
 	struct ieee80211_reg_rule reg_rules[];
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d02fbfec3783..c80187d6e6bb 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1120,7 +1120,7 @@ void ieee80211_regulatory_limit_wmm_params(struct iee=
e80211_sub_if_data *sdata,
 {
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	const struct ieee80211_reg_rule *rrule;
-	struct ieee80211_wmm_ac *wmm_ac;
+	const struct ieee80211_wmm_ac *wmm_ac;
 	u16 center_freq =3D 0;
=20
 	if (sdata->vif.type !=3D NL80211_IFTYPE_AP &&
@@ -1139,15 +1139,15 @@ void ieee80211_regulatory_limit_wmm_params(struct i=
eee80211_sub_if_data *sdata,
=20
 	rrule =3D freq_reg_info(sdata->wdev.wiphy, MHZ_TO_KHZ(center_freq));
=20
-	if (IS_ERR_OR_NULL(rrule) || !rrule->wmm_rule) {
+	if (IS_ERR_OR_NULL(rrule) || !rrule->has_wmm) {
 		rcu_read_unlock();
 		return;
 	}
=20
 	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP)
-		wmm_ac =3D &rrule->wmm_rule->ap[ac];
+		wmm_ac =3D &rrule->wmm_rule.ap[ac];
 	else
-		wmm_ac =3D &rrule->wmm_rule->client[ac];
+		wmm_ac =3D &rrule->wmm_rule.client[ac];
 	qparam->cw_min =3D max_t(u16, qparam->cw_min, wmm_ac->cw_min);
 	qparam->cw_max =3D max_t(u16, qparam->cw_max, wmm_ac->cw_max);
 	qparam->aifs =3D max_t(u8, qparam->aifs, wmm_ac->aifsn);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 80bc986c79e5..e3dcffd96919 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -667,13 +667,13 @@ static int nl80211_msg_put_wmm_rules(struct sk_buff *=
msg,
 			goto nla_put_failure;
=20
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
=20
 		nla_nest_end(msg, nl_wmm_rule);
@@ -766,7 +766,7 @@ static int nl80211_msg_put_channel(struct sk_buff *msg,=
 struct wiphy *wiphy,
 		const struct ieee80211_reg_rule *rule =3D
 			freq_reg_info(wiphy, chan->center_freq);
=20
-		if (!IS_ERR(rule) && rule->wmm_rule) {
+		if (!IS_ERR_OR_NULL(rule) && rule->has_wmm) {
 			if (nl80211_msg_put_wmm_rules(msg, rule))
 				goto nla_put_failure;
 		}
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 283902974fbf..2f702adf2912 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -425,35 +425,23 @@ static const struct ieee80211_regdomain *
 reg_copy_regd(const struct ieee80211_regdomain *src_regd)
 {
 	struct ieee80211_regdomain *regd;
-	int size_of_regd, size_of_wmms;
+	int size_of_regd;
 	unsigned int i;
-	struct ieee80211_wmm_rule *d_wmm, *s_wmm;
=20
 	size_of_regd =3D
 		sizeof(struct ieee80211_regdomain) +
 		src_regd->n_reg_rules * sizeof(struct ieee80211_reg_rule);
-	size_of_wmms =3D src_regd->n_wmm_rules *
-		sizeof(struct ieee80211_wmm_rule);
=20
-	regd =3D kzalloc(size_of_regd + size_of_wmms, GFP_KERNEL);
+	regd =3D kzalloc(size_of_regd, GFP_KERNEL);
 	if (!regd)
 		return ERR_PTR(-ENOMEM);
=20
 	memcpy(regd, src_regd, sizeof(struct ieee80211_regdomain));
=20
-	d_wmm =3D (struct ieee80211_wmm_rule *)((u8 *)regd + size_of_regd);
-	s_wmm =3D (struct ieee80211_wmm_rule *)((u8 *)src_regd + size_of_regd);
-	memcpy(d_wmm, s_wmm, size_of_wmms);
-
-	for (i =3D 0; i < src_regd->n_reg_rules; i++) {
+	for (i =3D 0; i < src_regd->n_reg_rules; i++)
 		memcpy(&regd->reg_rules[i], &src_regd->reg_rules[i],
 		       sizeof(struct ieee80211_reg_rule));
-		if (!src_regd->reg_rules[i].wmm_rule)
-			continue;
=20
-		regd->reg_rules[i].wmm_rule =3D d_wmm +
-			(src_regd->reg_rules[i].wmm_rule - s_wmm);
-	}
 	return regd;
 }
=20
@@ -859,9 +847,10 @@ static bool valid_regdb(const u8 *data, unsigned int s=
ize)
 	return true;
 }
=20
-static void set_wmm_rule(struct ieee80211_wmm_rule *rule,
+static void set_wmm_rule(struct ieee80211_reg_rule *rrule,
 			 struct fwdb_wmm_rule *wmm)
 {
+	struct ieee80211_wmm_rule *rule =3D &rrule->wmm_rule;
 	unsigned int i;
=20
 	for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
@@ -875,11 +864,13 @@ static void set_wmm_rule(struct ieee80211_wmm_rule *r=
ule,
 		rule->ap[i].aifsn =3D wmm->ap[i].aifsn;
 		rule->ap[i].cot =3D 1000 * be16_to_cpu(wmm->ap[i].cot);
 	}
+
+	rrule->has_wmm =3D true;
 }
=20
 static int __regdb_query_wmm(const struct fwdb_header *db,
 			     const struct fwdb_country *country, int freq,
-			     u32 *dbptr, struct ieee80211_wmm_rule *rule)
+			     struct ieee80211_reg_rule *rule)
 {
 	unsigned int ptr =3D be16_to_cpu(country->coll_ptr) << 2;
 	struct fwdb_collection *coll =3D (void *)((u8 *)db + ptr);
@@ -900,8 +891,6 @@ static int __regdb_query_wmm(const struct fwdb_header *=
db,
 			wmm_ptr =3D be16_to_cpu(rrule->wmm_ptr) << 2;
 			wmm =3D (void *)((u8 *)db + wmm_ptr);
 			set_wmm_rule(rule, wmm);
-			if (dbptr)
-				*dbptr =3D wmm_ptr;
 			return 0;
 		}
 	}
@@ -909,8 +898,7 @@ static int __regdb_query_wmm(const struct fwdb_header *=
db,
 	return -ENODATA;
 }
=20
-int reg_query_regdb_wmm(char *alpha2, int freq, u32 *dbptr,
-			struct ieee80211_wmm_rule *rule)
+int reg_query_regdb_wmm(char *alpha2, int freq, struct ieee80211_reg_rule =
*rule)
 {
 	const struct fwdb_header *hdr =3D regdb;
 	const struct fwdb_country *country;
@@ -924,8 +912,7 @@ int reg_query_regdb_wmm(char *alpha2, int freq, u32 *db=
ptr,
 	country =3D &hdr->country[0];
 	while (country->coll_ptr) {
 		if (alpha2_equal(alpha2, country->alpha2))
-			return __regdb_query_wmm(regdb, country, freq, dbptr,
-						 rule);
+			return __regdb_query_wmm(regdb, country, freq, rule);
=20
 		country++;
 	}
@@ -934,32 +921,13 @@ int reg_query_regdb_wmm(char *alpha2, int freq, u32 *=
dbptr,
 }
 EXPORT_SYMBOL(reg_query_regdb_wmm);
=20
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
-	for (i =3D 0; i < n_wmms; i++) {
-		if (wmm_ptrs[i].ptr =3D=3D wmm_ptr)
-			return wmm_ptrs[i].rule;
-	}
-	return NULL;
-}
-
 static int regdb_query_country(const struct fwdb_header *db,
 			       const struct fwdb_country *country)
 {
 	unsigned int ptr =3D be16_to_cpu(country->coll_ptr) << 2;
 	struct fwdb_collection *coll =3D (void *)((u8 *)db + ptr);
 	struct ieee80211_regdomain *regdom;
-	struct ieee80211_regdomain *tmp_rd;
-	unsigned int size_of_regd, i, n_wmms =3D 0;
-	struct wmm_ptrs *wmm_ptrs;
+	unsigned int size_of_regd, i;
=20
 	size_of_regd =3D sizeof(struct ieee80211_regdomain) +
 		coll->n_rules * sizeof(struct ieee80211_reg_rule);
@@ -968,12 +936,6 @@ static int regdb_query_country(const struct fwdb_heade=
r *db,
 	if (!regdom)
 		return -ENOMEM;
=20
-	wmm_ptrs =3D kcalloc(coll->n_rules, sizeof(*wmm_ptrs), GFP_KERNEL);
-	if (!wmm_ptrs) {
-		kfree(regdom);
-		return -ENOMEM;
-	}
-
 	regdom->n_reg_rules =3D coll->n_rules;
 	regdom->alpha2[0] =3D country->alpha2[0];
 	regdom->alpha2[1] =3D country->alpha2[1];
@@ -1012,37 +974,11 @@ static int regdb_query_country(const struct fwdb_hea=
der *db,
 				1000 * be16_to_cpu(rule->cac_timeout);
 		if (rule->len >=3D offsetofend(struct fwdb_rule, wmm_ptr)) {
 			u32 wmm_ptr =3D be16_to_cpu(rule->wmm_ptr) << 2;
-			struct ieee80211_wmm_rule *wmm_pos =3D
-				find_wmm_ptr(wmm_ptrs, wmm_ptr, n_wmms);
-			struct fwdb_wmm_rule *wmm;
-			struct ieee80211_wmm_rule *wmm_rule;
-
-			if (wmm_pos) {
-				rrule->wmm_rule =3D wmm_pos;
-				continue;
-			}
-			wmm =3D (void *)((u8 *)db + wmm_ptr);
-			tmp_rd =3D krealloc(regdom, size_of_regd + (n_wmms + 1) *
-					  sizeof(struct ieee80211_wmm_rule),
-					  GFP_KERNEL);
-
-			if (!tmp_rd) {
-				kfree(regdom);
-				kfree(wmm_ptrs);
-				return -ENOMEM;
-			}
-			regdom =3D tmp_rd;
-
-			wmm_rule =3D (struct ieee80211_wmm_rule *)
-				((u8 *)regdom + size_of_regd + n_wmms *
-				sizeof(struct ieee80211_wmm_rule));
+			struct fwdb_wmm_rule *wmm =3D (void *)((u8 *)db + wmm_ptr);
=20
-			set_wmm_rule(wmm_rule, wmm);
-			wmm_ptrs[n_wmms].ptr =3D wmm_ptr;
-			wmm_ptrs[n_wmms++].rule =3D wmm_rule;
+			set_wmm_rule(rrule, wmm);
 		}
 	}
-	kfree(wmm_ptrs);
=20
 	return reg_schedule_apply(regdom);
 }
--=20
2.17.1
