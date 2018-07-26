Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D9CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F5B2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="KbADhssa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F5B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbeGZIat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:30:49 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:22866
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbeGZIat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4u5uB4pyMz2QMMCboV1G5cEG2ARP2isXycosXVGyGw=;
 b=KbADhssaK5tlwR6x5LIhoHCyDZd5JfwQkWkAYEQ7cZmzZa2m5SMubhjmYUKcbkOkco+5XCt6U2SKuowb/NTo0W0A0Ef2GdWQoWndkgrnm3BErDHRSZ9NpLXf1wgX7Qy8tfk5D6B+3MtYv6ghYH0zy1YUYamSETbDHwPErQMQh5U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1570.namprd03.prod.outlook.com (2a01:111:e400:52a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.16; Thu, 26 Jul
 2018 07:15:15 +0000
Date:   Thu, 26 Jul 2018 15:12:55 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next v2 2/3] mmc: sdhci: introduce adma_write_desc()
 hook to struct sdhci_ops
Message-ID: <20180726151255.764aedb7@xhacker.debian>
In-Reply-To: <20180726151017.4da1e336@xhacker.debian>
References: <20180726151017.4da1e336@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:402:1::16) To BLUPR0301MB1570.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d5ce5c7-19ea-41a8-ce05-08d5f2c78a09
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1570;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;3:4mmWX5WdUnz++FpxK+ckNplyTPLIXCcpIjxNsTEHeOtmwtEG/g2/wRRl1ao+4lb6Lx0yRMTWMTdqxmc9odg8TqpOsemLwP7Iyn4nIpY/Sp+qN2LpM0DXzuIUtnRvoJQohCH28SqBQK63Wxkw4ylzONbmHJBIJiwpggLfK2rRANnDEyePBmbnYQbgpAhlZ3KXAwq2wQFj2GAvEs2Q2whU5DGiIKhBO6hJj9Uu1aGs3cmJD+WOmrZsHGO3mQ7X4D1Q;25:pbyk/WlQEZt7EGs902XGMLv+ebUnL0JrMcsIGcdHm9QHrONqdQREvWt3yhkwrPJgdJeyyblyw4g9Dz+d61ZX8OF0WKX/mA71m/EcZfC2lTn67syjBtDxgO1IDOXllDLcPRhrUSrjcEzyDIXih1JRfmBlPcH0+Jm7/KSn5g4Q6oLD0HehOexeAjlsVkX+ihGnEGFHyfXH2ThOVJPqRTbDaZfHXpr3BwmchPTLmFxGDOVCYCrK9f4Pb7o/0oQm7IISEInGU9GSpMg60Wg+JUy3bWNTNvmtTDAkoXR8E4yN1x4UsdP8FKdTY2wnUg8iDvaX9jNB2PAXMtZiIydOxbAssg==;31:XP1LlLEc6QcyDQ1D/fZJQWpLSYDtedyMEKaQ1vI1RfKek25LQrrOu/d5x/Cgvsf0hqt0QEVNt/2hkSEYp/vVMISR+O+9qFLqJKBcyvDaQc2EgUgZGKcqD0EXL1IdpIp9ALChP5dg8C67/mgbcuNDhVu/G7HJ8ar6pRfEkCAD1AXAmsDLPKM0EVq2WOEKl/58qnld0d4uq/qdyuJCF7Nmfj7qxGcT2oGldJW07xu4Ekc=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1570:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;20:v7Fj8MvlQ6a9D9ONkAsUvxTL2QUXSJp3lMeDuo8AjGkiWuQ8IQgsAGfLXrbW6VrKfBfWQIqjPLgIIOnvAVjMxm9SxXq8C8UUFENi0N+3T6LE3KaIwZZgNbqv0fsL+DXd6y42TcCEV6Vf21/Qu4y0oAQzfn+QkeEgkA7QavtcvqHZnGZquo8CTAuXsuFRgobi1i84O4ewt/CdvBHflYi74bR7SubFMQpa3roN7pkLfgDE5xA2+oAMwAsQX0G483cvRAQjbbsAiHb8ZFNIAJkypGDOIVw4c1mxi6tqvJ+3N56ilHG0wG9fvKCJiIsBNn1gP5s+o4uA4Ks0yKMYhi85xRwj0gIzUU2zU3SEpZjFNA0dHaUVbRsAzDy/sI/ucF7fmj8ctgsa5HUWAqbSCqQdbDXcrCbHHa27ryTQdDGwX9ZRoXBTBOq59OVJjWxItKEa+8aOWxQ4axBMWV3cZLJ/X0t7VvU5hZYK1Z5/p15moN4+5eykCnd/8PY9Bnq8JRjE;4:En8HrnjrK5W36c1B0/XwHizZO39OvFvxGvVYwGa5sHp5zhq3J0H9AXBU/+dmOGfkl1ndgVHMNSGbVufu2uAq8gmIoUquYN8ma142TeuAC/YtVww3Yba0C5CeZ9eg/HTcJgc50t9zphzXG/uE+x92Xjiimlak8ud2FefQjdYqpQOon4CuHAhd2gPpUN6/PcWMRE7U8v2XTQx6HyGEYw4SaUxKxEkeng4dvZgOh/kFtqWD0hnDjCvBeocuyj7dtaMgh2rEHjCWBfWXaxAlC8ibNA==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1570B22CFAFA978A5F4A2909ED2B0@BLUPR0301MB1570.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1570;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1570;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(376002)(136003)(199004)(189003)(53936002)(4326008)(50466002)(25786009)(50226002)(9686003)(486006)(446003)(26005)(956004)(476003)(14444005)(8936002)(55016002)(16526019)(68736007)(186003)(97736004)(305945005)(11346002)(7736002)(3846002)(6116002)(33896004)(2906002)(5660300001)(575784001)(86362001)(230700001)(6666003)(478600001)(81156014)(81166006)(23726003)(76176011)(6506007)(7696005)(386003)(52116002)(105586002)(106356001)(72206003)(1076002)(8676002)(110136005)(316002)(47776003)(66066001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1570;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1570;23:VSgUW2dahq7NcCLIXLzVEjWmbEcPxVtioMlTwi3?=
 =?us-ascii?Q?CbfqO2u4FzX+U100xN2lSWS8kSB4rAfws4aYqagVeoUbfr23TsLO2JRW0wOW?=
 =?us-ascii?Q?uskr41g2aipr+WgDU9vNGEtIzPAUIGpiau5wnthWw3J26kQSQXxUfERwOSKd?=
 =?us-ascii?Q?qoplf7w+PMtbjmnexWO2VQlYn3b/cesP+kYjoY59j6DcFv2qzIgvWChr9gPU?=
 =?us-ascii?Q?GmmJqSIjVWMpn7L3w5LbQE/G95ltOe+BRVDe693SIxecYmMUgCf3DwXrczuU?=
 =?us-ascii?Q?i63J0O03vR2nbiO2W9rV0s9j634wShqxR87UVNHp6xQ+GCYclszJP+SP8zRW?=
 =?us-ascii?Q?ExA1znloSZrJKrWT5+RGoMp6yW2xxDu4L0Dh1ca058i6xBFyQcEerIIpkhNp?=
 =?us-ascii?Q?Ot9OOzphHyKn86ALWVLHKitVswMT8QuUoMNIMP5ygRYvaefZTFsjSEK44eKj?=
 =?us-ascii?Q?tp6zDtmDqPelq3ZWyiaQTwqAt/IJlLS+xvlA0VZgvgetwvi/0K5Cwkm1Rq/0?=
 =?us-ascii?Q?yE0qSL5fsC4t6TCJeCcOA2URvUItg6suQ3/DYgNPhJROSzGYzid2903dpHQs?=
 =?us-ascii?Q?DuP1ouhC8pnOPcxOd44oAmHPId5KOGLJ/wQBttalaxnNiwR+scu6PH7EoMPO?=
 =?us-ascii?Q?Fpv05IrD/fBwWK1ajxNkVwaaXLso5xV+qRqyPYCGWJciSCRZUMrxt9wZXlEc?=
 =?us-ascii?Q?1ytt7RT/DfGQGUNsPR1KoQlOqli/3ItPajQQFx00lmae/Dn6BdDQmpuZjnHL?=
 =?us-ascii?Q?MhcqrPD2PODEh8xZJu4VC1qV+/NSF2XhwVzzTykDxTISzEic/KPNIyl+EHG1?=
 =?us-ascii?Q?t0RcuKuSx5d/FJMhR8WjYsrPFSGIpnE5PD3GkLmIW4bnRErUiBKLZvXrxNHx?=
 =?us-ascii?Q?LI77b7qNnErS2XhRRacJy6lOjqxCETGBWYfFlpDDjdh7J26dl2A3cyYmWCcj?=
 =?us-ascii?Q?U08yE1k8fOJtQiNMT/V62/gtD3m6toehVrowkcmYvreM+8q8ctFnKJhqqXCw?=
 =?us-ascii?Q?XCVXVg2GZueYNGP3OyrhTR8/UDP+6xgNCZsSnB8SeNANYRz7xoYxhLy6ss88?=
 =?us-ascii?Q?jRpmlwRov/oaO90AV2ejsuKwxUH6LE33X6qEGho1/5PJmAeNXD/tv5/J6l3t?=
 =?us-ascii?Q?L50g3HcLUdveINpjZg69vU54JzziYbuxWKZIqYbIDy9rq36U/EoWQKNsqRZ+?=
 =?us-ascii?Q?kd05L0prwbvpiSMA1I1KCauPKXVOJLP6gqnRDPmo5DdQUx3qoRinlqDARZXK?=
 =?us-ascii?Q?zb0SRxkp6ILO1vK9TUZI1MqwXfd3MTGyb+/ys5eZw?=
X-Microsoft-Antispam-Message-Info: kCrTuZkePOyQIEx8uCMwngL4bNF7CPbItTiLYz6w/VBns3GVPZnIdYqaR0RF2Tu+YwI07DEI8BDoBiAxISyhFOrh1tyZ5YaKQY6nAqRixiKXELOKXwrlkT6cD8uOvkrC5cof/538nhd7amF68/5PHxcIHdTYZWhBGZKLX/vzot+SlaHyK872LvBNQrR/p09r6qKbpI3afqLTfSqrhMT+61hIQhpQ9w6T66cUVnIhXNQlmof3+7alaIyRk60jQzIZjyUxi7Ig04P44BeZxDm3jd27hrf8UUcxkMQM/AMVZcP9Dfoucxj5tdvXiMJf7GPe3t8MSFCst/RVhHuDubch/LW51FJEewgIUY7czU/ASm4=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;6:IkDnlTs9wVFcPeGDLBi2IsmGNoIk45iSMwwu5JKVwX3rFvRmuFf45ZhhV5rjUtmqsXiFym7I3fsRNzdsVOF0h4HFKM9jV0pJ3kAOWAq64YPtSq0OzQVPtuJTXiLZJvhRtPhQkRkPXiW26OpSL6RBnGOhamLUJawEH/r89iuqANXCU/q4EtruhRxVUOXKro58Y8Z//wKKG+TU/aclIJZ0hVt7h9QVbMrraRc5ZL/kKnKArpzUkRNQikUGqOLviypgVauRslXo534omR8gkXrfC3sAxx/kow2Oi+ctoXXZS1FBf4Ll8FWmmhINfN6L7GQSKqfHhduPdFAuVyttFCbsWKWABQLyGO3Te0ie4YCgFG5gwtUAmQv3l61cDQAiQ45/05onFv30qvYS66w+avsWLXxqDYQmZ3UCBwErdawLruOjbwROuSg9K1P1/hun4yIV8D9pvfkffT6xOUK+YKBAzg==;5:Gr1Sfr/xGm1mT5MHNvln0RBuGz6l7MXiEGQNo32Q1G4z9ANPjFE8Q7Ul8OsrV3S57Bes85E5y3e3AKh7moeRi8V9ZvvMBNHsEoiq0eMOPdtKjWOFzyBUxDnOLgTQSMAwxlWnMDJKZLGegOKbylMmvyR9DPK8HB0mzMzqp1mfM/Y=;7:rPYUzcOHBX5zEp1q+V2XDb4elZmTjSDp7sU8EXvK+FxL1346JDFmUowYvJrnQULPFoqVfk2J4888pd42FToow69N5t40OFAy+oDRRVRgVpPtPK7kB0And6GBpsExuzKQIfi7BGaQ4FCZuyo4Ncry5SCIDAmECIDHhy1XaPHoHcclVaSijue9jTtQgcU0hPIB+PB9yWqWIXDcoglqAyneETeuuwb44hL4voGJfWF+ExcVNWiYyorr1CsRUVYX8ITH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 07:15:15.4855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5ce5c7-19ea-41a8-ce05-08d5f2c78a09
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this hook so that it can be overridden with driver specific
implementations. We also rename the original sdhci_adma_write_desc()
to _sdhci_adma_write_desc() and export it, so that it could be reused
by driver's specific implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  6 ++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 14dd4a49e03b..50c846d99182 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -554,8 +554,8 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
-				  dma_addr_t addr, int len, unsigned cmd)
+unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				    dma_addr_t addr, int len, unsigned int cmd)
 {
 	struct sdhci_adma2_64_desc *dma_desc = desc;
 
@@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
 		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+
+	return host->desc_sz;
+}
+EXPORT_SYMBOL_GPL(_sdhci_adma_write_desc);
+
+static unsigned int sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+					  dma_addr_t addr, int len,
+					  unsigned int cmd)
+{
+	if (host->ops->adma_write_desc)
+		return host->ops->adma_write_desc(host, desc, addr, len, cmd);
+
+	return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
@@ -585,6 +598,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	void *desc, *align;
 	char *buffer;
 	int len, offset, i;
+	unsigned int desc_sz;
 
 	/*
 	 * The spec does not specify endianness of descriptor table.
@@ -618,15 +632,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, align_addr, offset,
-					      ADMA2_TRAN_VALID);
+			desc_sz = sdhci_adma_write_desc(host, desc,
+							align_addr, offset,
+							ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
 
 			align += SDHCI_ADMA2_ALIGN;
 			align_addr += SDHCI_ADMA2_ALIGN;
 
-			desc += host->desc_sz;
+			desc += desc_sz;
 
 			addr += offset;
 			len -= offset;
@@ -636,9 +651,9 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 
 		if (len) {
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, addr, len,
-					      ADMA2_TRAN_VALID);
-			desc += host->desc_sz;
+			desc_sz = sdhci_adma_write_desc(host, desc, addr, len,
+							ADMA2_TRAN_VALID);
+			desc += desc_sz;
 		}
 
 		/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d55fd7033e93..0aad0ee8f63b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -605,6 +605,9 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	unsigned int	(*adma_write_desc)(struct sdhci_host *host, void *desc,
+					   dma_addr_t addr, int len,
+					   unsigned int cmd);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -735,6 +738,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				    dma_addr_t addr, int len,
+				    unsigned int cmd);
 
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
-- 
2.18.0

