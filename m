Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A24C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5862077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ufgTiH8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5862077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeIEXWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:22:41 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:10563
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbeIEXWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVzJDIrwxiVg4BdKeNsDLlm+LWE5porY9ztnA7UF76o=;
 b=ufgTiH8ce3BaAnbAABvESPZ21Ke0hMY1wSvA7hHXi75E6DY48euCehxq/WxmqHM4QmLO/kmyVv2DoVNkxl7AyDPQrP+e1lCfHbDfjQa0Q0w9mIzNVyF5G6Z1DsprqH3NFa6w5OyUs6tkBmseSdqJLtqQ1tl3t2jyadf2FM/9WEg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4454.eurprd05.prod.outlook.com (2603:10a6:209:43::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Wed, 5 Sep 2018 18:51:10 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fxctE-00021k-Sn; Wed, 05 Sep 2018 12:50:56 -0600
Date:   Wed, 5 Sep 2018 12:50:56 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, op <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tty: hvc: latency break regression fixes
Message-ID: <20180905185056.GF421@mellanox.com>
References: <20180905121439.23809-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905121439.23809-1-npiggin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR12CA0072.namprd12.prod.outlook.com
 (2603:10b6:300:103::34) To AM6PR05MB4454.eurprd05.prod.outlook.com
 (2603:10a6:209:43::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f560962-9c26-4348-555d-08d613608c18
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4454;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;3:vBr+bJLTzLAds0TOhZo7RvuOI8K8JIiux4Fv6pBUjdtwVRWlw2Ejhtjr45QNd6jyR2xmVjqkhSqAn2Bb753Clr2TzDbmMmIahbAuPDhpLjKndYAn5PQynUeQm2AIriHVv9seJ5a/QBn6UZqb6j8ZASVAI5H3q8m9zzociFnzrvhdfkwzX2Gzw2+albn5e0BAgYijtavBNz62FX9ZUV+1Q5WDHoHp5XBR4K8Ye6vBlXP1n6TjnpubXZ2uC48E3NZt;25:LZNPGklCsXTaf0mSJKz5n1cL98DXdajDlvJ9tXdWOoq+UBfUHDhMWaQ7ssaeZiu3ggOJ6yzPO5slLozCf6vIlzaPopBb498gKKc1eLsd+c3TQ02aP4KgtIJmH/+LP5dd0HFBOVizHdoM+4nwVQmkkVCUZgDU03aBmrLg0WV1jpW2bo5G1K18BCaws/sTpbH/H1l58ZIEjDAD3dgef5yh22hQk45YJCWupdmBWJpt60hDJNbJ2cYZxh2Ymzo5ZtgS9HZpJk9Ppei/jE8+/BiBjfHvBu3CfcjAwUAQ4Zt+4TTlK8T0MfnXfjfXUEQo03uhmezLaTV2h3Y2lMRXerGjkQ==;31:nD29BcK9yX5wDfIZ+H8I59JvgyeLfP+27PpE/mTjcXxOV12CF4M0GB/1obXjIvVcKsH7/nHiddTNHKq0lKOvykrSLTYuaimuxk3+2D2aJhiw1CZpqAjZpIKg+r8Xu1hj57seErXHI4Z+ahezY7yqhTG5fGL33iLYFv/Y9FGNDqS4DPYcZ0nlsr+bexrZaByWKrf3Dj2NtZ8Hzj5hZajCc+oX4xLgB1xPmx80uYTC1m8=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4454:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;20:X62nvMyRxgo3wUtIgWO7auDMnLE5vtHfNB02JWthV5rTnS6oZ1Gp0K8TmsHODqKVeYF5WFkQGI4xd9iHVkbKbPha6k2Co/zB91PpioW8xbBR+Fr8M4dyfkQw6PPfke0tBXXiVEz3ICRL5sclnlpPUC11sD8y84+fn7/JXnuMcpI9QRN+JNWlo3ObeJmyqC2mbZit/PR48D+F/ho+6jIHo0p2PM/GHjiWsWHRyfFuokXuDuLL1rURx+7u96isU0pPKbO0p9gfTdT4xeaL4nQX7BuQichETESVDBwoifY/l4uI3xyCi+GDm1Snh5awz+i90gdxxEwmCIU8Y1P8uuDnsO6McxBQjnWk0Jb4XSmkvJpQWXt/AI2vppdZ+1QTOjE0M46N/j1F3pk0gMxtd3vvUNO89MByNRkKd0MzXkgImRaG51OYQul4NuysE71SnWvCMvomqjU35bfQeZgoGJD9lpg5Dpz6cmOwGfy72ugkpkVc3KB2GMMNOYgQRUtlqfjQ;4:Ro9HKWcdApboD829PeVxK+jXlxohg83vD+9UBjGsMrarxOZ35aivAZsnRzA8oUXY6QB9c5puJZ5rDTcZqncU2HQujbGD12/t0hmUtE816Wm3YQo6dJHZ4KIIkgWvB7OO+EusqHB4NHmi5xxdMpRU7BQyjSWJggYDWXIbKAvNvSCmFQiHH5OTpyWuGxzWHC9oaq2BaJBZrnI3gq8DfVGGaylI0l9RMAP/vUn1c+N7SSvL5xPtCUlFFi0Kgzsv7EutJR7iBVvj+y6orwm+GmPp3w==
X-Microsoft-Antispam-PRVS: <AM6PR05MB445400CE9F87B87142601617CF020@AM6PR05MB4454.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM6PR05MB4454;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4454;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(486006)(105586002)(83796002)(2616005)(476003)(57986006)(11346002)(5660300001)(446003)(7736002)(229853002)(305945005)(1411001)(86362001)(26005)(6116002)(16586007)(186003)(68736007)(46656002)(47776003)(58126008)(3846002)(2906002)(1076002)(66066001)(106356001)(97736004)(54906003)(6916009)(316002)(23726003)(39060400002)(478600001)(81156014)(81166006)(4326008)(53936002)(386003)(8676002)(52116002)(9786002)(36756003)(6246003)(9746002)(8936002)(76176011)(122856001)(50466002)(69596002)(33656002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4454;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4454;23:zKv9ibw8PEKS3Jo9z9jTnXOePoosEwxheoSL62H4F?=
 =?us-ascii?Q?v6RTqQOkgn9xl1C+GLQ+YYWFyyCJdWnjdEh11xpOb1rYY7v/bdVDLoFXV7Az?=
 =?us-ascii?Q?Y+uDcC+Mi5VJsfOC7X1kN+762DeYLdS6n2Td6GzZUNuA6FTRUO7b8ya1nkKK?=
 =?us-ascii?Q?2M+98MKNDVqkWkSMf39E4hyajhsYIdzbTpKqcvVB97EmyGuy489EDpwk7+BQ?=
 =?us-ascii?Q?YhdhSlVCU6oq80RC4ZDlKp5ojxK+Y3TUxaairvhGa3l1oOC7aSEVb7IiQ9u0?=
 =?us-ascii?Q?s8sWAQqcT/TkMzBIUBp8ic4cOf9v2GYSrMVFFclSWTPMtiH1qu9gmZy5dt3H?=
 =?us-ascii?Q?kJzwHmtvznpyqGaxLoz4Dq3Emhc8/8fWUfS1j1RbUalMgS7+gPuwrXC8ghye?=
 =?us-ascii?Q?eI3nCEcWJqxo/P0J0uXU2QSp9S3mm5WtZZNjvxZYh/tOqVDnoe/qOXe9qmch?=
 =?us-ascii?Q?VWMEzGC00CsqrQmIq9zMc7MkltsmrkElU7Rip77U0XItAbzjFvAkdeKF9d/s?=
 =?us-ascii?Q?npNBZdxgTPIEXL5zKAMYUkcmRZ4Qh4aO5vlsXr46haXmsy1ZsfmQ42gAf6Df?=
 =?us-ascii?Q?tbEOgDoOJmGWE9WO7O2VJFXQCGyYUAOETuFRKRyMXEAgFydfZIYBXOfF6DBp?=
 =?us-ascii?Q?Ytm+8QnyXOdmiZvktB3prQoBP7kXbN6/wpccimONzdXyURxFHOqLdgPaTNvB?=
 =?us-ascii?Q?18IWPzjoC0aHb9UJgVqfAu8Akk88u8VqnaHcqHI4aTmRi3WpDmTcZjQwaE9n?=
 =?us-ascii?Q?18qcNQxCiGX9zjKwbIaGuYtJt6QrLW2sX5dMwnvg5RhLy4uQWwH9LwnLeT0h?=
 =?us-ascii?Q?A6jeU4yKBPYCTCN1lniwVCnMHOCYjTTQsg8pWZLDCTAgZoxZNrMmMa63lFxp?=
 =?us-ascii?Q?DjCtY73zCeBGXIG5kqr0zclsc7BusY1xYciBIRwYRaUc7VI0WF3LlLnUAGNK?=
 =?us-ascii?Q?h0VVzcK70CmvSjhW6rCzqPdf8/+69S5HYv7Fcwep5u/nQL4UyoubJTCRo8L4?=
 =?us-ascii?Q?Guoegoi1KmUBOJZtsvSAReiFkWvuzqUUHRyWgRp/54qbsmQaAhPJWglBdhKA?=
 =?us-ascii?Q?J0Y+zY4xhOF/+Wz1DVaraOVbILTxEOViSm/8zBv38VhBiSB7elKikL6LgsF7?=
 =?us-ascii?Q?i6fQ580Op31ut1+WZvdrw6ENiErDH8KcTThplTgWaO7lwcp385WGfjW9AYVj?=
 =?us-ascii?Q?oYRr2uagzjTfypnhGYMI04mYcnD2DuWNEgUAc9s21kC4SMkK0LKQDT/NRpSz?=
 =?us-ascii?Q?jq5I8Al30StnSOSF7uIt1PeHd4LkwbDmmuGCja/0NW6NK1j4EwBnoB+s7m2K?=
 =?us-ascii?Q?12xm3eiLNulJ+dxCLEgPWYi7ZsMUHvsayTYeVV+GeCgDUPuAlrXHP2mQqGet?=
 =?us-ascii?Q?DWMJiePCUD92WKlDhpo8Id5BHk=3D?=
X-Microsoft-Antispam-Message-Info: mJhFvigawm1PC6zvR1Yg6IdtJ0O3HtzKgRDilPEK+i0WNSDdSm5bn8+ahuZop0QJ3/5PjSmphMHQHYGHQU8mvbEPE2nz4hVHr5qivcNGYVU08tWmdhSr/GUf5VS2kZhzT8K7FYppr6Cm0gKCaUlufkgR205Fd9K6mEn2wnwW5I0HWhxdAzhSUm9yScOGz9C1WrE9jgrTouP7DDVL5A4MfvEhp0C8V7CloF9pDgGDNm/fsJA8JYfcYOf3HpAijzv6VpReALobv59E6Dfl7pykaroqt27hRhmZzU1te3VnEGxpGfIQ3J/WkRm5hFKMC5iFFbEe38EqQMH5hxjyv0SR1fPCKJiLH9vk0Yovh2YEpi4=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;6:Ct58meWGVAaqbSijjTd2G7pYUiyxQ0VJZtCQjeVGBJB+R5qwFJKPw2Xj95DUg8HddayFfW12obwg6xJ+fORFQkCBd1tqkQjwNHuKJfc4NqyfjNFP3zkHJYW/N67+zXoVNtpcc/xoKOku1gWXoPDBkWkq5BN5QR+j37iNMUhfi1UbP9CvOp/Y5A+0LECZbbF2K412TJsTz+8QtgpVu/oGAjz+/8sb36yPguJ5V60O6+Throq51C7twPBPZo2OCEUGbipC5v867GrQRFR0nagPnUbiobnp8cqBzfLdhbs4QOJboA4zYrkSyE5Axrjdgh22rT1mV+7d5LaOjBhpWeJVKM8g9ai53Vu05eCG+GpCN6XdU5eoYxKphx+v7vvZwSetF5fFv09t88bxTi8NE7G8mKD6ViEhFBV8fARy8FgQxxP5/ujBzFaed1Lqt64+/P7HtYrAzib79UUHg//GLpsrQQ==;5:GN22+9QzwW81uWG8nFkMW02rLbRUt8488b7vkLJkvI5DKPWAGwOMEgJrthNIYwLRS5Qb8XVf5IFIU13Onahk3QiBD5ubkEfZ9s2xupho9SrL/7R1yZg9eZlO/HxXD5B5JsjF5+WmaSubzhDS0hni0hXf/F/AkyA6YmQwvrSXHQA=;7:epvniJOgooG9zxgGiHVQhr9LVEY9CerBogL2v/M5RELbK8qB5ZVvoUXNTh6sVmriPzsYJi/YsXpe+GOtae+2quaJpW9vXi+F45zrD5bx3SEF0xDNS8P1KlllitP7yDHchUOfybLtMF8lV2kbMQwjX6Se9Tj5myTO9nPjFFdMGz+7Bmg57CzAWkbr/IB4E8y2fVPEoE9QLxG1X5BseBED7uPu0ZBttv4DO81MOgep9J4MLCvTqWO23E91mjvhHmpr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 18:51:10.7676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f560962-9c26-4348-555d-08d613608c18
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:14:36PM +1000, Nicholas Piggin wrote:
> Hi Greg,
> 
> Here are fixes for a few regressions that came in with my
> carelessness with the irq latency work for the hvc subsystem.
> These were independently reported in 2 configurations, and I
> confirmed with another.
> 
> I think those went upstream via Michael's tree, but he's away
> at the moment so if you would be able to consider them for
> the tty tree that would be appreciated.

Series works for me too, thanks.

Tested-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
