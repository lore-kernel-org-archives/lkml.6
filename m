Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0726BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84972083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="j+lMNnhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84972083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756696AbeFSI0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:26:40 -0400
Received: from mail-co1nam03on0057.outbound.protection.outlook.com ([104.47.40.57]:50284
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756469AbeFSI0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHmF3EIIio7vfHEFs90cXFVX9TKL6ark/wO55T+C6cE=;
 b=j+lMNnhI3DEEUNz5DLs/bvd0zelBdoHl4eLQCYLT8XO6dv/vSdUHHFDIkLBDW0ozeyUUwfiVfoYy2o63ShXNGXjkLL5gVe2MQiznzRhp5bC7MIl8oWLQFWf1Py5A7/dzIovDV6UVaMYFYsCEoctrYL4Mq4HPlM5KWBH7cVAWLZ4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.vmware.com (155.4.205.56) by
 DM6PR05MB4585.namprd05.prod.outlook.com (2603:10b6:5:9f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.16; Tue, 19 Jun 2018 08:25:59 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH v4 3/3] drm: Change deadlock-avoidance algorithm for the modeset locks.
Date:   Tue, 19 Jun 2018 10:24:45 +0200
Message-Id: <20180619082445.11062-4-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180619082445.11062-1-thellstrom@vmware.com>
References: <20180619082445.11062-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: CO2PR04CA0136.namprd04.prod.outlook.com (2603:10b6:104::14)
 To DM6PR05MB4585.namprd05.prod.outlook.com (2603:10b6:5:9f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91bea715-ed72-4c2e-5fef-08d5d5be4a6b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4585;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;3:z3eEeicsueokQCaXr29CYDW+lIX9vPydjuHFN6uORO20p7GsIdaUMxLiXXCA/eQ24U0sELqL7MsMUUf9fNF6YP5LjwIUlL0hOvLZ4bumZo8epqTSS5f4Ra3S57vHGJ63mZKzDfuqpdtFjW8sCfVFtpzAOd4MjWiEpBPoUhdqQJkrMP+pM52L9RAv5VIkhZng1jEZUffLPbA7AeqJwveIJ5uxqzzp6gwqSkhvi6Q9ss3VEiZCxEHoQJU2b9qQlSpY;25:FN9vUm1yA6negw8y6yXqwSwdMlnqwJ5lLNGXKV9OYEgBDYPxSXEYeRNGe+khCNUvZNZHWIC6sIWmSJKwxbI2ioPE+f50knu5QYlJeKGMHfl1uq5nSkkZYJ+CXNR/EuOY0Ojf9s7LH8xjfIeyKERIFsbqQ8de/hPFqYMA6JTKUVwW6kJhvyG0q/vlPnpBxu5S/ZlppVrpnczeA8NzvAB+C8N1Q6Q5xRy8eKGHIRyCs6ePzMFFimqv5FxIwu8tdalfgagmk0Luzp2SjtUB0u1ujiqR6FNv+dpAncsgkcjfDs1WU7RD3ZML8FODufzpnUNb7/FsMBRTq6AFM4WlQRplwA==;31:B4LHg8D84pkP9JaAMV3sEWyuILvJWE3+qNCvB87PMSBJoWhVNEK0Kll04H2YQuwyIJteC57sLQnzzHSIoNGYjv8etE3D43X8y88XhOLIR4WHV76ZQ6NuM1h2/96HldRBkeNL0QT8rIc2tyUrsL4gMjBax/ASZuCdx8BslWLlLrA+4ES13D1Ubbhfbs3DRAzF0NUjIdrGGw+b8yWnR31wozo1tLWX2IrPBuj2XduhyXc=
X-MS-TrafficTypeDiagnostic: DM6PR05MB4585:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;20:3BGtbaX/oMoJYPOgS+jDueCiSOkOjzvT5/WNQvLxDM6uz/1Wdd+XBkhBNdM9PLXNHyNr/w1jf5WyA+iswFWmilLaWMFX7qta7Z/7VaPT1Q4A+kHqJRapyGfBZRW3Bh0y170JAGaxVR7C2t4mLQRiisajHuyzmWKBjz7jMGDyzdHSZHLa0g0ViyMgJwfp3pWEhb+FrLWhPMpLhCJpjh6p35XYq7emCQpzXSbqPzThVDBzSsgsYIe9F00Sj1pj7bi184FKRI/1aiz4qwp2bUjdtgehbcK2a7EaEVGnNwrTHbApvuyLKXruCm1SNM8xwNobMb83MFhY03T+cyCRNvpT49DxL5JTLantBsYo5d9iI7pbZhMr0h2LH0cLYH8EH3Y12R2yyxx3vh5I2wMGrFnOQqPCpFrrOt1YF5oL4IBPbM0uBg4Acx/1J/T4YtX5iQ1oDNN5UIuEzgRWb81G4yyl3piyuq3XArhKjqFd2/Jl/mVJINMcBh88ir3SGTbCwfE3;4:2D6+qiCsGHuJKrvG/eFZATWoDT+UlkHe0E72oQl74ml0R5GBd70a9eMVzvQk1KL5EaYeJ0Ss0Cnx2C40t7fA1o03I1/8xx7gFmmnf6MTbSSZZn4IsbYaI/Kd57LqB9rddNIWt/QPDWhl6eGeq2Ci4v1XUJ/BoSkmgSx798dtRNRlZmWx6HmREaywgG5FMNO8qtKCAc6u5i4mvYbZ0Jkx0Az0npjGSiHG3xeoiHOB9RT5/26YsYYenEagE+pWL5zc5JUeV68TDHES24ajcdwjefEwkUq4oc+GVNGxz+hqzsgtAqaL1My8+P3PQlSpAh6TqZHjTlGlCcmBiDnB5H+Jf47tfW/p9PH9YTzhV/uEGv4=
X-Microsoft-Antispam-PRVS: <DM6PR05MB4585F120DA97FD021F29E250A1700@DM6PR05MB4585.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR05MB4585;BCL:0;PCL:0;RULEID:;SRVR:DM6PR05MB4585;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(106356001)(68736007)(76506005)(53416004)(956004)(105586002)(11346002)(7736002)(305945005)(107886003)(6116002)(53936002)(316002)(3846002)(69596002)(478600001)(486006)(50226002)(66066001)(2906002)(186003)(16526019)(48376002)(47776003)(5660300001)(26005)(97736004)(6486002)(8676002)(7696005)(52116002)(86362001)(76176011)(51416003)(8936002)(476003)(2616005)(16586007)(25786009)(1076002)(59450400001)(446003)(4326008)(6666003)(81156014)(81166006)(36756003)(50466002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4585;H:localhost.vmware.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR05MB4585;23:zDeRbd18YvceHq5uGj8BYPKMl4GIHMldSJyUewI0s?=
 =?us-ascii?Q?UHHP2V5HExQclxp8l1Nl2JT7dAgGUXmrTbUsJbifIeljymXbnDzQoLQ2OcGN?=
 =?us-ascii?Q?Z62xowi8QItshARxO3CIPRgW64vA6NIU1p8qDKVmFmk6p0APMaFUioPn5uYn?=
 =?us-ascii?Q?+A1n0XnUb7ysipi0rYzy3UwYahb4o/kSJMANgCQNdtlb7IAQ5Mz7fRk79Cjr?=
 =?us-ascii?Q?0wsN0n99VUoDp+2Ofy56jQokSrdmPJlknDw7nM8HGggKvifT21zJL65DBiPq?=
 =?us-ascii?Q?LK9EfjUH7s/4PLHFtaxOllM726NDCADhv5LUFrkVM1b8CwB1DD4+K8PZUhP2?=
 =?us-ascii?Q?FtemhAFjksMZWQLH9vjdBBR1J+vH0TFzH0OnNgCjnBp7+R5RMo9Dw7kq/ATr?=
 =?us-ascii?Q?v0DtprKE5I8nqujt24ujk0jUpz+zDfkFXtDIvitIKdgbwow/0rDe1qsAwv2J?=
 =?us-ascii?Q?/bAg8GejTnjVMO2jkZ6P/m5XdnruOCc766dzXIXDe7PtNVupE9V5oU+ESir9?=
 =?us-ascii?Q?qWuPPI0pU2uw4UWZQRO5dO0RHQuqhYIHqNjfezzT9sKRjKVaBWK3SuQ2eAJi?=
 =?us-ascii?Q?FJnzRSeOf48rClFPzkQhJDKpoMrXvBBOxeIxYqnjObcFJzyURyfY1EgnuZw3?=
 =?us-ascii?Q?v5pB5H4iE1NGdEU0xJ26BoOYUJgKbIMIR3QyPhF/jMoGVCGqzQu8qe73u5sg?=
 =?us-ascii?Q?G30MRPyw4Zo8iR3vnyRPngtifteXMPBZ9H+JWftnEBkMuzduEK/KNurxmwfN?=
 =?us-ascii?Q?/hrCgAbXfNGJH1s815zgpfh3hI5g+7LwVwZw6sOvvNK+1Bp4Gsyp6rzP3AQF?=
 =?us-ascii?Q?8CLajQtYhBtO2PDCDqcmkjNYPx/iNaeZ6aA0NnOBRewVwyAkWh2TAlqcOyFw?=
 =?us-ascii?Q?/13h04EFKG5Ik3l8m1fPIjIUf85LnG8tUZehvBv5/JxqLIelw7Z2/xwwy9nM?=
 =?us-ascii?Q?QofpMdvjGmmslvVugMNnr1PTN3/lP3fZPvXhJ5sqRDgA8X8DexcFPD+eE1kV?=
 =?us-ascii?Q?jF/03uHX7VzQBjxUs60F7QMoCduC+IP3ZvTwGcYySbNPumQGythzTzAS79oq?=
 =?us-ascii?Q?c+urdlh/3eoZNsJoUXnIgiHn0zspy1WZqSh9TmkYVubzLTnW3X0uuXkminkX?=
 =?us-ascii?Q?44m0avrNcgTFyzrEm07e2Z+Y3YBYqyiD1r4nZQMY5hhyJXhuLaD9bgDo8hMY?=
 =?us-ascii?Q?azo1Ni9Z4qU8Jr8TfwFtLqDP21swvlNUoqey0n4kp+9BCZ75GkGdIy1thk1D?=
 =?us-ascii?Q?UFNK61N5oP66fw6KpZ/FXEZQoxdosM18LhwwugNlRfriTHSyqLmsR6O1jxbx?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: CUbiHz938EJPWEAq8rmYGGdTeMpqvKmD41Eq+4lng89tsCXqcfsrQKKfsZ+/uvWQMfsdYUfaeRClx3XmpSGcxwzcmp8+1X3YS0k88eloCaAqh4x3sePtHEFFh2+JW07bv6Ghgrnn1QL/E1MOczUFZMVyV0iSIUhnp+7LMuy42IUuVNKR8+7r5aP/al+8b5q8cf8mqBRwujhnfi68kChIIoH9OepJCQEYv7F4iym+tgG3zIhyWYxwSEz3qWsyvG9m4ScjbsnYILAjHERxn6SnEph+XyEz5WxLAy/kXC9wtUqAxoR8aVvmNTHSmlfebUThAC25nhRC9HlVeeC358TikA==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;6:P7ROwcVNAIhDzCV23y5OcTobdbEtYqq54mbJuIwMlvBh88sShsLVxNGc8I9CSWDFGYiSEqOEMGNZOxsAtFNEwQL010f8Y8cLlTukw/oddmQAcWxVRkxR1qkhnwPHpW8fIo8SA8jwIEg/X8oYlL+L01IqWJwZlEVBzmQIqF1g2Hn7uWCPomrjPbHbxaqaFCGSJwYgVQRYeAFYZiYNqQNOyhebA+TeCZ7w1YAg+h/gvEJEbFfkD30jPkTSLrqY2/Dq9NihAm06cXEQ8Xa59f51EGIqkIfgaScIYuDebRbTIiJ+q88Mx90zf6eVqAmmq1UR1PiVI1JrDUKZdcE4jZq8edZsCeWeukTphZ21E+M16cPGtapGK7NsG5APQWNgeEmXFQ/yl/7DvsrFbakYRTdKQrxidobsWsuhXv6m6ENs7bODLQQnrxP6I9jr8TS495PoU1XRtjOyS+PMs08uhJYI3w==;5:j06oOy1v7w/XEQAsl4X+ExcTKrfsZqRMioKNXzOwB4vXkWG1THxHP0001NvL43X4PDh89xCwBEagkLRDDQf3voSLTW2J+Et/ZSXkHxKg4wd3AFO9JQmXEE6A2Bw8jKqfgLxIebLc1tsEnV5KDbbUW/MWCMOjx+quMVlR0ihg+gA=;24:w575C+TuA18xSri1HNSFd5oCAFF6ZXfXVj0HxL93PsDo/7gJYmETX0qlbxwY4Gt2bU5rZlq/bMuZ+NMbf1PGt8UWd+1QQhNFVC7Raq6SwE0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4585;7:GujipQY1tuwcwRTMpLBg2LBNVcWmfP2zYjPgbBGl0x1b2CQsxVuo4sIHbwDQOMH7nLVeQpqeoAk67WyeCbun8jhKOGFDqN8qRIpyGf1TjtvAA4Jiuk4eM/I56hCvE8Z/kZ5eqdh5BIytANfYqpsiFwxfN5mq2J7UQSYIsdEzCL+iQqBAUrThyHKSNy8S0+1rUmDN9GEocZFaC8U7hzOc3gUPSdepdZr31uMNXzdBg0MOSJBw01yq/BySpcWo+vZC;20:M68npuzSunq+n8sxk78JxgfETKOvQqdNxV7RgC1VLhO5bQTYI4BszRCS+opejrYFms/svKdfMsgRgdLeYZhmNk3PEiZ4wrr2t/b3PKUCGiIaKZezhKBhcd/anl1+GH8rzvjcX70tcuZdHQyTuVRgfTc2PdJk9psz+c4r/XsdxQw=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:25:59.4904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bea715-ed72-4c2e-5fef-08d5d5be4a6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For modeset locks we don't expect a high number of contending
transactions so change algorithm from Wait-Die to Wound-Wait.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

---
v2, v3, v4: Adjusted to API changes.
---
 drivers/gpu/drm/drm_modeset_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 638be2eb67b4..8a5100685875 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -70,7 +70,7 @@
  * lists and lookup data structures.
  */
 
-static DEFINE_WD_CLASS(crtc_ww_class);
+static DEFINE_WW_CLASS(crtc_ww_class);
 
 /**
  * drm_modeset_lock_all - take all modeset locks
-- 
2.14.3

