Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeBEJRP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:17:15 -0500
Received: from mail-dm3nam03on0051.outbound.protection.outlook.com ([104.47.41.51]:47512
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750949AbeBEJRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:17:07 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Auer Lukas <lukas.auer@aisec.fraunhofer.de>
CC: "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Alexandru Porosanu <alexandru.porosanu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Rui Silva <rui.silva@linaro.org>, Ryan Harkin <ryan.harkin@linaro.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: caam - fix endless loop when DECO acquire fails
Date: Mon, 5 Feb 2018 11:15:52 +0200
Message-ID: <20180205091552.11057-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.12.0.264.gd6db3f216544
In-Reply-To: <VI1PR0402MB3342899B009D1A6CC0569CFE98FE0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <VI1PR0402MB3342899B009D1A6CC0569CFE98FE0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131622958246949283;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(2906002)(2950100002)(1076002)(5660300001)(68736007)(2870700001)(36756003)(50466002)(104016004)(81156014)(81166006)(8676002)(50226002)(8936002)(316002)(106466001)(110136005)(450100002)(4326008)(5820100001)(53936002)(54906003)(47776003)(305945005)(6666003)(356003)(23676004)(336011)(77096007)(26005)(59450400001)(76176011)(97736004)(85426001)(26826003)(498600001)(1857600001)(86362001)(105606002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0301MB0594;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD010;1:QS3g+FiWpYukItX8QlnJmEwrzNmRCZV9SlEbHK/yN87K7QQywKqlUvc9rUjNR/Cm0wIJg4d8U7HQy/GqdvMeG8LW4bz+JywBErBx5YPQhbBhaoTgOA9R9pGTw38iyDaO
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d52f6b2e-645d-42d1-71a3-08d56c79390f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BN1PR0301MB0594;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0594;3:BfBEMTspiymvseWPVhHQFvuumaJphWVbhc2XLeFGYqlySeVuSlBjjUOiFmBDA10btKgkSkShtqKQl0ghBhKUDaD2QHPIb4Wn/NBcXoUo8h6e8W+Qd246WsT1Wp4Ai/Oqu/Q4m/Aat8zpn9wcId7TXUuPBmIraExMFaneHDhCeRZQsOPqVJdaDW9J3ZfyeGZQFcVV3QF2yV/mzKJ3dtc2lXGSdf3D5Yu3DYa79oV1Q2EkzUsfX4HoNJvmM+55tDY6Nln8pgxvoMn4kUtWl/YrLVtuM+ubXSKe83zcG09i5c6dqhMAQAG95vnIAgJr0HPySD50vdGBUJaEKI/o1y3Wnnx3i1kwoFz7viP0vjzuAi0=;25:NjdVxZzQg834PtUY3c9myLXCyxhjm8oiC33CPD4GA4t/dWnayKbCySMu4lCmSjnos7FNeMdrRk9b5dMH4hh0Xv2Pz4QOOMHxFlYzRxJd6rRtgVdb1gSr8bZH6JiaV3mVzfsRTfwJ9mMzTCZMCDGNoIGsuhQaO+VYUeXFPjxPx8Y+X2Ir/ZERNh+3X0yue16N+RdpMDtuqh44u158nDyOivTwF+01DS/tdFMvLbU+SC90uHYg83laM1dZakIKCkbC8S7KKFcMcZuf+7chO8zM4uOHXPS+fMDCuw/CvbPy5yPmGwBo/dnCMl33GH6N2bDe+opeNU6nQ/7pTk4YMVSzOQ==
X-MS-TrafficTypeDiagnostic: BN1PR0301MB0594:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0594;31:2Fmf9O+UAFqmk5Kt2ptJiOOEYVXc3WYneg792UHY0Y0HS5ngNTDT3nDr/S8V9wxPQ+79IIJDdHEOtc4h5D5SHR0YqL+J94/dlBAEGhikVJut8L+/er8CSe+xjHzui1pJIQF5HuVoPz43wb+v8Axvye4IdCfsNkE2JoDuJ/AH1gU6FIU8rnz5WQKWxmTlJtcyMuK+NTdw77L1JxqWoXdS/Jn/Xl/m7Cw/vaWy9sntxP0=;4:93sS97R5Nxktr+Y0lxsAPlml3oRkhw8YT5sgGV466pRx7AjMIuVsLXcyUGZ0nrOfg2FiYVeJBJSvfQUP12+Fxo9tY2md9uqgkZbvNWA0ZhPp1F2/4zTjsBsM4+ttujqN5eIkEd5/LaJoZKpUpxNWeKkn9Y0CLb7vlQZ2u7zRU0HxNs9eQdx9MBspRHAUqkFqmq1UFaODh6vWerZe2WdxaVvkwKt6q9z7p9U+9nGuKlX87Xx+pz57vI+CtqE+Iu+uxfc4UDZFQik64Qb/5mJeZONG/Yg9QxC0RIBWwMCm0SK+eC3uJ/NbV5LvsI+klc5ZOrWFZArEJhCLrxOEit1g7/saWFuhv5OTKvQzjlsdh7g=
X-Microsoft-Antispam-PRVS: <BN1PR0301MB0594D1532FC01559409AC89398FE0@BN1PR0301MB0594.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6096035)(20161123565025)(20161123556025)(20161123561025)(20161123563025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BN1PR0301MB0594;BCL:0;PCL:0;RULEID:(400006);SRVR:BN1PR0301MB0594;
X-Forefront-PRVS: 0574D4712B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjFQUjAzMDFNQjA1OTQ7MjM6V0FFRmlkKzJWd0pZUk9mOWpVMTZabmo1?=
 =?utf-8?B?SFBjc1hwajNYK2NBTUxZK2FjaVI0dlFSZ1FqT0JaUnV5bHBzQjEzYjNlN0Vm?=
 =?utf-8?B?UHp3dTJMOC9FTkYxWVkvdVpqVE4wYmhQQlFEMEx5RWhLcnVxSE9yNWp3WlN5?=
 =?utf-8?B?Tmd3aVQ4V2RPQTRWV2wwVkxBUTVtUExBeVVDdlNNYURWL3ROV3FMLysySlRp?=
 =?utf-8?B?c3gvejBUelBYbDZIcUU3bjYySUIrUWZjREhjS1pleXNCenljQ0txdEZzcnhq?=
 =?utf-8?B?T1l4aVRncGlqZGlUaGlLd3lYS3gzbDRudnRRUHk2MWs2N1NDT0dVT1dETit3?=
 =?utf-8?B?NGZ5cndrSGVqRVlzbU9Xd2NYOXMyNFVNemViclBmWCt4eDhzcHdnUzl4dGYy?=
 =?utf-8?B?MlJSTEpma2V5VU1XRngrRnpaQmVldUxHMEpVZ0Zia214ellrR0RVOUEyQXI4?=
 =?utf-8?B?RUh5M1MyUEpSek8xem50MHBJbHgvblphVzVVQ3F0dktqRFdlcmZwSUc2S2d2?=
 =?utf-8?B?TnE2SG91NHFNTnFmK29OWkpuWm1zaS82YzNzYUw5YjNlayszdjVRb1hLL0p6?=
 =?utf-8?B?MVZDeWNWZzFDOVAvNm8ycXBLdzVhNW42RHI0SGhuRFJCSFF0ME51STBJZUtE?=
 =?utf-8?B?MFlKMzFwTmdBd3ErR2EwdEltQnBXa2hGUlprdWVRM1F3c1p2WXNrZDhhK3Vp?=
 =?utf-8?B?NjRVVkFJV0gzWjcreHJwbFV2SGszMkdveitoNGxnYjlUL0hhek54OXJ2cGN6?=
 =?utf-8?B?L1FjaGhKZ0RFVVB2b3ZMNFJpclQ1ekhhb0RqZEZLSktqOVAvZ0JzNktzR2pM?=
 =?utf-8?B?Q2hsOHVYS0JhRENDZUZJWE9jbGNGTVMyZ2FleTFMSXh3N2hROGR5RFFreGVU?=
 =?utf-8?B?cEF4MzBjVU9ZN3BCbEtKUGhVbmtTcWU2R2NBMDF0dUJFcExCWmlhbm11dXpk?=
 =?utf-8?B?WlZlbndHSzJ1WVpiOU4vQkRQSE85ZVo2SGRiaGg5QWxOMDFkc1F4eHFOempK?=
 =?utf-8?B?SmZVN2VnbTZzTnZ5amx4L29BampSbElDZFpnTEsrTHk5MDQ2UjEzVkpXb1lY?=
 =?utf-8?B?ZElEdFgwK1UyeTFEVlFmcFBTb1NHS2padlhZU0Q3WDdxbVc4d2FVckFmdUhC?=
 =?utf-8?B?bHlhazFqTVI5UU14S0RRRjlxTk9uM1ozUVpJNnZ3N0x2Mkt4bmZ5a1d4OGZj?=
 =?utf-8?B?UUVWNEJCWTBNbjQzVjJaTmszakdxaS81K1hWd0svM0tPU1ZyZXJJbDZuQk8r?=
 =?utf-8?B?K1FQNEJMNi9yWTIrNWgzdlo1ZGg2UFd4b3FzeDFJQXN5em5WT3FZSmJlcUFN?=
 =?utf-8?B?OUNUV2QwK3V1TTV3R1NGYllTc1ZUNUc5T0NXdzFtK24rWjZCVTRTY25SRUtn?=
 =?utf-8?B?N1VZMS9DajRsc1ovdG5PeklnT2UzczVwOVVxZVMvV1pIeUtqZmxMYzdoaEtO?=
 =?utf-8?B?SWlDTnBoYVBsNWcyRmVGYnBpKzdEMjFYVnljT3BSa2ozNXlrY1NqRHZadEhF?=
 =?utf-8?B?TTBRRUtCWmxUQzVaMmxvVGw3eHhUZmdCK29Pd3VEWnUyQ3BaRzlQMEN4VlRj?=
 =?utf-8?B?enFMcEJ0MnQ5cUxWbko0NjUzdno4U051OHdza0x2YmJwVTg2b3hJOGlxNGYw?=
 =?utf-8?Q?k=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0594;6:kghSEb2Jkc6JL6Wjvoxydi4sfGze/8xanN6yYX8kj+iQjR/aoJsItE6Crxez1+fFsFceXQTnzZgWi7yKAZl2z7zT7EAlW1a5alC4CqLROnPs2WaL9jYjKr/jhnoGYMFiuGwrN9/tqTqJQIZvz6MNo44Fcf89C8f3yF8Jus+K6OGq15r/9ejNMBdDr1BxWEpK0DTDogcMEzNoBH5q9JRKgI+FqrodMaDrA210U/KF0wPdfmJ5oZ0F5YZkFg0x9nABn7TVfILoQc05fP8IDUtlMS9+HeTPV0nR4iUW2/GGtpl/JjzDIbBP2rhUWEREp3esjCMP+Cn2W7GSuurkYH+tONoxXzziDEMxLOHl0UwoW7U=;5:vRVEEwpbpAMXDZnQxFMEr1jriAsKjrD3Vu78M9u3AHZNQ1Fi+aac0g043En1RpSm6phfY+IRBPvComDJm0hwiEe9+JYgphqmIumIhnOP3R1EXQVYy19fuvE3WbCRHc1HVrMBOxTnYtqxQxS7fJeSpg6tBBm0jyb30/gNHuLvXGg=;24:zOCtPeASPQJ3ucwBn2y8kFRj7tMt+IlDvLz64cjfsLErh2dRHrhx8Tbk1Dr6OreHpmnZHaiHqw6J5D+02ODqEJOpI1wO6D9grEpykgbF7FE=;7:SMw6JRVgOlaEQm88jMZmNREWOBqqiCdLIdlz1Gy4puKcWXJvj8hvEEMujjE3Pvh44tcAiJf55M/CkJxvAcyl5Yc1EvMeuI788omsWdfCB5zqcQv8G/oKJ/kdwBteLDBKXhr+oV4Mz6kqpj2cBW0vn2lpbd6T+SbXSLZo+S2iR+1o3FQshYOH6vA6jSxlsZCo/pNX9yLFhrNt+hTEC6lDtdi1RSBD5vE7CXQes9u0h1aE2rdZ5GdDcmUla70hTNTH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 09:17:04.4765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52f6b2e-645d-42d1-71a3-08d56c79390f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0301MB0594
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case DECO0 cannot be acquired - i.e. run_descriptor_deco0() fails
with -ENODEV, caam_probe() enters an endless loop:

run_descriptor_deco0
	ret -ENODEV
	-> instantiate_rng
		-ENODEV, overwritten by -EAGAIN
		ret -EAGAIN
		-> caam_probe
			-EAGAIN results in endless loop

It turns out the error path in instantiate_rng() is incorrect,
the checks are done in the wrong order.

Cc: <stable@vger.kernel.org> # 3.13+
Fixes: 1005bccd7a4a6 ("crypto: caam - enable instantiation of all RNG4 state handles")
Reported-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Suggested-by: Auer Lukas <lukas.auer@aisec.fraunhofer.de>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 75d280cb2dc0..e843cf410373 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -228,12 +228,16 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		 * without any error (HW optimizations for later
 		 * CAAM eras), then try again.
 		 */
+		if (ret)
+			break;
+
 		rdsta_val = rd_reg32(&ctrl->r4tst[0].rdsta) & RDSTA_IFMASK;
 		if ((status && status != JRSTA_SSRC_JUMP_HALT_CC) ||
-		    !(rdsta_val & (1 << sh_idx)))
+		    !(rdsta_val & (1 << sh_idx))) {
 			ret = -EAGAIN;
-		if (ret)
 			break;
+		}
+
 		dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
 		/* Clear the contents before recreating the descriptor */
 		memset(desc, 0x00, CAAM_CMD_SZ * 7);
-- 
2.12.0.264.gd6db3f216544
