Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6025D21568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdyRdip+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6025D21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeHWV4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbeHWV4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:56:38 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9EFC2075E;
        Thu, 23 Aug 2018 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535048742;
        bh=4usv3NpKGqa2Nwn0+UdnrYyMYgaJ3IKDNvqDFpNwXjw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tdyRdip+mAxeke1IvDEHa/pcj8GgoPuVEDrokuBD09IqLJiKCR/ChzZkxHYR7WcQk
         Kna+n+NuEwpQJlauF9j4ZE5SnqUdzGPywO72uV1+mJP3LZked51aMcf3j76xyOtEMN
         0HGlCuO59fmNjn0T0foGaWnziFHrN9owqgy77CwA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <4cda3c7e-3ac3-af97-6d9f-24dd5a4efa28@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533952436-17221-1-git-send-email-tdas@codeaurora.org>
 <153455835372.28926.7641705907931269497@swboyd.mtv.corp.google.com>
 <693d9cf4-4a6f-feb5-0c3f-ded842bbdf0a@codeaurora.org>
 <2db97037-b5f1-9234-862c-fa483b8aeb62@codeaurora.org>
 <153486545785.28926.5289007760649251969@swboyd.mtv.corp.google.com>
 <4cda3c7e-3ac3-af97-6d9f-24dd5a4efa28@codeaurora.org>
Message-ID: <153504874119.28926.4197673432816461627@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 0/2] clk: qcom: Add support for RCG to register for DFS
Date:   Thu, 23 Aug 2018 11:25:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-08-22 03:28:31)
> =

> > =

> > Hmmmm. Ok. That won't work then. recalc_rate() better not try to
> > populate the frequency table then or it will not work. So I suppose it
> > needs to fallback to reading the registers and assuming the parent_rate
> > coming in is the actual frequency of it's parent until the frequency
> > table pointer is non-NULL. Would that work?
> > =

> Yes that would work.

Ok.

> =

> > BTW, does DFS switch parents without software knowing about it? =

> DFS would not switch until a HW request is sent, but SW would be unware =

> of the switch except the current_perf_state being updated with the =

> requested level.
> =

> What
> > happens in that case? Does the QUP driver make sure that the new parent
> > of this RCG is properly enabled so that it can switch to it when needed?
> =

> I am not sure if they poll for any of their QUP HW state to make sure =

> the switch is complete.
> =

> > I'm still trying to understand this whole design. Who takes care of the
> > voltage requirements in this case? The QUP driver as well?
> > =

> =

> When the QUP driver requires to switch to new performance level, the =

> first request would be to set_rate()(QUP driver would get the list of =

> supported frequencies using the clk_round_rate()) which in QCOM clock =

> driver would take care of setting the required voltage for the new =

> parent switch.

It would also make sure that the new parent is enabled if the QUP clk is
enabled. That's another concern. Does the PLL turn on automatically when
the RCG switches to it?

> Then the QUP driver would request the HW for a new perf switch which =

> would result to a DFS switch for the QUP clocks.

It sounds like the QUP driver does half of the work via the clk APIs and
then the other half through the DFS register. Maybe the QUP driver
should be registering a clk as well for its DFS register so it can all
be clk API calls here. Something to consider. Anyway, that's not
important to this patch so here's the updated patch.

---8<----
diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index e6300e05d5df..e5eca8a1abe4 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -163,6 +163,15 @@ extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
 =

+struct clk_rcg_dfs_data {
+	struct clk_rcg2 *rcg;
+	struct clk_init_data *init;
+};
+
+#define DEFINE_RCG_DFS(r) \
+	{ .rcg =3D &r##_src, .init =3D &r##_init }
+
 extern int qcom_cc_register_rcg_dfs(struct regmap *regmap,
-			     struct clk_rcg2 **rcgs, int num_clks);
+				    const struct clk_rcg_dfs_data *rcgs,
+				    size_t len);
 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 55a5b58cbb15..d5d77f9ad170 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -940,25 +940,21 @@ const struct clk_ops clk_rcg2_shared_ops =3D {
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
 =

 /* Common APIs to be used for DFS based RCGR */
-static unsigned long clk_rcg2_calculate_freq(struct clk_hw *hw,
-		int level, struct freq_tbl *f)
+static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
+				       struct freq_tbl *f)
 {
 	struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
 	struct clk_hw *p;
 	unsigned long prate =3D 0;
-	u32 val, mask, cfg, m_off, n_off, offset, mode;
-	int i, ret, num_parents;
+	u32 val, mask, cfg, mode;
+	int i, num_parents;
 =

-	offset =3D SE_PERF_DFSR(level);
-	ret =3D regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + offset, &cfg);
-	if (ret)
-		return ret;
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_DFSR(l), &cfg);
 =

 	mask =3D BIT(rcg->hid_width) - 1;
