Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 630E5C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED8F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="nbOfrTym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED8F208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbeFNHa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:30:59 -0400
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:45824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754673AbeFNHa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN3OYvHKxlyUdsu4P6Dtzq6gLvtX/P+eMJxlwGLUJNU=;
 b=nbOfrTym3YMuRZYv7xIuF3ZgvcKK5kI0Btf/d8cXu3IIosVoqLohbBw+8GY7HWzQM01/pSkk3WB4yXIAH2Ggy+GAuRqn39QsVHr5Nhq94zmT4MG6RBeyoJAiI0QiKPyFevuZTFYBOjyiAs0bDuFw8xPk6P7oXFNIJE8stzGDN2w=
Received: from localhost.localdomain (155.4.205.56) by
 BN7PR05MB4580.namprd05.prod.outlook.com (2603:10b6:406:f2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Thu, 14 Jun 2018 07:30:53 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH v2 2/2] drm: Change deadlock-avoidance algorithm for the modeset locks.
Date:   Thu, 14 Jun 2018 09:29:22 +0200
Message-Id: <20180614072922.8114-3-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180614072922.8114-1-thellstrom@vmware.com>
References: <20180614072922.8114-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To BN7PR05MB4580.namprd05.prod.outlook.com
 (2603:10b6:406:f2::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84f5fab1-9546-4bf4-c45f-08d5d1c8c2f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4580;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;3:lzQwQIcwMM1vJLcXiRPCI/SwaUf6rD7ZqVlU8eC3Yi7ekaE8roVPylFcWA86VIcbB5mxKY2qvlrMT/VwJEJi+5ti36mSc7zBKXBuJyL+G0GKObi0UoEmUDqIna+aklTmI55h4SvcR5242ThXxCkRK1VDZrKof13v1n9789iYss7nUelNVzI7XFkq93a3lVWk2VrYJK9IRqRo/aRm9xVoMmCzXGrgR853ELXZdVB67k7ylOWC4jrY+lAjz1IjH3B1;25:D/1Ab1me9kX7qBPOEE5CEcO16GrqrWr2XB2Ai9scly2PmBrDoiIQPQhHhwgIqFUAesg12n2gzv/Nr+QNvn27pDdq7YZ+wm5E2u1XoC0V00d5NmyeuiYLdS7UwPDcn0CKHtQKnGRCT6KIaJZsRWicI1KKdG5sBqs0UOsJc415dcJUJeejcpRUcetjozfWSlqJpRTfuq23+UDbJba6ay3NjsJxpXA+sPLbUKgf0hE30s0QqdvIM5NjUzZG+sQEX7t7SAZ4q4aoOO1gTB8zCGuFr5NxT5B6BmEydFupBeVp09hwPPMtmnp6e7eBQ0hds1RyCaznsj+rmTVTXzQ1HUG8Fw==;31:sMwJU7zsmsWHym96RJo+PFN/ZtBxjTDoeAyzdrbo1qBHbDnNE/PrX92R46bLSXy39WHZ3DKB2e+5Zl69uAEeU27jGX9iXTbeg4YCe4lGdUJEQaDFiw/5nIFhQIvvVWOB9cwnHW9D/wmTA9yJXhCtdriZEIHFODH23BP0y6RKJEu2RKQG0EiCTg6Mes6N9PIMqSuteWrKe178s9sZF71UQCk0I6l20kYj8CrF4by5qUM=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4580:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;20:5QWKInaZPnGn2/gWbGUUMls4LX348fcUtFExhfPJSxja62BWyIQ2P1hq+7ZrBUxfKHpf2FkStqoaUfuNUN18iauSFYSTPMjm+4n0OTaiQwpmN1tvAzEkim0nN2poKs1QRf9BtHfWk7kJU9N+R5/DS/5KEZ+du3E87Vt10stQHPZq5484k7lbe60QRBy91IGJ7crrKEilq+1xLghyc8ZRlEpJ+K6mxg9eeBqAnJtSgG2ZMlu2N1t7vpcwmhUCBH5kXzUOl9G7r4oJFcQbuAGucU7UF2OBSMM3JD36bH7u2MqgulSdrXhg9ehvQBxq5B2Fp3TOCfQyXBr2vsNQVogERRsvF3gfXFx4MYMim/NVLpP2p/cl1LXn8JFNwJz+TuzTuYLO1RU2iroOFBGESBAFgQgkTANt9FG0kb9eT/dP93xjQapy02YI/Bx4LwsncusE0r10kLEeFMIELjfHAD4dYkBrTNdlEjQhgI+v4N+Hlttnn1PFLGI8XEGGoEw6qVFK;4:gWYzd6os8kNYPf9nGjWEG4KcRmwK14vlDZliopp4K6+aZsVNAOTJ1fo4gZdPJq5PDL4X32x98DwTcilWeiaqpT6EBw/WPb2jpXv5jW7dodvsWewD7PROWs+J6xnrQdP2rsRDZ7e56Onp73xItm9zRP8xIE09uomR0FQEsqTzME3xrsRQz/vl09kgErlRjqF2FKWMblGgvzZjDbVrBPZZN4UcShuc097Jhx9R7/vnAtARuV8NFEoo73b/kr+7g+j+x1pr5HLoTUBuzsNarMp6QnE3fOcFo6iL4s2e10bgFC6PteaUssE0EKNg4h6CHU8+
X-Microsoft-Antispam-PRVS: <BN7PR05MB4580EAD1E4CB4FD875900336A17D0@BN7PR05MB4580.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4580;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4580;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(107886003)(6506007)(50226002)(2616005)(476003)(48376002)(11346002)(26005)(305945005)(105586002)(106356001)(478600001)(51416003)(316002)(52116002)(16586007)(86362001)(486006)(6512007)(47776003)(8936002)(956004)(97736004)(59450400001)(50466002)(16526019)(7736002)(25786009)(186003)(386003)(446003)(5660300001)(53936002)(68736007)(6486002)(8676002)(2906002)(81156014)(81166006)(3846002)(36756003)(6116002)(66066001)(6666003)(4326008)(1076002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4580;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR05MB4580;23:WhKoo+Q7VAALNl7s0OxKUty+ZsmZgLXJfjDEBW3gd?=
 =?us-ascii?Q?35j3jlaMSga5ni/CUSy1/EGLkn7nB+pjdzc4GwH3S/KRSP/yzM6wCOcKu7jf?=
 =?us-ascii?Q?CdWYYKbMxPUSQGo8q1jKHHzIR44P+rzSN+oomi3no10IhuOm05pQ9LzZmJlo?=
 =?us-ascii?Q?CmUDxLuSg6FDHNa/i6mchiegsTppvieYNheu2gq5mWdkjx51mkQ2IE4wG1Xl?=
 =?us-ascii?Q?m6oIcwQbyNE7xhK9vJvhed7POQqrY2etE4ZYjv28lXdLjKFss/XBqoE7bF4m?=
 =?us-ascii?Q?v7wtizKdCO5BxuuHSzZ9tqU6ScrWin7vAn6mCd6f8K4ZwY8EdItpsFsSFBxl?=
 =?us-ascii?Q?86Y1td9wUq3gEN4zq3rYMslZwuuj06kCnB4GOlL51l0Z0DE9BcioRozweFVL?=
 =?us-ascii?Q?3NMQaznch0SHSYBcpt5759sm/buXv7e/ro1xNZwuxvC88Xxi8Aw6lZ/aJRov?=
 =?us-ascii?Q?A+VfXgF5pOlmlDX0m1AOi1K+H8s44ZLfOY6g6bwj2mamK9FUikbhylJNPRLS?=
 =?us-ascii?Q?zKTJ4rlgUDfofepGG0OUV7k1nMpFkQgMyO6VZSEMykezQtZt067FXAhl1mnu?=
 =?us-ascii?Q?v+Utsj5zAi22XSu3kF8/xKeJMFrT9Yy5zmWl2vh+q3vNamxS0WUJyaEdxPOK?=
 =?us-ascii?Q?+PE3E1VKqTRTtvMetdHF0/8pI+8RH1pb8Vf3yqLEL7k5GQAkr2VPE/8Csx0e?=
 =?us-ascii?Q?GS78gLFnKW0MbW/BsKTydBlIYfBK5Hjgr5QIbQ+m6UQ2e4F4MRsn74NuYBCP?=
 =?us-ascii?Q?unGnx1cf9DMZlBt9kYweBXP80G7MppE8Ji0O5VogZ1+WEmK9CEvW4H44NxyN?=
 =?us-ascii?Q?o+QqSaKM5CUvysXQ62OqJ9w76yKXpvD2HhCUqogx91mMH5eLiTUBJ0qsO18A?=
 =?us-ascii?Q?gI1eo5EnbsQhPVobusnEELKdPE3ScLGnhlmMn74Jch+87IBULIjANd656xj4?=
 =?us-ascii?Q?67gbFCwH9R4bsGVpbM5Q3QUpzfxtzsX9IeG0+AVqDs/kxSI4cd9xG02iO21a?=
 =?us-ascii?Q?7tLKm8w6L/61dDFklZ3wb6wv0HQZN+Pp/HTlDkX21rLSq9iHkXYiWpKaYQ7W?=
 =?us-ascii?Q?clcojx9hx61I07vecOm5S4Hn7GkCYxanZKUuQDd2Z2auVpZGSufR0uCa5bYK?=
 =?us-ascii?Q?nr/v9HZ6xX52KDVzO2wQAeE51UoNVM3mMEFFmyT+R4mkrA0k+ffdi3Pe3VKs?=
 =?us-ascii?Q?muVr1U3uBs9DGBkcG5qrgfCLXQKg9u0JyxppVCzNIQ6m3ePHmJuU0WdbKIg0?=
 =?us-ascii?Q?/BLJchiKDM135Bz5x8=3D?=
X-Microsoft-Antispam-Message-Info: EKewSqnrllmt4XSdOoNdxU+NcmuO8WcmaW68ie2fI77f6IPq55Eh8hSRtkK/RXrp2CwlnJiGJyqF/sOsK2Sj3iEcqM7Xhs/8l6B8FrJ+JLKo7pFYnqJoxk8M4IcuIEETTp+UZpGIDF63ZxdG38m9oHWIqp6WJqX+5XTIUUk+VslRNV4Cs4owNgpUlfQyaNia
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;6:DK9m/r0yBDw5p34WO876W+hYTnFnYJBjEEAxEj4/BssU6vtUdgEUXzRR6fWQDe8+gBg3psmWyN1rgkCdaaNaHKGvB/7Bb+8hWQNqEtRERRY5475DcG8gbg+cQFAvlg7mteBH+6YfcMN5VpeXVQaefCFe5U2+eu8/k4ZVCQ3EWBqxvL97Q9+SmhVVKZvmqnzV9//tr12lOcyFq5toaZOynThCLfU3No81kIbOzSbu3wVfkILXfT3K7ZTk7K7ZrU8AYcBa4+VPSOsgYp8esgzlepZ79LrJpiQIQ/JkmQYajACemfWcAn4h7tN7EhtRcgk51mV+u87t+hCnou+4qxzgPkZxeKmGt2gBh9cmjk2b/qMApncaFgMWu+RG4xO2lQsa8l/qJ7QsXrwasbNUojC/Xhd6RNkTUVcntkLCa+5NSj2hU7i0gAueefqt5fEHPjbghyJFf4CH55vxomg4VlXi9g==;5:1f2d45pMIA+87LPQn55vcVQExZAwLf0zvDXSxSBd1QPSiDNHOGYVJC/Z3mKvUb/MYeSnbdZMsIuklDpAfyemFI4IFUHHYEkAdioqI3lyM8mjmA2SCiwvrZjn2VH/bqLuUoKm57EgFistzApAweoWNOmsdVn2Q/k2MZQLyzx70Uw=;24:wfgG9fqQwcf9LK/DHUb8P5fwczYpxscLO8UPqYbpetzdaw0SLuQf07KETDvHYHC5JYOvxFA+a/CRSNSS6sZh9eIhk1MUthHc3WnOA1/1e1E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4580;7:wmQAy24EVHMq8jseLwels0V9y7vpnSaQLnn1PjHnO2dog18zW2g+o/FabJ4qhXxUL9ED8yPaMpSPnr1+0NjQuidH78/ut81nGWB3VCsrtBb/IKyriiSFxlZegIk6/ZS/MjfG2oZUXvdmqwUYgyPwXiK+yqCukO8GSXKd9uYiJNle1WB+o/sCVkEyYwbixCyrqrKjupQwK8+EHoxTv4LdsHCt7ORqXtuCBT3/Z7acnmFgdCTwHgbLt2a+dIK24oXl;20:ZPhDukN5v88W09J/E6+gPCD71ApIIy4IUoRSl319OPTz8GUACzY7gcighI0w8blOBX+iuqaBA6/bErIjNDBH7pxC8SzDQYYFpEAj2pHl5lo4H248aeSQKil0GZOnyaDhLtfT9iJj766gFGSamAnbpJkMSJBtvQX1bGuirpS2Hj0=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 07:30:53.0434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f5fab1-9546-4bf4-c45f-08d5d1c8c2f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For modeset locks we don't expect a high number of contending
transactions so change algorithm from Wait-Die to Wound-Wait.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

---
v2: Update to API change.
---
 drivers/gpu/drm/drm_modeset_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index ff00a814f617..8a5100685875 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -70,7 +70,7 @@
  * lists and lookup data structures.
  */
 
-static DEFINE_WW_CLASS_WDIE(crtc_ww_class);
+static DEFINE_WW_CLASS(crtc_ww_class);
 
 /**
  * drm_modeset_lock_all - take all modeset locks
-- 
2.14.3

