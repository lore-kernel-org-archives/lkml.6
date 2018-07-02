Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB47C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C362825615
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7+nXUz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C362825615
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933061AbeGBLxC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:53:02 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:16590
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754002AbeGBLw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCsEP0OCy+KRepo+jerEegNEWsY9GVbZBWsc88fvKbU=;
 b=g7+nXUz1XM6opzPqcTe6gF5vfmqoG8kmtn9Tr8/MbWTOlDXw434DwC8IQ9HNlFT/9FdVZfaVjzNrEAqvUDn+mYsa/e5t48axg0QtrtA9iYgrxG682xomVQQ8AmM+3TLnaC1eBo1d2m6H5Yxne7VkoBg4tGP7yuhVbuhYZ9NdTYo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Mon, 2 Jul 2018 11:52:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/2] soc: imx: gpc: Power off PU domain in suspend/resume on 6qp
Date:   Mon,  2 Jul 2018 14:52:33 +0300
Message-Id: <cover.1530530881.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR0201CA0035.eurprd02.prod.outlook.com
 (2603:10a6:4:3f::45) To AM6PR04MB4295.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c8779a7-942c-449e-1882-08d5e01258d5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4295;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;3:R+bco0P0LYb/bpPAjwi6jloBBAtrSo0XiS0mlKgINaRKbse50CjW+HCmIhS8iDVFwKgSfYxxc1j/0jbJ+53m+nsQdxKsDyzQQyy1LhGrUKI/rIEDvbY8Cm2vSPkVvfjPKptyvUeewMyvwNICYAuExkP3vdxspRkoNsnMZ+7oXDxYLpR5mxDSu+Ei0HR9S4DJ5/NsZKDmEvuuk0QpGhcNKDVo8Fpgi3mUt2bEfQXt2+QzpydjL9NW9tjAKuRQ3jtq;25:aXJI8FGrmVa/OcIf8D7zwu4L0O0VEB1vPEWv7j+/Q0zljbqdn8WkZyZFHS/qzp27X6QsxDzY0lg+DYerqk+2/GJwqaggHJU6sk4qcBJW36RbCtVHNyehai6ttggaZeunmrFajzbj0r4kFswfvRG2c7nuqx8cL72Jo2TqaYemIeVOutEI5F9V7S4Ov311f6/pT1Tvv+Fgam4E6V5/zzC5vKFMC7flOVZH2gn2dV6xcxDcOLx3uUtUQExqt/6vR3Cu7t1C5Zi0oXfy3LbkvB8fUYF237JvC2OEncIp50d/HQ6EkhdmsT0nYLdyRAMn7bp7bTxv4856d7omf6uhSTyb8Q==;31:hHFbscH6APlP/kyJz5SRdIjRw8yX1NZ+NN/dVXeVrsA9hD0GkA9sRS2KakYHDDwx3BI5AjcJN9/uRIlIUjkdkUlV7yfvDC8pRjQXb64cBNav3VKcPVrmzZfSsXw1QOui27jeQgQXhbzHHynu1hIttMwwyQknEKVB0qXlMTyqgRuuUkilsLo1Gb0Xhi4ElwiCwLUnr6mwrci/8pr9AFI5e9fr/1ylMFvfYChc4nTmR8E=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;20:mVOtqhLTKpwS3FAsFIhxfeXTdfgjGJ6OMkech5sJxl2TlA9iU0BuL9nYHE7daDdkDuUVT4hC7gct4tbfT8/X8yFdlXhqZemKUn3e61duEAwghtO/eB+Dx6qXbCc+pHwJPQ0AGrz0XiycK8voAesi+ENGoWI0J5NrRNbDu57A/2KPGQCFYe8Hiyae9iMg/LZ/ghXSjBBH8jjjBg3Sq/QqmZSIcSXx5bpwwELTofPZuIU4rZuEBm871dpDeXe49weN0O81v7wRIta00ZcFns++I2D4TIjfaYiNawbcgkyYP/ucSR0eFruWyCLfpSTFHwi0gjk5Kpqoe6Np7K5UshIbz849wPWd/GSnFrO1TsLxBfwWanSbBMa1yEgbFF+skBvut4Blhy/8mxrgMyqQitSGqphs+0oS8nhZ4AEpwGvIQVoridIUOWrbjAYgtHSHfbA+nKxQcbA+hQPelF/VfMyXboNUe4VcOUtMp2pLiBDxVkyoB8xt5PQ+UaVBA46mKHlh;4:XgAZQJDboqU+RLiDv8Mwf4HrISCJJhIe59S8C2gc6pbCwBSDcKHEqBecli7obvl40NBeBXsVIsUpoFuCkFvifYwMKf11DH6/VGiDVIplyR7dt/Im9lLunQGON8TZh1Q3x/wYRChUZahby4nxO9ffPzCR43907pRMoImbso8EoTs+nzljFW+IOe8TIEUiMN4TFGK66jK5DP8EW/PULsqPnGmethAeL6YNUCHcshg+MzPRVbXhUBi5hPNAKKmJjtWLR6npOsklhHMpnoGcr14nIg==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4295AAE02158BA7CCF7BD2E4EE430@AM6PR04MB4295.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4295;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4295;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(66066001)(305945005)(47776003)(478600001)(36756003)(6666003)(7736002)(50226002)(6512007)(3846002)(6486002)(6116002)(68736007)(50466002)(15650500001)(44832011)(956004)(2616005)(476003)(486006)(5660300001)(97736004)(26005)(186003)(6506007)(386003)(4326008)(39060400002)(14444005)(25786009)(16526019)(53936002)(86362001)(106356001)(16586007)(316002)(105586002)(52116002)(110136005)(2906002)(54906003)(8936002)(48376002)(81156014)(81166006)(51416003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4295;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4295;23:KkNdG/C0OTLDfiQIEfcW8kHJxnmLl0dADyXnrzaBT?=
 =?us-ascii?Q?3mSPJDH0YZn3X3MflkKSfb+Sq9P13xtTsZg9DXVFt87RmuV4fqrCgKyKc3YN?=
 =?us-ascii?Q?iz44aw4Nshp7eA+MML5jKzbZgpjJMzmUorMBeZuP/FV0oKkxYBLa184ZH+KS?=
 =?us-ascii?Q?S9jr7F91SPLw2EXv5l8rd5OGYCLwbiHC6FD9BtVX1Cw3d9Xa2+xRMvDeMies?=
 =?us-ascii?Q?RJSBm0fhVyBzxYXlz8JaJr3tmui0DyHgHTOsHyZ+7GyNbI+rIT2Ehs9wA6nO?=
 =?us-ascii?Q?MUEbV96opU5amyR2BuSV9EbMUZ+D+XWRpLObybO1DS5EdoUZyHKRu3v84fzd?=
 =?us-ascii?Q?qXORwtUH4BXpT28C6ZXQoRVFTAvIeT51E4B5mcnPyX61wfSnD94e+ERbd3fu?=
 =?us-ascii?Q?+jtASEEbbsplL9RLUJCSCoL/C5xT8EXhvQEH02qtTvPGLPO0mlRzCJaP2Rmc?=
 =?us-ascii?Q?i+AmLjxeRlgqkYS80UidI8vk/YVNEQykyo2vpGoA/ITrgVXxdE0E/bMkK8mi?=
 =?us-ascii?Q?6TUYxqMdSRZuaXQ2ofKH+qxnfmTTn+ai4qpmenIEPYd5wHq/4Qbu8lscir2D?=
 =?us-ascii?Q?pzqphZRrtKXubX03eALoOHvGeF5RTgZZNmBqee/iebyHmRV6TUnjsiXF5swT?=
 =?us-ascii?Q?KnlRnYOs3AVcpRg+Ig+fKAuIn6HeO8roPEHZLu6BG12ZKT/wbXQYcwhd2sRN?=
 =?us-ascii?Q?/cztnCk28DUTlwJlg3MFrMkUT9xhnQ5An7a1YduQGf6MU6k2t3npEs9gwUOC?=
 =?us-ascii?Q?fvYb2yuptSD+P6bJc/V/IvJk1Wtv+ehpL5if74pRRMXIlZaNAgocUnkc1n7g?=
 =?us-ascii?Q?r53KoqkzETPvnExZXXNxpdFodpMq21jNAs3E4U3LFd1mgb86QHAIrhwAeXZ6?=
 =?us-ascii?Q?2L76y++hRLyA2RFPDcrWvbgnxH2RHnw+i5T7wIEr+c0/Cev9f4oJBmUyZiZB?=
 =?us-ascii?Q?n4+CIerRDxDUj0+voBUf/iUH61cFkIwOk9wguyesUNJHIeMLqH8rWULVRA6p?=
 =?us-ascii?Q?3gecbQCwGwsQRKRMEkLeNvmv19T9WzXN0MjneY44WMThSDJQ9d4nO/x+MOvF?=
 =?us-ascii?Q?hZnX8UvJQLAhDGnodzSB5CMkDmpK9r6DIDaJsvP91YqstQvf3GHIyDTjnPOM?=
 =?us-ascii?Q?25rlscaH574q8O5JgZKu6JLVMPJkroqye60/rpYq49zh/zIUj/1xnUBxM0tA?=
 =?us-ascii?Q?iB8+WMo523NGin/rL+sVSx7BhhT0Xk5bsdrxZoFHmI2dslv+dWb9aKTsU7P6?=
 =?us-ascii?Q?fjjD77zsMNM4rvZP2k=3D?=
X-Microsoft-Antispam-Message-Info: D0lPc4bAEDAUxiNFr23JBiR/yYejrEKzvheeQWvF3iaifl24C9kpzADCKBzCdY5lqj47PK0GcWTcXR1GflLuRnP5RYn53Eph0tJa+sqrUs8K0H+Uh/aAOHiLa1mIEnVnMxdjfr6A6g1+noiPfUeQnGHPhPkYC/trvVg/E86czD4xqb67ggjZ1lpQFCBa8f6445B91poLSHlVnQKcdADIoa1oU8z1EUI+2NsCnvEvsuvxFORB9MOx2vb+FIkVoK4h30G6lXzhAXFxDn7S8CY1mH9yXWr3jkBZXCi05IBuErZ4dvQoW22VFTLRgZ96j9xAERhdX0WkkPtm1cCbuTeXw9X0Ktt//Pt1ytFWJCIPTA0=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;6:W0umjcc38ShykRFNeC/vHz/0q76nngJTz8Wf41z5GMPSbZ+h4frqAvixrvhmT9ktTAbFuP3RzaDbPFUfaUL6k9/pvp+GLsQfGz9ZWOlluTvhoc1f3LLH3uabTmdkIoOREB3Qh6ORyhvE/9Qp/ue2q49eMhwGLB8HskU6qQdy7Y24tBjJoj0qfJ9YxNlIWYkV/Dm0PeH1U0LVo6UWm/hu1+XYGmvnqx0QiF8RWjDn1IGgvd6Z6+Z74QuBfJnVT1Ck16nzDd7hnjeAESdvPmqKTbj1D7Yc6VTB8ey5LLHix73Mu2YGYGtqrqlhG5MxysqXZjuhLt1vhWH33h2mg4cTvn3tyKFHIcunR9Dln0pPkAWjXDgACOwJJj3Jp/wJ7HtWhmAqAvkTbHCMbB37KYi0XMAJ46i9vI5FF9eAJS1rjRhEaMD8An2H5nge7YktCb2V8QMmKIQHxEO4G7zKnuMNbw==;5:pWbbraLn9gowBD/Xdmh4XjQitnp2ZTYdbf77yvlBMGJW5ye2W9ua9NOSIBHtvnNtb2SNdgM6LOE2jifasUzHOMwed+bUFTBjTyoq1noIiPh7CbItweEYYOyjOhHkR50goAfYL309/antO3ELMba89R2eRQktfQif6zc3K13lklk=;24:1AhfTGpUucMZ7HGNAntCPovkwFkKhKM5vfWwGZ51AaedWtS6zFvgf1UIRwcVXZ2RYphaUrycfyw6l3mOAGO9KNLxwXb/xNz/R+zxOQ/xfwU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;7:QMjmsOiVsH7Rmgm1hTG1HxEiNmlRgPl00s3LPdkVr7rCUFyNfx/lDWK5k9izc7AX2h32ifxslxo+TGL97p4BduJW5feSBugdW/0pEwfBCLDZHGJPn5sbYGUJp9xs1qVOKPfafiicc3RfiBH91svdMvNDQ8dZxiHucTIbT5y8mUwwN70+rw+VtTaESt+pFkPBTnfGaqO0AUSKHcKpPbyrZqDzO05epaO1nqgY1MGen/no0SxHaZzCYpIFxYE+2QKc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 11:52:53.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8779a7-942c-449e-1882-08d5e01258d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by doing `rtcwake -s 5 -m mem` while running glxgears on etnaviv.

The first patch is required because otherwise it is not easy to reach pgc
domains from the gpc itself when using new-style bindings. It's also
easier to understand.

The use of dynamic allocation in this driver is strange. Since there is
only one GPC physically present in each soc my impulse would be to make
most things global and delete imx_gpc_driver.remove entirely.

With current code (even without my patches) attempting to dynamically
remove/probe the GPC fils since since the per-pgc platform_device
instances are not removed. I'm trying something like this:

echo 130000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
echo 134000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/unbind
echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/bind

But is there any usecase for dynamically removing the GPC? Instead of
trying to fix it I'd rather delete imx_gpc_driver.remove, just like
for gpcv2. Would anyone object to a patch doing this?

This series is not very pretty, constructive suggestions is welcome.
NXP internal tree has quite a lot of changes in gpc code and this causes
a lot of trouble when doing upgrades so I am trying to push some of the
internal features upstream.

Maybe instead of direct calls from mach-imx the gpc could implement
SLEEP_PM_OPS instead? It would still need a way to access the pgc
devices directly.

Leonard Crestez (2):
  soc: imx: gpc: Use static platform_device instances
  soc: imx: gpc: Power off PU domain in suspend/resume on 6qp

 arch/arm/mach-imx/gpc.c | 10 +++++
 drivers/soc/imx/gpc.c   | 93 ++++++++++++++++++++++++++---------------
 2 files changed, 70 insertions(+), 33 deletions(-)

-- 
2.17.1