-	f->pre_div =3D cfg & mask ? (cfg & mask) : 1;
-
-	mode =3D cfg & CFG_MODE_MASK;
-	mode >>=3D CFG_MODE_SHIFT;
+	f->pre_div =3D 1;
+	if (cfg & mask)
+		f->pre_div =3D cfg & mask;
 =

 	cfg &=3D CFG_SRC_SEL_MASK;
 	cfg >>=3D CFG_SRC_SEL_SHIFT;
@@ -972,60 +968,39 @@ static unsigned long clk_rcg2_calculate_freq(struct c=
lk_hw *hw,
 		}
 	}
 =

+	mode =3D cfg & CFG_MODE_MASK;
+	mode >>=3D CFG_MODE_SHIFT;
 	if (mode) {
-		/* Calculate M & N values */
-		m_off =3D SE_PERF_M_DFSR(level);
-		n_off =3D SE_PERF_N_DFSR(level);
-
 		mask =3D BIT(rcg->mnd_width) - 1;
-		ret =3D regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_off,
-					&val);
-		if (ret) {
-			pr_err("Failed to read M offset register\n");
-			return ret;
-		}
+		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_M_DFSR(l),
+			    &val);
 		val &=3D mask;
 		f->m =3D val;
 =

-		ret =3D regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + n_off,
-					&val);
-		if (ret) {
-			pr_err("Failed to read N offset register\n");
-			return ret;
-		}
-		/* val ~(N-M) */
+		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_N_DFSR(l),
+			    &val);
 		val =3D ~val;
 		val &=3D mask;
 		val +=3D f->m;
 		f->n =3D val;
 	}
 =

-	return calc_rate(prate, f->m, f->n, mode, f->pre_div);
+	f->freq =3D calc_rate(prate, f->m, f->n, mode, f->pre_div);
 }
 =

 static int clk_rcg2_dfs_populate_freq_table(struct clk_rcg2 *rcg)
 {
 	struct freq_tbl *freq_tbl;
-	unsigned long calc_freq;
 	int i;
 =

-	freq_tbl =3D kcalloc(MAX_PERF_LEVEL, sizeof(*freq_tbl),
-				GFP_KERNEL);
+	freq_tbl =3D kcalloc(MAX_PERF_LEVEL, sizeof(*freq_tbl), GFP_KERNEL);
 	if (!freq_tbl)
 		return -ENOMEM;
-
-	for (i =3D 0; i < MAX_PERF_LEVEL; i++) {
-		calc_freq =3D clk_rcg2_calculate_freq(&rcg->clkr.hw,
-							i, &freq_tbl[i]);
-		if (calc_freq < 0) {
-			kfree(freq_tbl);
-			return calc_freq;
-		}
-
-		freq_tbl[i].freq =3D calc_freq;
-	}
 	rcg->freq_tbl =3D freq_tbl;
 =

+	for (i =3D 0; i < MAX_PERF_LEVEL; i++)
+		clk_rcg2_dfs_populate_freq(&rcg->clkr.hw, i, freq_tbl + i);
+
 	return 0;
 }
 =

@@ -1044,55 +1019,54 @@ static int clk_rcg2_dfs_determine_rate(struct clk_h=
w *hw,
 		}
 	}
 =

-	return clk_rcg2_shared_ops.determine_rate(hw, req);
+	return clk_rcg2_determine_rate(hw, req);
 }
 =

 static unsigned long
 clk_rcg2_dfs_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
-	u32 cfg, hid_div, m =3D 0, n =3D 0, mode =3D 0, mask, level;
-	int num_parents, i;
-	unsigned long prate;
+	u32 level, mask, cfg, m =3D 0, n =3D 0, mode, pre_div;
 =

-	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
-				SE_CMD_DFSR_OFFSET, &cfg);
-	level =3D (GENMASK(4, 1) & cfg) >> 1;
+	regmap_read(rcg->clkr.regmap,
+		    rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET, &level);
+	level &=3D GENMASK(4, 1);
+	level >>=3D 1;
 =

