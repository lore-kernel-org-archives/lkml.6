Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C19C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6FB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eSqlhN1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6FB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIFICC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:02:02 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:27456
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbeIFICC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2co/rOFNYCKDFEtwWMeOia35S7BptEN1oQanmK87z8=;
 b=eSqlhN1dj3UbWDDu/DfJlRFQMX6V2xTCF7AMKwbGshL3SEcRxGHomZjg4a5MOtILkjTZpxo/bvSHf4bO+2K3gxkHB2q8QB+LaDOZjvHyRLtP4p5mooEwPk8r/EcsR+1OPUtFu6dfyi9bK0v5cjPtwl+ln2amYyVPB3/IS+xmEfo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Thu, 6 Sep
 2018 03:28:41 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     dmitry.torokhov@gmail.com, fabio.estevam@nxp.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] input: egalax_ts: add system wakeup support
Date:   Thu,  6 Sep 2018 11:24:18 +0800
Message-Id: <1536204258-433-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:203:36::19) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:f::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86642759-df94-48d9-eab9-08d613a8d8cb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3905;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3905;3:fjDDdMdmw2lPWRFmAfbdvJiREa32I4407azK4Iv199a97KRjB/vmLL0BVsLAAZ1m3CGSWfWVqS1TCAZaOg5Lg3b2XfbYQSGN2WehYrdD0TN4qmoTnmxclPXGmcR/fORDgcAmysl4At01ctJdl0w/7k2km01cyd2W682QIjxo5zJm36ltCT4NooqJsdO0QoJ/TqB5sI/9/MQavn+leKAZCxWOHjAUwDG06fLIi5bzOEmwJprsp8/pO9WRftzNoSYE;25:WlZaqrgahuBsemPwmVaGyHAFDqqAsb+DjlKzM7y3KBsbnE4GjrfvX+w9T91vdfnj6ypdiEJkny9ytEoypIdANGlZ7HzUeL0pf72Cmw6/eXCEdtsoBnf+nBtyRDgKneul5ijzpa2AXnJf/vZgOTSsIe8Ex6HtdLWae5olCRyyrCt+TgEWxI8cb3Sql5If2xEf7brjKoyzu4+JTQF2bVVQ5fyQ6hmSdIzEx+I1dca/u8wh+9FZ/KZ3ZJ2jOM6L1JLcB0tnJz3WhzLthpFddDWeqwQkdCPNENW7zOQo/NkG+Ywrh/voFxDkcT1Fqr3VWQ5YdGr84C4JnkWGi4I+wLQGHg==;31:qEq8SBggY/0A+Jo+49PXLhrWsbstmrNw+x+dwgnDEE53a9ZVjFYh27jMA0B8YeFFHKMwTemlWQIw3g2MO7Xbzvqwhmrkn99nFa2RGlC6gG7SpviOIlWyOowzQZAUU9oF7Q89dqadzvlnaTPboRJa6G6dBof+BtjCs/Ll+cSbRsUXsrwV8J3EXybwnk7tRXIqxX30YMoOp8+rt1MPCCiJnUZhJQl17byeZ5O/sCiVHhM=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3905;20:HQs2kzdsdzPT0pG9qALJz283vqpzwRu3LMrIeJ24BPrRZ0whRzy1QB/477ROF5P25QnLNbKUGq+ktlZEtOMmg9tg9qJHnQzihN/b6gDpFdgGehow830/a6OdM25/iyl5Cx3Oz4mYojgYz9wT8ivLbO7k8TomAumGGFaldyS2f4MFp8FHg958i0VNP05sIAohRQ5sp03JCthtARtdG3Lpovei+2kR/0d1c7qcMSkBQZR6U6wu8hfDCti0857/im394qLZ+UTOjVB3okJE433xK92Mrzh5dqUU3KmCwolH4Y40hetv57lUlE5PhYis/+JJ/wbFmCVeqkWJlqVUvLQAQunR4TjOccLbmKcjRDM8PrtteETOq8CEoJK+otYAtG3oCpeS2stD0/QeNOtfw/xkPKPbV0v0503C8a1uzpxEw3qb3EgKO0ICH0t5nra6Hb/AHjDrb8Fwuzal/rv/rpcL+fAGK2P1GerqakEMC4pMhc+QqNdljM5MOVk/agxVD/D0;4:OOc0s17VKgL3ZnH0nHoN6HqMC4fq8xvbGSK0BLPSe1jTCbCS2PL8BjsuiSL2/aHnVMLgQvTPoCxG6sxj0znM0WP8vBrnEWtsIj3Gzk01+kIfT12k9hwL+FbaRcESpP+I0mGT9MNnrAWQWWE9P1+YAXjfI95XRsCjLy0fPnnItiyyq9/ur6mzj5GyAZGmmm6Ipq9UFtrUq8QtSb9FPBA4qU7SMwUVMFSANWXTXqHVuuIneOhQS296xbl9ve5j2Vxmz7NgDDriEsMZRHnT8OKmHI34qzpgRCvlwF+uc/p9ac86NfOR3hV0kH2mMV7JD9FB
X-Microsoft-Antispam-PRVS: <AM0PR0402MB390508C103AB8DF4595DF08FF5010@AM0PR0402MB3905.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR0402MB3905;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3905;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(86362001)(50226002)(2616005)(956004)(486006)(476003)(81166006)(81156014)(8676002)(97736004)(8936002)(51416003)(478600001)(6486002)(66066001)(14444005)(68736007)(53936002)(6512007)(47776003)(2906002)(50466002)(6666003)(48376002)(316002)(305945005)(25786009)(7736002)(26005)(5660300001)(4326008)(6506007)(386003)(52116002)(36756003)(3846002)(6116002)(16526019)(105586002)(186003)(39060400002)(16586007)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3905;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3905;23:YEXnX1sV+wRIHcKYrUw6Ye1Q5hwdG+X87H7k9ca?=
 =?us-ascii?Q?qkjGMOdyZGFRbf/vVdor0rGof1ZOXcavGQutOEHwyrrWmtKV1Bio97cOGOjS?=
 =?us-ascii?Q?NSgYJNA8DHcZVs8P1aJi33vRb2XPvkdwugkty5CLXeO4u1ULTgpAL+Vgcueu?=
 =?us-ascii?Q?aWHcfkdjAB75ZAnzt4tVVqXybZGVT1M0HPQRkgU0p8Dbh1CJJxhihDMyDXP7?=
 =?us-ascii?Q?joTGXBBbSZ9yEX4pyUxBhsUuRi4gbKVx9IxUFM/nd8v8RUPcujUgIOj8DwMq?=
 =?us-ascii?Q?FNjYMcVWNrabNPnDG9SYz+aPHnSoTn0xxiFBDejoc5eOdkVSCQlfaIz3xVVN?=
 =?us-ascii?Q?T2wHAMpI1R9SIDDULTxdDatfF7tkq/OdfmXNZ18nSC9wOXeBiwWQ99J50cU1?=
 =?us-ascii?Q?/hd0nsb5lZbpvA3yYM5SlS2DzI81IYyK8bXCqllKJ1B430rVDWh0u3bNCSu8?=
 =?us-ascii?Q?DsWG08yruz76Gq9syoyblbmxGml4OOhk7M5bx4VaULUIb/7iOzgtKrknPQTe?=
 =?us-ascii?Q?oJhSmEYQWP66V/Q2rwzAtiZdT2+BjWr9pQeqH2qEamZcCjMvxOUaJEq8FvQu?=
 =?us-ascii?Q?CnUrU2Jh+mDusTE4nrkp5aZULjf0gPpvn9n/tuFdYHBLoC3/l0hvAG1nIHLj?=
 =?us-ascii?Q?yPtA55u2iovXGNzVSNbXJJato503MKNAcZvVAQ1oSAelyG4B/ZeyE22Y86+u?=
 =?us-ascii?Q?9xMq+WmD8j2+dEURTkTVrUJkxgtiQSMDTLzIP032xlNzyRlIqWOvyOOhdngD?=
 =?us-ascii?Q?tBCKHp1N2hToRHXYqy4e0SfUr37lvUVSw8kLAfQNZrVOpXUIG0sQl++4T3Aq?=
 =?us-ascii?Q?hZ+3T56sBu1ByEsFR+aY8FxYNdpS4aL+3cHB8uNZ/OpdwjhIuOzMu8LnMSaE?=
 =?us-ascii?Q?mNMqDFxiiffYdRsvWhSZKhKAYuC9xTjAP0bOs+83S7gSr01A5o7RiRlvbvr9?=
 =?us-ascii?Q?ZcBCtFMN6CTggcsTVnI12iBsMXRq0pHsUln8FZ67aP+1MJ4JSFZJIGLMN+XU?=
 =?us-ascii?Q?vPmYFqHDCHfBn976JFjazFzPiQAgg8BSDmPwhMpt+FrxMh9PjM5BdHsPYxx9?=
 =?us-ascii?Q?P1PX+xhJIjAoWCem5pG3VebbZ+qM86qwN9PGNU2T6ByloW+PegiWfbFSOONz?=
 =?us-ascii?Q?ULbyE7zp10JMfVH/Uk7PAZmxvAWdhTVMy?=
