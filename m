Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeC3J4a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:56:30 -0400
Received: from usflmia-meg1.delphi.com ([69.195.251.241]:11780 "EHLO
        usflmia-meg1.delphi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeC3J40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:56:26 -0400
Authentication-Results: spf=fail (sender IP is 40.103.34.84)
 smtp.mailfrom=aptiv.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=aptiv.com;
From: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
To: <vigneshr@ti.com>, <sourav.poddar@ti.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Arkadiusz Kwiatkowski" <arkadiusz.kwiatkowski@aptiv.com>
Subject: [PATCH v2 2/2] spi: spi-ti-qspi: Add checking which flash chip has been mmap-ed
Date: Fri, 30 Mar 2018 11:41:24 +0200
Message-ID: <1522402884-26790-2-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
In-Reply-To: <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
References: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
 <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [141.251.18.197]
X-ClientProxiedBy: BY2PR6801CA0004.017d.mgd.msft.net (141.251.18.208) To
 DM5PR6802MB0091.017d.mgd.msft.net (129.75.148.88)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR6802MB0091:|BN6P160MB0050:
X-OrganizationHeadersPreserved: DM5PR6802MB0091.017d.mgd.msft.net
X-EOPAttributedMessage: 0
X-CrossPremisesHeadersPromoted: BY2NAM03FT010.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: BY2NAM03FT010.eop-NAM03.prod.protection.outlook.com
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:40.103.34.84;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(356003)(7736002)(53936002)(52116002)(126002)(486005)(2616005)(5660300001)(107886003)(48376002)(97736004)(69596002)(68736007)(50466002)(478600001)(51416003)(336012)(54906003)(11346002)(486005)(16526019)(316002)(446003)(186003)(85426001)(2201001)(305945005)(386003)(76176011)(956004)(110136005)(476003)(59450400001)(26005)(156004)(36756003)(6116002)(106466001)(104016004)(2906002)(575784001)(3846002)(81156014)(81166006)(8936002)(6666003)(66066001)(47776003)(8746002)(4326008)(8676002)(105606002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6P160MB0050;H:017-smtp-out.delphi.com;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT010;1:v2srFn59c7WNN9GWk1nwLHv2KtUjEXdW4w9psWH4o3gcyxk/F84hK+Y0PVk+oUvxyiF7x9L3mrl/7R81QjA/t1H47RaZfJgP72c5StnXUrsZc5+9etvKOnQh6yVM4e18
X-MS-Office365-Filtering-Correlation-Id: 3dfbea3d-870a-45e9-4477-08d59622906a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6P160MB0050;
X-Microsoft-Exchange-Diagnostics: 1;BN6P160MB0050;3:5GR+RtxDzSNojK4hZtX9bbsgKSymPhVOdFphi+tnjMxJH+sF+V7DrRZj6pLBYRmVw1oQuYXFrdyZj/TCURO33UdPoGbtVjKM3lSM4gh/avV+kBSQVDN0c7m+NZ3yAVPsKp+s3XU5wmZVeoZ01wSACr6X+Wx7yM3J3RPumMv0C7Hbof0A7BS6yp3eNVe81aqlvliQI/IVYK6y3SDZvUYF7Xcp2tM+kLqxr/3JEouJvzccPUlTjrxYt/sANx9pO8RAkE3ARxHkVmHpwGBWxhH0DcuiAruy59cV5EZxhPak04Z8Wha12y66Z7/VJhSkQOFR3P/8NJ4MDLcbABFTpXDRnQ==;25:ZyhFpQrkYdOkB6yESRxX5FLhoL7gjOHmdA+mN9mVk8B5nKLD6Kowy5kkbzRbjapYaO5RXqZnf7VGeHew0pLeOS4Xacti+ImgR5Y+0IQMakmDq9vyKWR1y9IgFq59FQw7eFWyJufmm2G/VqWoQkA1qCTacScRRXrF6s2bjOlAGUBpKUX20wPzb4NaEBs7vjYOuhYl6QC4P4asAqcqMOCZikLgx7yPp/7I9mxrVEh9bpD24e16ZFVfEKQBGtyvzJluL39/plzDID9jykPyfllDTQenFv9VRnFaTl6HXv+yWMlFHX5W/g3NWQ1kKFJyI5WMLjrq23BrMeMFIlQE+PNaMw==;31:7koxt7sk0wKHsSPNqq/ui29aIaeFAInrNJhpgA1uZtVc4RPKRsaIW0Qmv++jKpTl/f9cLvFeEfa1K5C6FgF1IUfHGcnm7EPhFsvy48GtRLnjQT6QOj0zVHkhngnoGjHmUw3mx0Nb1RfqhFjMVw83Ybik/V4qSIqaY3lEDPLD63DBeWdss+LnZ7vsD/mcjhskNBxoegSepl0REmPuoPSJyvKv7ollQmPMM3onDzRKGkk=
X-Microsoft-Exchange-Diagnostics: 1;BN6P160MB0050;20:OzRz7zj9jlaQ6alI2hyDGYGouBC8NZwpcksKjvp6EZ8WxCR0sXRa+m1rS1qCWXlEQLx/ANky2HCYetosBltiPmW5zVrU8J/Defb6KoAyZAdEJab69kiqE3+XGki/FQbL8X8+Hj5OSKJf+56yOgHTJrjcUa5cIFVUF4mwqUNCv8Dgudo8Fhgin4bNcrWXZpTkk8fGztOFAom3OOPEagDFZBe2bNBLmNZIlkgDyCbipElVbkG1jTsPzf2W8s5XnBkOTq53VtAPrkT7Qa8gyMHn6PsqJFv08ZbpsMFgBc7FPByLKxJpQ+yQ3zp3nyrzkRzzaJCKQ2Go/Myl5FAsF4tLx0tniGtXbfwSh/BkMeIPOmnTygHRjiqw1wJVp4mD4Y0ZxZQyT6tE7vE05RA0xb/Rlr6AuI8W2NMIaHtDWAZFY+kDE3qfRCmjwXHcMtTD1lEGM1jDFgIdbGx0PwpZnd2UkPVjr7j2DAx9+pqGzy5ZqEJG9RCpI1PQ6vvlZJklLeQJ;4:onSO5/PaQmSA/kEu6sHeOxb8mtGMAHB+Zr5hxwRzDcu0jn92wFBDvrNGoP4SAfi46Ttd9Pnm+oEeBFjEDgFL49AXQB6KNGcBq+PVomlF+SPHfM9qGZ7cTaHBa6eX2c02JKTyLGX2fo+WCGxB78uRi6KQVXZIYtv5GlcV/SGT2QUcgUGAxz4mu7KgO66n91qttFlWGJMmc0yaSSwUzOjh98Y+ekN6LahwHWL7qvjn5/A9ZEKpvNPl3UDBPklZyyaiZZ9NHg+2oS+0MneWqPjGig==
X-Microsoft-Antispam-PRVS: <BN6P160MB00509A3997A882EDE364FE91EBA10@BN6P160MB0050.NAMP160.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6P160MB0050;BCL:0;PCL:0;RULEID:;SRVR:BN6P160MB0050;
X-Forefront-PRVS: 06274D1C43
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P160MB0050;23:Av+5lLR6GvEofPAl/kDnn78SyF2vn0Gg0j/8N4/TI?=
 =?us-ascii?Q?rPkbf9sxFq3syQ0CpaiXFOCuT2/Nget/dH70qvQudA8/r6o1adMHUmRPH+nk?=
 =?us-ascii?Q?JN/JUGIvz/iGJZWHLknjG7RyOhMPkktB53xprFvl+xR1WxjGbrttHAeiZcM5?=
 =?us-ascii?Q?IhKC4enKDGa9dQLvBh0kIw5PlVE9XJM/YcdA/SH7dp6zOrmCBK3j7n3OqFXf?=
 =?us-ascii?Q?4hcfAL9Ia/3PEGQrGCYBVG5ogEJwGy8pXW8Nucy8I3o62jGfxuFjPCyo0nC5?=
 =?us-ascii?Q?ocOsotJ5M4jfTzUPAVnNBRl8ze7Qrq96cOmj3Tt86/ShhBpFTfmLFnHXPtA7?=
 =?us-ascii?Q?A3Z4Fi+L6yS9b7cZThzvVvfPjufRPPdXGYT2jhGmB/zLtOF9JZ90qG2hCRzz?=
 =?us-ascii?Q?2JIBvsJFrV7LeCRkCOTOKwQfbUgR1ijZEnXXZIGX4A3BCsGGZaVKzhtJd1c5?=
 =?us-ascii?Q?FU8vImWYjAsMQlXQqR7r56ODVISQS3EuvmKs298AZManNGAYEij6BTFByXTA?=
 =?us-ascii?Q?BXWU8yGa+E1MvDySKWZcZmXEWXtcNTeDs+PG6u7oErCTbVhujIoi0n1CwAo+?=
 =?us-ascii?Q?jG1xC7K9Dk9Xq0nBMNWYNpAv2AYjNHSzhyQWF1IAhKIHTyIeqC2mXe/p6GW9?=
 =?us-ascii?Q?r/Yt3+3fNS+7g0OL1TIyCPVhFzbShs5Dh82gPU57nla7oWtYvhUlJV6Vs1QX?=
 =?us-ascii?Q?zQvlp+bdJ5icpG75wikNK7xlMNfPpmf9eHSlEueDghQA8q1ZnpwEtUNHk3g3?=
 =?us-ascii?Q?LYsRgR17PJEZJi+ATxwsox6V596hJiOaDi53EATrgM1Wa4VxDU703nc458l4?=
 =?us-ascii?Q?69/1EsgehvCv9UtqrjFee+C5R7e7rMwFW5R+tpdioag7Ys4zq75GozL18NLq?=
 =?us-ascii?Q?rnvl4+mI4xPTy3um9dlhOkfXMZHZmtgokxNOaidIiYpPVwDEoo716Tu27QfE?=
 =?us-ascii?Q?C0USLMvzHzPpKyzSaQiKrYrn8ibnCRRmlkSow6+dekJJQkMrWe94UPhuPc/a?=
 =?us-ascii?Q?Vi9j920ceuVz0f/LIY4a4WVL8Ix7O/MpF1qur+imVIvvICLfgH4H83YpzjqJ?=
 =?us-ascii?Q?vjY87V8B3cE2Qf9qytE9r3KfhXQQq9xtoJVMVnUgVXSvnq+9qh6R5MFi8644?=
 =?us-ascii?Q?BDt49yMUykMfWw458xNJ1Dw8TgaseHFhIN5VfqWSqgF8MPJ+/YUyIgFMSu4F?=
 =?us-ascii?Q?3acuHwZZiXU9d90Pyz4wlzVcPDADguWGJ5v3VpaqGYfPW/tlhhfvrbGRU3i1?=
 =?us-ascii?Q?fVMEoUIrgOdy2NfwAblzDM+ALeJXcH82qO+WmXc3TrCut5fAXIxqzWjqcxTx?=
 =?us-ascii?Q?VKOPQwKiyIJMNsAY9SOgfMtAP8iqXazPsyHukvLNWa7bwOpB5lHNwlaMojR2?=
 =?us-ascii?Q?bnzItcqbg+7jTlnBPwAeb+Lg7ejlpSrtOc+k9F86Wz/PWGlhz6YBUxJxlMTW?=
 =?us-ascii?Q?6WuW0WQfg=3D=3D?=
X-Microsoft-Antispam-Message-Info: Wf1lxXummDSQl7M3m6Jlvnib1486OrOzhobKS/iQQLee3Y4ACpjiWWlvwi+Ma3hx8jZl5sWBYFbNITGghPg9rRaaV8vOyqqWSL6fSMZtWEXnJRmislnHCB4s3TIvyvEesYL7Ztfx5MHa+ZjzwR22UnPmYkwbPuakMZzVqobkm2yZvHCfvyQjEtQJ2fiZgE8o
X-Microsoft-Exchange-Diagnostics: 1;BN6P160MB0050;6:rPk1DY9+PcTStyI2G59Ng3/t0Ez0EqkukMKZSdB9fDWr0zC8pWlkY9NS+zxFwojdF2WvfQiszSmF4xIiyNVkQ39AQ/G0cIUpt4w3rIyjW5m0k5cmAdptPBXm16S9sTGStBEu0aO9PhoHVquuw/ekvmwZfiog4hrX/XI/7m1yoju1CYa8OfXioRXfgUNxSGXixOnuUAJMh7UEY/kmgRTcDC85vh7804uWaZz7QLjor8iX01SFXlZ7QtABqJ4PnMs7aTjqYkaC+akYEWjfup4xg97WnbEt/87v++J3NTI4+dzRK1Th/jX0X9goxw5Nm6zAPHPMlNRTuMqpWBgnlqYss8IrkszOJHRnenSigogGYSdrIl2CeTozTWD2HPbB1wG2o1aXAe/dk43SCPTvuL7yeuyLyWpJl+F1Z5p4ydGcF1cWYCdnmPNZZZv+jFApCeAVYuqdO84SYul7Q3NNiMfjsw==;5:fLBsfb1T2diVm2rVTEQ3VF0rCiMWHvExljY4+dddJ7hYhaX7sClYbnOb1SQXCEk5kNui9JfkKc9Cey2hI3x1/B8b3bMW3UsW0V13Jbf3vcOgFLOV5zXFZ58tpKTw/VjNbCMl9pRCkQN3iG9HzLQxKzWUoz1Xe9SEctrki/CBm+Y=;24:yjlQzPZ14jCupGAobdpyEmuG9Z4u6cLE/ho+T3VXbS0HnxnmHI1YRooSv73DqYY6cO1fXkSSZKDgd4LHzJroJJY5iAVC51phhnUThaI/E44=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6P160MB0050;7:WfOve2DPM9Cr3yG/ooZM7k88Ex6e9zkCwOOWUGg85OEmG74y4AVYNoIbKzUJ/qGDWAJotVtTdl3inZuYaGdq1+vw2zvZ655tAZ2DObPegxoviWl6rlsjAlTLmj/K0yBph4E0P6biczjdt0O4DwublYks8Oq615CmelpOMnpxXlq855O1Y8JobOXXOgWmjao6IkeLzZn7svpDrIA0lI0htRyx/C8qZOLw+tJGo38DDRiMEvDF4VJxR5eZ+bYvfa+h
X-OriginatorOrg: aptiv.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 09:42:33.7481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfbea3d-870a-45e9-4477-08d59622906a
X-MS-Exchange-CrossTenant-Id: 1d57d21b-62d9-4e6a-b97f-39c9a7dcea11
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1d57d21b-62d9-4e6a-b97f-39c9a7dcea11;Ip=[40.103.34.84];Helo=[017-smtp-out.delphi.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P160MB0050
X-RCIS-Action: ALLOW
X-MEG-POLICY: ALLOW
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2U9uoHN025818

This patch allows placing more than one flash chip on the qspi bus
by checking which spi device has been memory-mapped and remapping
if necessary.

Signed-off-by: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
---
 drivers/spi/spi-ti-qspi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index d0ea62d..5b99a1e 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -66,7 +66,7 @@ struct ti_qspi {
        u32 cmd;
        u32 dc;

-       bool mmap_enabled;
+       struct spi_device       *mmap_spi_device;
 };

 #define QSPI_PID                       (0x0)
@@ -493,7 +493,7 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
                                   MEM_CS_MASK,
                                   MEM_CS_EN(spi->chip_select));
        }
-       qspi->mmap_enabled = true;
+       qspi->mmap_spi_device = spi;
 }

 static void ti_qspi_disable_memory_map(struct spi_device *spi)