-	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
-				SE_PERF_DFSR(level), &cfg);
-	if (rcg->mnd_width) {
+	if (rcg->freq_tbl)
+		return rcg->freq_tbl[level].freq;
+
+	/*
+	 * Assume that parent_rate is actually the parent because
+	 * we can't do any better at figuring it out when the table
+	 * hasn't been populated yet. We only populate the table
+	 * in determine_rate because we can't guarantee the parents
+	 * will be registered with the framework until then.
+	 */
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_DFSR(level),
+		    &cfg);
+
+	mask =3D BIT(rcg->hid_width) - 1;
+	pre_div =3D 1;
+	if (cfg & mask)
+		pre_div =3D cfg & mask;
+
+	mode =3D cfg & CFG_MODE_MASK;
+	mode >>=3D CFG_MODE_SHIFT;
+	if (mode) {
 		mask =3D BIT(rcg->mnd_width) - 1;
-		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
-				SE_PERF_M_DFSR(level), &m);
+		regmap_read(rcg->clkr.regmap,
+			    rcg->cmd_rcgr + SE_PERF_M_DFSR(level), &m);
 		m &=3D mask;
-		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
-				SE_PERF_N_DFSR(level), &n);
-		n =3D  ~n;
+
+		regmap_read(rcg->clkr.regmap,
+			    rcg->cmd_rcgr + SE_PERF_N_DFSR(level), &n);
+		n =3D ~n;
 		n &=3D mask;
 		n +=3D m;
-		mode =3D cfg & CFG_MODE_MASK;
-		mode >>=3D CFG_MODE_SHIFT;
 	}
 =

-	mask =3D BIT(rcg->hid_width) - 1;
-	hid_div =3D cfg >> CFG_SRC_DIV_SHIFT;
-	hid_div &=3D mask;
-	cfg &=3D CFG_SRC_SEL_MASK;
-	cfg >>=3D CFG_SRC_SEL_SHIFT;
-
-	num_parents =3D clk_hw_get_num_parents(hw);
-	for (i =3D 0; i < num_parents; i++) {
-		if (cfg =3D=3D rcg->parent_map[i].cfg) {
-			prate =3D clk_hw_get_rate(
-				clk_hw_get_parent_by_index(&rcg->clkr.hw, i));
-			if (parent_rate !=3D prate)
-				parent_rate =3D prate;
-		}
-	}
-
-
-	return calc_rate(parent_rate, m, n, mode, hid_div);
+	return calc_rate(parent_rate, m, n, mode, pre_div);
 }
 =

 static const struct clk_ops clk_rcg2_dfs_ops =3D {
@@ -1102,32 +1076,28 @@ static const struct clk_ops clk_rcg2_dfs_ops =3D {
 	.recalc_rate =3D clk_rcg2_dfs_recalc_rate,
 };
 =

-static int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg, struct regmap *regmap)
+static int clk_rcg2_enable_dfs(const struct clk_rcg_dfs_data *data,
+			       struct regmap *regmap)
 {
-	struct clk_init_data *init;
+	struct clk_rcg2 *rcg =3D data->rcg;
+	struct clk_init_data *init =3D data->init;
 	u32 val;
 	int ret;
 =

-	ret =3D regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET,
-			  &val);
+	ret =3D regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET, &val);
 	if (ret)
 		return -EINVAL;
 =

 	if (!(val & SE_CMD_DFS_EN))
 		return 0;
 =

-	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
-	if (!init)
-		return -ENOMEM;
-
-	init->name =3D rcg->clkr.hw.init->name;
-	init->flags =3D rcg->clkr.hw.init->flags;
-	init->parent_names =3D rcg->clkr.hw.init->parent_names;
-	init->num_parents =3D rcg->clkr.hw.init->num_parents;
-	init->flags =3D CLK_GET_RATE_NOCACHE;
+	/*
+	 * Rate changes with consumer writing a register in
+	 * their own I/O region
+	 */
+	init->flags |=3D CLK_GET_RATE_NOCACHE;
 	init->ops =3D &clk_rcg2_dfs_ops;
 =

-	rcg->clkr.hw.init =3D init;
 	rcg->freq_tbl =3D NULL;
 =

 	pr_debug("DFS registered for clk %s\n", init->name);
