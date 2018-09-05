Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1368C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD47206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WAsp51fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD47206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIEOAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:00:46 -0400
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:31808
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeIEOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpQtvzSqPBPcCmE4KnJqoFP83upaeTmOHpolcff8hyE=;
 b=WAsp51fX5qk2eHlWOfBj3QXTPHNddTA7j5jvT0oOvOT8Zxd7IErYoR04UIeUW9ycetV3hwsGSTJsG4Lh5z0rE9ogbGsgPHFGXebYzdOXsDg0IZm/GxsklHYy65kSoZ54lTC8ruCt5mLG9qz//4BrSjQc7haGBtWO1CiSIMMDwP0=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 09:31:16 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, marco.franchi@nxp.com, fabio.estevam@nxp.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] input: egalax_ts: add system wakeup support
Date:   Wed,  5 Sep 2018 17:26:46 +0800
Message-Id: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4531d2-f048-4a24-c348-08d61312567f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;3:p5TaF7Ec3BzqZB2hHCdUtdeGysjba3fcROOlObw0fF8IGhsAy0B7h95uUyWnPtPtEhEEK+3Lvy3s142j6ZGivx9VkFwXfgZpTYAjMiGks6AuRn97I2szoPnQ5J1M1musFbMqPtrp2Rdg3jT6RL7eN5DM866s/Mkjh5taBGrjucNRHSKolNh30+fwq+19TFzE/y4zKykAsv9S4evBQtsdpxyJAepmtE8qrS0RzLRV7qAN6SLp/AY03K1MQv1sEYPU;25:JVSFmVlaWkIvf72l7wb8H4euiCaad9Mb3YPF3l/dp21qMsojCggRyihm3noYteJKBDYSrbHUWdrSMu0ZBeGSt+Tr60rk4VYF6BWQ4B8ScHCeR2e1XumHX69KhxnVuZoFcLTcSuC521IgapDA7K9IVuAT/1x45uW2ZpAvy2eP8TUfqtziX5xQ+m+1QAQYMALclb83QDnDJVAmHhoLKtPencvBN4bDBRXRrfiLfiXTwFEJJfI1mwlkcMKMYg2DI93j8SnO3M+Loxo7T7CUn5kd0w2bX08k2eEKhZQZdswRRXetYclU8hMsMldXHO3KYQWQyCFflrn3JgyzXD+6xOPqqA==;31:hoA4o/ilo29ROk10fn/hNwJUXKcJorXQFtWUgyg89xN6mOHLbGyTCdJ10A5844TZ5TBeW6oDq/ZAa9nkb+rS/ny9kldzqXrZuRE2jxHb/CKxC06VfgbegA2DObpQVGfG6GLD4AjjyG/OSBnwt7S5+FhfNWtWb9leRTpNfBCxW5rzoDlgT52IIq8jDMutqScSX1/e2nFlsxOfbH/iWWFLclP/bG/Eouh1K4Pwyh4l0eM=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;20:DdRDxFUxguf9LKJ5yMMKcZJP1r7xkGY7CxOcyOl9PWNXKfLvJZKDGJ2izwpAypAd+KKvnKqORmJsr6PjcP2JdWkoA+I7nngpBhPzgUvFybO7Pe7cxcpYNMdfPjANUpMRRWUxOycg5BHZxt57EaNIlASqk1TkpiSXuQlu/9A2xIKz8n9L1W2W85CRWfczpLf3dXxRkcg7eYCqpAwv8/sCjEwQCaRSQau0GKxtxa4eYzqod9Zt9/cDkxIXVsO/zP+MBQYMPwSQUh1Y/n6W6hBQyTjixZry6OtdzkM1vMANrSs+8DOfiUMaEScCoYBbGoWiSRYgliGBTjiFxlpY6rRfNeK9EyTmDActtgpBVPQwPWPDKzIWz6WlOQtfzHgoDu07U9ttDC8sYkDZGW/OoM2eq/8hg6K9mzVFmY99pYmpXQtvy1G17Q5BmqCAYVp8vFj0WKcuo5qNQy8P14Zx6IwTWjTi2qekSLarmPlq8pUEgKxe41YCGu7vDrq7Xi2naHHW;4:0n0Wk7i6XsplrUe7GO6HJl3+l1UbI3o5wQ+gCijVWOdj3K+Y2zpZCJKGD8/3GQLZYcddLMtzLWE6k44DtFvEk8xJYRWT+5O75lU8I58zfAG0bJlb41zBkrOYsQMyy/FDB/4/liw1G1s7GzC6tzazmsHot6v3aiZRTw0ETlvQVHmWdkaVjgiYJJ9wgapl5K+de+dR2S9MODKEAxfnsMx3ePD2E1Xd+J+Q7gVbO56LiwhNKPLFW1m9am+Sh7emC3pennPPoFvIuAypq8ho+xVIxlF1GHVrTwtVWxwdhXkYPkp7kmlgM3dHjtNkR37WpSgI
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39167FD844C95A3299E84E65F5020@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231344)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(86362001)(486006)(2616005)(66066001)(476003)(50466002)(956004)(8676002)(36756003)(51416003)(186003)(6346003)(305945005)(26005)(16526019)(14444005)(7736002)(52116002)(316002)(6506007)(48376002)(16586007)(106356001)(8936002)(50226002)(105586002)(53936002)(81156014)(97736004)(386003)(81166006)(47776003)(39060400002)(2906002)(4326008)(6486002)(478600001)(25786009)(6116002)(68736007)(5660300001)(6666003)(6512007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3916;23:1yuWlVpLCWqkwEcKLlAhkT3MgNHmUx0jebk3H+o?=
 =?us-ascii?Q?Z0X8/+MBC6wOiT33KOM1myyru4uHLpgUylVz5BcmCgljpjMDqzHtQwWaCxwQ?=
 =?us-ascii?Q?CkHxwn/BUzKhizHLA/4mnPG2nhYHlmKw5ZBcYX1R2OADmR3WY0p0PzyBR5A+?=
 =?us-ascii?Q?OSnNkngvQwTHdZ1degEbUVpDwGagwdVBbYdppOdVMsgv/8xxBJz+AxEknn+p?=
 =?us-ascii?Q?D0Am2fnF892QfqZEVePY3mjcJ5WNJquwKWVg6xlaawORnoMEP8XL/GUZFXo6?=
 =?us-ascii?Q?qujll8HAuM2bJwTj+DiPWJanpKhkaZLrq9Zza8/S5rLehQE7mDbpVJPweioy?=
 =?us-ascii?Q?7VZHDXwCF3ufTRBDRKb5JdT1pTlANLFNfuPpkoyamvwpMsZJ3EaSqhRJ3zJS?=
 =?us-ascii?Q?B/yvQ8uowl7sZfCOdwKV0mwpcyL90fWySjt+OE4mQDkW1q1s4tFqedYwlF6Y?=
 =?us-ascii?Q?fFivEgTYkGUsb5ayRjNd+8hDBFh89kEzvS1QD9gPQ6SZq2JPZ4VLdAj0iF9e?=
 =?us-ascii?Q?spXP+duRcjayypZJQx2uZGBsXuA3oM+NAfZPdzGz7dK+964OQj9EpUz3r3in?=
 =?us-ascii?Q?+h2m+U0+AoVluiAnzmWHn/JUYbpMP0PTwQdegoJ/IeOJ7JNGyqjBBgIy6cMo?=
 =?us-ascii?Q?hlS00vcBi16toIqQfhdLYj6fyxkaG3ygXlJFr2mBk4sosQF66gHCM4N3fZCB?=
 =?us-ascii?Q?wRkcdhmGUgmdfC/dzhWVNzi/D85L+En1u0u+Cu+fb7vMSnWAa0CHp3l+RzdO?=
 =?us-ascii?Q?wvb4okhbMzplwwjDS1Y73seZPgz7ReBUNpI9IxvEnx+zvc0pWZmY5OjaU/1x?=
 =?us-ascii?Q?/F41+pGVarhS3EH618mXgFOjpCpJlA+izrGNwObMDfZvajXPKpw0gH0iQzUo?=
 =?us-ascii?Q?EwtDSI+wBkrPSdcT3JYYx0QpqAhwIPV2v+UmeFRGrIRi8W/cyEK5qI9q02AH?=
 =?us-ascii?Q?QrHXXXh6x98HC00f29sqPTg+SQlc0YQ0h1AN4YxTbOU9GCGnbv9lAMvFnZZK?=
 =?us-ascii?Q?eIOgVfTCt0kWq9Ht0FIrlhdZbx3sivH/IiRsW4vChcT67gH05zNcpN1fBCYC?=
 =?us-ascii?Q?PoLPOCZerdiiTb8vszjz0Mi1XnX6Gmhut6sQ5g/BcthBV+690AZ2b99nzuNs?=
 =?us-ascii?Q?SomrvO3YzklySWfXNsfA8+qNdxGgpzZMea8ge+OyXCWvkuHGGQosTjQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Hdph5YRatNCpVjxhav25DoRluUUJiMREp1qz937KRwoyYLLGJaG817QlDmvJGCeZJ3kJITIfpF6OJfZs2rz9vz7N/0nc+hB3LGbZ7TThJ4JZj0WeW/chDvSLcTkFyqwWPe73/TuB6vN2mPnQADtIhouQBdOf6Twt8QggODR801488jiNw0yFdwYp7Ga24zHqy7tXeVipAS/VoVWFGgXdYZYB6l9COmec//8L++R5fGq5oR59vhJ5xZlQluNWDevjtqBpt5118d2MaBvlQqfFPKzB3DrGXzAkz/VFzDgCUWYQAMs9cANatgHmi4CViON4i3pEtTX+TxRqWeSnuyrbi1ZXinpMTeTc2GYsuCsijxQ=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;6:RTGzzk3FmoTDZYzOCpjJZAahT2H0l4i127XYn+7LzyNayWQ7/JfSQVzDyQgiz4xHN2u0ZM+TMRtHKp6jFO/3H4yIJjgvp/yhFbRYOI9LPu+5eYW7kKV1WALFy6SLZ70dKPaVafVaFehtDOpyRJ/pmnKbJY2fQ1jiH2dg1XtnYoG/HUVUVBdboBqf8EWyR5JgtyuaayHuRJFAStziHUFdehOozSzpFhFG9lqieg0WcS4agZqAoxpZtxCRLlChOAb1hX7dk09mlpr2Z4MzFyE1k5GRLENFLZbT3Fko7Zbw6atPHYhRkedymps9S+Ltr4wJDEvc7oWwTZH1qXXpOCXgfm6gY76ZsAskBeOp6Dlt0miK0ekv2VSNuCZflLWaBoiLLXIGbDB6i14qBCFQJXLWOJNZfxZhS1tKjEwhwwiqnixzbRJB2hK8PS3Ae6dxjxQ/19tFiXspTZjR/EsouN8lMg==;5:iyCeHnmfH/kz6/TyMCUofRgaOnH/98IPDx8XdvmXSglXRtb3j+QD6/6t1W/eFZyP+3qJrb4w58TJWjKjpOwlPeyMQ7ZfhO1uX+cixBom+uHwxnjVnfM9q3WxGAuguHFfluvmayO72St7YmWC7Trx3zMfVsVLV/ROp8Wq4PXKZZc=;7:cE9mbEdDEVHTncBBNW1Y5oLoDPo+PwZJbYZoUYxkBfK7TIAS0OeZQGX1Ie7NETaXcv8R8MIHoo/I4xKdg1w2q7aed70AAV0vJc4c68AxWbauM1Fg7P/mPiHRAFNC1SNcjZb0qxXMbqD9ciFKi3X+KgYq141dheNvorQW+5Ee065aqZAqt+dlktdwaILjvHgdCE6njlgLtLC/jizd0tJgzVuI6WKSw4FZxdz9V1DYQwPeK0zFErkH9NKI6xXrxkdj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 09:31:16.6056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4531d2-f048-4a24-c348-08d61312567f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
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
 drivers/input/touchscreen/egalax_ts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 80e69bb..74984ed 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -164,6 +164,7 @@ static int egalax_firmware_version(struct i2c_client *client)
 static int egalax_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
+	struct device_node *np = client->dev.of_node;
 	struct egalax_ts *ts;
 	struct input_dev *input_dev;
 	int error;
@@ -224,6 +225,9 @@ static int egalax_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(&client->dev, true);
+
 	return 0;
 }
 
@@ -241,6 +245,9 @@ static int __maybe_unused egalax_ts_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(client->irq);
+
 	ret = i2c_master_send(client, suspend_cmd, MAX_I2C_DATA_LEN);
 	return ret > 0 ? 0 : ret;
 }
@@ -249,6 +256,9 @@ static int __maybe_unused egalax_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	return egalax_wake_up_device(client);
 }
 
-- 
2.7.4

