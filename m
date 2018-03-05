Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELuiEqlOuXsPPgS5aU40a96sPUFdFTzClEy0lthGBiwiDciXKlx13imu6gxvZb6IEv9OaUBD
ARC-Seal: i=1; a=rsa-sha256; t=1520260231; cv=none;
        d=google.com; s=arc-20160816;
        b=eXwQWtO+hAAl5Gt0J/8RjMKqvAjaQ/xGYg3DZZDWNnBP3yHgzQjs8CUAAx15lgVGgv
         DZJnbeEO94KmNexBDjhxdCZncrz2Ppady6vHL7A7MLepidoBBQmPLMJhb05bUrkvFiLM
         zoxGDEdqZSRu/ObLyShc8YsplJb3ITvfnTAXZlfMeJa2Yw5BsE6Pi1ofe/fYj7EIrODO
         DzU3lwhWTkvurur8J+YyFa2FNNMGIQ46af2BOnWXrouENNngsx1mbMP8Akjvn9eTyWYc
         7ZzqzAvEWjpU+8erLqh+xFTanSTqOvxtGPS811j/W7Yd7te0JVftXC8ti5foY2OPB7FE
         ABgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=FHoO+2htJlvQlIRf2+xkcthZfm8Y75iAwBlrreGbaqY=;
        b=M+aOcNOxvIXmsBFI9zR2Hyr+A+U25SPHJl7J2wfWgZATlpEBBdMQJPvt6K+IPYDVCN
         8YuHAYIrNX9zEwTK6dgJ6imGd9yd2y6Nola5CSp6Qmy2XzHdINHbgT2XvdCGrdV9WQlx
         IJ2lJ65gV7Uoxefpu55a1jy2Pf5p/4Hi2687byV5Y92PwHPrN3day5a1o8GlXIFbM9aZ
         y+xKim0u+FpDdNS6ySI6mcIzUdpBWmYPoe8ZfmJCQRutpx+EFH/Lvwc0u8WDLWFimZxX
         Li8og6/ey+K734KzuKbAZrwjBxwtFDXZ68b2/HevK8ed6Xl1wkn8Rr77sQXIAWu4FvLy
         dr8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=UeGby1HL;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=UeGby1HL;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org,
	robh+dt@kernel.org,
	hch@lst.de,
	m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	leoyang.li@nxp.com,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