@@ -1136,14 +1106,14 @@ static int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg=
, struct regmap *regmap)
 }
 =

 int qcom_cc_register_rcg_dfs(struct regmap *regmap,
-			    struct clk_rcg2 **rcgs, int num_clks)
+			     const struct clk_rcg_dfs_data *rcgs, size_t len)
 {
 	int i, ret;
 =

-	for (i =3D 0; i < num_clks; i++) {
-		ret =3D clk_rcg2_enable_dfs(rcgs[i], regmap);
+	for (i =3D 0; i < len; i++) {
+		ret =3D clk_rcg2_enable_dfs(&rcgs[i], regmap);
 		if (ret) {
-			const char *name =3D rcgs[i]->clkr.hw.init->name;
+			const char *name =3D rcgs[i].init->name;
 =

 			pr_err("DFS register failed for clk %s\n", name);
 			return ret;
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index fef6732bd7d8..42ab01d33b52 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -396,18 +396,27 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_=
clk_src[] =3D {
 	{ }
 };
 =

+static struct clk_init_data gcc_qupv3_wrap0_s0_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap0_s0_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
+};
+
 static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src =3D {
 	.cmd_rcgr =3D 0x17034,
 	.mnd_width =3D 16,
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap0_s0_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap0_s0_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s1_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap0_s1_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src =3D {
@@ -416,12 +425,14 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap0_s1_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap0_s1_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s2_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap0_s2_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src =3D {
@@ -430,12 +441,14 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap0_s2_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap0_s2_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s3_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap0_s3_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src =3D {
@@ -444,12 +457,14 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap0_s3_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap0_s3_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s4_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap0_s4_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src =3D {
@@ -458,12 +473,14 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap0_s4_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap0_s4_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s5_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap0_s5_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src =3D {
@@ -472,12 +489,14 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap0_s5_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap0_s5_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s6_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap0_s6_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src =3D {
@@ -486,12 +505,14 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap0_s6_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap0_s6_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap0_s7_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap0_s7_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src =3D {
@@ -500,12 +521,14 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap0_s7_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap0_s7_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s0_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap1_s0_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src =3D {
@@ -514,12 +537,14 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap1_s0_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap1_s0_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s1_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap1_s1_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src =3D {
@@ -528,12 +553,14 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap1_s1_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap1_s1_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s2_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap1_s2_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src =3D {
@@ -542,12 +569,14 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap1_s2_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap1_s2_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s3_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap1_s3_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src =3D {
@@ -556,12 +585,14 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap1_s3_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap1_s3_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s4_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap1_s4_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src =3D {
@@ -570,12 +601,14 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap1_s4_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap1_s4_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s5_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap1_s5_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src =3D {
@@ -584,12 +617,14 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap1_s5_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap1_s5_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s6_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap1_s6_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src =3D {
@@ -598,12 +633,14 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src =3D=
 {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap1_s6_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap1_s6_clk_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s7_clk_init =3D {
+	.name =3D "gcc_qupv3_wrap1_s7_clk_src",
+	.parent_names =3D gcc_parent_names_0,
+	.num_parents =3D 4,
+	.ops =3D &clk_rcg2_shared_ops,
 };
 =

 static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src =3D {
@@ -612,12 +649,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src =3D {
 	.hid_width =3D 5,
 	.parent_map =3D gcc_parent_map_0,
 	.freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
-	.clkr.hw.init =3D &(struct clk_init_data){
-		.name =3D "gcc_qupv3_wrap1_s7_clk_src",
-		.parent_names =3D gcc_parent_names_0,
-		.num_parents =3D 4,
-		.ops =3D &clk_rcg2_shared_ops,
-	},
+	.clkr.hw.init =3D &gcc_qupv3_wrap1_s7_clk_init,
 };
 =

 static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] =3D {
@@ -3458,23 +3490,23 @@ static const struct of_device_id gcc_sdm845_match_t=
able[] =3D {
 };
 MODULE_DEVICE_TABLE(of, gcc_sdm845_match_table);
 =

-static struct clk_rcg2 *gcc_dfs_clocks[] =3D {
-	&gcc_qupv3_wrap0_s0_clk_src,
-	&gcc_qupv3_wrap0_s1_clk_src,
-	&gcc_qupv3_wrap0_s2_clk_src,
-	&gcc_qupv3_wrap0_s3_clk_src,
-	&gcc_qupv3_wrap0_s4_clk_src,
-	&gcc_qupv3_wrap0_s5_clk_src,
-	&gcc_qupv3_wrap0_s6_clk_src,
-	&gcc_qupv3_wrap0_s7_clk_src,
-	&gcc_qupv3_wrap1_s0_clk_src,
-	&gcc_qupv3_wrap1_s1_clk_src,
-	&gcc_qupv3_wrap1_s2_clk_src,
-	&gcc_qupv3_wrap1_s3_clk_src,
-	&gcc_qupv3_wrap1_s4_clk_src,
-	&gcc_qupv3_wrap1_s5_clk_src,
-	&gcc_qupv3_wrap1_s6_clk_src,
-	&gcc_qupv3_wrap1_s7_clk_src,
+static const struct clk_rcg_dfs_data gcc_dfs_clocks[] =3D {
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s0_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s1_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s2_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s3_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s4_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s5_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s6_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap0_s7_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s0_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s1_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s2_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s3_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s4_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s5_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s6_clk),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s7_clk),
 };
 =

 static int gcc_sdm845_probe(struct platform_device *pdev)
