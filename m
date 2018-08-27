Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82FA20671
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=actia.fr header.i=@actia.fr header.b="WGh2I+qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82FA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=actia.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeH0Rqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:46:53 -0400
Received: from mail-eopbgr90084.outbound.protection.outlook.com ([40.107.9.84]:63875
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeH0Rqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=actia.fr; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UvbPQew15ROX2WOCgBrDkOg8AzpikZWF6593C9tx3I=;
 b=WGh2I+qnji7PYgeSEDGFASRyzmMxq2u+7YsDFwdatDXJrgxc+FPuO3YlpXUuVueaIad9UWVeXdlVYmoS77YblVKQYu62iO2rHeire48GenFaJwwStLEaaLMHmZng5MyJqDvee26IkRup5JS+Fpbh/pCdYUi+ZsDkBAxE/qla26c=
Received: from localhost.localdomain (212.194.216.83) by
 MR2P264MB0051.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 27 Aug 2018 14:00:03 +0000
From:   Nicolas Adell <nicolas.adell@actia.fr>
To:     Peter.Chen@nxp.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.adell@actia.fr
Subject: [PATCH] usb: chipidea: imx: enable OTG overcurrent in case USB subsystem is already started
Date:   Mon, 27 Aug 2018 15:59:56 +0200
Message-Id: <1535378396-9328-1-git-send-email-nicolas.adell@actia.fr>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [212.194.216.83]
X-ClientProxiedBy: DB6PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:45::29) To MR2P264MB0051.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bbc7044-a3f8-4a24-d1d0-08d60c256364
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MR2P264MB0051;
X-Microsoft-Exchange-Diagnostics: 1;MR2P264MB0051;3:3F2PDmS1LtfwbU1hO/TkmYWaEAMj7aLL/Ct+P/3hkMzUvQ2Fl2MsrtyD7HZBK/pda44B6ZQmL5jTOYUNtJdBMG9yKROXsUzz6x0LH4nACpk4/K86nnWSUCijgZGxUouKcSe5EfhnVjTg6nozHfsY+o+DtSrHXCZTRDeds++veANR5bRhDRQctsT3LLOFagtMq8Mo4ucI8En66pjby7+zRBEzd4GnLJJBee87MqJDsWpYq/MN8cXq3Sfuim6yAvPl;25:boxYxw9b4mgueATg4MSr1OkYi0KZSpeo6l5Y3R5zrBxa8v8S5GNaNDyYPjOP0knT1cPUnKsKEWjHBUfx7shzxwUO4itI8WL26zOKKX3qxDslSXpEylBtLlOQxJfjbRb00YkXPS3F1uxHEKVYgjs1+OwjY42tIuEZsQ0ENR3x+YLzR7nlq5GTBqd9pIemAgQVJM7Y9EEFJTSS5lC8lsEhg67C5vuX1O81FJTeL8V7NkWp+DAqZDXGHT0g3COJiHpKtuPRxSvKI7vPJAXQEAEN4PbSjQc2C8mhlf3NJ80tMAR1OHCQAAyj2g+89QWX0C8zUDKvfSH4dSjKEQ88zYXEFg==;31:/EHyFT2cvTCBToozvlVpLNioCLQkiXz0AGTXmtSJCwht979m+L65hbHq0LZWHBSzColQ2RGcvWykcIjLMfs5vpxhjfn2TXJCaMfvpgD+h3+u+05Dqm+QV2QJoB/jwMTC1sUU4WW1XrvcQRb9FycFXunz/uChZ2Rg327YhEeNCjNM7r7bla0G4Ftr+SObulgbuCp/PTAU2ITzHZFbuhp/GEw2SccMblivsjTCfETyFGg=
X-MS-TrafficTypeDiagnostic: MR2P264MB0051:
X-Microsoft-Exchange-Diagnostics: 1;MR2P264MB0051;20:K77jOulN3WWL6HXH14O89NYKqTyVqafWOuZQ7qrmVN58XpvP+jeqRLEPQLinwT5q3m+dMN8RA/mMcFhjR4LAA86YZnS6YG7Ao+LHIhCtW8qEI51N9FW1hyLLFpl4vX+s8RyfTVDBV1hqCCqpoHNWdm0Gg1RxJXvzP2hkKexp6Zw=;4:DbwZBAUpRueyxPgfSstfDLdrGIrRPYnXCI6yDX8TRsr4vjB0XynZzwYTKu6seGx2nsygIpMYkI050+GKHL4QGyAY+Ii8QSIlNlxojXSkJb7iS9h+KixcnalUkes3WZQPUrHRFDTiDTv75WMKFEAGU9f03QEJzlJZyWorQ9pBoj6W8wOGkOxvNp9PDcVmBkQGUsOkaeJ0DS4UaFlpSzDb7LBM5Ivma9qrc+XiaPmYA9fNn5yfkMYpNaSjKsv1ApUHFJd7uZCRwrE89TW+zqqIiw==
X-Microsoft-Antispam-PRVS: <MR2P264MB0051A8F67ED99C936C8BAA99850B0@MR2P264MB0051.FRAP264.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:MR2P264MB0051;BCL:0;PCL:0;RULEID:;SRVR:MR2P264MB0051;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(136003)(366004)(346002)(39850400004)(396003)(189003)(199004)(14444005)(6666003)(6916009)(105586002)(478600001)(5660300001)(6512007)(106356001)(48376002)(53936002)(2361001)(50466002)(305945005)(2906002)(81156014)(74482002)(7736002)(81166006)(8676002)(2351001)(36756003)(86362001)(486006)(6116002)(3846002)(316002)(6506007)(386003)(107886003)(4326008)(16586007)(956004)(476003)(97736004)(2616005)(25786009)(8936002)(68736007)(6486002)(44832011)(50226002)(51416003)(52116002)(1857600001)(16526019)(186003)(47776003)(6346003)(26005)(66066001)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:MR2P264MB0051;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: actia.fr does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nicolas.adell@actia.fr; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MR2P264MB0051;23:iHvKaEZs2ngUz1NVDPOUBvO/BgTR+qsyxLBG6r04V?=
 =?us-ascii?Q?2IMn9UNkhWDxSCJB9sAQz1kJ41zPgTFVoleENVjoTFvAqPQlbR0addDR0YKK?=
 =?us-ascii?Q?C90C8nkwEGyDilIRlOwThJuxvvD7iGKF/PFS4yNQmMQlg/5fmv/NYgWVOojF?=
 =?us-ascii?Q?WEI7OGcHX4/f1kcAHhT9JwrIv5JpVtNO4KypBpL16ab5+8GOXtn0BVnb5CVR?=
 =?us-ascii?Q?2XhwAcHi5tAeX646U1P+l18t3sVbxnpVCwXCtV6K1mh4Gif8fhdqtauQtkpH?=
 =?us-ascii?Q?djgMG19uIqagVdz9iDbnpb4UXW8F20m0LOR0dJlNrjlZmi9c2Mxshn1TGg9R?=
 =?us-ascii?Q?plRldE64B+hswmBQxppJdNrkNnW7Pr8m3kYZMe8Vwq/0/1ZaGbduxWNlLq0G?=
 =?us-ascii?Q?6SyFFRyyLbo3CU8xWYeu1hQVMHAYz5OzFcWgaqiE6AxQoQZk3FMGN/yDxVKA?=
 =?us-ascii?Q?hVI9xfuRt8k6AK2A5E3MP60tunIcoan7c0dtfIGOd+0OVgFnMNHVbgs4yOyM?=
 =?us-ascii?Q?q/5O5oqcldtSzfk9HCqf5KuNhIHe52vLPsShDcDNcW3qIKhRxafZjGhlx9PG?=
 =?us-ascii?Q?8eL1rSMATEuCzvYghZ0YTCq7vinHEe0fbmRmI/e9M8uLarE5hOaX6ANvDWup?=
 =?us-ascii?Q?OwO21UgZ5+skAb3I/bipPH3w2lWxTmRsY12cZrn3GxBkTCKYmpnObtp4/TN4?=
 =?us-ascii?Q?5QuoMq7ZDnMH3BdH3M+PRHPDTPh/X5fcv8+ze+0Ss+FHY/WSfW9LOdf8vzJe?=
 =?us-ascii?Q?LKW4Z5gF//2ddYSf7rLyFq0Tpm1LID54V27iS9StAugLKx7FSSyN6b1sOMyJ?=
 =?us-ascii?Q?zIfHar6mItCJxlBT2c725e1+a7ZCa4N2nJK9Gk5t/6kSjfImUTeV+YWKgC3o?=
 =?us-ascii?Q?Nv27CXt3vWkioQZMiKJfhq0rc1MPMd9fPhJHyD+/Y0d4XGA6HcsyC9DZ+311?=
 =?us-ascii?Q?FtWzrf2jb7AW/V8xxr7tuJnlmNJZ/P/GzhjGOG2sJvJx/qm0IWpbQ56NWN/f?=
 =?us-ascii?Q?UOAEcBXrcbG2fa9j6KVlXPtuYaSpOAM0ug1qF9fODjSPbATz+NF8iWYI7bQH?=
 =?us-ascii?Q?TCGYh2e8kvnl0SuHhhZAB5PKqrr3lSGYzhtSJ4ckuR+06WP4O/FkUGMJuB02?=
 =?us-ascii?Q?zYB13GsHZ+SniZR9weremoXhNfORUIlwr612fcAAMDHl4npq87cYrrrZ8w8O?=
 =?us-ascii?Q?zXlEJJ+xAQ53mVuBXfcBM5zHABts3WG/bkIzCNh8+Tlv78vxnBC0CPMJ6ZWM?=
 =?us-ascii?Q?Rx2k+T/txziKzU1ovqvjdt3SPpQf1lrAlSY+Ub7kkq0aje3353b2Mze1z6jb?=
 =?us-ascii?Q?zioxPWKQcLY1Pp31GNoMclkXjIBHY+h5AX8Ez1UNjyU?=
