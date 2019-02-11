Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82174C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A1D21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Mq48zZ/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfBKOfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:33 -0500
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:64150
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730195AbfBKOfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn5dlR+B2td/Ngk7WZ1AhB7SCQ1Guz2DCmtGHTntTlM=;
 b=Mq48zZ/A6o46PnKiNhTRMnpfTPvbrJZO9lLmyYKjl7nyxWN7AcEu66g5YABBMwwE/GyrXTuUDt8lFGNbv1TBKFZRtG97rq9D7EIK5xX/GHxS8L4R0SKnb6xdZLLi1+EnTTxZzVZ5r5+S0C1dBWaa6hP8ONat4V6aiHu5SPM1XyQ=
Received: from VI1PR06CA0088.eurprd06.prod.outlook.com (2603:10a6:803:8c::17)
 by DB6PR0601MB2151.eurprd06.prod.outlook.com (2603:10a6:4:4f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Mon, 11 Feb
 2019 14:34:48 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::207) by VI1PR06CA0088.outlook.office365.com
 (2603:10a6:803:8c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 14:34:47 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; lunn.ch; dkim=none (message not signed)
 header.d=none;lunn.ch; dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 14:34:47 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 15:34:36 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 11 Feb 2019 15:34:35 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Andrew Lunn <andrew@lunn.ch>
Reply-To: <federico.vaga@cern.ch>
CC:     Wolfram Sang <wsa@the-dreams.de>,
        Peter Korsgaard <peter@korsgaard.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Date:   Mon, 11 Feb 2019 15:34:36 +0100
Message-ID: <17223650.b0dSvDl2uj@pcbe13614>
In-Reply-To: <20190211140138.GA19023@lunn.ch>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <20190211102424.5xnzyxvfd2yhf6ui@ninjato> <20190211140138.GA19023@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(189003)(199004)(44832011)(229853002)(9686003)(4326008)(356004)(46406003)(86362001)(446003)(6246003)(106466001)(476003)(126002)(11346002)(47776003)(486006)(426003)(53546011)(33716001)(33896004)(7736002)(7636002)(305945005)(23726003)(106002)(230700001)(478600001)(43066004)(16526019)(186003)(3450700001)(76176011)(336012)(26005)(316002)(9576002)(786003)(4744005)(2906002)(74482002)(54906003)(6116002)(8936002)(6916009)(97756001)(8676002)(246002)(50466002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0601MB2151;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ca022a-6aa8-41be-4e1e-08d6902e12d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB6PR0601MB2151;
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2151:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2151;20:jZiz593bvBnKVtpMm6gLzeiw60tZ7GH0miwfjySmnMieKRqd8ZIB5TR+4EPdxTN3enYTErXAcPifkpguFhKpdgSn7FLcsepATf/onf6dSrbv9CseZZ12/WUWF+u13zvtzelg7zBEyStkTc/QlWtTrLVP7gNp7ZhMB81JLAfdzSsIZ/BlKsngACMFb5PAwWcdemHcBZpeYkiakNbrhHISDxiSxIw7zxzcouVfmed0CTq0BKudu6tMiRvF8AB8/mK9wh1RxRbwcwQ1+XoxSLJ5sBUSR/sSK9VR53H1KqR3h0gAub02jAaUSS30/I5gQRwRyjniH3nY4tUWwMCpItgNML8VJfh27RLnC2kjS+613Ril4ng2sPXgqpI5yEUVEx773Xp3M9HX0u8E7TptFUZvWbE4JMsVmsNI4+k5Ym6LV6UGwqF99utswqeWM3uK/IYeeCDxQH686ZtJh3g5jfY74OMdsGVnQduhC9e7e1FnSS0eJnM+lG0HOtx5K81sp907;4:1PWh+fdDizJmCUV++MskId9id+qag2KhyJWxOc//PM27iAR3tA1/G9fSwaq0K1KymrR1/MjblMV0TqiRjEBeVHQ+gAiaclRTOkFoHUA3j9extVt3nLB+b9VDomdd4II/keEu8oR++9O47HU63YKletfM0/4lwSe1pNMe3/660VfrdBcr6CfLfGRzt6FwOMYVMXvcVqKL64H4SErBP4BhM0zGH8fp5UzB88TJBCIi/lY+0RHonqOm37Ex5cpvJ/rEqrY14ipTrYwGzaYqwxQ+toX/4II0lhPPxfP020xQKqJZ1QEKnFUYtPq7eFtBJh57
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2151D93D149C496918FC212EEF640@DB6PR0601MB2151.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0601MB2151;23:kCm10mMKYia7nrwCDtNCMMzoUqtAkFpYeU8S7X2?=
 =?us-ascii?Q?MYlNFNbIyPUVpdW74fAw4adW8yQlGHFpmrQKQxM3rvwWzo9MOben9cpZJaI4?=
 =?us-ascii?Q?YgShwsAT5OGnQ4kAHokczk6kU6HwYH9+zWi/Hj4k1cQcUmdjb7DzXJHJVWVU?=
 =?us-ascii?Q?XV0rKoXbNkxtPepE1/rYbcPltFZMpzSQeCf1glxBvjQWuRNMvOSRTKyXIa5B?=
 =?us-ascii?Q?1YkR5EZz/uQ6YyD2m+0tqVLGBc5E6ojU53nKkmbej5VAh+iKQDK1qc0coetd?=
 =?us-ascii?Q?I7zp6xJ+Mc+r6oUMKWHl+i4MqQPR9w39GEa8D10orhfI2Ct0d2+85E9zhUjU?=
 =?us-ascii?Q?nMJgaTRAGptEsNLJSaO9YVPcjZlxpME4Orp+mZCiiKD954LhKaGzb9CV7Vvo?=
 =?us-ascii?Q?GU4xJ66sR48NxR67XgvFeIKVdjKJTGPKcf/T8Jd4QJFIXahpC6qGQm8WFlRt?=
 =?us-ascii?Q?CgePJzssmvUMh6lxtMkZgkGVc/PonWZGeAUjAgrz9JHonrZAb668w3u8QvFS?=
 =?us-ascii?Q?e3sm739rnrl8AGZEr+rpNxBldzBRbfKNBvcUf5ClnxZuuUGnUvW1leIKxfrc?=
 =?us-ascii?Q?7y4FR+SJ0k1o13h2P84XufoWAuWRqJx/ncU6DYWdBmChetR/FAZahVDJk0JB?=
 =?us-ascii?Q?s8U054wmVmflG7UhKqTSzs3ubuoFXDwjdIxLxmWkAL9s8YaLIAqrtFhbf02k?=
 =?us-ascii?Q?E3heWq/A2pMVn7jIFtchin5gtb0AaUWS/GrAAQm77qcz0hRU6rJo6AZRQ/Cf?=
 =?us-ascii?Q?L1tDqxUoEM5Tr4Ts40oenpawGOBDV99s9sncMnRysCmpkpcSihBoLMUvKfqQ?=
 =?us-ascii?Q?2x1DfKoK6cft7IYYBVHEwhnvyAd3A2WIZAGuK4HvFNfVk4djUhN6C4cwSQa+?=
 =?us-ascii?Q?yyg5fg5faZKULzjYIoHR+hMTYmiK5Zk0UokPR+E6B3DbKcSVpEDz1GY2+QbX?=
 =?us-ascii?Q?DBZ0+EbzVDJzCG0ZZ8+rfMLTlzy+4KfqNeDygo4ywn13PbAPuWv/leUap4o4?=
 =?us-ascii?Q?mWrDWj8omC+qI/K1qeitfQpArkMRKwgw4q0qah0dHeEG9aSBVzMhLWN7snjY?=
 =?us-ascii?Q?bZ/oneLNz1WUVPhjC6OcCGmKyyPxlKcztlfyBu6ceZ2eXB7neJYJAvU4DLw9?=
 =?us-ascii?Q?PkW/X/MwarpOXzfrociZF6VEou4DBX6W1C6lrTbKAUGzCXDxNZV1EHXeLal9?=
 =?us-ascii?Q?UxJfQe8405LOsMOiWvchyxfiNl50BJlHV+EU9Pgxr5aIclgDN2bMy63wucQ?=
 =?us-ascii?Q?=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UjLe9hjLvf/FUjtvkPJNOsG5zR9DJjSPMMS6upllFEE7U5ovTdSDP2NIs4J/rKXjWuEp2+0ZGDtcFnTWEHt0LZNTrrEXHOt1uqBYTJUDego83eARIRaRTW9tlsw40efNEahlEy2mSW/vddd8mYUHmH5pnFFvdsY7N2DS68CrL8YrNH+Y9FW6+52ED+zQBW9us4e3eqFJ+ov4URwOefEQoBnGqFWDwLnS9Pu7k3cejJtYVDzPGeX59qkG3sAGgDwruUxXwQvKwoY8CGOj9jRLdhWo5vX7lu3pYQOPkBHZwM+MFzthFPQhHMRd3FwRyuCvlQg3xToFRuCb61Xmm0+MT41bQTakxGOGhIBfsvUBuPl1nNMJsZAN41xGAqG1cXbPFS1DYOTdRO/3EXNj+JTY5YN67uqu6Lr40iMGxmunvNM=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2151;6:m0vj58OTYzW7Cg7CdYmgIiFqTifRdLXIitJm5zgnft/8Wqwy9Zg6qWMl1ASpqcSxxOPA+pH3c1nm64TPVC/PWO/SeFxmvxJxPMdpQmREvyJjnSql+6vkintI+vLTUPGT5nShdakeUrQthIZ40KEmhoHBGZpJEKgKDKW1YuhjPVV20tUQf8iJp6BvlkcTv4f8wgtqepjji0CHV7PBh/3xhw8Nh51LnCguF4Ddsvxxgk+SmZRBNqltwRTYMYwJyFJy//62G8lMOx5HP8mhsG67TfXsFv7A99rxVykL9mDK5O8DYEL9xpky9aCfvDaspOLJhI0JYiNsBKbVmKTotgew62l5ZCThvHMxhbhJWsQeRVs8U3rXxgmqP1+TP7T8rSY1yKMSmUV0IQvuaL5kuiHlSyf5qMt/mdxOImjz2txZv1uVFb9/UeTv6zimh67XC4QiosXtrS919zCueXTwu6kHqQ==;5:zsJ6LQv2pkwnOHStHLT0zqZwle+7U2gdZQhcZN+8w1muXTdkaXMqR6MQB7P/LnBAFiaWPE62yZpQUKJJHHLieG0td2Fv2MHSlGPXcuaZzMQwirf1ef5ApRAeqBStKpnxutMyXUFMZCZQQlofzA3lf5yiseBfTAbSuGWBZCkc+aGKfMH16c5vgbhhXANEH6EggfPint5CzE0Yn2AVJ8wK8A==;7:eWiiwjwRYbqaNeqnkQzHk53/DHcDioHbSWZIrZ6+dsmFqWLyokit/8imyyKuQJqCEuhM3b/aXHpYjde+4/ijsR3rG9SnbAnq753c4tBtD+Lf0zabmlovH5ye6rKGMI3uyLZNn194m2UT1FCxLge4xw==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 14:34:47.5691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ca022a-6aa8-41be-4e1e-08d6902e12d6
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 11, 2019 3:01:38 PM CET Andrew Lunn wrote:
> > Applied to for-next, thanks!
> 
> Hi Wolfram
> 
> Could you drop these patches and wait for a new version?  I don't
> think you have pushed it out yet? So it won't be a visible rebase.

I will wait to send v5: full patch set, or just PATCH 3 and 5 ?

> 
> Thanks
> 	Andrew




