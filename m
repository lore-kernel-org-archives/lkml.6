Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ECFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C142087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="eZAOB6A7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C142087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeH1UcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:32:16 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23424
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726807AbeH1UcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0oYoOBShCSw0YgehI3Jybwdd9LgUrBrFujEhGyo9Kc=;
 b=eZAOB6A7ocxvGERnz+UFO8fQV+gpqwUGvzPQhTM70Uo9FDMiv031qnqEr9oY3ABceMnCkXVOXl0VXcj5CRznFz0+UI7j4coELqfuhVW2V+tU9gSazN0CrpCT68pb1NbGyaonTK6pe+YmYOjHwVlUl+Ufa/ERhG0vdnN+bHR5vHE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 16:39:43 +0000
Date:   Tue, 28 Aug 2018 09:39:41 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, keguang.zhang@gmail.com,
        y2038@lists.linaro.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rtc: mips: default to rtc-cmos on mips
Message-ID: <20180828163941.ztftznl7q4745u7f@pburton-laptop>
References: <20180828142724.4067857-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828142724.4067857-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To SN6PR08MB4941.namprd08.prod.outlook.com
 (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9725504-1cfe-48b9-f79b-08d60d04dba0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:yFT4cF2Ci/Z1OCu71853ixKbDP7S1MI2uS6cYFKSLGQWtVRQS6f6yN7TpCPLxKRdXGbZ2gi0JFLcNJ910oxiREEp6tB39oYBK/6IfQdC3znIPmnprwIr0PR74bmdO7W+A6VN6cLgdGE1owbvqG9afqn4SGrJ/CHdYSnMZDg640rt5VvGyKAh2ePhNH1snEzbc8gtREILg91PedYsfXlhb6kEpffhFc8d5vW9wiIWhmbOH58IQAuOSf/pjsu44gae;25:p/KeMmUJ4f9JeUaQtfdXGP1jq+UEsX0yVeS7IgA0uzFP7XvpF32V+mvoUma+cLFGi24YyU9Dpja6cOIPgnvHIGgrLIjrd2NWF1lIQsDuYFtC54aSg7fNUJhvkgz27g5AITfUrtnfmKseMzUcYZZQ2bzd+6hcasxtb9Tj9WSzGS/ckDavNVUpE+zvmt3swu7rxqhDN0rTSqYdBafus8dmMl8+H2iVvnjRjS+E1e9TvYU/ZjSOPD1+ZC05pyEqElCHX1FT47/S5GcOOesnESFmtX48mcDH4cYm55VxX3dCWH9FU8vs2xbUT8gtsZ6Ga68T+2/VsgNJ5rnB9NRSHC5EOg==;31:9YLXDVaI1SvgkqodICUsEnxAX3A1xXaWwBXn13daJ6W0S5Rjq+TZjvQHlmIhlYJJngPN9xV3q6WPLBZae9sFLqLrxVBeJcHeQMO0/UdmrKhGWGBK6BBqYb5FcX77sIPwAOOWn+RpCYW57FhXUjM8u1baX0W5cqHzsitB12CFaWNkOBcCys8kLR0o0zEh5xRYFhuHvttb6z4ilVkg7B43CcnTzt7wLBqHLNHBjyYCjOQ=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:OUiq0YW5WA2quY6punMDJSGhVktVTYhTtAhGmfXV36Zof0t2uLrZc0PWUeVX5xHS7wId7OHV7cdydyZZ4G7q5vnSjvnNlx2PtC1BZRz6Uux7HC0hIvDa8di534Tyfb8WP3MPHRmaQMO25YrmBh2vYvTcOiwxbbdbYwH9oGt+XxLKoqJrn7aGnVHtzm/I3EAz/e0EJzG50sO9DZb9LtXUiQFLiCVEMfUPeAiLqHXrkpmBdnz4l6ZuJwEaqE5y3sHY;4:QchtRnkyP/dV6fd9wBnppp2BnRGDc6w4D54FYyIgC257dTV1xUdngB1GghfroTKIOYBu4wdpZ60lnf+Huq341LKvaBOQf11VXc8keaKk/g0po+9/v21RISWhfNjmUD9CEb4bn/bakExT4C6YOoexv6S7zjlzTkpiwjCHLqbQT5NXVAm/LRGbWYhm+kqPxTVJm7xQVZr/lwPiUCu/PIZ0gvwVcC1klEpw5jxV6j24z6RP1Ynsr0c/Rh5H2eiZQQ9S77Ha2NWzVd8xozO46DRtPw==
X-Microsoft-Antispam-PRVS: <SN6PR08MB494185BA91561B9CBDD022F0C10A0@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(136003)(376002)(346002)(39840400004)(366004)(189003)(199004)(52314003)(81156014)(16586007)(7416002)(386003)(26005)(106356001)(11346002)(76506005)(50466002)(66066001)(47776003)(105586002)(4326008)(6246003)(39060400002)(6496006)(54906003)(58126008)(42882007)(97736004)(8676002)(186003)(16526019)(81166006)(486006)(316002)(7736002)(25786009)(33716001)(476003)(956004)(53936002)(68736007)(9686003)(52116002)(305945005)(229853002)(3846002)(446003)(23726003)(44832011)(1076002)(6116002)(6486002)(8936002)(5660300001)(33896004)(2906002)(76176011)(478600001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:bqPIbdr34H5Cx8JyO3hwIaDbvxNVKlX4lAIAdACJW?=
 =?us-ascii?Q?p8huiGwFeh4b4Ur5rOM8uW1+Vx4zW+aB8pcLANzxBe/Dd9wjNYUxuwZo6uv/?=
 =?us-ascii?Q?h6e+Hg+2QzqhVHkEvNVseSzDeLJRUnZL0DHFEyivQEDSBJ606ro3PBMsI5u7?=
 =?us-ascii?Q?BVdqe/bHtcglzSluqQx5aHwDdG6iNMty/oLisO1eIPmYx2FhaXRXRcNCmNz5?=
 =?us-ascii?Q?sQ2sQjney2opzLtKYbqva+tkC1Dpe9V8wlPWUAaLbxEXp5efSJm3yQKohhMD?=
 =?us-ascii?Q?4eiX82pK68eUFBYyRjXpYnZ6i0vYx2COTFX4uG5fZZLB7i3sruLmjNkuGLLL?=
 =?us-ascii?Q?0T0xBffCe9jPTgt9LfllXVhHvVmjsegxVezosMk7QdnTeM8fFRKAVw2rBDE8?=
 =?us-ascii?Q?UpSHW5S5AbOrmPj3bJm8o82lIOAcvG+PQCfF/ofsvgV+j+FqmYgnR18hCkyE?=
 =?us-ascii?Q?S2+MoSc6BKrj5dJTCbdiA3J1q1suVueRfzetibl3Hs0dDHUaYeZvuIYLCXeW?=
 =?us-ascii?Q?pJZDZjsHyBzPgWao0Mt6FeNmLUdKSlY6SDkdTEdgx7eICFepqPV/nHDXFqfe?=
 =?us-ascii?Q?jEAJm6kplUlqBhwEAwxjMX1+uQMDH8PRU/ot+JYYNNIk+xqE6nOUz8U30Esl?=
 =?us-ascii?Q?6o09rXOxvvgBV9Kie8n9+VNwFNzx6FCnD3KLhjAaEj4bm5z8VQ0qltWsSDSp?=
 =?us-ascii?Q?UeNJjRWGoHmDnMoHRkNzohGFUQ9NUcpgIghkAMSop5jbYqyVEDl5lOhzrWVQ?=
 =?us-ascii?Q?GEbUb9SpWfEQx8yHP55+rwrp06GXr080qvhB78UEIjcsZ9NqVBbnor29KRj3?=
 =?us-ascii?Q?a356XgKO5wCxe2+BSo8wESgzbYv2WTCxD94Bt+F8GJfkrdUZ+jVimLAfa1Ht?=
 =?us-ascii?Q?2WPdemmBUDRnApFxckswWaYpE3OMo/xwMdIGJ0EjxQ3LCzSu/jsjfuBJMuIh?=
 =?us-ascii?Q?/JpkkA3RBLntjzr1Tlxe6O+DObF45L5AXcfVV9kSq389CDR5mVA54PMqoNX5?=
 =?us-ascii?Q?6q+yopBgKS7b3CipnuV0RWuUZSYBsedkIyC5/MlwzwGk0LSb6kZyXZFNQ9G8?=
 =?us-ascii?Q?Ry6XjB5JQ2BhoVTT4EjWIainGTh8MaD8o4REvSIWcGSVba6m669cQxyPOSRP?=
 =?us-ascii?Q?wT01Np0chn8fBVJVp/50Uu+TiqnMfjXtRyKSRWi/RwRsg8qAlHeM+T9YjafC?=
 =?us-ascii?Q?SsvwOFDGNZDDq7DjeDEjRcaLQN40VhgEhFVtiYNiHQ0eG5rpjYJgMiGM/LgC?=
 =?us-ascii?Q?RCiMdPE6T9MmEV2N+y6HgaJlqJ6KySiBSvnyczasXNGf7Hs2QieZJhplIu7b?=
 =?us-ascii?Q?lKabK2R8Cj82sOj0QKFHPEM9vBVRlIQqFqBp9bqJYHjw/BR/goBluWW9hK9f?=
 =?us-ascii?Q?0kvsg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2lcbpjqi7zGpRGQ48J0pQ2mPl30odg4/UQReYNsOwSswqOg9qBWE5ghDCCREWl1epZxeRkMab90Y+WuGD+nvCDjZgcjzE+t3o3WMPTtxW0c90bgZA/TVz8pEz777iAr9v7DW/Tv1F7SjvyWkDyzOUpgPZJlXFi0g1sEMmSIbB9vKlOjUj8PcDUzFtDLsK7rToLXZ5okGEYhjTO1RYWkEyKu0s8Q8lMCguUGcru1HzjQXA/K9678Djc+eCASvz0+dR9a0FviZpUWVh2VrqJ+kGy/dxkN1ZlvNQr7XUHEkGiIn47RCNXqlSFbY8HKlXc8fDZIA92VHyKSlA953rpz5ioTcjTG8CSY9WHUJXQWg00U=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:Lc1fAhwzeom6n6e9gWc3pNVrGtCGujD/LtR8QhqIFszL8hdls4RfRVPW6qb4hPjp4gifwz9Die8MBvdTGtffkD1AXKcT2wyI8m2ZSwwOc5izTYSAw6WrTwLeqVZYRiLC1PY+Fk4c681Hjvg5Nsl1zu7vHZNqInnMvqILEAi022JWY5Ze4VVYXXroBLXboUFz801dBlIbsT2+/7Vyv09xKNfg7XmhDNnvwfBUue0hmXpgG0oCRTIEnLD35G72uNe7AQ+yaDCri5YXVUU1demn9CK/PADcUceYzE5d/BWFzk4AefvgVSI/v/X2ph6sja+CirHMHUruOFWwapngRMNj3JOxGdtaHjgUfSHsbKhV8PbF/i74ZKDzql9hRVyZV+2GstlFmj0uydtL1dvYT3BZJAsY3X70lXwzmVSofSd39AK7TDTMW+dc2GvgJEW7P5Tx1naDnpeMlSoS3ke9P3Z6QQ==;5:w5OOzEezSGDQ1FTq/Ra2mBY2o3yWMYPNM9vcars336iwKapMk22lviFR0RePvGvrJplHv+7n5DMf2PKXeO9lJXSSnEdnUcIM3s4TuYACwd0On+TRjjvivOUH6y8QcQYB59Wv8rMf1CdoBS9vh4CukN7LWwq1mP0RXSpr5MSAjt8=;7:/du+3+zoUzofo76oppub3EtTVcI8EHvbf5JtfEcJkSmvuvvHBG5IK147EMcBLZRxynIysxhNTLdxry6SNhNndxASW/8A1yT6uFUWw7GCI1fp7ey8r7pVUzjALhG0KfurgfRJQRJhyg2vddbAkw8ui4QNAa/iCKlYn6QIYbwfVnsmMR97KMOelCbR5iOj/dtAUNd0lSd5bFaPRmA1lEB/A4p4/vtV6XV3xGG3Op0GiBi79IJiGodohphXub8Eiqeo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 16:39:43.4072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9725504-1cfe-48b9-f79b-08d60d04dba0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Aug 28, 2018 at 04:26:30PM +0200, Arnd Bergmann wrote:
> The old rtc driver is getting in the way of some compat_ioctl
> simplification. Looking up the loongson64 git history, it seems
> that everyone uses the more modern but compatible RTC_CMOS driver
> anyway, so let's remove the special case for loongson64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/Kconfig    | 2 +-
>  drivers/char/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Looks good to me - history suggests Loongson's RTC needs to use binary
mode for some reason but we've had that support for a while.

Presuming you want this to go through the RTC tree:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
