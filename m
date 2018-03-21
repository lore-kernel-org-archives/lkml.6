Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeCUTCQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:02:16 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:56933 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752637AbeCUTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:02:14 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3870:4321:5007:6117:7576:7903:8603:10004:10400:10848:11026:11232:11657:11658:11914:12043:12048:12295:12296:12438:12555:12740:12760:12895:13439:14181:14659:14721:21080:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: shape50_878cc10cc8053
X-Filterd-Recvd-Size: 4571
Message-ID: <1521658930.7999.25.camel@perches.com>
Subject: Re: [PATCH] drm/amd/pp: use mlck_table.count for array loop index
 limit
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2018 12:02:10 -0700
In-Reply-To: <20180321182653.3150-1-colin.king@canonical.com>
References: <20180321182653.3150-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 18:26 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The for-loops process data in the mclk_table but use slck_table.count
> as the loop index limit.  I believe these are cut-n-paste errors from
> the previous almost identical loops as indicated by static analysis.
> Fix these.

Nice tool.

> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
[]
> @@ -855,7 +855,7 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
>  
>  	odn_table->odn_memory_clock_dpm_levels.num_of_pl =
>  						data->golden_dpm_table.mclk_table.count;
> -	for (i=0; i<data->golden_dpm_table.sclk_table.count; i++) {
> +	for (i=0; i<data->golden_dpm_table.mclk_table.count; i++) {
>  		odn_table->odn_memory_clock_dpm_levels.entries[i].clock =
>  					data->golden_dpm_table.mclk_table.dpm_levels[i].value;
>  		odn_table->odn_memory_clock_dpm_levels.entries[i].enabled = true;

Probably more sensible to use temporaries too.
Maybe something like the below (also trivially reduces object size)
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index df2a312ca6c9..339b897146af 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -834,6 +834,7 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_sclk_table;
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table;
+	struct phm_odn_performance_level *entries;
 
 	if (table_info == NULL)
 		return -EINVAL;
@@ -843,11 +844,11 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 
 	odn_table->odn_core_clock_dpm_levels.num_of_pl =
 						data->golden_dpm_table.sclk_table.count;
+	entries = odn_table->odn_core_clock_dpm_levels.entries;
 	for (i=0; i<data->golden_dpm_table.sclk_table.count; i++) {
-		odn_table->odn_core_clock_dpm_levels.entries[i].clock =
-					data->golden_dpm_table.sclk_table.dpm_levels[i].value;
-		odn_table->odn_core_clock_dpm_levels.entries[i].enabled = true;
-		odn_table->odn_core_clock_dpm_levels.entries[i].vddc = dep_sclk_table->entries[i].vddc;
+		entries[i].clock = data->golden_dpm_table.sclk_table.dpm_levels[i].value;
+		entries[i].enabled = true;
+		entries[i].vddc = dep_sclk_table->entries[i].vddc;
 	}
 
 	smu7_get_voltage_dependency_table(dep_sclk_table,
@@ -855,11 +856,11 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 
 	odn_table->odn_memory_clock_dpm_levels.num_of_pl =
 						data->golden_dpm_table.mclk_table.count;
-	for (i=0; i<data->golden_dpm_table.sclk_table.count; i++) {
-		odn_table->odn_memory_clock_dpm_levels.entries[i].clock =
-					data->golden_dpm_table.mclk_table.dpm_levels[i].value;
-		odn_table->odn_memory_clock_dpm_levels.entries[i].enabled = true;
-		odn_table->odn_memory_clock_dpm_levels.entries[i].vddc = dep_mclk_table->entries[i].vddc;
+	entries = odn_table->odn_memory_clock_dpm_levels.entries;
+	for (i=0; i<data->golden_dpm_table.mclk_table.count; i++) {
+		entries[i].clock = data->golden_dpm_table.mclk_table.dpm_levels[i].value;
+		entries[i].enabled = true;
+		entries[i].vddc = dep_mclk_table->entries[i].vddc;
 	}
 
 	smu7_get_voltage_dependency_table(dep_mclk_table,