@@ -504,7 +504,7 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
        if (qspi->ctrl_base)
                regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
                                   MEM_CS_MASK, 0);
-       qspi->mmap_enabled = false;
+       qspi->mmap_spi_device = NULL;
 }

 static void ti_qspi_setup_mmap_read(struct spi_device *spi,
@@ -544,8 +544,12 @@ static int ti_qspi_spi_flash_read(struct spi_device *spi,

        mutex_lock(&qspi->list_lock);

-       if (!qspi->mmap_enabled)
+       if (qspi->mmap_spi_device != spi) {
+               if (qspi->mmap_spi_device)
+                       ti_qspi_disable_memory_map(qspi->mmap_spi_device);
                ti_qspi_enable_memory_map(spi);
+       }
+
        ti_qspi_setup_mmap_read(spi, msg);

        if (qspi->rx_chan) {
@@ -600,7 +604,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,

        mutex_lock(&qspi->list_lock);

-       if (qspi->mmap_enabled)
+       if (qspi->mmap_spi_device)
                ti_qspi_disable_memory_map(spi);

        list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -787,7 +791,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
                        master->spi_flash_read = NULL;
                }
        }
-       qspi->mmap_enabled = false;
+       qspi->mmap_spi_device = NULL;

        ret = devm_spi_register_master(&pdev->dev, master);
        if (!ret)
--
2.7.4

**************************************************************************************** Note: If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please notify us immediately by replying to the message and deleting it from your computer. Thank you. ****************************************************************************************
