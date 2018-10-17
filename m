Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8940DECDE3E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FC121479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SierraWirelessInc.onmicrosoft.com header.i=@SierraWirelessInc.onmicrosoft.com header.b="VoWut8Mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FC121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sierrawireless.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeJRHV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:21:29 -0400
Received: from mail-eopbgr720076.outbound.protection.outlook.com ([40.107.72.76]:34205
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbeJRHV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SierraWirelessInc.onmicrosoft.com; s=selector1-sierrawireless-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/e0ak3EpZj8O8jDslU8HSVxaCNlvYGmpWs0I6YAIME=;
 b=VoWut8MpVrQ840DHqqFACwGXRMzCrN3GkVL8OXfH31xeZ39Bo6MMDPzY963eoING1OXEFakC5VWzdKLKfXW1XegbIjMhPOqgSpu0Lx7+AKqTlSVVEOJ+81puowEBNchZsZJSpRP3BJAST+yus0pjPcvLV22+0HMvnWBr9itFn18=
Received: from DM6PR02CA0006.namprd02.prod.outlook.com (2603:10b6:5:1c::19) by
 DM5SPR01MB344.namprd02.prod.outlook.com (2603:10b6:4:47::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Wed, 17 Oct 2018 23:23:25 +0000
Received: from BN1AFFO11FD006.protection.gbl (2a01:111:f400:7c10::118) by
 DM6PR02CA0006.outlook.office365.com (2603:10b6:5:1c::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20 via Frontend Transport; Wed, 17 Oct 2018 23:23:25 +0000
Authentication-Results: spf=softfail (sender IP is 208.81.121.44)
 smtp.mailfrom=sierrawireless.com; schaufler-ca.com; dkim=none (message not
 signed) header.d=none;schaufler-ca.com; dmarc=none action=none
 header.from=sierrawireless.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 sierrawireless.com discourages use of 208.81.121.44 as permitted sender)
Received: from mail.sierrawireless.com (208.81.121.44) by
 BN1AFFO11FD006.mail.protection.outlook.com (10.58.52.66) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1250.12 via Frontend Transport; Wed, 17 Oct 2018 23:23:24 +0000
Received: from zm-legato.sierrawireless.local (10.1.4.244) by
 CARMD-EXCHHUB01.sierrawireless.local (10.0.6.2) with Microsoft SMTP Server
 (TLS) id 8.3.348.2; Wed, 17 Oct 2018 16:23:23 -0700
From:   Zoran Markovic <zmarkovic@sierrawireless.com>
To:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zoran Markovic <zmarkovic@sierrawireless.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [RFC PATCH] smack: fix access permissions for keyring
Date:   Wed, 17 Oct 2018 16:25:44 -0700
Message-ID: <1539818744-30912-1-git-send-email-zmarkovic@sierrawireless.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:208.81.121.44;IPV:NLI;CTRY:CA;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(2980300002)(199004)(189003)(6666004)(316002)(246002)(16586007)(54906003)(110136005)(356004)(8936002)(5660300001)(50226002)(7636002)(8676002)(305945005)(104016004)(47776003)(486006)(48376002)(4326008)(106466001)(51416003)(336012)(2616005)(476003)(126002)(105596002)(50466002)(86362001)(2906002)(36756003)(14444005)(26005)(508600001)(77096007)(186003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5SPR01MB344;H:mail.sierrawireless.com;FPR:;SPF:SoftFail;LANG:en;PTR:carmdsmtp.sierrawireless.com,spf.sierrawireless.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD006;1:2T2NSEup7Ig3ovnDXKAZJOsDOsZu4V2V+1blGjaYMgC5sjWfphnJsJPHPczYlKZbUR01lR9bNDr22AzNsb/wn11MehoxhOCtp6RBveyDuvOofNyPDP8ldUebjodVSIpY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9570cd-29a3-4ba1-41eb-08d634878945
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5SPR01MB344;
X-Microsoft-Exchange-Diagnostics: 1;DM5SPR01MB344;3:C3wmNZyMSaw8OLgjphI4qFI4oZ7hZOVx5xCRAm9STkaXy8VV+f2Rv3CsuMGqhZevGf6Crje0P2z68HoTqtj9Ho8oN1l3PUUAfLgC1lC2TolY1ok4/ycP00bJ6wpPJ2uWTQDPx/FOL7iJOvlbIsAmWZh6tfILI0YYhUSpQ+zBj3oa45pQ75VBRxZZUieLglSc1flp+WrFAlppPzAEt1/2/x7CkbVVAGFaerwXYN0whGlPudHqehZkBGlXJXlvwr/Q3oY5MEn14nqT6H0s4MKiIdx661CUT+spPeaTcrkrlN+AqYs9xfnO0V+NG7hy8h9NIjz/mqYo6b8WOVYQQPzBSk+WFtu7uXZ7NXY6uMMHQWE=;25:duAbWgIiM56o6vV8diVHCPZ9h69LrMHQRLI7CK1wDjRYciktpp825c6nOWKxrzs2oOzw9N3ySvY1LSdI4fEp6BLgBMAtsYpkl5mwRwR6xr5vEnm9ZrHjEtxLag1z9Hqb2ybVqZ4z6Up0EJg99gSqwKBZh641VUnpZegP0cpu4hHg4jGApG2aJtsPDDDv342dNcysI/QTpIcxWSBhkIXjR6yVjIyeo5mHBptnjHXAy3fan9PIlG+1tzFbKdDboc8OPaunzkztEABVljO1Kztt16kMqzwLc3+mrlXya5te5rP4OHusG4AoYGKr7nOONBmvov7BIL00c+YoJ+dgGFCWxw==
X-MS-TrafficTypeDiagnostic: DM5SPR01MB344:
X-Microsoft-Exchange-Diagnostics: 1;DM5SPR01MB344;31:l5QiY2GQZAfdPFgtVY4H1e96EWeRc2PVckD8HyvC+2zZHTCSO/IXcUOSStXuLiUnQMMEqfF5gJcV2utf/wiTmtsyH8ybk3LN3W7Wdo+tENTRXQZ9VSvRBXz9MV/YbXSJx1gviWGExxvaKxlZnNW5u5HjdATkTd54zdGC0TDOuMxRevhRU4aKORbW8cMYcicZUho2iTKVRLfN9h8dvzPigiu0FN5zauvdbxAgODT0V+A=;20:EEiy43lkPT+aNjcdPWKeSTfPhujEtAjv2p95c0XhcQHY385X4nypDs4hmuHftAs5G8nMQbqCBpSyQmNwLL9tJHVgkWOz3cf5g3yvASTWOgT7qHRfvVnEburFoV4cWqlBuoJzwQ03O9SpiqzVDUGDtGtJGDLzyEsqm/6hNf2yvf0DfNJA+3hxLcVeDdTSbq8s6AzYRjrnG8fU43aiNtPj72kNtx/6aHcmhCgK2x6drhxSpb4wdgRPGXAtimtR/PAZDA91nnfXzQMrmPHbsakTNqNFdFgm7b2YUUqTSPT6a2myiqFbGsv+l2cBNwu8RJgL+aAcOYrttWZZ0KNR3JuL48XyePUlXyMARKOSnm/qDeaQz53zUkY1/M1ndthG2V+Oba3pXW2C9pH1mDDKKdYoBwgw1bHobyMwRpHqc9ZnLJm8UHM+R7WMcuxtI4q8nS75y1eVqsyiWpvT4wVX4MNFREnDDsyitrFJZ/E/S9j4ZhhqCRQqq7tvgIBTG5wQmNwS
X-Microsoft-Antispam-PRVS: <DM5SPR01MB3444300942BA06015F0C574D7FF0@DM5SPR01MB344.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201708071742011)(7699051)(76991095);SRVR:DM5SPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:DM5SPR01MB344;
X-Microsoft-Exchange-Diagnostics: 1;DM5SPR01MB344;4:pjMuYshk5sEHlh3wfPSwtAxEdkqvfMSNHWlpF12XV0+eWGo8ETXTVRTnkyo6cc2JM47X5OnsUnjU4mz8/Aw9nO85XSzCqYBknXuHY5QBiTYdBCFT4bn9nrxhmY6w8G+3UbifgZh906zrlQs9b1w0a+PFxt1V396MqoZScBoceFf6ZAvyDqdm3/cWDZSsayRniuciWUB1rsKeRWmbUo6+dhJsu2Uwd1MKgidAGygW+cs9qUIizgZYGg6noGZ3aiMqghNFULss+WMK3+sJo/GUX0o1iPDhLuTVPoQgSOoy71cxAfN6iLJ5UEfiopI8CY9g
X-Forefront-PRVS: 08286A0BE2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5SPR01MB344;23:ARU7J4iNYkLC7toMlwZ37rz3FEu639dA8HdACYhvQ?=
 =?us-ascii?Q?3LP0kl/IB8Xy2EEin4mFILPjkTCtJkNe1Pla7d5h+jYJnFrCE6n5CrWijpKk?=
 =?us-ascii?Q?SILTw8kEkBjWND5nkYQ+1mg+t2WwZV1br1o78QU9UvB3Ya9X+PS2wsLvq8B2?=
 =?us-ascii?Q?fE7QhGoB4phd4DyST0kGQv28qL2d4JDbxYOUe7eVxl4qYE9A7NF9iQ3WX31l?=
 =?us-ascii?Q?/1eBLb0GU6t7+ZgVtToxGs/1PwPCz4VkIpA2gpveXVllPkmbX602KojH7t0G?=
 =?us-ascii?Q?hwTjCo4V3/xPhZXIbkG4jOq+cyfyc1tkkHTMylsj+TAEP/LHRbabRHk1achi?=
 =?us-ascii?Q?yerkD+vwjA4tWFsImeMVB4LHxkNhuzL0VzCCyIa7bHLXQWmIZ6PhGQeLn9ei?=
 =?us-ascii?Q?+5Vp7f9jw8d+71R5KSlOMBJ5uxrwM2uQCVn4IBRvgSJEI6KkazpQnDupPa66?=
 =?us-ascii?Q?PiDfE59DmAC8xGsThupwCZzVpGDyYg63hoOi1IwBkwLoj3lY8cy7EIIFCBrT?=
 =?us-ascii?Q?EcCmH8uJfI/suE2xx3cMYM0pkXvceVU/GI9cI5cGDARW4l//FdifjXKvrR2b?=
 =?us-ascii?Q?WwGZGElnm+R0TPE9iTleXFJPbt5RngBXwF9DWwqb6o0kaFlNgIHfzNKkJOLB?=
 =?us-ascii?Q?bozUE/D4R7SE9GFVa8H2s0VvmOyhX2O1zOSC8DSF0uu0zeMq06xjWezHVQ7Q?=
 =?us-ascii?Q?LRgPEvri7AaLA+PpD03Y/GgNvzty0wSTx0xy6+xXeQWthYGRiD627KCXuX05?=
 =?us-ascii?Q?TcsOwlDtz6T/fV9vqSThGDsxlYA27eVgnzv2MxPDyftWlVkIdCM1ZC2TAle8?=
 =?us-ascii?Q?XDbOTIMGKPevJa5ATZqtGBzbml5jkwuGlOlUwziTcWzCkWSar6wW/38pU0JS?=
 =?us-ascii?Q?kqvosPNhWyGYG83t94j5R70/lEFG/Nq9PoF+DXz/Zplp+rUbWJ/vdH3gFqDV?=
 =?us-ascii?Q?9YDc0VKQgk6XOhA7pvgCKb9J4K4K23f2GD4QoxBKl/ZYcbGQetzI5EitHaBV?=
 =?us-ascii?Q?g0=3D?=
X-Microsoft-Antispam-Message-Info: 95UyJOmPJ98198XneRF8OMznuVcunSidz+Iu4itiXkTXKxt/6yMhCP3OlbjLqV2obeZhfO/amRQ5wjRgwEltpr/HZU9b04z/B1KmrxaxnwMD4p3IDl02vkWlQADOL1tQWo8fKkNINtnEuOtRe+cfZGSp//jCMARG4Vpq40+p84aY6cNn2bMmBhMPdgXbHX7oZZgIHvgJKbYHD8m+leyoUmkBlqezyjFNqE50MTqu8cwQRDULfIACG9sCt2KX+mb/nkMGI08mmiUSdBzm0nzw16G8cs/FApaRRNVMb5tu7Bcsa01vkhtXzbFmAdqoUqCWSWOcmqTjFtSa9MzcU0Em99BWTJ+L/zZpGpiGIjjBoKc=
X-Microsoft-Exchange-Diagnostics: 1;DM5SPR01MB344;6:pgr2JVfe5wF0CIOzsTvz76nomX6zOM1KqlKn90iTMVFEKnc0u7hb7LxIF5Oynu8bta+151sLBPqDrKtkPbNnJItdF/m0CBLI2opLejaxjRNPLDU30h7Y8PrC/Av+FAmOXuqoi7TKuaAyS63GRii6TGDnfgTAFqGj8R4fF71l8vL9XQETnNLd10x3g+Oeh04WdekZsSZX3013KmeXtkSZ3laIIWXvSdwgVm1K0uMNWW5fQ+arO+v2kHwtyxJeuvRW6ZZIpyj1vONFxgocF4gW7Ru9ojQxf6cZGKo9X++aH/Bb6b1hjtEg6Nrh0E0DjH1YFhM/O9rouZMxbhfW9CDHDuQo9PkFPK36yICd9pkDTsqOm6FbBOS4/xaLuafNxePdzsjGY8zrXWe9iZCkNUOAe8UrkVdmzxU45Bca+NeVMJe3BTcffI5QfjeWQBEJJwQ5B+RKPSqOoCZlNDHWz0dg0A==;5:EqsY2Go6bvZAXihf7gB5LEzIsdD0Yn9V6vdbnPHhOW0SNl3spQzRoqpCjF2u3m8vSsUfUXcrKrn0SXDGdwK/0nL6dHvPwDVSFZDIhIklfwDF8Y6UrB1VmJf5HNopUWQ4aWnRsfQ463+QpAphnXVgUWCSqdallPVZOKb008tMT6g=;7:Zx1T45XTYdd5Q8DogFATbC7S6q4BhKiioxC928A46b7bEVrYzaxr6MNICF2tKnGL4rGmNvM/rLtlgJdAJmDyuK8yrws+O7RbjATaTyYNrxz+HtzKMto7EKyTnEIvM7lcTOrVU8MseZNPCoOZFW97XhURFCfcp4/zMRs8MGJ9Z6WNkhlLolNMCW90a0exAhYZSGRwK5enMLNarh73W4drGwqr4dIR/8s6/z2fklvBNP2CF/O5vVoVX89nJ8kT/NLQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sierrawireless.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2018 23:23:24.4157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9570cd-29a3-4ba1-41eb-08d634878945
X-MS-Exchange-CrossTenant-Id: 08059a4c-2486-43dd-89e3-3a747e0dcbe8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=08059a4c-2486-43dd-89e3-3a747e0dcbe8;Ip=[208.81.121.44];Helo=[mail.sierrawireless.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR01MB344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function smack_key_permission() only issues smack requests for the
following operations:
 - KEY_NEED_READ (issues MAY_READ)
 - KEY_NEED_WRITE (issues MAY_WRITE)
 - KEY_NEED_LINK (issues MAY_WRITE)
 - KEY_NEED_SETATTR (issues MAY_WRITE)
A blank smack request is issued in all other cases, resulting in
smack access being granted if there is any rule defined between
subject and object, or denied with -EACCES otherwise.

Request MAY_READ access for KEY_NEED_SEARCH and KEY_NEED_VIEW.
Fix the logic in the unlikely case when both MAY_READ and
MAY_WRITE are needed. Validate access permission field for valid
contents.

Signed-off-by: Zoran Markovic <zmarkovic@sierrawireless.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/smack/smack_lsm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 340fc30..77e405f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4326,6 +4326,12 @@ static int smack_key_permission(key_ref_t key_ref,
 	int request = 0;
 	int rc;
 
+	/*
+	 * Validate requested permissions
+	 */
+	if (perm & ~KEY_NEED_ALL)
+		return -EINVAL;
+
 	keyp = key_ref_to_ptr(key_ref);
 	if (keyp == NULL)
 		return -EINVAL;
@@ -4349,10 +4355,10 @@ static int smack_key_permission(key_ref_t key_ref,
 	ad.a.u.key_struct.key = keyp->serial;
 	ad.a.u.key_struct.key_desc = keyp->description;
 #endif
-	if (perm & KEY_NEED_READ)
-		request = MAY_READ;
+	if (perm & (KEY_NEED_READ | KEY_NEED_SEARCH | KEY_NEED_VIEW))
+		request |= MAY_READ;
 	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
-		request = MAY_WRITE;
+		request |= MAY_WRITE;
 	rc = smk_access(tkp, keyp->security, request, &ad);
 	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
 	return rc;
-- 
2.7.4

