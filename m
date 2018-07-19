Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE7BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F7920684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pbOJ1Z0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F7920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbeGSSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:37 -0400
Received: from mail-eopbgr690089.outbound.protection.outlook.com ([40.107.69.89]:44714
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731774AbeGSSnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVb5wnwgzwGUNCAp+P1qfyxB/aLceYXKtrMFDYNtpaI=;
 b=pbOJ1Z0IDHT/E34XEgtS0d+SF+ePraAg3l6D6nklbWOfRfTcfAiOsacQUc0NujGaRVL+1OnFdeSZjxeamfU2QW5SSnu4M2m2V+nYoBudjZNBpG3dm8aKX2zeYdKaTfUC/iKVC2lAEp5UA+FwMNh1wv/RExFjpEwCJ8iXKKXeZWw=
Received: from BY2PR07CA0078.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::31) by BY1PR0701MB1333.namprd07.prod.outlook.com
 (2a01:111:e400:480f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:16 +0000
Received: from DM3NAM05FT063.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by BY2PR07CA0078.outlook.office365.com
 (2a01:111:e400:7bff::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:15 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT063.mail.protection.outlook.com (10.152.98.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxARt019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:14 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:26 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:25 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAFI005678;
        Thu, 19 Jul 2018 18:59:10 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxAg4005677;
        Thu, 19 Jul 2018 18:59:10 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 05/31] usb: usbssp: Added first part of initialization sequence.
Date:   Thu, 19 Jul 2018 18:57:38 +0100
Message-ID: <1532023084-28083-6-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(36092001)(36756003)(186003)(50226002)(2616005)(4720700003)(7636002)(1671002)(14444005)(26005)(476003)(486006)(51416003)(126002)(106466001)(76176011)(2906002)(105596002)(336012)(107886003)(575784001)(86362001)(426003)(446003)(8676002)(42186006)(316002)(109986005)(478600001)(54906003)(47776003)(87636003)(16586007)(246002)(8936002)(6666003)(305945005)(4326008)(26826003)(356003)(11346002)(48376002)(5660300001)(50466002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1333;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT063;1:MxaNKjQZykAR77A+qpv4gSYwfLozzZkSETduszOspBj5+PrEOiHZ9RSkmo2YBSZi8DG+xj5CTEDZrdltNGAOBG2rM0iOLsn17om8WniyiN8UeQ7y+he6kFMBtGR/uuNq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90f0fe0a-a2f2-4f4c-5204-08d5eda1576d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY1PR0701MB1333;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;3:2AKCeLEgFLPJCJrWOFFpE53FzsWA03h3T2D6oDnXDCUtT4OJj1WsJly76ymC3EkI2ePwyUUnDDF95Wxd+UG4s2OJOIlufrOEOf3BUIplgGsVVro1l8gH4gnNzfqtNFen661D5D/MNXfoGup1itAxrhZhvgkj0HgdZvT4OioUMslPF48jeATFo4kq4YF9EZkd3cs9tDWziplve7U2TSwAD2vWABKGGoYCNfZrXI1Ra7xH2WgUEzwtH8xraOCEB4GSeujMtnOqZgB1c+/kyPYMkVaXJX7yGDy67R7cj6daYM+oqwGvSgTiRuNNduS0f6SdQMAjb09GdZjTTz8hLEF/HoBfAME730UejSRGrKXc90s=;25:XLzn4t2RBT2AxA/IHeg5IA6zIHi7TsloY/QSAQN/EpYVd4kT+2IPv3G5fTbiclAkBgi6RI1pn4mnq14HShc1zC06TzqgrVvnHO6YhBN6d1dQyuaZOeHEFO189hvdxhkXrthiSr9MsYXmdt9spNVsk+8aaO7h7MIAER+rp1fuCzqLzZTf0dVQNmLsJKdju2QjBare48ncsX3YiQh7V2VZ5UAKN7g03w25WcKG6Z0TFQXKxq7qyBWbx6grzFrWWxIzIbtLB4dZDDTRzIlxoCX+zabIougTVuvtRt38gS4KJGKEvP3B0wga73ZfxEkfSsNBDYN/pspDjXDSQrfyiFEggA==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1333:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;31:PCKQcdSX40IiY60daoE1GwFxcnzPGXg7ztvgtACRTa39PhHXOtL/egfm0i7FqdPxK7B3dcyRhHrWxtIYRbndS2ly/8xzDiYWlAVEiFTHAVaMHCserknAkFHv3HLHqGQfjPLCrXOmowVeY7k4XD5yubindFTTIZLYTWWMSjLnUcHt2K06RSr2iW0GVjAtV0SQu9bmpouD+eWg0vrUWIH1MiIEx7c3igHLqa1DX8bi+U4=;20:IIyUsj0q3RBmXBOHBqt9hGI74Y5WupdWAp/QNoNWkE3sEi4FIf7pq8PRBFPLspG56JLQcOHvsQYpSr8hNklmsoSpbHmCo0YI3fXCrO2Lq9dOY+2aK24VWaw1vaLoMNeIDBZ+I1NsBa2t7A2VDgksVq+OwkJjeLEaIeXDImYfMj0ITHX2bjPT14yLxZ/BAq5w44wlLxj7TlAa8h5Lw4pelCOqKHrVPjan3yHJTfnJXRKl87g9yqsdsSCTim2ARmYbHb/Yx7Iodu+v0eDNGc1FMJPBsRf1H5HC/7yOqos6AlawihmgIZXSES6owyBtoIYZAFnD1zaMHfvyAAE0C+ipojdq6SYazggQfBYCE9unHcRM4Jdw6ENKvTPt7o4gQC2sat4DPzjR/veiYyEcC8oWgZv14jVua3eATjwxrs932uytMk348kSQxibupV3rm7JVHK0QSoCIKj3hSW7UdZ8zxUF6GkuUgF6kYA7SK+fJSIolYXuOUmci3wzUZ2nehQ2C
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1333DA90814F9D58D7C1F600DD520@BY1PR0701MB1333.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1333;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1333;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;4:TJIjUNuzgm/Fhq5CHPB2eOxBBpptBly5Lwmk2dEj4g0hUUekPU9Nkk9TTOGTNpA7AHtwrQeeOnRtBAbSCLx2wk0IhELFSs43VIjFd2v/M5vYpnZ5l8ksY5E9ZCzfFmr0UsblWMrtMoNOLUw17uJWrKqhPAQjLJxrJkTG70S4lj00aP1v7XsS1c8ZwOlo40A1Erpmh6tSIniavAll7moSvetd/emVOjoLK/N4JxL7/xnUzkutAe91qjns/aSqMxi0/cZJmiOK02/uUXRt3rcxxD1gvk2RiBOgp7EqDN1yKGY1jr08T4NUIZY3ddUFJ1B4
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1333;23:wK3S+kFzsKAG/DtgiGHvrtxI6NTfscojAGXPc2+?=
 =?us-ascii?Q?0acUOQzImO4v1u/otncAnM/JTHq9rU5pIz7AJ9iNxkLVlNhVQc/6QRZZoNet?=
 =?us-ascii?Q?kqHtjlb68HdN427Q+F2YGUqiGdU/dO1dDkUHPSuChe2szSJUZxPplo3010XE?=
 =?us-ascii?Q?ogrARu1iTmv3qCMhk0pKZ/1Vav34cQAyxpPslEsEJNGAihh+n9PqiillVjYm?=
 =?us-ascii?Q?DqveNmpcWDdGWcc5WdWjAGMtsVwMgetanEfH5pCr/m2NbOHLemUzJnyhfIh8?=
 =?us-ascii?Q?0lgfbA2XfANqy6yzP/NfxNIBFE8pyDXqdiqObDe+lIHIGWnlK+yDQyVlvZoz?=
 =?us-ascii?Q?ARwfq5Lz+I81XRnDnEv1DFtg15ab+PLCPpXyBn64CxLyrr+DhR43Z2kgs4No?=
 =?us-ascii?Q?hBzKQhFq91HGtQ/0MzdokO+mTZW/VREXsSnH9BiFGIZTTjBUzMK7irqwXVtc?=
 =?us-ascii?Q?bVKiFSbHQIsx8t1UO022a0HBVzGqUeLgLJoRI+tpN4pyImk5V6jBaTfm4Bh+?=
 =?us-ascii?Q?txypW9AT8RLrD3EPAMs2p4ZxIqyR9MckkN/IiR2+zC19/BjMo4ceg5sfHJQa?=
 =?us-ascii?Q?5kdMQUA6K/6fiVcxVnoIrGSfAB6tUGW+SOB6VgXxDZSa24E/4/pVqOdVkYi4?=
 =?us-ascii?Q?clUcrI6Xpo1+F6FJSwbr2u0O6FwYTIfhZi1KZmMAZtKq9+gODdTzdJLPDmxm?=
 =?us-ascii?Q?q86mjAah5TJQXNytl3/AR8nzDmPYBecQZXXrQEZiwQok2Oidnj6N1JesoUL5?=
 =?us-ascii?Q?ecig3962rNgz9Yh4Xk+njOLFRz4RI8UX0caezupgtdG7dSw5fMD7K43Zk1R7?=
 =?us-ascii?Q?/WRgungCK+bjE+m9HHkYIpwCZ1qt1JydN66R/LE6AKQEbu80NS0T8Oz+RN/x?=
 =?us-ascii?Q?X8CZ4MwS6ymEd90060nwMwl4IewE3OstXVoDit6cphlFVkF2eyQXfOk8CDbh?=
 =?us-ascii?Q?gmiHji2XMFxdu8TNJ4pgfD6O6y6nQb5eLARx8sycq9WL7jc+mDC/zfs/E0+b?=
 =?us-ascii?Q?mdh7Q23ANmNqQg2GKKRsElJG1a/OmpoFuRw5g0TyEUjYh9nRFhuaqdWiyRl+?=
 =?us-ascii?Q?3qJZi509af02gtv/K0x3nSC9pBK9vIirBeivTh1PGPX6wal6w8lkRLKTTJ+w?=
 =?us-ascii?Q?EsMDT1HonVOmRwAklHq2GTm3C9UTeOff1/CNSmbluq5gba5Mxws/fpmnXTo/?=
 =?us-ascii?Q?MTf6ymSM6QfwOp+8=3D?=
X-Microsoft-Antispam-Message-Info: nBmXvsVV07Kh8F7pJzv/WHPNIIYoqbXfGDrSCFNntCPjobc+hxzS2unoptLEuIkqugZEuY3jODyFUJHpkksrwWztNDqenlj42bKbotpL1elHpADp3fFHcMbLIrSxCYa+jXbJ5RgA5ze373iV8eBLbCMi45t5uuUrimTnZtp36EwCf62EcY/JBDbwJRviCNEUty4nm+YORakQqbk6cY+fLEwNlpyk9BeiHf7sT6c/LWIjTZfBds5tX8j6lKXk/+YTBJPGF/MtnzXVePe8IbUdNb6AXea1h+O4cGdXtmvyvs3TaFbu+wajMiORazHDmmsPxbLVr84sxyvJUgR3bWXJ65/NU0p6K0CCarG2QIv29JuDWa6QWp+s7wnmBBIopW2wnrXdFN9tbqbdCditaeHg8A==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;6:k1suC2UchWWRO/VQPvaHMfyGB/g0nUyY5F4M9yMD5UTJPLPjvi2sfK0syCAi864mbz7KItkX+UFb6gyB47+G0rDCT9T+Mogiaq8fecTTfmFtcm3gKANfokvlOAoQEEKe37Dy5xABxLJeUr1GaCshf9/J0Ie20UKVatm5o6Zh41QVGWnfanHY/u72BmsNnQkVZ0fWEX94YsqrTAxLVZpgwPPWjYWkicwBrUGXxFI5AyfeEhV0kwghmOJ5q+N3Zs5B5ExUOY87vse3pmAZKeSRY28sm0FPby1XNCG3Nq0GcVlwxA7rt2hPu+Mh6clp7Ybt5jf+laW5qpEht0JSGjJwYgvYHTYIXKz9DwDzC+jOJrozLzrYKSLwFFJfDJEDmjXzF4pzcKeMgQhBrZrxnzjuM6vPL4G6DE97oqM8XMwyxMFXdVZynq/4PF1a0tHMZ87eb1BmQgPXjP/1VmW77/BNwQ==;5:1Veh5KxpaaVEmsOjlGw34/9Ne7aPC4WV5qXLG43+6oy7AiyuoCM422ttCYBUWZhE9EUeA/zyPZYRAtD3h+5+FElDtCtnOcyKC+JF+cfk2lPqBHQxnjjlyjdOLyAnjgjx2pkah/YvExwYzaBGyzJQhKK8jTPK6zTrmdOW7tIqO6Q=;7:NI6vrenKxEk4+kgAYB1LgoSEvBZhw+u75TxGRoASklxiTZERi8U0tHrqV8nzG6R0hgK/1eyzIw3tPTE5bdTJ4gTc3XuP3//8yC6r9hIGjUvPeC+3So7LWEYUR6JD0vcMQlG2NsH9X+4DvQ0iqW8RxH/1P18W+agaLZsdxWd2ifImrbLsyqlrxS6tQiaFMsGeUUQHYRlMC0LvDnwY58BwMuplQGZ7WXdAINntX9YyjiJrr45RpCadWT2X9TVm5gRa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;20:1KxHc6gy/Bigu6NS8n6lQBWeuSzjHxkJBiLIV7hyDyltQ4Nh9jWfFMTuSxR+afqEjO2gvkhipIrq+EkHo4JjnNMN7lje0VHBPE1BieX4yFSW4I3+EbIIQe27qwGgL5OKhxTQCfKt3OdsS6x5VAKReK6B/x8g27sI9AMrShfYaIxUvLNbFbpBAebZpAw7WaP6H3UeFGDMmX7vmeCFJR+ZE2zB4sf4JI2A3roaDJAFQsaV7NuVi6EMgi7rEYCneZNj
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:15.2124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f0fe0a-a2f2-4f4c-5204-08d5eda1576d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1333
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds some initialization function. The initialization sequence
is quite complicated and this patch implements it only partially.
Initialization will be completed in next few patches.

Patch introduce three new files:
1. gadget-dbg.c - file contains functions used for debugging purpose.
2. gadget-ext-caps.h - holds macro definition related to
		       Extended Capabilities
3. gadget-if - file implements stuff related to upper layer
	(e.g usb_ep_ops, usb_gadget_ops interface).

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Makefile          |   1 +
 drivers/usb/usbssp/gadget-dbg.c      |  30 ++++
 drivers/usb/usbssp/gadget-ext-caps.h |  53 ++++++
 drivers/usb/usbssp/gadget-if.c       |  24 +++
 drivers/usb/usbssp/gadget.c          | 242 +++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h          |  15 ++
 6 files changed, 365 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-dbg.c
 create mode 100644 drivers/usb/usbssp/gadget-ext-caps.h
 create mode 100644 drivers/usb/usbssp/gadget-if.c

diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index d85f15afb51c..0606f3c63cd0 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -5,6 +5,7 @@ CFLAGS_gadget-trace.o := -I$(src)
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:= usbssp-plat.o gadget-ring.o \
 				   gadget.o
+				    gadget-dbg.o
 
 ifneq ($(CONFIG_TRACING),)
 	usbssp-y		+= gadget-trace.o
diff --git a/drivers/usb/usbssp/gadget-dbg.c b/drivers/usb/usbssp/gadget-dbg.c
new file mode 100644
index 000000000000..277617d1a996
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-dbg.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include "gadget.h"
+
+void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
+		      void (*trace)(struct va_format *),
+		      const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	dev_dbg(usbssp_data->dev, "%pV\n", &vaf);
+	trace(&vaf);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(usbssp_dbg_trace);
+
diff --git a/drivers/usb/usbssp/gadget-ext-caps.h b/drivers/usb/usbssp/gadget-ext-caps.h
new file mode 100644
index 000000000000..2bf327046376
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-ext-caps.h
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+/* Up to 16 ms to halt an DC */
+#define USBSSP_MAX_HALT_USEC		(16*1000)
+
+/* DC not running - set to 1 when run/stop bit is cleared. */
+#define USBSSP_STS_HALT			BIT(0)
+
+/* HCCPARAMS offset from PCI base address */
+#define USBSSP_HCC_PARAMS_OFFSET	0x10
+/* HCCPARAMS contains the first extended capability pointer */
+#define USBSSP_HCC_EXT_CAPS(p)		(((p)>>16)&0xffff)
+
+/* Command and Status registers offset from the Operational Registers address */
+#define USBSSP_CMD_OFFSET		0x00
+#define USBSSP_STS_OFFSET		0x04
+
+/* Capability Register */
+/* bits 7:0 - how long is the Capabilities register */
+#define USBSSP_HC_LENGTH(p)		(((p)>>00)&0x00ff)
+
+/* Extended capability register fields */
+#define USBSSP_EXT_CAPS_ID(p)		(((p)>>0)&0xff)
+#define USBSSP_EXT_CAPS_NEXT(p)		(((p)>>8)&0xff)
+#define	v_EXT_CAPS_VAL(p)		((p)>>16)
+/* Extended capability IDs - ID 0 reserved */
+#define USBSSP_EXT_CAPS_PROTOCOL	2
+
+/* USB 2.0 hardware LMP capability*/
+#define USBSSP_HLC			BIT(19)
+#define USBSSP_BLC			BIT(20)
+
+/* command register values to disable interrupts and halt the DC */
+/* start/stop DC execution - do not write unless DC is halted*/
+#define USBSSP_CMD_RUN			BIT(0)
+/* Event Interrupt Enable - get irq when EINT bit is set in USBSTS register */
+#define USBSSP_CMD_EIE			BIT(2)
+/* Host System Error Interrupt Enable - get irq when HSEIE bit set in USBSTS */
+#define USBSSP_CMD_HSEIE		BIT(3)
+/* Enable Wrap Event - '1' means DC generates an event when MFINDEX wraps. */
+#define USBSSP_CMD_EWE			BIT(10)
+
+#define USBSSP_IRQS	(USBSSP_CMD_EIE | USBSSP_CMD_HSEIE | USBSSP_CMD_EWE)
diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
new file mode 100644
index 000000000000..d53e0fb65299
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ */
+
+#include <linux/usb/gadget.h>
+#include <linux/usb/composite.h>
+#include "gadget.h"
+
+int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data)
+{
+	/*TODO: it has to be implemented*/
+	return 0;
+}
+
+void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
+{
+	/*TODO: it has to be implemented*/
+}
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 2f60d7dd1fe4..338ec2ec18b1 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -23,6 +23,107 @@
 #include "gadget-trace.h"
 #include "gadget.h"
 
+
+/*
+ * usbssp_handshake - spin reading dc until handshake completes or fails
+ * @ptr: address of dc register to be read
+ * @mask: bits to look at in result of read
+ * @done: value of those bits when handshake succeeds
+ * @usec: timeout in microseconds
+ *
+ * Returns negative errno, or zero on success
+ *
+ * Success happens when the "mask" bits have the specified value (hardware
+ * handshake done). There are two failure modes: "usec" have passed (major
+ * hardware flakeout), or the register reads as all-ones (hardware removed).
+ */
+int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
+{
+	u32	result;
+
+	do {
+		result = readl(ptr);
+		if (result == ~(u32)0)	/* card removed */
+			return -ENODEV;
+		result &= mask;
+		if (result == done)
+			return 0;
+		udelay(1);
+		usec--;
+	} while (usec > 0);
+	return -ETIMEDOUT;
+}
+
+/*
+ * Disable interrupts and begin the DC halting process.
+ */
+void usbssp_quiesce(struct usbssp_udc *usbssp_data)
+{
+	u32 halted;
+	u32 cmd;
+	u32 mask;
+
+	mask = ~(u32)(USBSSP_IRQS);
+
+	halted = readl(&usbssp_data->op_regs->status) & STS_HALT;
+	if (!halted)
+		mask &= ~CMD_RUN;
+
+	cmd = readl(&usbssp_data->op_regs->command);
+	cmd &= mask;
+	writel(cmd, &usbssp_data->op_regs->command);
+}
+
+/*
+ * Force DC into halt state.
+ *
+ * Disable any IRQs and clear the run/stop bit.
+ * USBSSP will complete any current and actively pipelined transactions, and
+ * should halt within 16 ms of the run/stop bit being cleared.
+ * Read DC Halted bit in the status register to see when the DC is finished.
+ */
+int usbssp_halt(struct usbssp_udc *usbssp_data)
+{
+	int ret;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Halt the USBSSP");
+	usbssp_quiesce(usbssp_data);
+
+	ret = usbssp_handshake(&usbssp_data->op_regs->status,
+		STS_HALT, STS_HALT, USBSSP_MAX_HALT_USEC);
+
+	if (!ret) {
+		dev_warn(usbssp_data->dev, "Device halt failed, %d\n", ret);
+		return ret;
+	}
+
+	usbssp_data->usbssp_state |= USBSSP_STATE_HALTED;
+	usbssp_data->cmd_ring_state = CMD_RING_STATE_STOPPED;
+	return ret;
+}
+
+
+/*
+ * Initialize memory for gadget driver and USBSSP (one-time init).
+ *
+ * Program the PAGESIZE register, initialize the device context array, create
+ * device contexts, set up a command ring segment (or two?), create event
+ * ring (one for now).
+ */
+int usbssp_init(struct usbssp_udc *usbssp_data)
+{
+	int retval = 0;
+
+	spin_lock_init(&usbssp_data->lock);
+	spin_lock_init(&usbssp_data->irq_thread_lock);
+
+	/*TODO: memory initialization*/
+	//retval = usbssp_mem_init(usbssp_data, GFP_KERNEL);
+
+	return retval;
+}
+
 #ifdef CONFIG_PM
 /*
  * Stop DC (not bus-specific)
@@ -50,9 +151,146 @@ int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated)
 
 #endif	/* CONFIG_PM */
 
+int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
+{
+	int retval;
+
+	mutex_init(&usbssp_data->mutex);
+
+	usbssp_data->cap_regs = usbssp_data->regs;
+	usbssp_data->op_regs = usbssp_data->regs +
+		HC_LENGTH(readl(&usbssp_data->cap_regs->hc_capbase));
+
+	usbssp_data->run_regs = usbssp_data->regs +
+		(readl(&usbssp_data->cap_regs->run_regs_off) & RTSOFF_MASK);
+	/* Cache read-only capability registers */
+	usbssp_data->hcs_params1 = readl(&usbssp_data->cap_regs->hcs_params1);
+	usbssp_data->hcs_params2 = readl(&usbssp_data->cap_regs->hcs_params2);
+	usbssp_data->hcs_params3 = readl(&usbssp_data->cap_regs->hcs_params3);
+	usbssp_data->hcc_params = readl(&usbssp_data->cap_regs->hc_capbase);
+	usbssp_data->hci_version = HC_VERSION(usbssp_data->hcc_params);
+	usbssp_data->hcc_params = readl(&usbssp_data->cap_regs->hcc_params);
+	usbssp_data->hcc_params2 = readl(&usbssp_data->cap_regs->hcc_params2);
+
+	/* Make sure the Device Controller is halted. */
+	retval = usbssp_halt(usbssp_data);
+	if (retval)
+		return retval;
+
+	dev_dbg(usbssp_data->dev, "Resetting Device Controller\n");
+	/* Reset the internal DC memory state and registers. */
+	/*TODO: add implementation of usbssp_reset function*/
+	//retval = usbssp_reset(usbssp_data);
+	if (retval)
+		return retval;
+	dev_dbg(usbssp_data->dev, "Reset complete\n");
+
+	/* Set dma_mask and coherent_dma_mask to 64-bits,
+	 * if USBSSP supports 64-bit addressing
+	 */
+	if (HCC_64BIT_ADDR(usbssp_data->hcc_params) &&
+	    !dma_set_mask(usbssp_data->dev, DMA_BIT_MASK(64))) {
+		dev_dbg(usbssp_data->dev, "Enabling 64-bit DMA addresses.\n");
+		dma_set_coherent_mask(usbssp_data->dev, DMA_BIT_MASK(64));
+	} else {
+		/*
+		 * This is to avoid error in cases where a 32-bit USB
+		 * controller is used on a 64-bit capable system.
+		 */
+		retval = dma_set_mask(usbssp_data->dev, DMA_BIT_MASK(32));
+		if (retval)
+			return retval;
+		dev_dbg(usbssp_data->dev, "Enabling 32-bit DMA addresses.\n");
+		dma_set_coherent_mask(usbssp_data->dev, DMA_BIT_MASK(32));
+	}
+
+	/* Initialize USBSSP controller data structures. */
+	retval = usbssp_init(usbssp_data);
+	if (retval)
+		return retval;
+
+	dev_info(usbssp_data->dev, "USBSSP params 0x%08x USBSSP version 0x%x\n",
+		usbssp_data->hcc_params, usbssp_data->hci_version);
+
+	return 0;
+}
+
+/*
+ * gadget-if.c file is part of gadget.c file and implements interface
+ * for gadget driver
+ */
+#include "gadget-if.c"
+
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
 {
 	int ret;
+
+	/*
+	 * Check the compiler generated sizes of structures that must be laid
+	 * out in specific ways for hardware access.
+	 */
+	BUILD_BUG_ON(sizeof(struct usbssp_doorbell_array) != 2*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_slot_ctx) != 8*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_ep_ctx) != 8*32/8);
+	/* usbssp_device has eight fields, and also
+	 * embeds one usbssp_slot_ctx and 31 usbssp_ep_ctx
+	 */
+	BUILD_BUG_ON(sizeof(struct usbssp_stream_ctx) != 4*32/8);
+	BUILD_BUG_ON(sizeof(union usbssp_trb) != 4*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_erst_entry) != 4*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_cap_regs) != 8*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_intr_reg) != 8*32/8);
+	/* usbssp_run_regs has eight fields and embeds 128 usbssp_intr_regs */
+	BUILD_BUG_ON(sizeof(struct usbssp_run_regs) != (8+8*128)*32/8);
+
+	/* fill gadget fields */
+	/*TODO: implements usbssp_gadget_ops object*/
+	//usbssp_data->gadget.ops = &usbssp_gadget_ops;
+	usbssp_data->gadget.name = "usbssp-gadget";
+	usbssp_data->gadget.max_speed = USB_SPEED_SUPER_PLUS;
+	usbssp_data->gadget.speed = USB_SPEED_UNKNOWN;
+	usbssp_data->gadget.sg_supported = true;
+	usbssp_data->gadget.lpm_capable = 1;
+
+	usbssp_data->setup_buf = kzalloc(USBSSP_EP0_SETUP_SIZE, GFP_KERNEL);
+	if (!usbssp_data->setup_buf)
+		return -ENOMEM;
+
+	/*USBSSP support not aligned buffer but this option
+	 * improve performance of this controller.
+	 */
+	usbssp_data->gadget.quirk_ep_out_aligned_size = true;
+	ret = usbssp_gen_setup(usbssp_data);
+	if (ret < 0) {
+		dev_err(usbssp_data->dev,
+				"Generic initialization failed with error code%d\n",
+				ret);
+		goto err3;
+	}
+
+	ret = usbssp_gadget_init_endpoint(usbssp_data);
+	if (ret < 0) {
+		dev_err(usbssp_data->dev, "failed to initialize endpoints\n");
+		goto err1;
+	}
+
+	ret = usb_add_gadget_udc(usbssp_data->dev, &usbssp_data->gadget);
+
+	if (ret) {
+		dev_err(usbssp_data->dev, "failed to register udc\n");
+		goto err2;
+	}
+
+	return ret;
+err2:
+	usbssp_gadget_free_endpoint(usbssp_data);
+err1:
+	usbssp_halt(usbssp_data);
+	/*TODO add implementation of usbssp_reset function*/
+	//usbssp_reset(usbssp_data);
+	/*TODO add implementation of freeing memory*/
+	//usbssp_mem_cleanup(usbssp_data);
+err3:
 	return ret;
 }
 