Date: Mon,  5 Mar 2018 19:59:25 +0530
Message-Id: <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 666148b2-e187-47ab-67d7-08d582a5a3bd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:fZfpty77aqnlcfQ7Hz5yypPvSS6vsdvy/QsFk61mlN/5GnDBjO8JGpOF+Cuy/4zvuJUpUYUhoDEmuX1MjS2oyX/byiqBaK2H6KN907eyFvI9RRwlO+XgmaaDqrMXAqK+U39YSrQUoahEzf8YJ44012vUZBO+Xvpk4VyWBf2EiSTJ8/3bjLC5YKA88yHaj+RX9sYzRwIPeWRRcNKFC7XbKtjldgKMbrtv+PCXIic2UBDlmE+jd2UCqT7wf8gSmXYk;25:hifCh6NwKT2QobuGFyhWfKKEYbcQnlanINsOUA8P+0Q4S5Sa1N7P4ZXinRl/2N01srWhSIwBFTDT2uHmpnXI7JFYDQCK4BWO8VJIaBqE2G9RDInXE7v2zNoJZfCjDtJz6RTFFZmnhQMf+yzopQtM0JTnOFvCuAgkIXOtjWWtZq6WQjjf7pn5e6WBEVm7eK5gSJsJe5O8j+zI6TXu7VH8WUlIl4DKfzjLLbFOnvVdbyy/q3MkojBytYl5vAS2biC5huYe5jNnpGddVj4sayoVlqQqRCyO3GKVP/bsdMhNHDqxOFrJ944nHPRvRZrnVj5Qhe8gM82R7wkQM8hWbyI55A==;31:Dehy81XqhFXaI0FzmMFdatLat5egDMArWlAaRYxT6vRteoqcq406jg3HerV4XpXjkI/35SLEz8H3wP4GAmW/PlWY/BddgGPODyjsPGWnUZ7PlIRBJRV/MM5DP/566Gw3dceOZJ9eOcP2j+DIb2w/6LXEwr4Mv24qV4kGmMW5y5yrDljohrreo4+SJZ4ACHxvbvnbbtWGApNFlkMtfdyLB0OdYexG61U6lL3+MfdXOd8=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:wkawaVMAgZubZXXLO5Qr/wZJugTCdIWE7onOMoKM174JaYTcu5Hc1p4MSewrK42mM4LpVEic1BssMBOdnuFy9pjlxpmEupNVhPhlMeZz1mf1M3vUMYMPr7jGb9no6On3f2bKMNnyZXNJjQ/W7L+gkQ1ARbTyf/zDOavE7ixm2WuMQFhZ3nUJIu85DdcYcvS3C68WtfMa3WjSxZiOmUPBQ8WnWJTYQVq/ObFy08g1Iz8fqdoi/yQ25dAApEppn/NbHRDBMfHGZy5ylFgxf89NpHrMD2qqv0zT2Gmr/LcBMHeJAUUCrufZ4y3NNVuMoM5/hRCdoxYRqljexEntrmNBOUwrAg6fpmTDcACWZkjcrd7wyV10itUm5hSwKMyC2UUUJkDPA0/EmFMv4twmBEUUW2q8nhQgEm8sgSHvcKP0Xi++ktlqJic4cJEXveiaQsc5GkccD8VTXbeq8hgP/w6D99i6zA0wAF89MXTFha6kcP9wPn7N5MxE9q5DpQkDg35F;4:W7QX5ympG5+7gJewbGtSeKVuhomkMXkhg3AinE54Kzkn3IHZ89Y/z1APzbIVbjf/rpUHFSfIiOYktcRs/ArugQVNZxqSXlLMQrAAfwgZ48ZljFMgsHdLRYNQnhWn3bJyE5PszB9L6ZK9AmXPamI8vOhkOtfTtKD9Qtqze41AcY5eFq/DrmNDagSkr7LsqbUEGyTzpUSO8nWrxY9HCkQi6GWyCvI5dVx6L80GcwWkI6D1YeWXkejQIE5r4eDHK/6czaAvwSJYVN2UOI8JS6pGqcDDYfVUdg8JoeoyjzDEZuYbDIlfaiXV5hbDz0uLAD71
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2425A75A7ABD87C984677E16E6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(189003)(199004)(2906002)(47776003)(106356001)(6486002)(3846002)(4326008)(316002)(39060400002)(25786009)(5660300001)(6116002)(6512007)(53936002)(2950100002)(97736004)(8676002)(81166006)(50226002)(76176011)(8936002)(81156014)(5009440100003)(386003)(51416003)(6506007)(26005)(16586007)(48376002)(52116002)(478600001)(86362001)(50466002)(66066001)(7416002)(16526019)(36756003)(55236004)(186003)(7736002)(305945005)(105586002)(68736007)(110426004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:oJwYgfCJB/kl2aEA5frcSY7nMfVyraO0qJbHsUq?=
 =?us-ascii?Q?f3aXCpT9rZn+joBczW1BtUuDBWb8cHzn4c9os48NiEidv/gFi9Y/lJKHaUVN?=
 =?us-ascii?Q?tceqVXaEqUawrz1VYcRIDwli6+UKrn51RTC23FEIBowGatY9EsoJWDuZWD5P?=
 =?us-ascii?Q?jLRotewOoefG28+/+B9kAMjWA13mOmrpiTyjEc5OHDbipNrlexUJyZanfXe/?=
 =?us-ascii?Q?s74fPf/2ubUUWZI6iaDAdzJacfUHwaMnqj8T+Usn+VIr1SjGJNNolLuEHOn+?=
 =?us-ascii?Q?kHQ4OygrL25BEmL5F/8/xNBBJWyTP/RHN6FSC8sDI8Jg7+mQpkqexNi3NPKS?=
 =?us-ascii?Q?EyhtDIOB1t+OSyPi705VxjdlpOfCorBbYDmOyEu2RMb2OnYvUkrJn7MscCpB?=
 =?us-ascii?Q?lSj5TTa7CaQMWzyIgfZ740eapQrls/gzTtuUJ57M/eKiPYlLSdgyzdVchxAc?=
 =?us-ascii?Q?Zy59tZfA051Rpv/34A0rB2tGmUcfNNe+3rLRDX+BCac+hUGnvPwJ8pIWHbkw?=
 =?us-ascii?Q?UWY3pOXfAFLh8aysOsMQJQ998HP8nkeFyHuhHB+sivos85R6sav+EwlCoz6y?=
 =?us-ascii?Q?ddeaKZSFVQ50ZRonkSe6JgIt6piK4hwjp4UmlJHhH+KZwGYz2hq/rboBOJep?=
 =?us-ascii?Q?kWk5NzaNe04jkyCNaFnLRVU/fYVB+XwPvXoID/QLHbcK9dAVaQ6VLB0FPk73?=
 =?us-ascii?Q?3wkWXxiboChPrypDnrwhYS2bzRhX+pKwY8M5rn8yzasnzYNx+tp7nil/J/+D?=
 =?us-ascii?Q?aNoGKtTr+QagfLovbfsBJVwmlRUDJv6JGmG2+7XLFByDY1uA8cdK1SoQCmOC?=
 =?us-ascii?Q?CeTJLd2J0xN7SzvFDInVppJLcTx8NNbFOQscx3KexEOeFIDY0pT9jSIcApGv?=
 =?us-ascii?Q?0KhKSpqOTiDDLvr6tSq+8liT6ZCJ001r4sWHkoo7eVhn/qMMC5C5PrRnQpzG?=
 =?us-ascii?Q?ROhWs41J37GMLMGUvtyh3GThxsqbYJGsC5K1487dMp4NmKRJWY0r2ylKBgQD?=
 =?us-ascii?Q?+xZY14z3sjuKR/69W5vX42vUrHhDqaxVfJENVCURZcp5sRthnCgv0q2rkgr/?=
 =?us-ascii?Q?6vfHRXkhEA0aCZsjk7Ma991XH/WHLRHxdA6PVjR4KMfl4KXhK7c6E/HqCbey?=
 =?us-ascii?Q?wSJ6ruowm0ERAOWQZHFEQzbKhAmlYX1UNtpleDYp7C3bv+6eXae6+/YlvdBo?=
 =?us-ascii?Q?IucGiI0w/HlvyJuE=3D?=
X-Microsoft-Antispam-Message-Info: pQW68XFKcjQCvoRQwkNGKnop/mRMXui/7SAFEj0zsHhrdcsmNdjs3kSka8Hx4y9KbyX9Sy/ZvkeK5G+2ec6PGTAJ3kIpXf6sG+FasiwASCO/cJrQH4S46KmhGl9C0O4nP06jds9K5VjNFgL0Z1G38/wKSYsluFXlrb2cq2ipNZRRrYHNajmkn5WH/SM0bL5o
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:qGVq4S1keYkTCwbYT0QVXX9LY/2moyJOl6OUbrrEIeYhfcFojkozmNq3fOlLhuubhAmGwsRXNhWgppKMC4jJh4ixMCo3nYMquW4sk8ZBso7+LRaKGDFVQGiX70sHpdvcFy5Qd+tsyAa7IcZswKGlhD4BpszJzUGirthr4/uTJ21/SWY2oXp+vElwtGiJ+yThyL3yiTXEE0SvoV+sjT59IKinzJghRlX3K5ymitvJrPFerdEA4XeQ0ISxjmz7ffcjUJJW8f9jFbhvdHBWIYkNW4skiCrz5ioO6OCOlugKEboDk/yQBKW7X/g7xlsQnDBmM2jQuv2PglMM0/hYkNQe6WIwjyqph9wKEKp/SUEUoV8=;5:taTOfVDgt4fgn/HX2WBAgqvEdmfMpX0KNTC3fSJFPA9yW6Gb7+ZCJqsYmFwbgmK9uNR2XqU9037ELuJB3YObVAPIBQWbE33oU00A9WU1SoJZc5ESmAdlRuiCJy64qJZgtcI0s1w1xl+fxteBVVdfmOzuGjw7A1XMO+8Bjed6G/c=;24:JcvFuN2HJgDkKUhoy6dpd03N/jEWy4+cDkSnGKNSK/6gdq7fuRgMI7iWuJKXueVEIEwzI3in30WqkFSsStAVdkH4XZT/t8djfsmq+gTkwTA=;7:70v1u6m4y+w6u0e5iXvAWPdgJwZQv3E+kHn7JGwoeTyXE3CfDmF4frONcxMjVAs6Iquvwu/himvKxAlxg8QPHdqOOqj7EThvyYfRq7CadFc+ueIzcIpE5BdKE3nd/MgAsyxX2jtR5hpjVTZOaLn13U87/h5i5EFwp+YtKHnWu8xtsdkezBMhdKZZGZr+JKeE4z60LFQGGf0ogN0OFAY1KxBpBBj715IveJwGo4F1yG3GKk3OywXqmoWN5ruyzvrW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 14:30:23.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666148b2-e187-47ab-67d7-08d582a5a3bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594108392554438818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/base/dma-mapping.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 3b11835..2279c4d 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -334,6 +334,7 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
  * Common configuration to enable DMA API use for a device
  */
 #include <linux/pci.h>
+#include <linux/fsl/mc.h>
 
 int dma_configure(struct device *dev)
 {
@@ -349,6 +350,12 @@ int dma_configure(struct device *dev)
 			dma_dev = dma_dev->parent;
 	}
 
+	if (dev_is_fsl_mc(dev)) {
+		dma_dev = dev;
+		while (dev_is_fsl_mc(dma_dev))
+			dma_dev = dma_dev->parent;
+	}
+
 	if (dma_dev->of_node) {
 		ret = of_dma_configure(dev, dma_dev->of_node);
 	} else if (has_acpi_companion(dma_dev)) {
-- 
1.9.1
