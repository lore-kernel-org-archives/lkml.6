Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C6FECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6A320989
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="aWxf/nXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6A320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbeIURn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:43:57 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:61440 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389883AbeIURn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:56 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:21 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 93A0D7318A;
        Fri, 21 Sep 2018 20:55:21 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="291574202"
Received: from mail-ty1jpn01lp0177.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.177])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:21 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dye8VDOE1pqk4zB+6P2rTJs/HSH+a8Zw6eDTjvByi9Y=;
 b=aWxf/nXNliGBtrEMgjyzOTLbCsYVGEj7fw2MwNW5yNuSulgLrK9EXLqOWOyGcY54P2kLj3veqzExsBF2RYESSmwRzCr2xidfYYmJ3yQXGvkgymDLym0vV5YsT7DVkk8oniSJzaKhk34AJi9ij/e24ZovOOqaI0IHAJIZ3GIirrY=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
Received: from localhost.localdomain (211.11.155.144) by
 OSBPR01MB2296.jpnprd01.prod.outlook.com (2603:1096:603:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:55:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/8] phy: renesas: rcar-gen3-usb2: re-design for all R-Car Gen3 SoCs
Date:   Fri, 21 Sep 2018 20:53:16 +0900
Message-Id: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.144]
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To OSBPR01MB2296.jpnprd01.prod.outlook.com
 (2603:1096:603:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eecada24-0af4-452d-8c3c-08d61fb91aa3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:wIIcemyqsKb6gDSvuALFhDEEgjTlvugnfcwmLX7sH/E08pmBPHfhCwMJNU/xEQavMsmY5Rlp8n/24au8XFUHhZDpAhooGOhDar92QIFdy9NMBePV5HN8RCxeXfUZHY8zPLfZiy5nVejY8pmvn5QMQ+YmUdOMLSOBDGoBO5Ymmti4/CfaZ4PppEvehutZpqoQbSCmg0EqaKS/SJR863rac0pdPGZt6B/Mh6MvaoDtLdP7Uf6a755oHmYQ9NcJg/4K;25:tsq7cLXKnu7umrWP65+53PlmvHSxvzbom6OoLA0fX592a1iD8S4MaV2VQGUTqfm/2Sy2a92HGYTJnE6vcBQi/VKGuSKbMMzqVEXiu2HHGCJ1ZjkWHVWHIxAIqO2bg5Fc1gojMjF7xohwCvj+17cLNbx4/5gBrkOZ31XUgAIhCrA/pi8a21bxB3n29DpTY2T7d7l+4gGoT0W+XYvgP0YLgpY/LHOK6XKKl7vT5q1WTQ8fbNyeCZgQ2uwYhNt/rMcVwOXvLuYvpoBfD8P1Ijmce7sbEAMaKOrj+OmPmnf/lMXSP7nSEmiKQ6GRoSARxQa/D9ehWFxuty4hteVuY2K3ZQ==;31:oizdBE1SSTNkc/aoOC566/60J9ua2yGf70z0MvgKWGRZCow6cS9m2XUvp1+fVQZb7xwxkGkLOUWt8L4UfjCs6yYgh+EZivNUM6fAHAgujZuuvrCqKj2z9gBXHbLbFpNyXGukYirex0fAGzHtkBkBJVQJnKJaRl9mc54/Ex2YEV6WPdBd8vemsxLWkZYDLX0q8tb4T7NFhuZsgIqwMCt3jPjOfBC1KPiXMi8hrrjLmUE=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:PWHIysiiFBhNbshf52LoNrzFSGUINsKzx1XXMnH/IO7iMkmS6uUN9rqxfPlYbPHoPo52JmO2G8kW9I7q0/0MDm1GLUyZTQifCBskiIvJTqiUCPAk7PG5Yc1caMPBjCzSPkpVKCGMirqMOYhx1j8X/FMVHyOxj9sfVDtk83UbFAHuadNspQIxlEO4ItAGgLBrLJ3OyiDQR2NS4VTED10PGmtItSSH84mUreVNn8n3mDegrW9MtV5nXRJf/0uwDOhpAiERaame649DwftmchRYbHwzIkfj5fHzEb+ZuuPEEHaJyRvOqM6+8K+sze0YC7f0fsxpn+WLw5SwwY4g5O66ZsBWMaAZ16xxDXFtpiG/Mc8JCA+ecjjzqoskYpf0hQLzzpmpVlra3BvB/8wWvFF1N7vHKiExrmzBIpBp/lZ0ab+lVvVbQ3019VQYXiL5mrNb/ihfeaCZioKdNg2+qrJALlTtM/a7+9rFDr7P615xZUXIJnIbDJup0AoCW7Q/+a1h;4:vN+iZK3RSmObR7W5tq9Wx7WuHgSdjuWytI1b16mZJnoT4l20HA4rWAmg51yXUFWI/BpW+C/CSl7FrE4FscJ5oXgulX3Pr3ZQKgOO/zBswtMW0pw2mnaPhvQt8RD8huYcYTScRkRtnW+LAlgpElp7vsegTbRGeetujdbUt1Wdj9sYMa74vYRxAbZL7V6/eZrGSdMIiyAoUz3jeHC6BWLrGZXIudAmE0HowuKKto1n5PknFq1C8nEyvL0s47l/u0P4p20077yB5f6PPAGcXIPsTw==
X-Microsoft-Antispam-PRVS: <OSBPR01MB22961EEF90A38C4AFA08D21FB8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6029001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(956004)(2616005)(53936002)(36756003)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(106356001)(498600001)(8936002)(305945005)(6666003)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:jRHKs0RJ6V+PA156I15yUqQElXMV2pu5GSzrg1hxV?=
 =?us-ascii?Q?c6X5JszdR1XjD7q2qtu/OHKWkAiHI85nh0tB8yAuXJXx6LdNUC/mi1Imulph?=
 =?us-ascii?Q?KqNbxbDzHVuqStc7FymopzYqOEvYymtIQG9gahGMf2VbUyG4FasprUpt7SzN?=
 =?us-ascii?Q?kbT5ETIZp9OD4E7br9rLOU0imYXkjfLEt9EAj7kcfjkU0EpSV9idMByRUqek?=
 =?us-ascii?Q?H1RbUDkAqT1Clm7zmfBIYn9epU1v999YmPgKt311pA5Dc49USx4GpssLUHS3?=
 =?us-ascii?Q?TbPZ37u+ruFpmnQcWzCgCvaaejPijcKJdDr2XTUN7qKuU/d21wkBLNLS8riR?=
 =?us-ascii?Q?7+wYnafS32sWnT7n6LtOREFJ71cjxH9VYx2F8jEl8t+DYnM9CQqi51oTo4LX?=
 =?us-ascii?Q?kod3pYbX5yMvvEDz0SxISh7xSYrYWGTeNbJ452FyNq7XHHxX9CUogRPFh6Aw?=
 =?us-ascii?Q?KBBnFm5v0OsBs9Ju5dOW1pTJx37GhHL47hoTKwCOaKuodlwp/ULclH9MQXRD?=
 =?us-ascii?Q?6HklJLvCSpzYXuHmqPEpvV0FMR7VYp38rU4EqXcV5l/NzIpCqu7up45NplU5?=
 =?us-ascii?Q?rnf7yEvBWI7+t1iWZIS4SHWlf+c68fi3WIbDKVgj8YUS2g0HpscjZqaS3e84?=
 =?us-ascii?Q?kV4WYs1q+UfB8UwGwcuQB4pgQF/e1UHlU+cG7p21iZAA9ewJXMuoV6wf4x1u?=
 =?us-ascii?Q?Bnbfu63MKqp+LL3w1ItP1VuI6RXuEwchEaBuGgbe8C8psKjprIkPVFntjfYD?=
 =?us-ascii?Q?S7TMlehX0ge7XIUvtc9hfIb2WZUKa4WXKUCQRB4aIcV08IVN9KcHgoeO9Uln?=
 =?us-ascii?Q?UzpONdFHUYNWE8avkIrtXi4PxjZjTnd2GwhO+YyiWL6FSLiZjgnBppP9+m63?=
 =?us-ascii?Q?jHskhw904uL0dt8MdV5eocZXVE/xByeRYOlBQ5Fgg+uLN3jK9ytvj6Hd5/CA?=
 =?us-ascii?Q?RE0EyvNXKcwapq0A6koJwtovKXlptj2jshCs8dxFxS9YywjxEeu+pmsB1kaO?=
 =?us-ascii?Q?rUCkF/9jvW3tdORWkOjOst+Nd4FQMEtMfBCglLRZTo934ss2jZ75KSAincF1?=
 =?us-ascii?Q?+quveft8TAvteNstY0f9dNwLZl7dNjB0FXE2FabyQprnrW1/Wt6zSMdso+T8?=
 =?us-ascii?Q?GzQklue2+bOVfNnbnfTvXOHpLctb59s06OwjOi3QyyXx5ykLuCUnB1C0l1AK?=
 =?us-ascii?Q?q/+eejiwEdWskZQMiQOZwHKA+4gE08ecYpN?=
X-Microsoft-Antispam-Message-Info: WVdCj9aKFuLcRyv/GlqZwIPgrjzC6IoZaaivEOSj2s891of+rA7km0oo1kex9DxTdToUKqymYVYiPsCpRbZ1Oz9VCJaatEaBg02jiHwagaVn7vjPycfn+BO1EZcLSd7bGLoj9ByoSkid5vbn+Axi3lKqq8epFgtgpeDJRcTPylSwSWzrtO718R7OMIR9vaHAlsVlp/lbz+e1nf5+9NLhXcYcyeinOCvNre+wJT/d60qqhjzg7pQ9rMpLGaZiQa/jMRM7ASGOswv6iLKZB9Hzjtx/UWLJr7ALOe/whS5vt9n9aJQZI21S4cjUcuGfDyY/JacXhims6ZvvSreQazr6MpP+CKasapH5oYQiI/31dRI=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:6np/bPK3xV7yIYy2UKRr0GAFhYfOpZfBu8dhqwtcvXBwsJvAWhCaXpomq7mqWVtLeVHiFYsyWZTJf85poeqdGo4GtFhs3owMFErBhh82VO0u7z5kNQTnmvPW9QE/arnP1NuYSsSshes2h2Xs22PpdZgcO2xzcGm5KMJc7PIfbJpbXvlLVl6y/QQp1ohBKxR3xQ6nFpe8VlBsvmUlmqr2OroPLAjC39/JEcsRkgakuVGme3zQIUG7ylf0Bn8B/FacLD1Z7SmWIBbrAM/O5HUTaM96UikiFJbzzlXZ3CAI+ZfoTuTM884AlcJ5IpgBGk8yyGYC7/s+ZQZYYMZFToRmHT/VYmJV9G9Lkq5xUDBbwp0q3BFLIJ10WeWFY9HgRU9bw+B0fo2Q6VcSAK+dH/ysKMxNCIFK8svyDd2kSQxtjXyX26Y+xfSioJfg+vXbDhSbufJv9hr/3FwfEBW74Mke4g==;5:IWhjwyn4U9rqx7+VkXfkI2Gf31Fk0R/HQtnD0tMXg//Rj9KeXPx5jbYEp+k8Mhc+HplRQsTbrts2nCbVsrHR02M+D9pMBuAkIgghlxVmq34DKHMP8DzvByzkOl2KHqr1BsERYz1ruqt2JJjNzxQT5u/bJsYcFYNRdDK2OzBSvXA=;7:GpUPikAzFJnqwFpj2Ww3uwnI3jlSM1n6k2Z9TgJFn+5qP10bk/m/vLjv3wVQ+DAi3ThHyHCUkFfeqC36geKGZJiE1ljN8OV9EHqfDVQa4JC1NOs707HR7OBOnZ06cMM48XB3k6lamyobv0zOA/cnsTUHuKKvruFodRCRAbk2AOngcScgYTcqSQ4M/wgtJg0GS0w20kgeN7vj68cnxOqiYGfScBwzO9lr4bFkZ6ECcP8S8KpAg83fDrU9Eddsc7zc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:6ngIn2TVZw4dMLlg+FYxyXY5N0GHuJoPB6jZo4KChn6VLtsUcN6fgiQ1Dhl0rzwBPCzC2Aulz5hD+o6lY71P8N7VQWD6+KtWKecAvD7/F8XXtLNaAjfXlpCn4Cxm1I1U6CZBPQKAvLUCQ1SOWIAYjdPU7hKCc8hpqjgm2e1Skl0=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:19.4479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eecada24-0af4-452d-8c3c-08d61fb91aa3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on the linux-phy / next branch (the commit id is
53706a1168631fa5bf2e6d47de4647ea7e69f270).

Since all R-Car Gen3 SoCs have dedicated otg pins in fact,
the previous code was not good to handle it. So, this patch set
changes the design for all R-Car Gen3 SoCs.


Yoshihiro Shimoda (8):
  dt-bindings: rcar-gen3-phy-usb2: add no-otg-pins property
  phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role sysfs
  phy: renesas: rcar-gen3-usb2: Rename has_otg_pins to uses_otg_pins
  phy: renesas: rcar-gen3-usb2: Check a property to use otg pins
  phy: renesas: rcar-gen3-usb2: unify OBINTEN handling
  phy: renesas: rcar-gen3-usb2: change a condition "dr_mode"
  phy: renesas: rcar-gen3-usb2: add conditions for uses_otg_pins ==
    false
  phy: renesas: rcar-gen3-usb2: add is_otg_channel to use "role" sysfs

 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  2 +
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           | 80 +++++++++++++---------
 2 files changed, 48 insertions(+), 34 deletions(-)

-- 
1.9.1