@@ -60,5 +298,9 @@ int usbssp_gadget_exit(struct usbssp_udc *usbssp_data)
 {
 	int ret = 0;
 
+	usb_del_gadget_udc(&usbssp_data->gadget);
+	usbssp_gadget_free_endpoint(usbssp_data);
+	/*TODO: add usbssp_stop implementation*/
+	//usbssp_stop(usbssp_data);
 	return ret;
 }
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 55e20795d900..5d8918f8da84 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -12,8 +12,10 @@
 #ifndef __LINUX_USBSSP_GADGET_H
 #define __LINUX_USBSSP_GADGET_H
 
+#include <linux/irq.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/usb/gadget.h>
+#include "gadget-ext-caps.h"
 
 /* Max number slots - only 1 is allowed */
 #define DEV_MAX_SLOTS		1
@@ -1676,7 +1678,18 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
 	lo_hi_writeq(val, regs);
 }
 
+/* USBSSP memory management */
+void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
+		void (*trace)(struct va_format *),
+		const char *fmt, ...);
 /* USBSSP Device controller glue */
+void usbssp_bottom_irq(struct work_struct *work);
+int usbssp_init(struct usbssp_udc *usbssp_data);
+void usbssp_stop(struct usbssp_udc *usbssp_data);
+int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
+void usbssp_quiesce(struct usbssp_udc *usbssp_data);
+extern int usbssp_reset(struct usbssp_udc *usbssp_data);
+
 int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
 int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
 
@@ -1689,6 +1702,8 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 /* USBSSP gadget interface*/
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
+void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
+int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
 
 static inline char *usbssp_slot_state_string(u32 state)
 {
-- 
2.17.1

