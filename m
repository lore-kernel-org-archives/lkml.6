Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4269C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4734120875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ch6q0q/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4734120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeGLF4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:06 -0400
Received: from mail-eopbgr710081.outbound.protection.outlook.com ([40.107.71.81]:32736
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732343AbeGLF4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXwsnVE/kGUed8WtB3n0MjBmAOH/i3q1wVWYE6Tk8jQ=;
 b=ch6q0q/LHCLeU3vCQDDdGTVD70PW7nZhbKOkI5UyPLipwq9v41ubZfM0suiq1RuvyO6aFkGjZx2FZT5X3PVriPJwaTThW9ZHgngEDAJU3gY0nk+3+DgZcXm09iiEXbM2Vf32OhMYljjrEeH+dQhmgcCZsWQF+03WNGwL6Th1Gi4=
Received: from BYAPR07CA0041.namprd07.prod.outlook.com (2603:10b6:a03:60::18)
 by BY1PR0701MB1333.namprd07.prod.outlook.com (2a01:111:e400:480f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:48:05 +0000
Received: from CO1NAM05FT035.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by BYAPR07CA0041.outlook.office365.com
 (2603:10b6:a03:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:05 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT035.mail.protection.outlook.com (10.152.96.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUY017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:03 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:09 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:09 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lrkU029902;
        Thu, 12 Jul 2018 06:47:53 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lreo029900;
        Thu, 12 Jul 2018 06:47:53 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 28/31] usb: usbssp: implemented usbssp_gadget_ep_disable function.
Date:   Thu, 12 Jul 2018 06:47:25 +0100
Message-ID: <1531374448-26532-29-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(36092001)(4720700003)(109986005)(107886003)(4326008)(86362001)(316002)(5660300001)(6666003)(42186006)(54906003)(50226002)(16586007)(106466001)(2906002)(50466002)(26826003)(105596002)(478600001)(48376002)(87636003)(1671002)(76176011)(47776003)(426003)(446003)(14444005)(11346002)(8936002)(246002)(51416003)(336012)(305945005)(7636002)(126002)(356003)(2616005)(8676002)(486006)(476003)(186003)(26005)(36756003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1333;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT035;1:eSpbIRca0Fh8rc4fi2Oj7aBDCj8WaDxcCVzhvkziqPKEbksLv9kkUGefLBqjyflIeWOplaKHp7Eywo3dsVyooU9O4exLBvvdwpm5MYjKJbyonCXYhubx66FVylAaMYs/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1d0dc9-793d-4416-3e69-08d5e7bb099a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY1PR0701MB1333;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;3:wxA3yUPMuCKYQ9iVOZvambeYceeDvFZYEPmp0ligPL33OksZuxIYAck828ELE20f29xokkpzRbtbpCdJJwOj0LK+Van6c+K5ZlhJ37sPFONGHfaSlqO0RSnd1KSeYXdgyEbyZaQaahftPK2jXcGxaCmK6kogGAg+aVoqiRdvk98Tw4A8USwmp183RiWw777S0Yj3140G3rn2e4bed1BETjerdFnpwNz9pUS0j964BcVZZcGM4WgBqNS135PmzMaF8XYucAGwlvM5Bvd4Uv91D/9uZzA1MlkdR6GnWsogWI9FYdgfFC7n44g0W1WWFLFILoWJANl6/TBE449vrrVwQ9uD5s8naYfFUFZeP/OCwRI=;25:oGxgTzaicCPGVCH46Znx5cgP4okCFmkOqkvBkUZbdf9vXolmc0az/RZDi88lKIBZ0VoMxNYKXqBMF02RIcBh3faX9l19d44bOeCyFDtZJmLfO34nU68avkf21FYUYxfYf93Dv4Pd/sqvqPgGb5lnz7ktvhMtSgSkRq89au8kzJ631YKnVpOLCz0x2y/GU3eexO/WaAst9RVsOgF0QKGxex74Q3neMni66CxvGtGFxfBxO+KKp9Cctn+auA998zAjhKBX8su7m+MTcNZsvDrqa06JBhOWEqrISx+S86LJxmzd4QejjPX0xe7YgnGgUjwGUnY4WdWzV7Q0owZa9efQfQ==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1333:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;31:1FlgbUykkhgLlaM9/mLpv2t7HJTGiSWpQ6r6J9zzVtlU+5uEhQadzvS3s2bFu51dOtgvJVeUIbi57dr80lN7D8QeqCBX4FsouPXeghqZm736AMA4acT6sdQP6H+SEY3N6odac6CGnZtquyIN1xErk0T+vth/h+wLaV4SGtyfjCFZLuKuhL75HYSenX8znAWfbrE8uw+3sXXK7Tvogr/ChP+13OBbout+eLsqMX7Vtnw=;20:Dpww+FwZUmaUsqM4U2B55Dt3dwCZ5h5Xn6xcL0Ea/e3++aYixF65AgyBykDVg7Y790cmrtvy3PGBtkIU6WJW91Kpc5c9Y8Ug3X4qs5N8c/O+WOBhDqiBq3XdFEwXbzSXgBlNiD1OPQrg+1M2gCrOXEH+wpgb2Op8BujZnXVeMGmuuF5vOD1liqOtTNRsQRuLC2xd1cusieU0ykuClVqYZhiPjpfQfHxIFdZLVCpAOQdAUL/fqEFJYDT8fUKW5hh3nTalK+EnjjHAsyK6MF+ISprCZY2YyU2yaf3CgEZyBPnb00vjazK51N3hFf2MDnX4mUAD6S4uo4t6+cwDRfwFzbu80ayhACa/GgUFbixebUrvUMshAHJLnFaNQQwCWiG+8v0BSwtbRG+TFfZ48NBIJPRBnGns9M5R+ps8kq1CiTFTkfXb3j2x123GCcW/5/0gBcAU4HpCSVj0vs+QR4vcPvDAyobuhfm+rulrz18YWRTlX85iPnUm+NP9/d8mMwA5
X-Microsoft-Antispam-PRVS: <BY1PR0701MB13332EF82CDD09A94C33602DDD590@BY1PR0701MB1333.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1333;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1333;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;4:Vy53t+Eu/TjibPW14/j+dhNS5A11Gxnlg6nJbL39aasih9oDZb01sqguXTMx0Pv0kf1KaeqifeN9+lXMAp9LMgDgTmTEXvZ1nOwfoxPvslUo+9iNxKZjRk1n9CtWyBCO07ZayJR/QxUeQiWLtRIp2e8UhBnpM6vHfDM4HhZncFhlCurgZYbLX2SAKjcxSfa8aKyhsFYcvIeZDCrnFuCyXSQpj7k/tH4hCYjZmHGa16wjT/7psmBydKQTpk9vDTpTnwmnjSHO+GGR5yXGNox7LO+/4jz80yrfFwZ9GPdgzqCRuqZ1Jlv+emHfDibt0c5c
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1333;23:Tx0wNuyXZxVPwhVirJD7BPVa7dVHDy+PY9R1kwe?=
 =?us-ascii?Q?DZwlPD3qhLhd1WKEzOKVNnrkJKlwFQE4n4L2K5wr3XPtlQvIqyBWb3UXjwns?=
 =?us-ascii?Q?6Rzd/YuFyuBvm0VdDF/878v02g8rLmvmlDCLB6d2efCFrkSDTafAj2iiGVZQ?=
 =?us-ascii?Q?E96Z/1ljexVifejopg9cdMikyY7h6zESbUyO9C/qeUGStwJ3W5g9h2ykfbew?=
 =?us-ascii?Q?Pd37OCMxsm0ss4iHk5WPyv0z8DFHrWBOib2pIWAJgDBg8nN46cxA/HQwVrt0?=
 =?us-ascii?Q?7jPISuZzg0p2eiEVnjtIYpikmpSfLOvvIfW3y1zEHGdJC6Cidrp/K3aKxkfa?=
 =?us-ascii?Q?qEeH48L/VI1kZUga4bDp235rAimWKiSo0QVRJd/u2rb5N5WtUKbrvj1GZ+C+?=
 =?us-ascii?Q?6MBljmx5IQy3shrvVGzyN57+qatinR64CujhlHiUIBMg+PQq5jLBhJVDVRDL?=
 =?us-ascii?Q?3ebo0xgGwJtcmTuWvToyZXXpL1+UsB95VfDMDtTy2pJQR0EaylWDV1qQuepW?=
 =?us-ascii?Q?WqTZ8zEGV4IMdi1GLRuM6kvjCKK0UjSQI0h2tRUMqmCLhaYyvkbECgAlcl7N?=
 =?us-ascii?Q?cXh2096W6qMRYGLVSJFKexX1JjtSqj6rQVI+zvGXBgcq3GAhuvhHEz53rmdm?=
 =?us-ascii?Q?rWJjMQF+f6wvphrF/OO9qHN8sZ++si6gLEcj7NSwt7+1wVmFYtdziGYGS46q?=
 =?us-ascii?Q?M19h3W8bSV6yjhE1CLR49dMk5m1tX6Q7PZ8g/rYUM43/YP4C2Bc0FR1P1Ynf?=
 =?us-ascii?Q?OG9hN1PbKo85PsY9ZkIHWgBzf3vpU6MnKln2jIFVW45qF7/UGAbNxZ93Ou5f?=
 =?us-ascii?Q?sxMjiCWHbdZP11YVdZs5uSmAHQdnOoVkieVRut2cAbej5lRQBxy0+2E0zL31?=
 =?us-ascii?Q?gMTEWwEOl4q2h7QM44duWD/bLG/JnMJvciHV26ywwVgXmrj0dillSXoi1+/y?=
 =?us-ascii?Q?4gXNvOkz7CPV0IRnI9vZpeAtzDmdYdKInvoLYX+6QYW/hFkfFBbAb+2onHGk?=
 =?us-ascii?Q?eCVqJOqEcEuOaFPYDXqU9f4KKHEECUHKFnZCLluNXIoPBUxs1Hj8Ai93ep+x?=
 =?us-ascii?Q?GwBdjTqEhNXeUNN2BWN6eqsQUyvUKoIi+AzWQUPe39RaMqF6OOM9QVoODep+?=
 =?us-ascii?Q?nXhjsbjfGDiiX0q3XMvc+Dyk7PCDnSKSd67IlbmQ/J51AeUe1kX2BYQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: JE/JQzeU60abkNt50PiamfHKEizOGG40GM3Js0LH4/mysMhJbTmG9O0AEkRLt1GQqBlhvXrtb7wFPTJDLL5X5nG8DGoYQHQfTIRybg1UOCX4rQGcdCh7rfWJ4N6+yGktf52xrT1znhXVMS4NlYT2i32zCMrXHO5JKCOGxjWzL9hHandCvL3Q8iYol1TAdKb0Ud31DzX6gIj+NTNuwbm3pKGc0yQISK9OFvhaJq95B5N5vyp087Rqq0aubeRIZyyvaZ7gc6A8c+NSeVh/ML4WM42lqVp2rg60UKTmIg1pXsyy3rXE/d8Ryb0ZqRR1K2IN9B9C8zMVXFPkmXFGncWCdgafIIp+qAVWZJZe4LDFgeR0M+AAFwTOlpY64HzTjwWVGyV4zSExRIM0TeQBP+OtFQ==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;6:e01a86P6bwn9Au76r/qqiyFn83UxGzfpZ7BjbERDoB5JjXCrQQNQ0C2zMeb/rjiXSaokwLOCJm4ua2YjC/tCWy2Q+xErhFkTINF/xoup1NSkF4SGd/rDGKRQL03vLzcwGPrlH1jN8KOf/ysSPHYSPcizGJTKIivFuxPwN6fmUnHN+jAkjuLApoCNuXSRUjbtDB9itFlfsneE/9fvoWeGQ/kynbJfjdWdBzJm1Gl71r7VRskLChuwK5dQ4CXLwVB1nBkFjLdHfeiV8DhM7nvnlKk9vbXYZ+MuGMxyeKfAmRLRNmYlUaZZgUO2/Osira0EhMpy+ocYd6GCVHLFcumbArhCXJto87dQW6sx1gzC4skI9fqNiYiR7PU4yRVoWElRrday/AjK7Qn7FxLfhWs1CdP2/V2rP003MXhvkIFY7pWCqr9cRbKHbleb1Ta+TowBlo0P9mEa2qiePs8Db/ITuw==;5:V43enumZXVkTt+7HVRGk9uNMl4IVzL6ZU0Yx1Pey+Jpwk8izCWAqNOqzilr/f85a2A+NLFZIgdUy7PHdr8ZA1eeMYn74MOWcNMU+J+uQL/Wcv1zTshAdt2V8Z/taNKDe4X5dgFEIO7d2cNC3JM7mS0p1AvVzdV/t+CR8GW7IgLA=;24:AVsDPkwcrPrugC0y35uRhRrUgHLBJ10AGUrCMsVEh0uXIQnKlTPeoPA1qD15z2WVsUmaVBkhYDXqToMrpSbBVSRzMbfn4d3J4iBo2F68jlM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;7:pE6jarIjfelfmJYqVO+M+zyLn6/qHZs+bDSFVUdb0dJrvTJCJRaG3I+QVCk3y8fJprguGb7jR5iSsPgNS06FxhacEA4115fxU018o7mDwSun3PXsQPeQME4pnkRbW09RzsbUM2JUVlscYTJ1nU8NxVThp7SBpYU0jrg82TLAR3FTDI8CR91VYvcS8ZudIP+iZ3gW4n1LoOWoeRJqIH6k92/mqen7ORbrDYiLBUiLD6C5XFhOdhAvvylyGV23XbxB;20:GgKAeaGA6sQEV4Ir628kWwpguNb0BRGuMYZQxY9dgU4hNb5g+ODKKLOLPWbxs+nEaePnMiTp7upX/g5P97cAjYoBZjsOx7ykslF6Zt1xu1aayMn5+AehVFXPgxsMKwwawverZADApGYcEo9sPGuiRY665XSGebm4KLKyefC3+Ck/BtXyiRZW+E8tcxo570WC4ABBxGv+qtvxNRwQfA/4BlEndErMX1SRj4U9Ms9m80bJTu/pN+n+ZCVn9JqoA/R+
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:04.7078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1d0dc9-793d-4416-3e69-08d5e7bb099a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1333
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements function responsible for disabling
USB endpoint. This function is called
from USB core gadget during handling SET_CONFIGURATION or
SET_INTERFACE request, or after such events as USB_RESET or detaching
device from host.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c  | 44 +++++++++++++++++--
 drivers/usb/usbssp/gadget-mem.c | 18 ++++++++
 drivers/usb/usbssp/gadget.c     | 75 +++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h     |  2 +
 4 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index 2fecc934cbce..75444eaaf699 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -86,13 +86,49 @@ static int usbssp_gadget_ep_enable(struct usb_ep *ep,
 
 int usbssp_gadget_ep_disable(struct usb_ep *ep)
 {
-	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
+	struct usbssp_ep *ep_priv;
+	struct usbssp_udc *usbssp_data;
+	int ep_index = 0;
+	int ret;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
+	struct usbssp_request  *req_priv;
 
-	if (!ep_priv)
+	ep_priv = to_usbssp_ep(ep);
+	usbssp_data = ep_priv->usbssp_data;
+	ep_index = usbssp_get_endpoint_index(ep_priv->endpoint.desc);
+
+	if (!(ep_priv->ep_state & USBSSP_EP_ENABLED)) {
+		usbssp_dbg(usbssp_data, "%s is already disabled\n",
+				ep_priv->name);
 		return -EINVAL;
+	}
+
+	usbssp_g_lock(irq_disabled_locally, flags);
 
-	/*TODO: implements this function*/
+	ep_priv->ep_state |= USBSSP_EP_DISABLE_PENDING;
+
+	/*dequeue all USB request from endpoint*/
+	list_for_each_entry(req_priv, &ep_priv->pending_list, list) {
+		usbssp_dequeue(ep_priv, req_priv);
+	}
+
+	ret = usbssp_drop_endpoint(usbssp_data, &usbssp_data->gadget, ep_priv);
+	if (ret)
+		goto finish;
+
+	ret = usbssp_check_bandwidth(usbssp_data, &usbssp_data->gadget);
+	if (ret)
+		goto finish;
+
+	ep_priv->ep_state &= ~USBSSP_EP_ENABLED;
+
+finish:
+	ep_priv->ep_state &= ~USBSSP_EP_DISABLE_PENDING;
+	usbssp_dbg(usbssp_data, "%s disable endpoint %s\n", ep_priv->name,
+			(ret == 0) ? "success" : "failed");
+
+	usbssp_g_unlock(irq_disabled_locally, flags);
 	return ret;
 }
 
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 303dc8fab8ad..772a43f24ca9 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -1103,6 +1103,24 @@ int usbssp_endpoint_init(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+void usbssp_endpoint_zero(struct usbssp_udc *usbssp_data,
+			  struct usbssp_device *dev_priv,
+			  struct usbssp_ep *ep)
+{
+	unsigned int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+
+	ep_index = usbssp_get_endpoint_index(ep->endpoint.desc);
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->in_ctx, ep_index);
+
+	ep_ctx->ep_info = 0;
+	ep_ctx->ep_info2 = 0;
+	ep_ctx->deq = 0;
+	ep_ctx->tx_info = 0;
+	/* Don't free the endpoint ring until the set interface or configuration
+	 * request succeeds.
+	 */
+}
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 833647600485..bf6a147e2a16 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -723,6 +723,81 @@ int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
 	return ret;
 }
 
+/* Drop an endpoint from a new bandwidth configuration for this device.
+ * Only one call to this function is allowed per endpoint before
+ * check_bandwidth() or reset_bandwidth() must be called.
+ * A call to usbssp_drop_endpoint() followed by a call to usbssp_add_endpoint()
+ * will add the endpoint to the schedule with possibly new parameters
+ * denoted by a different endpoint descriptor in usbssp_ep.
+ * A call to usbssp_add_endpoint() followed by a call to
+ * usbsssp_drop_endpoint() is not allowed.
+ */
+int usbssp_drop_endpoint(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
+		struct usbssp_ep *dep)
+{
+	struct usbssp_container_ctx *in_ctx, *out_ctx;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	unsigned int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+	u32 drop_flag;
+	u32 new_add_flags, new_drop_flags;
+	int ret;
+
+	ret = usbssp_check_args(usbssp_data, dep, 1, true, __func__);
+	if (ret <= 0)
+		return ret;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING)
+		return -ENODEV;
+
+	drop_flag = usbssp_get_endpoint_flag(dep->endpoint.desc);
+	if (drop_flag == SLOT_FLAG || drop_flag == EP0_FLAG) {
+		usbssp_dbg(usbssp_data, "USBSSP %s - can't drop slot or ep 0 %#x\n",
+				__func__, drop_flag);
+		return 0;
+	}
+
+	in_ctx = usbssp_data->devs.in_ctx;
+	out_ctx = usbssp_data->devs.out_ctx;
+	ctrl_ctx = usbssp_get_input_control_ctx(in_ctx);
+	if (!ctrl_ctx) {
+		usbssp_warn(usbssp_data, "%s: Could not get input context, bad type.\n",
+				__func__);
+		return 0;
+	}
+
+	ep_index = usbssp_get_endpoint_index(dep->endpoint.desc);
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, out_ctx, ep_index);
+	/* If the controller already knows the endpoint is disabled,
+	 * or the USBSSP driver has noted it is disabled, ignore this request
+	 */
+	if ((GET_EP_CTX_STATE(ep_ctx) == EP_STATE_DISABLED) ||
+	    le32_to_cpu(ctrl_ctx->drop_flags) &
+	    usbssp_get_endpoint_flag(dep->endpoint.desc)) {
+		/* Do not warn when called after a usb_device_reset */
+		if (usbssp_data->devs.eps[ep_index].ring != NULL)
+			usbssp_warn(usbssp_data, "USBSSP %s called with disabled ep %p\n",
+					__func__, dep);
+		return 0;
+	}
+
+	ctrl_ctx->drop_flags |= cpu_to_le32(drop_flag);
+	new_drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
+
+	ctrl_ctx->add_flags &= cpu_to_le32(~drop_flag);
+	new_add_flags = le32_to_cpu(ctrl_ctx->add_flags);
+
+//	usbssp_debugfs_remove_endpoint(usbssp_data, &usbssp_data->devs,
+//				       ep_index);
+
+	usbssp_endpoint_zero(usbssp_data, &usbssp_data->devs, dep);
+
+	usbssp_dbg(usbssp_data, "drop ep 0x%x, new drop flags = %#x, new add flags = %#x\n",
+			(unsigned int) dep->endpoint.desc->bEndpointAddress,
+			(unsigned int) new_drop_flags,
+			(unsigned int) new_add_flags);
+	return 0;
+}
 
 /* Add an endpoint to a new possible bandwidth configuration for this device.
  * Only one call to this function is allowed per endpoint before
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index a3288cd16c4a..cc826255593f 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1688,6 +1688,8 @@ void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
 unsigned int usbssp_get_endpoint_address(unsigned int ep_index);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
+void usbssp_endpoint_zero(struct usbssp_udc *usbssp_data,
+		struct usbssp_device *dev_priv, struct usbssp_ep *ep);
 int usbssp_endpoint_init(struct usbssp_udc *usbssp_data,
 		struct usbssp_device *dev_priv,
 		struct usbssp_ep *dep,
-- 
2.17.1