X-Microsoft-Antispam-Message-Info: obW5OtT0LMDc4ypZR0kZmWAtn1MS1TIp4Kvf7NikqWG7neiqNg8rRO3JnYH3gnhIHMRJpl8pTq9NuEuIqXIDxlCUSGQLCb6UZcvVCVal4I6nflkGhBR86APxpv81S9vcfrTz+5zW/uRb4vmFbJs1Sc5wvzSgME1g4TnW2MTrwRZeak/7bqhcWBLCAS5nPaq9vVqGi06TSbZHOlETYw/uxPxnRhjGSnxAIkyLGGZZjcXHPo/MgDVlM+4AV1rjuKr0//dcOMUOMyVyszwqfnHRoqD8L8oGJpV+SyFpoqviWuAwjSpXZVROdmuHaubJ/iYZsvVv7+ssBYbrjcZtmlqxBpGCrTPcbklZkR/JweJqr+I=
X-Microsoft-Exchange-Diagnostics: 1;MR2P264MB0051;6:d3aBYfjZsD8aDyofiJsIqSHMp2ns12LvytTuqqmbcuF+yQM22QPFoFAR0LMR9NyaOiFBQ9cpUfzp10Muycwep4vKikRAl303eMv3hhMbV/veApFIkpX9jq46ybJ+rPxAfKeNOpbQn+EfmoLx70IjMIu8VU2HBH7lYGn0ug94mI5DSZtM/ETXe1QsWsH3rm/Quj2WMDqwrsKpEcdF3XN26c/bpJgyBZpGu1rcTNqF5G5decq/Nv4TSNua4aHYU/acGOYsuuZCvC0+Y+TO4Re+mGj5t6o4C/dBm+SL9VsqrEMoWHwb2+5559k23+0FD6fXi6hI1y9SAQXk2KUcoy+JZvDs9bIYVmtyysceom8GTEGAI8wFu+8nWbkvqCH7Rzm6XUSd37Meqhz629b2Xw2yQqOgTJ9tMlhOjwnele44CLgrMcCjmGpLbWd3zq+iE1y2Ad3xkjSZa3Qwvfk0F9AKsA==;5:kLfdvPQzhTVNMjjwLGdvGdx+zROnNeJO+kiYKLZc6QTlqBu2SL3rtqQcGRiT2bIXqLaXthUbwThC3YWhgjCf5A4zeUxFKbuv/sD4CQ0JGL4F+6N06J25pZxMQ01pdauojRI56cJYqxUidG+CIyeVqkEn7eyIL9Vmj4thnpGTYUI=;7:RNu4GGpFke1yLZFOwFX8sWIrre9MLlEUjNhCK2IVjMemGkixkMPcwUuVZPU3Fv8t9mMXVMVWqRuZ2cmOoc8/kj8tb19qBbv58HUSwwyfHmcQPH49N4tljhQRnog+lVLsEqp9S5VXNPRdAv58KsDj2uot6IVz6lZ0QkzzVSW+j6an4AykSyxf2ZpS2Y38QxUloTzUgF9nkytgzqX9Du2EwFPuidNycStFaw79c9hOQzAjJtryceIjVZXj+sCqv0x6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: actia.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 14:00:03.5335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbc7044-a3f8-4a24-d1d0-08d60c256364
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 86314f06-03e8-4460-82f3-a44f992a19c7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR2P264MB0051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initializing the USB subsystem before starting the kernel,
OTG overcurrent detection is disabled. In case the OTG polarity of
overcurrent is low active, the overcurrent detection is never enabled
again and events cannot be reported as expected. Because imx usb
overcurrent polarity is low active by default, only detection needs
to be enable in usbmisc init function.

Signed-off-by: Nicolas Adell <nicolas.adell@actia.fr>
---
 drivers/usb/chipidea/usbmisc_imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 34ad5bf..424ecb1 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -343,6 +343,8 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_data *data)
 	} else if (data->oc_polarity == 1) {
 		/* High active */
 		reg &= ~(MX6_BM_OVER_CUR_DIS | MX6_BM_OVER_CUR_POLARITY);
+	} else {
+		reg &= ~(MX6_BM_OVER_CUR_DIS);
 	}
 	writel(reg, usbmisc->base + data->index * 4);
 
-- 
2.7.4

