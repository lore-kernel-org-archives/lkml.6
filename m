Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeDERSq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:18:46 -0400
Received: from mail-by2nam03on0060.outbound.protection.outlook.com ([104.47.42.60]:24093
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751255AbeDERSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:18:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Klimov <klimov.linux@gmail.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: entry: isb in el1_irq
Date: Thu,  5 Apr 2018 20:17:56 +0300
Message-Id: <20180405171800.5648-2-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180405171800.5648-1-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DB6P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:2f::34)
 To BN6PR07MB2897.namprd07.prod.outlook.com (2603:10b6:404:41::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa5028c9-c1b6-4cd2-282a-08d59b1945d9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2897;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;3:iGZJJp8yLziC5sXkLeAdrEZobo08TuRkQXndC3x0Ifpy9QQSgLLAy3Tkl5th6NVUwYkDoGSJJVfFCqRytBWlCo+EXkFbSZYAAWM6BR5CHgsQzWHxmTlgPtzGnMDQhyf4w1N5WdURev10z5FX7RCMyqaGrtcQO7bTvSooxBJskGFEW5FqbjgqcW2YZYcuyiCxIKsBHIa8dEMp5YjCtO77hGx+jXAQXsKylR5tffH8G68zJ/ZNj7Tz23hZh2L9406/;25:g2HSnx+lrN9f/g0I8NqWcK/KPpsPlrTEAgx5lCuXzWl4AgOHDWBKuzRLBURYuIRV+b5woZPn3WEppGOQYC2WaJL5GL4rzYzYzkDS2pu/CVisZDFfXA4Rn7iHzkAL5jQECw696/4+PfKXv70k1Xg2TTBbe9nAmEzuJppr4D6Qq3qoU6dB4270R8W1gnFrYp9yInXwJSrqI/FarWb1UeIVS8Ik/B7tLrqyBtBRY7z7q2gcoDAZYQFuhYkKKwAWbCgU/HzPZPWZ+gVwuXI49YiTdksdmGzVtDKJel95pA3iKiKiKVgtJphTLKamPbhjIca71+JMoIIwW2HpG4eK1pzXkQ==;31:vypeCk4lLh+tbqAhpP1DYlDxbAW7RFHOqlSLU469BTGMjxyknveJ2iDEN8qyBeqIBPsGMea6W0B+pUa1jsDXjJzBCQ/js3Pduy4ROX7eLFzY2V9wX7TpjDC5ZU3gnJTTg5vxfvQobhQdVnKLXFt71Lk8rXHhAfiju8xZCA7MsA4qHFGKafanjk6isDm7l3mKryr5W9p2c1kD2yh3tNbtPehypB6fxJAejBH5skkDlsw=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2897:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;20:YyaQrkLwGobUlPZYi57q99rJ70f80Df/mvOdCDASQ4SCp/oZD6mtkM6eF6iI7Z3eVFqGTIh7ETb7fg/MVzai+STIqycZMQk5jbluVOdE7c+0tAu632khJ1C9gkRwudHBjZzCb4c3baedAPpo+SA7EoKCQEtCKfJs/qlMEGJ3VdJLmBRawPmYPwdHCS3tYYkUWERSukuHnsZguLSjMAEsjernCTtCxwdeN6VD6m2f5GqHG9U0SNaYIVpdJuGTDifEAazcP3fuzb4pIfnKsXYFEuGbetPqVz7sWuoY33jQxiTuNuck726Rk1+L21/B+J11MSCH0hLqKjm5SqcQ1nyLwcIe47r/B8Q69VLCNxRlQ2bOE1/7isjom5ccfhc7mh6EBNoD5Saw3anOpOl3ohrFkhsVI/S6Y5StqKj/Qk/D572PMDysCD2QwKaLFz7OtfmJ5I66IMG95MrJVzTcWPR+VitnEwiY+uBDpliKfYG8atW5C8uevV3cYIvrD6VIUauNrXLU3TKfFztvZ9BWr8f0RJ/LDCKCnWSIRMw8+2pZBZkQMB6NC+o2E3sD5mLKG5SGbKVLQEhEzL6PVu/V5p4MP1EShbtG+EGV3xl94z2Omg4=;4:ooY0potrlnGrEeLq8SV+DJ87/RcbX9DTW5mawSbtMFC9xGN0+eLnhrESKskVgv+e9EWY8qyE4iytXQR2z2ZkqM3tBg9x/5JOCSO91XAMsYRAZ3piiHzlznFiWjFaDUSuye6C4LeHd75hO0qjPZc9cdSYbtlwi2QzaAf/JpSe2Tl47r3Oy9qkrW4GxOl9AIfg/Ta/tdbQgFwv24Dla+sEDFh+fw23tJK80vHL19AryHKBGt2Rr5Ip1xTNhSxsaBn8lhmRga5hmXJXJI/dwSQugc6V2efBUWSnmL2IRr0bM9GLXk/pfglR/A931BQP51N8
X-Microsoft-Antispam-PRVS: <BN6PR07MB28975F1BA240AB75C3C20CF8E3BB0@BN6PR07MB2897.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(10201501046)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR07MB2897;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2897;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(189003)(199004)(956004)(186003)(446003)(26005)(6496006)(16526019)(76176011)(52116002)(11346002)(51416003)(1076002)(6116002)(110136005)(3846002)(48376002)(42882007)(36756003)(6666003)(486006)(39060400002)(81156014)(6486002)(81166006)(53936002)(7736002)(386003)(50226002)(8676002)(2616005)(8936002)(476003)(106356001)(7416002)(72206003)(305945005)(478600001)(47776003)(97736004)(2906002)(66066001)(16586007)(68736007)(105586002)(76506005)(25786009)(50466002)(5660300001)(4326008)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2897;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2897;23:pTpj+cmmvLbhpzPv+yOBSj7O8RhkLitII1JEqgO5O?=
 =?us-ascii?Q?Vtrhb1xBlFZGiB+4Lx/dDzC6+6QSvGizHEv3cFDIb/+JFUtr+hakXXzsErbV?=
 =?us-ascii?Q?zH5ODtUfuVFum/jiSI9NRsN1aX3BPFJP2+GlVsHw7hGSP+y7INWmhfIaQV2M?=
 =?us-ascii?Q?mEO3TA4qdhlfv1WbV8PQM2w6NpNvh9bYbborAuqtJyuxhA81UJJUHI5Mc6W8?=
 =?us-ascii?Q?yuqmoC8c042HuVDtROEXzys4ArEbLl7zet6Pb39XA6EUgeA5TVAsnKuEsYLN?=
 =?us-ascii?Q?47jS7vAuQxLobikk3N7XeYMUh3Ez5Oqyn20L7hOaqVNAQjAebNyBGMwVn8aw?=
 =?us-ascii?Q?yqDWz67DBG8sggauULVTfRwdtplyiJJpiWQ0/kcx+yS9lnK9uNdRCjba2FkH?=
 =?us-ascii?Q?2GS5Y5EavqU/VLZE9WtfaKIC6KO1KAgJl9uRE5owgpOOMEL0z7Gbe3omtJij?=
 =?us-ascii?Q?s9RS8C/Uj2PiMC1UPLZa3Ny6XbX6Z8VaniNkTKQYb2QME7+/iFd06msw/e3u?=
 =?us-ascii?Q?U0Mc76uRxUykP/yQscckBQz6nL7E3hqnJmN3h+puNfe8tni0N/2yCpVfR0E5?=
 =?us-ascii?Q?tHTMnsXSVHFUBw83L3ALIV3EoLUU6MAQu3idKFYTEOAE+psdPi9RqvRrGntc?=
 =?us-ascii?Q?2PXSOgJMA00b/iN+iI6Sw9gsYtPJFn9JKwa9rinplYyi8e6muSbgN9Qe5eXN?=
 =?us-ascii?Q?A0HkRXfrI4vubY51PH2nSBQYelArklMp+opNzW9OGeMwDsiYtculs0flLH0U?=
 =?us-ascii?Q?P43LjcebwozjTVwN/n5Oc351CQYhDOhtXytr2M4m3EGnN8jeJ/NyYkWagtL/?=
 =?us-ascii?Q?xQLO9tGfItq1f7g5uFY7ABdxFBXmWJv0TtNm5vAJY5KxPoARZfiDe4TSL/NS?=
 =?us-ascii?Q?1iDrblba8UMba6LjiV6s785nxVb4w/mtteUDvCSTudtqakqCpIgczbyPe/4T?=
 =?us-ascii?Q?sQUofV/iFryln2daIU0JtOit3ekR8lztwwcQxIm46OtBHnWYiFjWnDr0b9Fj?=
 =?us-ascii?Q?P5xlEoO908QMP7Ph5YI03xhmRS1MkaiyINtq3YPj7a7VQp2RpoA27d6sKs+e?=
 =?us-ascii?Q?wTlVqDNSYW8VHMCLT8dAKwnrYZuIA5by3VrtWh4u0mZBBCViWNX4D910x0xf?=
 =?us-ascii?Q?dy8gsTjEBX0Vl3CTub3q9O5dnikvVc7u4q48O8qWc35VrGfy+wjswShT+cVX?=
 =?us-ascii?Q?ezcYxalDlve/DqTGdCATfevykX9HuV/azyK1F9XADXfpo/8BKUffb/LZMAig?=
 =?us-ascii?Q?UpTg0PI81+ucLNWsULAv4Kx46sXYPugGtqa+nRHtCvQKn4J6CKnQsgsnjOjH?=
 =?us-ascii?Q?GXWVudPnTmuSwRtFxvK2I4=3D?=
X-Microsoft-Antispam-Message-Info: a+8V3sCOExWjSiaqyV7DS9s0STWPBd5SS/GXOmbjWnMOwQMrGsQf1++xY4RmQ01wXc1TvjXVltvtw5tcJ0nWLuSOv4LvdZD7fiDkx9Csr97XH8Pf/dEGKpEHMiIeWOR2KLx7xgsOaW8THSkumnPIy4UK2EJje6kA9UTp7qDK9C0Qt25uZoFw+kZRt3luFLrM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;6:/gFuUFT0G+vwEWmowXscJ3GqkirFtTusU4eB+p6R0B4eLaMBgprqkIyNOcDEZ/Y3g8jzQj8aLvI2nUvy0hu/g1jTtfCU/8KRHKtAS5cF7bgRdX21hIvNH/4ZASl25bJPC0tDtiXc36sbtJVAmYdwM+Ox4CawmoRjYjns9/wx759YsejGYBKKtfymYrHlJwyaUzSPuU3CjBpdnrD7Ej8ypGqhFyFYD6NHF6CXLzGncOw5WCoBzgyg06dfn+BiIqCvcc8dpGuVGFOqeA58Rw4dkMA8c8LX+2yYTPRHzbiDpyg8sO0dyj2FXGHqD1GnNXymDRhEnfgvN4kbnD0oFraK2rW6AApwlY+lwM72uVdsD1rm29i2SuaLWyyjUdXQcdJYbJ192wt76orq8/Tulf7xgBMQbP8t8Q7xzgTYJnLIXKjYOUk5xMpMy+2iU49ZcRSF77TM5Dq8JRUF5XBiVzvHYg==;5:OC9AJM5pkAiPkv/oQy1H0Ix5t2wo9TIrpox7jRCcppm+67x1H2ZooeqO3oRt77+XRc9p0ew3MMCELdYsUEjaF5ZjIE41byTe5QHBhmEhLBWJos/Am2dB2ta01tLAutgjVFn3sAPwd+1PL8ud10kvxZnYRfjQy8SxySJO6zWAomo=;24:0in496sWnbcOjFmRqDxlL+PC8DDSW+XvwTVoLiZ8iEFYbFfVuSpoGL9eAXdEGUt03AaLXhYyuu+ZrW7Qhtop2QdMw9xS+VoS4bqvYAs2euw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;7:uSWCGpqiihdf1AZUhJb6Bx15fTomCOTXk2BvL8wocQrRVBId9eGhebcfFjSWqkmsnlV7tD979ctkTqGnj0YlKiNM0Qd30/TOeTfS6eX/aJlCAWy+U4d8yQ9qiZhg0PHg3P4O63KLq2bz9qUMu2HR/41DZYSQkxMeokdUeeH3AbNCLL4QwCPl+eeXVl1BfQxZfw+JgHKJlCDruV4rA9hinWaueu3adYy+GFYGYPR/Yf74j9TDZaQJaAv4aTIcyDFy
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 17:18:37.2859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5028c9-c1b6-4cd2-282a-08d59b1945d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2897
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel text patching framework relies on IPI to ensure that other
SMP cores observe the change. Target core calls isb() in IPI handler
path, but not at the beginning of el1_irq entry. There's a chance
that modified instruction will appear prior isb(), and so will not be
observed.

This patch inserts isb early at el1_irq entry to avoid that chance.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/entry.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ec2ee720e33e..9c06b4b80060 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -593,6 +593,7 @@ ENDPROC(el1_sync)
 
 	.align	6
 el1_irq:
+	isb					// pairs with aarch64_insn_patch_text
 	kernel_entry 1
 	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.14.1