X-Microsoft-Antispam-Message-Info: cJSUou3mXF1zbwpqbKwrIcaljbwuXTfPYBqpN114J9tjkGjUNx3S2uYWyppQbtEmPxrF4fXxWvuNdAIR7a08UkPkLyuvLmYqwEstwRCZI7HOKPAHiVMo50iEpfvT/wXWPSRuKSbVyebpKarhoiZZFmSIzAu2HbX5JISCwRwwcOXEqcUedJuYgJpVmXJ/gehCV6ikbwdv4CYNHSOvQKU4SL+S9qTcFykRzJ9BACZ6bKChOIs4dCjx6JNveqzMyTkxmHwTtlMGTNSWGt1mEAWw068MLdwAD5voN2INoCW/Q9a+IS+GD6zb2PePC3qkPsig6y7T4TBT1NURYPvdupGiQxtZNwBEdo8MvTPgJ+LnQ7g=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3905;6:zmTQDZ/lW4SEq7qmgv5rFB+lPysi4FACF0t+zjUNcfpEYE4X0VO9c4TBG3BhYgOyynjX0NijMaUCNq7ZstO0ZXWoSdekd8dgprtmnxSV6WwJmk10Bg2q0OktZvO91kFAfgs80lFzp531f5B0VIrchDj9pamN+TqwJ5K9yvlIC//nMWmjxvt21xvumWV50hyqiZ6rAVdCUtdgxMEMGO2SCpiNJRzTVEt3mOnxpZdHFJFywO1Z9L2LNNz5AM/7lnKDwIgSoEz9BSP5pd556FwUlqQfqgEHkWh/QACrFMnAXzd9o+4ZLmx8nZOgsPjb7lGkzAhksh6sPu70KELAon+JR/sOcSNU65LwM7cqItfAuX8mREw3R9QsjbmXzrzpfqCh7CH3P4fhslsGwrgZ9+o5EaL4FWn8dTYXAYB9T2fBLjHqA/Eo41/+NUEmFmywNWOtlujNnPVFvzJfsqnqPMOBnw==;5:3pLS/JF4UL89FmWN31UkP31S4oCrFL83AxoZkTvvchjAOT2SOZfUrJBd6NpBArwTvHJVm+2zfSrHmNDk1Es5+uiw7pqaifFx52FD0L8FQdSPhVEgjE++LXpmM/FAN1RCUf9p32qQOE56h9OQLHwFDcFcGqzPzGJqoU07luz4wDA=;7:DoGLeow5vs2I44qaO2CmCtM47BKmR8ojZJd0qJ1kFfWvlhnsHaIjeUsqClxzHwOghyzoYIVhqLA7o/of5CPQEz/KqiTeN3jmyG3/uIy1iJJ6vv0UWacsY7pO+lUBhdX+WFLbGVG9q6XqsWV2z5bnUsLc5WyF49fJa9jKOwmE7He4L9RgU8vVoFooyj8auzdbFWLPHTQ3rue8c43c5jkwOjautt7OGynF9Q8NrkteB1MpBpk2dbQUupRa3MpLAsvE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 03:28:41.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86642759-df94-48d9-eab9-08d613a8d8cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds wakeup function support for egalax touch
screen, if "wakeup-source" is added to device tree's egalax
touch screen node, the wakeup function will be enabled, and
egalax touch screen will be able to wakeup system from suspend.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	remove unnecessary device wakeup check and fix the irq wake balance issue.
 drivers/input/touchscreen/egalax_ts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 80e69bb..83ac8c1 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -241,6 +241,9 @@ static int __maybe_unused egalax_ts_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(client->irq);
+
 	ret = i2c_master_send(client, suspend_cmd, MAX_I2C_DATA_LEN);
 	return ret > 0 ? 0 : ret;
 }
@@ -249,6 +252,9 @@ static int __maybe_unused egalax_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+	if (device_may_wakeup(dev))
+		return disable_irq_wake(client->irq);
+
 	return egalax_wake_up_device(client);
 }
 
-- 
2.7.4

