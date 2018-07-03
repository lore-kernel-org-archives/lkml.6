Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D10BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CED22ACA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Rv6TNnph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CED22ACA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934010AbeGCKE2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:04:28 -0400
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:63400
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933929AbeGCKEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUESRLByKGhKY5aBBOfuZ/r1tRnIBMygQEG+fplyd4w=;
 b=Rv6TNnphRlRA4nKak82dHT9Extf0jKLl7GJkyzip/TumQBeADVVHc+0SWhJ92/O+QQobx8NNtSzOZR0j+E4xI5yfb0fi74eW1a5bO14hxRNSGd8eNBAAjwbPIYk+asSKcKMf6kK1gT3soeZ6+irQo6XoLzj77CH65AEpnXQAx6E=
Received: from SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) by BY1PR0701MB1334.namprd07.prod.outlook.com
 (2a01:111:e400:4810::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 10:04:03 +0000
Received: from BY2NAM05FT011.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by SN4PR0701CA0004.outlook.office365.com
 (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Tue, 3 Jul 2018 10:04:02 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; padovan.org; dkim=none (message not signed)
 header.d=none;padovan.org; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT011.mail.protection.outlook.com (10.152.100.148) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.930.2 via
 Frontend Transport; Tue, 3 Jul 2018 10:04:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3wC7018968
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 06:04:00 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:04:14 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:04:14 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3vHV030665;
        Tue, 3 Jul 2018 11:03:57 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3vF3030639;
        Tue, 3 Jul 2018 11:03:57 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>
Subject: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP controller.
Date:   Tue, 3 Jul 2018 11:02:23 +0100
Message-ID: <1530612152-27555-13-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(2980300002)(199004)(189003)(36092001)(69596002)(186003)(2906002)(87636003)(26826003)(97736004)(42186006)(14444005)(5024004)(47776003)(16586007)(81166006)(50466002)(81156014)(305945005)(8936002)(54906003)(48376002)(316002)(478600001)(110136005)(105596002)(107886003)(126002)(486006)(336012)(51416003)(446003)(2201001)(426003)(4326008)(476003)(11346002)(2616005)(50226002)(36756003)(53936002)(106466001)(6666003)(53946003)(7416002)(5660300001)(8676002)(26005)(76176011)(86362001)(356003)(68736007)(921003)(217873001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1334;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT011;1:HPjz8mxbP3JpVScS5m1n9eyAT/+8iPYvtfieMFmOE48PwqXsHpQbIZ/fj26/AcXa06ZPgW/Jll1VCmt+C3qhEF3hcYpIxVuZ/q3UlH0z/eOwOHPd4jQt1ORU4MGbro9g
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48b8a607-cf7c-4992-288b-08d5e0cc4db7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY1PR0701MB1334;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1334;3:BHMZHBgTZZE632VVdgdV7dPfUvzd3EEh4zs2Sqlrml41ZGFqQ+S4H2r+uWjk8Tq+f3xqqI8EMxhUp7Jfk1nr9LSPMk6+5ct3L8W8cMl4BLJMriu+PbnhZaCwxRZ0bnoFJD25SSMG9r0J7zLIxCoZIHmdpEIwOGmYpY6NmVHf0tZSmkrkd3hNLfHjzPHS5mrCTCIqJEtmBhSCYq+gTzUVSPBcyzaaGRD16V4akniFiY922uzLnGHmKCFxQkfcnN6bzJILkPVWovNpzj6s9xi3pvT5l/906lAJB106AoQ5/t5heI6euUTjHhdxNMOOCC1+b8RGB/WOZX3GVx9khpExEA==;25:tG8k/ue+sycQFADF6WgPZH0rIoGfNbJEBy6shHGWNOwsBW7K6I5vNHR+8MhIuPpmViuTbAPbHr3BwWFOxhfblMz8D7jIWJVsHREQrJTD8rhks7u9RHh8qRX5vgzNUJxm7EJIUpwAbgwcVRITjZbAQuEsLSqQcwcy2L10CEzP1POwkhJyVgfm/GfJ4K83UHhH4xQFsW3g/CPfM6PjaF2/4YBdwgo9Rdp/G8s94L7SQWZ5+sibhzbsSjPdqPOMllMCAymnyXdusSpUP3iYE4nrSkrLrye2S0XtmzXL6SORZLT0ldsne1tBqdTau0xKe+fRucZaFMh1sVUFIz1drWMmMA==;31:yDGhsy/jCAYEwY5hNVFMqU5MW//h/qRzwgx2ts3PZ1uzBLSph5fqqhDN9m5pJhMwRapRloT+ZDW7gIae7ttzksiLOx5XaAM5aDp/RZ8gbHrw4ewTP7fnaXKGZYEiiRbHTfb1IXlYo0p/Y4FuTUMFei8S+zaRE+s1jl1uaZ0+F3yG93IwBFph4xsVW9yTqpu8PBjzVYO1tKVYCl0bZzqEa46MzsLHxcokX7FnUoD9f6E=
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1334:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1334;20:4CorsJ1hgcfUFP5PeDg1ACi9x+un5IDPIeGjIfavt5cnEJHEiAekxwbHEW3KcAeINbO2QCW9Sl9yU5urkU65mlbv4s2mPtY8J3Q+WFx6ylMNRykAl6VkM1Pa7Bzu/kpntL1aJqWExkmizY13LtnUgviQXUbCnoymnbvUWdtPMsF88MYEbo8hLrvFebJphqcjnV1qv4yvLqHQUNLX30iweCTuj/vtSL1+41LrpKSjeiq/q5VVK+vzTaIZIXLi8myEXQyts+SqYqmSeV/5Ek/vEItcSqsOfzkbKLZfJQbrnheThB0NcSS8I4kkuVe7yMwijJADKNNRnBFmBVKraMjQ8RkacUTJIIr8kRVSiJmjmYnm3na5ebqTzQJncOmRyLjUmOHzR6AJiivv8WDXHm6h9a4rL1tScBU7oAJ8MFpd/wXSr4xXlujEgnEYEBsAtdWbNZLf8F+eaNcpbrLuXpsJP0eZK/kljgdiAVlJvO0uHqpxkZ19h/HRydOcaN4JHi/f;4:1zdB8FQ2DSm/l2pHTmXtEgvZ0Qyntkqc6bIa6JpGz5uNcwZ5uZ9FLvcjQaB2d94qQNlwFMl2CUD1eNe1eZjWIrkCEZfqLPj5ZHIEkuDCK0qdCMmns8zwyHzIUyETtNsNsjE0bbBS9RrpZyTHi83agkW6Fk3nm+DuOC1sN0p0821Ib6De/jlHSGAusmYaa//zS0d2eETH/DGPZu3+QTBOl65AZcqVxvKkNM8LyR0BJmOXYp+CRWonUET42w8FU+BctwPscjTI6frp8VvSbzcR1Q0dUF3DwFQxGqIbIbH2oDzyneknyoiiV6P4gR8WWOqF
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1334F955A1DEFA0BA3D0C3A0CD420@BY1PR0701MB1334.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1334;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1334;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1334;23:5Cp69kD2ltR2IVvCxHRDzXmg7RyXkzv9RpgbfJC?=
 =?us-ascii?Q?sVmYoz107esMOeRnIXD0q/kpeQi/F/QAV5dbEjklatNs8frat+aV+Lt1Kwg5?=
 =?us-ascii?Q?g/WLdcBCxfNd3d1ly9wgyMNzfxwgByhznNNJ1+nBVTHBo4kIpVdQZlPqU4Lr?=
 =?us-ascii?Q?wc0hVm4wLTSyp+lj9cIgIX0qzAkVG7pVzEh5M/kIX7Y818HCQ7dOCIqI3tOC?=
 =?us-ascii?Q?J6np/uUXoxkqRpV/06NywFfCBzZEs3UsvvFYoB8lnwP1WQy+7/YI1jUGRPiQ?=
 =?us-ascii?Q?fFanzzZRTE0hyL+8s4l1vE0ybm2a7CgWUaaTXTimmvqZ1gjGy74lVVpYpgDo?=
 =?us-ascii?Q?QeTrxEEtOACsQq0eC0SLYM6h6tpazN03OAnsEa0mQ+SE7+ENuUZ1yzziW/gJ?=
 =?us-ascii?Q?hC94OD7WYxQA2CmLjF86RM0sHS2wZ/SInow1eEplQqPHg70J4D1V2kkAsRGX?=
 =?us-ascii?Q?YcreJT44IG3u3sYZZ20ueQMeJExipX/QBWylCGX654zPbWQRNU2guEVMso/D?=
 =?us-ascii?Q?5ORVZMJaX2ucHtZL3UKtMMB/7KGoL7yug6DZEIlaazAr3UcTiomc4zKUZMil?=
 =?us-ascii?Q?WYe6Bhp/Jtciudw1EvBgjrbmr8f8yP/ZN9U515Y+05YukjnP+1cSuWV4aNTJ?=
 =?us-ascii?Q?+996DVm0BJSTaZ5YX5uyysiLi8Mqdteacc13yKmaJoazii0bFKXTIDBI3xEq?=
 =?us-ascii?Q?YBOgEgln01bZW+AwJIEQT0Ip5pt8AsHKHuj4IJM7ZF9KM6NK9vzUJT2mr8nO?=
 =?us-ascii?Q?5KDesfO1KrMz+zDJ1uaJdmhUKel1Xxip9z4T6GnA4Hwnb7IOvs8IMwlu9EbB?=
 =?us-ascii?Q?TNal+2Z2U0Va/VAFgv6Epn75VQ6GDQfOOOhzveRwQwxRBXOzlkbCLYb5RGs3?=
 =?us-ascii?Q?fZ9s9+QMrHTzWCZByPgrFgZsa9gt0JB2IEc5E3s0WZUPznq7xOBsJfiIR2+r?=
 =?us-ascii?Q?J+U0IFg8utY+eHwWHkRtLhFWG2krtesH5Goi17QaPA/Aop+/16HjFpkwAq9W?=
 =?us-ascii?Q?Q8p8k7wl82qq+23qOcPSTlgI353me3FEvzfycpijXDcNXGTW4qyB8rauY9r+?=
 =?us-ascii?Q?+79RVQbFWTsJ7XHPued1POIgaF24JZK+xcdm/Og9z2Al+LHluFlPk6rpu4Od?=
 =?us-ascii?Q?SgH2QIKIhQAWU2L0kiEOzQfAx6ZOb9uRQP+Vyw2yhOuG25e/ixhhDzRuZH5E?=
 =?us-ascii?Q?b3YESNHnNj9bzZuq2jx6iEkrZ4oW/w2l+BFOEfkOdaoCQ8sJazJ0tk765juJ?=
 =?us-ascii?Q?ztAn9T3OK35u58FjfaqaNpLAUXlj1s+b5OCQEInhSX5WGXYl3YnHqTBnL0Kg?=
 =?us-ascii?Q?TmcT4lzJIm/SeCKQ/GcW0iqxk++GU5SpxL5PqmHDaFT4G3iWdHzqLxhDsWe4?=
 =?us-ascii?Q?GDltn2Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: WW/ovPInEivs2m8kaKkQOGEU0HPKWmeevTxpJfaf79SyQ065YDgQFZA0RSgK6gESyv8NHKvxj2btC8Y69GQtlCGQfbS8X68G0JEIhH64+qPDMmnwG6KseuVNF0XpmO7vRuXReutuOdds8Mi20mCDmE/DMYQpW3xRu/QRJzdjijrT0vaD6Lq7/nvdOqJklBSSl7YIIOJzQ3vcgKW82yz09ipPprbwz4Vfvebxx/p0Ci5miJzDUMflmqiS3ztz/OEmCzAPh5lpmOxWHtT3ra1rlcLiG0KNwyT4n6Oo2swqI60/22L+ew4uGdWdXnucO66QGWINoV0m1rEYw/YoyvKOFP4sCyFflMKwrOuuVhkU5/GiGEeGI8ShFscnjNBK20zOG8/3VD50bvXGkjPVqaIvtg==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1334;6:AzNZGSUy+bkWQD9NsOR6g+r9U6z9K21Ik4TGFL+G7vL1GiJ988Q3Ef2PtUipMEVGOpv1IaKNaUvI374EtL/WI0347vXSfWtShNKQtcNdn+LjF8czAcO7oaLd4uy7PsFbZ71ms6pczGaRuZfhK4Awg9K9sJUzyO88D08oXszuTY4tMy7YkNOuk5d/dykfxs0qg97bNjeeDAaHqrQ3Iah25Td+jxhjYthB6blKYzqwAQb1c6VNoamn3ri+XOvwBw4UED9K0Af82a5cnUhREicHxqyvFVP7dHA/eVIQt1XahAKxaquWMmgKgCc9nT7tYG7PbRu81GFGwGrv2RHu504SzqkBzBEi45jrFxX2zKssJhRqGSozVt5rWQ7yqcvKKFR9PPqgdH3MpJXqmNZ1wq3VlD+4sPXsqg0f+HoQ+qDDQ9w6uif36g00xVd6ZjTqUCCLsSULkcNwZzAxUnLBWZO6Bg==;5:ZrN37N3wlhXZcDY5wIFACZTVkQMumLjqmIaxS1Vmg5WA6HRNLItnDJfHctTaR2x+grNQCah3bR+1C2KqrEvafjrBqdL8fHNuY5rvwNF+Z7liR+eY2GWANGrG3NJL9pilepI/4lIa0xUlFCFCGNjJbd6LdbWjaNYN0Kyp2xsBrdw=;24:CJAIo0parR4ZXoMyItyl0nweWJ7L4Ipar1KTTcYxWZKbt/RtyykT1B4YvS1iiNPWTZKM7JE5sfRt40eRZx1XvKWPYHtW0PsTHR3R58Jc2qY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1334;7:4+1Hd/RkeOfWHpj+Ygajc0dw/+p2ypAFZVCdBfw8UeikNeb5BuQbkh6/GtF4//VJgHe1JhLKnoEfOgM82OFOKE6DphAPNDHQhJa5BOIBKWH4LZPwsrGgUH4LkRJrx7mzYB+q4DgNLxoelUbRsNugBLB9pJc2XJ5+L0YFiuueKdvJbzCkWhAadTpUDWzvxjbSTKeyfA2TKxQUYGVhQuAiLnZZsSlmqdjUmemDmuPeXkOU5y1mMdtienstebGAskjF;20:F9iGycX+gq+77jxQSKPUiaJMPHekVQEJyof40gSP0KQ3t3a8zWci8MXTDLtjOfoVxh35iLUWCEDPLJkW1xc3i33j/+QPzfN0SUVCc726jrExYIBdJ379U78QiFfZs8cBO3NLsnnd9eLRGOrinP1ewDGibj2i3GHDwNoztGxgb5BYOKz/WTj+fWgyjPXIazd7fICXbxS9yELOXyTrhUvrqwwZEMds78oavD721EVYe+hbxNP6KWKT/I0UqioRMD1m
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:04:02.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b8a607-cf7c-4992-288b-08d5e0cc4db7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c |  953 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/cdn-dp-core.h |   25 +
 drivers/gpu/drm/rockchip/cdn-dp-reg.c  |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h  |    4 +
 4 files changed, 960 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index c6fbdcd..64e3ab0 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -18,6 +18,7 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
+#include <drm/drm_bridge.h>
 
 #include <linux/clk.h>
 #include <linux/component.h>
@@ -27,6 +28,7 @@
 #include <linux/reset.h>
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <linux/iopoll.h>
 
 #include <sound/hdmi-codec.h>
 
@@ -49,7 +51,11 @@
 
 #define CDN_FW_TIMEOUT_MS	(64 * 1000)
 #define CDN_DPCD_TIMEOUT_MS	5000
-#define CDN_DP_FIRMWARE		"rockchip/dptx.bin"
+#define RK_DP_FIRMWARE		"rockchip/dptx.bin"
+#define CDN_DP_FIRMWARE		"cadence/dptx.bin"
+
+#define FW_ALIVE_TIMEOUT_US		1000000
+#define HPD_EVENT_TIMEOUT		40000
 
 struct cdn_dp_data {
 	u8 max_phy;
@@ -62,7 +68,8 @@ struct cdn_dp_data rk3399_cdn_dp = {
 static const struct of_device_id cdn_dp_dt_ids[] = {
 	{ .compatible = "rockchip,rk3399-cdn-dp",
 		.data = (void *)&rk3399_cdn_dp },
-	{}
+	{ .compatible = "cdns,mhdp", .data = NULL },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, cdn_dp_dt_ids);
@@ -237,17 +244,27 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 	struct cdn_dp_device *dp = connector_to_dp(connector);
 	enum drm_connector_status status = connector_status_disconnected;
 
-	mutex_lock(&dp->lock);
-	if (dp->connected)
-		status = connector_status_connected;
-	mutex_unlock(&dp->lock);
+	if (dp->mhdp_ip) {
+		int ret = cdn_dp_get_hpd_status(dp);
+
+		if (ret > 0)
+			status = connector_status_connected;
+	} else {
+		mutex_lock(&dp->lock);
+		if (dp->connected)
+			status = connector_status_connected;
+		mutex_unlock(&dp->lock);
+	}
 
 	return status;
 }
 
 static void cdn_dp_connector_destroy(struct drm_connector *connector)
 {
-	drm_connector_unregister(connector);
+	struct cdn_dp_device *dp = connector_to_dp(connector);
+
+	if (!dp->mhdp_ip)
+		drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 }
 
@@ -258,6 +275,7 @@ static void cdn_dp_connector_destroy(struct drm_connector *connector)
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.dpms = drm_helper_connector_dpms,
 };
 
 static int cdn_dp_connector_get_modes(struct drm_connector *connector)
@@ -267,7 +285,12 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 	int ret = 0;
 
 	mutex_lock(&dp->lock);
-	edid = dp->edid;
+
+	if (dp->mhdp_ip)
+		edid = drm_do_get_edid(connector, cdn_dp_get_edid_block, dp);
+	else
+		edid = dp->edid;
+
 	if (edid) {
 		DRM_DEV_DEBUG_KMS(dp->dev, "got edid: width[%d] x height[%d]\n",
 				  edid->width_cm, edid->height_cm);
@@ -278,6 +301,7 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 			drm_mode_connector_update_edid_property(connector,
 								edid);
 	}
+
 	mutex_unlock(&dp->lock);
 
 	return ret;
@@ -360,7 +384,7 @@ static int cdn_dp_firmware_init(struct cdn_dp_device *dp)
 
 	ret = cdn_dp_set_firmware_active(dp, true);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "active ucpu failed: %d\n", ret);
+		DRM_DEV_ERROR(dp->dev, "active fw failed: %d\n", ret);
 		return ret;
 	}
 
@@ -706,8 +730,6 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 {
 	struct device *dev = dp->dev;
 	struct device_node *np = dev->of_node;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
 
 	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 	if (IS_ERR(dp->grf)) {
@@ -715,13 +737,6 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 		return PTR_ERR(dp->grf);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dp->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(dp->regs)) {
-		DRM_DEV_ERROR(dev, "ioremap reg failed\n");
-		return PTR_ERR(dp->regs);
-	}
-
 	dp->core_clk = devm_clk_get(dev, "core-clk");
 	if (IS_ERR(dp->core_clk)) {
 		DRM_DEV_ERROR(dev, "cannot get core_clk_dp\n");
@@ -897,7 +912,7 @@ static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
 	mutex_unlock(&dp->lock);
 
 	while (time_before(jiffies, timeout)) {
-		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
+		ret = request_firmware(&dp->fw, RK_DP_FIRMWARE, dp->dev);
 		if (ret == -ENOENT) {
 			msleep(sleep);
 			sleep *= 2;
@@ -974,8 +989,8 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 		}
 
 		/* If training result is changed, update the video config */
-		if (mode->clock &&
-		    (rate != dp->link.rate || lanes != dp->link.num_lanes)) {
+		if ((rate != dp->link.rate || lanes != dp->link.num_lanes) &&
+				mode->clock) {
 			ret = cdn_dp_config_video(dp);
 			if (ret) {
 				dp->connected = false;
@@ -1145,10 +1160,870 @@ int cdn_dp_resume(struct device *dev)
 	return 0;
 }
 
+static inline struct cdn_dp_device *bridge_to_dp(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct cdn_dp_device, bridge);
+}
+
+static unsigned int max_link_rate(struct cdn_mhdp_host host,
+				  struct cdn_mhdp_sink sink)
+{
+	return min(host.link_rate, sink.link_rate);
+}
+
+static void cdn_mhdp_link_training_init(struct cdn_dp_device *dp)
+{
+	u32 reg32;
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	/* Reset PHY configuration */
+	reg32 = CDN_PHY_COMMON_CONFIG | CDN_PHY_TRAINING_TYPE(1);
+	if (!(dp->host.lanes_cnt & SCRAMBLER_EN))
+		reg32 |= CDN_PHY_SCRAMBLER_BYPASS;
+
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, reg32);
+
+	cdn_dp_register_write(dp, CDN_DP_ENHNCD,
+			      dp->sink.enhanced & dp->host.enhanced);
+
+	cdn_dp_register_write(dp, CDN_DP_LANE_EN,
+			      CDN_DP_LANE_EN_LANES(dp->link.num_lanes));
+
+	drm_dp_link_configure(&dp->aux, &dp->link);
+
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, CDN_PHY_COMMON_CONFIG |
+			      CDN_PHY_TRAINING_EN | CDN_PHY_TRAINING_TYPE(1) |
+			      CDN_PHY_SCRAMBLER_BYPASS);
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_1 | DP_LINK_SCRAMBLING_DISABLE);
+}
+
+static void cdn_mhdp_get_adjust_train(struct cdn_dp_device *dp,
+				      u8 link_status[DP_LINK_STATUS_SIZE],
+				      u8 lanes_data[DP_MAX_NUM_LANES])
+{
+	unsigned int i;
+	u8 adjust, max_pre_emphasis, max_volt_swing;
+
+	max_pre_emphasis = CDN_PRE_EMPHASIS(dp->host.pre_emphasis)
+		<< DP_TRAIN_PRE_EMPHASIS_SHIFT;
+	max_volt_swing = CDN_VOLT_SWING(dp->host.volt_swing);
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		adjust = drm_dp_get_adjust_request_voltage(link_status, i);
+		lanes_data[i] = min_t(u8, adjust, max_volt_swing);
+		if (lanes_data[i] != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_SWING_REACHED;
+
+		adjust = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		lanes_data[i] |= min_t(u8, adjust, max_pre_emphasis);
+		if ((lanes_data[i] >> DP_TRAIN_PRE_EMPHASIS_SHIFT) != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
+	}
+}
+
+static void cdn_mhdp_adjust_requested_eq(struct cdn_dp_device *dp,
+					 u8 link_status[DP_LINK_STATUS_SIZE])
+{
+	unsigned int i;
+	u8 pre, volt, max_pre = CDN_VOLT_SWING(dp->host.volt_swing),
+	   max_volt = CDN_PRE_EMPHASIS(dp->host.pre_emphasis);
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		volt = drm_dp_get_adjust_request_voltage(link_status, i);
+		pre = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		if (volt + pre > 3)
+			drm_dp_set_adjust_request_voltage(link_status, i,
+							  3 - pre);
+		if (dp->host.volt_swing & CDN_FORCE_VOLT_SWING)
+			drm_dp_set_adjust_request_voltage(link_status, i,
+							  max_volt);
+		if (dp->host.pre_emphasis & CDN_FORCE_PRE_EMPHASIS)
+			drm_dp_set_adjust_request_pre_emphasis(link_status, i,
+							       max_pre);
+	}
+}
+
+static bool cdn_mhdp_link_training_channel_eq(struct cdn_dp_device *dp,
+					      u8 eq_tps,
+					      unsigned int training_interval)
+{
+	u8 lanes_data[DP_MAX_NUM_LANES], fail_counter_short = 0;
+	u8 *dpcd;
+	u32 reg32;
+
+	dpcd = kzalloc(sizeof(u8) * DP_LINK_STATUS_SIZE, GFP_KERNEL);
+
+	dev_dbg(dp->dev, "Link training - Starting EQ phase\n");
+
+	/* Enable link training TPS[eq_tps] in PHY */
+	reg32 = CDN_PHY_COMMON_CONFIG | CDN_PHY_TRAINING_EN |
+		CDN_PHY_TRAINING_TYPE(eq_tps);
+	if (eq_tps != 4)
+		reg32 |= CDN_PHY_SCRAMBLER_BYPASS;
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   (eq_tps != 4) ? eq_tps | DP_LINK_SCRAMBLING_DISABLE :
+			   CDN_DP_TRAINING_PATTERN_4);
+
+	drm_dp_dpcd_read_link_status(&dp->aux, dpcd);
+
+	do {
+		cdn_mhdp_get_adjust_train(dp, dpcd, lanes_data);
+
+		cdn_dp_adjust_lt(dp, dp->link.num_lanes,
+				 training_interval, lanes_data, dpcd);
+
+		if (!drm_dp_clock_recovery_ok(dpcd, dp->link.num_lanes))
+			goto err;
+
+		if (drm_dp_channel_eq_ok(dpcd, dp->link.num_lanes)) {
+			dev_dbg(dp->dev,
+				"Link training: EQ phase succeeded\n");
+			kfree(dpcd);
+			return true;
+		}
+
+		fail_counter_short++;
+
+		cdn_mhdp_adjust_requested_eq(dp, dpcd);
+	} while (fail_counter_short < 5);
+
+err:
+	dev_dbg(dp->dev,
+		"Link training - EQ phase failed for %d lanes and %d rate\n",
+		dp->link.num_lanes, dp->link.rate);
+
+	kfree(dpcd);
+	return false;
+}
+
+static void cdn_mhdp_adjust_requested_cr(struct cdn_dp_device *dp,
+					 u8 link_status[DP_LINK_STATUS_SIZE],
+					 u8 *req_volt, u8 *req_pre)
+{
+	unsigned int i, max_volt = CDN_VOLT_SWING(dp->host.volt_swing),
+		     max_pre = CDN_PRE_EMPHASIS(dp->host.pre_emphasis);
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		if (dp->host.volt_swing & CDN_FORCE_VOLT_SWING)
+			drm_dp_set_adjust_request_voltage(link_status, i,
+							  max_volt);
+		else
+			drm_dp_set_adjust_request_voltage(link_status, i,
+							  req_volt[i]);
+
+		if (dp->host.pre_emphasis & CDN_FORCE_PRE_EMPHASIS)
+			drm_dp_set_adjust_request_pre_emphasis(link_status, i,
+							       max_pre);
+		else
+			drm_dp_set_adjust_request_pre_emphasis(link_status, i,
+							       req_pre[i]);
+	}
+}
+
+static void cdn_mhdp_validate_cr(struct cdn_dp_device *dp, bool *cr_done,
+				 bool *same_before_adjust,
+				 bool *max_swing_reached,
+				 u8 before_cr[DP_LINK_STATUS_SIZE],
+				 u8 after_cr[DP_LINK_STATUS_SIZE],
+				 u8 *req_volt, u8 *req_pre)
+{
+	unsigned int i;
+	u8 tmp, max_volt = CDN_VOLT_SWING(dp->host.volt_swing),
+	   max_pre = CDN_PRE_EMPHASIS(dp->host.pre_emphasis), lane_status;
+	bool same_pre, same_volt;
+
+	*same_before_adjust = false;
+	*max_swing_reached = false;
+	*cr_done = true;
+
+	for (i = 0; i < dp->link.num_lanes; i++) {
+		tmp = drm_dp_get_adjust_request_voltage(after_cr, i);
+		req_volt[i] = min_t(u8, tmp, max_volt);
+
+		tmp = drm_dp_get_adjust_request_pre_emphasis(after_cr, i) >>
+			DP_TRAIN_PRE_EMPHASIS_SHIFT;
+		req_pre[i] = min_t(u8, tmp, max_pre);
+
+		same_pre = (before_cr[i] & DP_TRAIN_PRE_EMPHASIS_MASK) ==
+			(req_pre[i] << DP_TRAIN_PRE_EMPHASIS_SHIFT);
+		same_volt = (before_cr[i] & DP_TRAIN_VOLTAGE_SWING_MASK) ==
+			req_volt[i];
+		if (same_pre && same_volt)
+			*same_before_adjust = true;
+
+		lane_status = drm_dp_get_lane_status(after_cr, i);
+		if (!(lane_status & DP_LANE_CR_DONE)) {
+			*cr_done = false;
+			/* 3.1.5.2 in DP Standard v1.4. Table 3-1 */
+			if (req_volt[i] + req_pre[i] >= 3) {
+				*max_swing_reached = true;
+				return;
+			}
+		}
+	}
+}
+
+static bool cdn_mhdp_link_training_clock_recovery(struct cdn_dp_device *dp)
+{
+	u8 lanes_data[DP_MAX_NUM_LANES], fail_counter_short = 0,
+	   fail_counter_cr_long = 0;
+	u8 *dpcd;
+	bool cr_done;
+
+	dpcd = kzalloc(sizeof(u8) * DP_LINK_STATUS_SIZE, GFP_KERNEL);
+
+	dev_dbg(dp->dev, "Link training starting CR phase\n");
+
+	cdn_mhdp_link_training_init(dp);
+
+	drm_dp_dpcd_read_link_status(&dp->aux, dpcd);
+
+	do {
+		u8 requested_adjust_volt_swing[DP_MAX_NUM_LANES] = {},
+		   requested_adjust_pre_emphasis[DP_MAX_NUM_LANES] = {};
+		bool same_before_adjust, max_swing_reached;
+
+		cdn_mhdp_get_adjust_train(dp, dpcd, lanes_data);
+
+		cdn_dp_adjust_lt(dp, dp->link.num_lanes, 100,
+				 lanes_data, dpcd);
+
+		cdn_mhdp_validate_cr(dp, &cr_done, &same_before_adjust,
+				     &max_swing_reached, lanes_data, dpcd,
+				     requested_adjust_volt_swing,
+				     requested_adjust_pre_emphasis);
+
+		if (max_swing_reached)
+			goto err;
+
+		if (cr_done) {
+			dev_dbg(dp->dev,
+				"Link training: CR phase succeeded\n");
+			kfree(dpcd);
+			return true;
+		}
+
+		/* Not all CR_DONE bits set */
+		fail_counter_cr_long++;
+
+		if (same_before_adjust) {
+			fail_counter_short++;
+			continue;
+		}
+
+		fail_counter_short = 0;
+		/*
+		 * Voltage swing/pre-emphasis adjust requested during CR phase
+		 */
+		cdn_mhdp_adjust_requested_cr(dp, dpcd,
+					     requested_adjust_volt_swing,
+					     requested_adjust_pre_emphasis);
+	} while (fail_counter_short < 5 && fail_counter_cr_long < 10);
+
+err:
+	dev_dbg(dp->dev,
+		"Link training: CR phase failed for %d lanes and %d rate\n",
+		dp->link.num_lanes, dp->link.rate);
+
+	kfree(dpcd);
+
+	return false;
+}
+
+static void lower_link_rate(struct drm_dp_link *link)
+{
+	switch (drm_dp_link_rate_to_bw_code(link->rate)) {
+	case DP_LINK_BW_2_7:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_1_62);
+		break;
+	case DP_LINK_BW_5_4:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_2_7);
+		break;
+	case DP_LINK_BW_8_1:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+		break;
+	}
+}
+
+static u8 eq_training_pattern_supported(struct cdn_mhdp_host *host,
+					struct cdn_mhdp_sink *sink)
+{
+	return fls(host->pattern_supp & sink->pattern_supp);
+}
+
+static int cdn_mhdp_link_training(struct cdn_dp_device *dp,
+				  unsigned int video_mode,
+				  unsigned int training_interval)
+{
+	u32 reg32;
+	u8 eq_tps = eq_training_pattern_supported(&dp->host, &dp->sink);
+
+	while (1) {
+		if (!cdn_mhdp_link_training_clock_recovery(dp)) {
+			if (drm_dp_link_rate_to_bw_code(dp->link.rate) !=
+					DP_LINK_BW_1_62) {
+				dev_dbg(dp->dev,
+					"Reducing link rate during CR phase\n");
+				lower_link_rate(&dp->link);
+				drm_dp_link_configure(&dp->aux, &dp->link);
+
+				continue;
+			} else if (dp->link.num_lanes > 1) {
+				dev_dbg(dp->dev,
+					"Reducing lanes number during CR phase\n");
+				dp->link.num_lanes >>= 1;
+				dp->link.rate = max_link_rate(dp->host,
+							      dp->sink);
+				drm_dp_link_configure(&dp->aux, &dp->link);
+
+				continue;
+			}
+
+			dev_dbg(dp->dev,
+				"Link training failed during CR phase\n");
+			goto err;
+		}
+
+		if (cdn_mhdp_link_training_channel_eq(dp, eq_tps,
+						      training_interval))
+			break;
+
+		if (dp->link.num_lanes > 1) {
+			dev_dbg(dp->dev,
+				"Reducing lanes number during EQ phase\n");
+			dp->link.num_lanes >>= 1;
+			drm_dp_link_configure(&dp->aux, &dp->link);
+
+			continue;
+		} else if (drm_dp_link_rate_to_bw_code(dp->link.rate) !=
+			   DP_LINK_BW_1_62) {
+			dev_dbg(dp->dev,
+				"Reducing link rate during EQ phase\n");
+			lower_link_rate(&dp->link);
+			drm_dp_link_configure(&dp->aux, &dp->link);
+
+			continue;
+		}
+
+		dev_dbg(dp->dev, "Link training failed during EQ phase\n");
+		goto err;
+	}
+
+	dev_dbg(dp->dev, "Link training successful\n");
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   (dp->host.lanes_cnt & SCRAMBLER_EN) ? 0 :
+			   DP_LINK_SCRAMBLING_DISABLE);
+
+	/* SW reset DPTX framer */
+	cdn_dp_register_write(dp, CDN_DP_SW_RESET, 1);
+	cdn_dp_register_write(dp, CDN_DP_SW_RESET, 0);
+
+	/* Enable framer */
+	/* FIXME: update when MST supported, BIT(2) */
+	cdn_dp_register_write(dp, CDN_DP_FRAMER_GLOBAL_CONFIG,
+			      CDN_DP_FRAMER_EN |
+			      CDN_DP_NUM_LANES(dp->link.num_lanes) |
+			      CDN_DP_DISABLE_PHY_RST |
+			      CDN_DP_WR_FAILING_EDGE_VSYNC |
+			      (video_mode ? CDN_DP_NO_VIDEO_MODE : 0));
+
+	/* Reset PHY config */
+	reg32 = CDN_PHY_COMMON_CONFIG | CDN_PHY_TRAINING_TYPE(1);
+	if (!(dp->host.lanes_cnt & SCRAMBLER_EN))
+		reg32 |= CDN_PHY_SCRAMBLER_BYPASS;
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, reg32);
+
+	return 0;
+err:
+	/* Reset PHY config */
+	reg32 = CDN_PHY_COMMON_CONFIG | CDN_PHY_TRAINING_TYPE(1);
+	if (!(dp->host.lanes_cnt & SCRAMBLER_EN))
+		reg32 |= CDN_PHY_SCRAMBLER_BYPASS;
+	cdn_dp_register_write(dp, CDN_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	return -EIO;
+}
+
+static void cdn_mhdp_enable(struct drm_bridge *bridge)
+{
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+	struct drm_display_mode *mode;
+	struct drm_display_info *disp_info = &dp->connector.display_info;
+	enum vic_pxl_encoding_format pxlfmt;
+	int pxlclock;
+	unsigned int rate, tu_size = 30, vs, vs_f, bpp, required_bandwidth,
+		     available_bandwidth, dp_framer_sp = 0, msa_horizontal_1,
+		     msa_vertical_1, bnd_hsync2vsync, hsync2vsync_pol_ctrl,
+		     misc0 = 0, misc1 = 0, line_thresh = 0, pxl_repr,
+		     front_porch, back_porch, msa_h0, msa_v0, hsync, vsync,
+		     dp_vertical_1, line_thresh1, line_thresh2;
+	u32 reg_rd_resp;
+
+	unsigned int size = DP_RECEIVER_CAP_SIZE, dp_framer_global_config,
+		     video_mode, training_interval_us;
+	u8 reg0[size], reg8, amp[2];
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	pxlclock = mode->crtc_clock;
+
+	/*
+	 * Upon power-on reset/device disconnection: [2:0] bits should be 0b001
+	 * and [7:5] bits 0b000.
+	 */
+	drm_dp_dpcd_writeb(&dp->aux, DP_SET_POWER, 1);
+
+	drm_dp_link_probe(&dp->aux, &dp->link);
+
+	dev_dbg(dp->dev, "Set sink device power state via DPCD\n");
+	drm_dp_link_power_up(&dp->aux, &dp->link);
+	/* FIXME (CDNS): do we have to wait for 100ms before going on? */
+	mdelay(100);
+
+	dp->sink.link_rate = dp->link.rate;
+	dp->sink.lanes_cnt = dp->link.num_lanes;
+	dp->sink.enhanced = !!(dp->link.capabilities &
+			DP_LINK_CAP_ENHANCED_FRAMING);
+
+	drm_dp_dpcd_read(&dp->aux, DP_DPCD_REV, reg0, size);
+
+	dp->sink.pattern_supp = PTS1 | PTS2;
+	if (drm_dp_tps3_supported(reg0))
+		dp->sink.pattern_supp |= PTS3;
+	if (drm_dp_tps4_supported(reg0))
+		dp->sink.pattern_supp |= PTS4;
+
+	dp->sink.fast_link = !!(reg0[DP_MAX_DOWNSPREAD] &
+			DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
+
+	dp->link.rate = max_link_rate(dp->host, dp->sink);
+	dp->link.num_lanes = min_t(u8, dp->sink.lanes_cnt,
+			dp->host.lanes_cnt & GENMASK(2, 0));
+
+	reg8 = reg0[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_INTERVAL_MASK;
+	switch (reg8) {
+	case 0:
+		training_interval_us = 400;
+		break;
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		training_interval_us = 4000 << (reg8 - 1);
+		break;
+	default:
+		dev_err(dp->dev,
+			"wrong training interval returned by DPCD: %d\n",
+			reg8);
+		return;
+	}
+
+	cdn_dp_register_read(dp, CDN_DP_FRAMER_GLOBAL_CONFIG, &reg_rd_resp);
+
+	dp_framer_global_config = reg_rd_resp;
+
+	video_mode = !(dp_framer_global_config & CDN_DP_NO_VIDEO_MODE);
+
+	if (dp_framer_global_config & CDN_DP_FRAMER_EN)
+		cdn_dp_register_write(dp, CDN_DP_FRAMER_GLOBAL_CONFIG,
+				      dp_framer_global_config &
+				      ~CDN_DP_FRAMER_EN);
+
+	/* Spread AMP if required, enable 8b/10b coding */
+	amp[0] = (dp->host.lanes_cnt & SSC) ? DP_SPREAD_AMP_0_5 : 0;
+	amp[1] = DP_SET_ANSI_8B10B;
+	drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, amp, 2);
+
+	if (dp->host.fast_link & dp->sink.fast_link) {
+		/* FIXME: implement fastlink */
+		DRM_DEV_DEBUG_KMS(dp->dev, "fastlink\n");
+	} else {
+		int lt_result = cdn_mhdp_link_training(dp, video_mode,
+						       training_interval_us);
+		if (lt_result) {
+			dev_err(dp->dev, "Link training failed. Exiting.\n");
+			return;
+		}
+	}
+
+	rate = dp->link.rate / 1000;
+
+	/* FIXME: what about Y_ONLY? how is it handled in the kernel? */
+	if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		pxlfmt = YCBCR_4_4_4;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		pxlfmt = YCBCR_4_2_2;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB420)
+		pxlfmt = YCBCR_4_2_0;
+	else
+		pxlfmt = PXL_RGB;
+
+	/* if YCBCR supported and stream not SD, use ITU709 */
+	/* FIXME: handle ITU version with YCBCR420 when supported */
+	if ((pxlfmt == YCBCR_4_4_4 ||
+			pxlfmt == YCBCR_4_2_2) && mode->crtc_vdisplay >= 720)
+		misc0 = DP_YCBCR_COEFFICIENTS_ITU709;
+
+	switch (pxlfmt) {
+	case PXL_RGB:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDN_DP_FRAMER_RGB << CDN_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_RGB;
+		break;
+	case YCBCR_4_4_4:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDN_DP_FRAMER_YCBCR444 << CDN_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr444 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case YCBCR_4_2_2:
+		bpp = disp_info->bpc * 2;
+		pxl_repr = CDN_DP_FRAMER_YCBCR422 << CDN_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr422 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case YCBCR_4_2_0:
+		bpp = disp_info->bpc * 3 / 2;
+		pxl_repr = CDN_DP_FRAMER_YCBCR420 << CDN_DP_FRAMER_PXL_FORMAT;
+		break;
+	default:
+		bpp = disp_info->bpc;
+		pxl_repr = CDN_DP_FRAMER_Y_ONLY << CDN_DP_FRAMER_PXL_FORMAT;
+	}
+
+	switch (disp_info->bpc) {
+	case 6:
+		misc0 |= DP_TEST_BIT_DEPTH_6;
+		pxl_repr |= CDN_DP_FRAMER_6_BPC;
+		break;
+	case 8:
+		misc0 |= DP_TEST_BIT_DEPTH_8;
+		pxl_repr |= CDN_DP_FRAMER_8_BPC;
+		break;
+	case 10:
+		misc0 |= DP_TEST_BIT_DEPTH_10;
+		pxl_repr |= CDN_DP_FRAMER_10_BPC;
+		break;
+	case 12:
+		misc0 |= DP_TEST_BIT_DEPTH_12;
+		pxl_repr |= CDN_DP_FRAMER_12_BPC;
+		break;
+	case 16:
+		misc0 |= DP_TEST_BIT_DEPTH_16;
+		pxl_repr |= CDN_DP_FRAMER_16_BPC;
+		break;
+	}
+
+	/* find optimal tu_size */
+	required_bandwidth = pxlclock * bpp / 8;
+	available_bandwidth = dp->link.num_lanes * rate;
+	do {
+		tu_size += 2;
+
+		vs_f = tu_size * required_bandwidth / available_bandwidth;
+		vs = vs_f / 1000;
+		vs_f = vs_f % 1000;
+		/* FIXME downspreading? It's unused is what I've been told. */
+	} while ((vs == 1 || ((vs_f > 850 || vs_f < 100) && vs_f != 0) ||
+			tu_size - vs < 2) && tu_size < 64);
+
+	if (vs > 64)
+		return;
+
+	bnd_hsync2vsync = CDN_IP_BYPASS_V_INTERFACE;
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		bnd_hsync2vsync |= CDN_IP_DET_INTERLACE_FORMAT;
+
+	cdn_dp_register_write(dp, BND_HSYNC2VSYNC, bnd_hsync2vsync);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
+			mode->flags & DRM_MODE_FLAG_PHSYNC)
+		hsync2vsync_pol_ctrl = CDN_H2V_HSYNC_POL_ACTIVE_LOW |
+			CDN_H2V_VSYNC_POL_ACTIVE_LOW;
+	else
+		hsync2vsync_pol_ctrl = 0;
+
+	cdn_dp_register_write(dp, CDN_HSYNC2VSYNC_POL_CTRL,
+			      hsync2vsync_pol_ctrl);
+
+	cdn_dp_register_write(dp, CDN_DP_FRAMER_TU, CDN_DP_FRAMER_TU_VS(vs) |
+			      CDN_DP_FRAMER_TU_SIZE(tu_size) |
+			      CDN_DP_FRAMER_TU_CNT_RST_EN);
+
+	cdn_dp_register_write(dp, CDN_DP_FRAMER_PXL_REPR, pxl_repr);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		dp_framer_sp |= CDN_DP_FRAMER_INTERLACE;
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		dp_framer_sp |= CDN_DP_FRAMER_HSYNC_POL_LOW;
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		dp_framer_sp |= CDN_DP_FRAMER_VSYNC_POL_LOW;
+	cdn_dp_register_write(dp, CDN_DP_FRAMER_SP, dp_framer_sp);
+
+	front_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	back_porch = mode->crtc_htotal - mode->crtc_hsync_end;
+	cdn_dp_register_write(dp, CDN_DP_FRONT_BACK_PORCH,
+			      CDN_DP_FRONT_PORCH(front_porch) |
+			      CDN_DP_BACK_PORCH(back_porch));
+
+	cdn_dp_register_write(dp, CDN_DP_BYTE_COUNT,
+			      mode->crtc_hdisplay * bpp / 8);
+
+	msa_h0 = mode->crtc_htotal - mode->crtc_hsync_start;
+	cdn_dp_register_write(dp, CDN_DP_MSA_HORIZONTAL_0,
+			      CDN_DP_MSAH0_H_TOTAL(mode->crtc_htotal) |
+			      CDN_DP_MSAH0_HSYNC_START(msa_h0));
+
+	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	msa_horizontal_1 = CDN_DP_MSAH1_HSYNC_WIDTH(hsync) |
+		CDN_DP_MSAH1_HDISP_WIDTH(mode->crtc_hdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		msa_horizontal_1 |= CDN_DP_MSAH1_HSYNC_POL_LOW;
+	cdn_dp_register_write(dp, CDN_DP_MSA_HORIZONTAL_1, msa_horizontal_1);
+
+	msa_v0 = mode->crtc_vtotal - mode->crtc_vsync_start;
+	cdn_dp_register_write(dp, CDN_DP_MSA_VERTICAL_0,
+			      CDN_DP_MSAV0_V_TOTAL(mode->crtc_vtotal) |
+			      CDN_DP_MSAV0_VSYNC_START(msa_v0));
+
+	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	msa_vertical_1 = CDN_DP_MSAV1_VSYNC_WIDTH(vsync) |
+		CDN_DP_MSAV1_VDISP_WIDTH(mode->crtc_vdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		msa_vertical_1 |= CDN_DP_MSAV1_VSYNC_POL_LOW;
+	cdn_dp_register_write(dp, CDN_DP_MSA_VERTICAL_1, msa_vertical_1);
+
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+			mode->crtc_vtotal % 2 == 0)
+		misc1 = DP_TEST_INTERLACED;
+	if (pxlfmt == Y_ONLY)
+		misc1 |= DP_TEST_COLOR_FORMAT_RAW_Y_ONLY;
+	/* FIXME: use VSC SDP for Y420 */
+	/* FIXME: (CDN) no code for Y420 in bare metal test */
+	if (pxlfmt == YCBCR_4_2_0)
+		misc1 = DP_TEST_VSC_SDP;
+
+	cdn_dp_register_write(dp, CDN_DP_MSA_MISC, misc0 | (misc1 << 8));
+
+	/* FIXME: to be changed if MST mode */
+	cdn_dp_register_write(dp, CDN_DP_STREAM_CONFIG, 1);
+
+	cdn_dp_register_write(dp, CDN_DP_HORIZONTAL,
+			      CDN_DP_H_HSYNC_WIDTH(hsync) |
+			      CDN_DP_H_H_TOTAL(mode->crtc_hdisplay));
+
+	cdn_dp_register_write(dp, CDN_DP_VERTICAL_0,
+			      CDN_DP_V0_VHEIGHT(mode->crtc_vdisplay) |
+			      CDN_DP_V0_VSTART(msa_v0));
+
+	dp_vertical_1 = CDN_DP_V1_VTOTAL(mode->crtc_vtotal);
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+			mode->crtc_vtotal % 2 == 0)
+		dp_vertical_1 |= CDN_DP_V1_VTOTAL_EVEN;
+
+	cdn_dp_register_write(dp, CDN_DP_VERTICAL_1, dp_vertical_1);
+
+	cdn_dp_register_write_field(dp, CDN_DP_VB_ID, 2, 1,
+				    (mode->flags & DRM_MODE_FLAG_INTERLACE) ?
+				    CDN_DP_VB_ID_INTERLACED : 0);
+
+	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
+	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
+	line_thresh = line_thresh1 - line_thresh2 / dp->link.num_lanes;
+	line_thresh = (line_thresh >> 5) + 2;
+	cdn_dp_register_write(dp, CDN_DP_LINE_THRESH,
+			      line_thresh & GENMASK(5, 0));
+
+	cdn_dp_register_write(dp, CDN_DP_RATE_GOVERNOR_STATUS,
+			      CDN_DP_RG_TU_VS_DIFF((tu_size - vs > 3) ?
+			      0 : tu_size - vs));
+
+	cdn_dp_set_video_status(dp, 1);
+
+	/* __simu_enable_mhdp(dp->regs); */
+}
+
+static void cdn_mhdp_disable(struct drm_bridge *bridge)
+{
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+
+	/* __simu_disable_mhdp(dp->regs); */
+
+	cdn_dp_set_video_status(dp, 0);
+
+	drm_dp_link_power_down(&dp->aux, &dp->link);
+}
+
+static int cdn_mhdp_attach(struct drm_bridge *bridge)
+{
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+	struct drm_connector *conn = &dp->connector;
+	int ret;
+
+	conn->polled = DRM_CONNECTOR_POLL_CONNECT |
+		DRM_CONNECTOR_POLL_DISCONNECT;
+
+	ret = drm_connector_init(bridge->dev, conn,
+				 &cdn_dp_atomic_connector_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		dev_err(dp->dev, "failed to init connector\n");
+		return ret;
+	}
+
+	drm_connector_helper_add(conn, &cdn_dp_connector_helper_funcs);
+
+	ret = drm_mode_connector_attach_encoder(conn, bridge->encoder);
+	if (ret) {
+		dev_err(dp->dev, "failed to attach connector to encoder\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct drm_bridge_funcs cdn_mhdp_bridge_funcs = {
+	.enable = cdn_mhdp_enable,
+	.disable = cdn_mhdp_disable,
+	.attach = cdn_mhdp_attach,
+};
+
+static ssize_t cdn_mhdp_transfer(struct drm_dp_aux *aux,
+				 struct drm_dp_aux_msg *msg)
+{
+	struct cdn_dp_device *dp = dev_get_drvdata(aux->dev);
+	int ret;
+
+	if (msg->request != DP_AUX_NATIVE_WRITE &&
+			msg->request != DP_AUX_NATIVE_READ)
+		return -ENOTSUPP;
+
+	if (msg->request == DP_AUX_NATIVE_WRITE) {
+		int i;
+
+		for (i = 0; i < msg->size; ++i) {
+			ret = cdn_dp_dpcd_write(dp,
+						msg->address + i,
+						*((u8 *)msg->buffer + i));
+			if (!ret)
+				continue;
+
+			DRM_DEV_ERROR(dp->dev, "Failed to write DPCD\n");
+
+			return i;
+		}
+	} else {
+		ret = cdn_dp_dpcd_read(dp, msg->address, msg->buffer,
+				       msg->size);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev, "Failed to read DPCD\n");
+			return 0;
+		}
+	}
+
+	return msg->size;
+}
+
+int cdn_mhdp_probe(struct cdn_dp_device *dp)
+{
+	unsigned long clk_rate;
+	const struct firmware *fw;
+	int ret;
+	u32 reg;
+
+	dp->core_clk = devm_clk_get(dp->dev, "clk");
+	if (IS_ERR(dp->core_clk)) {
+		DRM_DEV_ERROR(dp->dev, "cannot get core_clk_dp\n");
+		return PTR_ERR(dp->core_clk);
+	}
+
+	drm_dp_aux_init(&dp->aux);
+	dp->aux.dev = dp->dev;
+	dp->aux.transfer = cdn_mhdp_transfer;
+
+	clk_rate = clk_get_rate(dp->core_clk);
+	cdn_dp_set_fw_clk(dp, clk_rate);
+
+	ret = request_firmware(&fw, CDN_DP_FIRMWARE, dp->dev);
+	if (ret) {
+		dev_err(dp->dev, "failed to load firmware (%s), ret: %d\n",
+			CDN_DP_FIRMWARE, ret);
+		return ret;
+	}
+
+	memcpy_toio(dp->regs + ADDR_IMEM, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	/* __simu_configure_mhdp(dp->regs); */
+
+	/* un-reset ucpu */
+	writel(0, dp->regs + APB_CTRL);
+
+	/* check the keep alive register to make sure fw working */
+	ret = readx_poll_timeout(readl, dp->regs + KEEP_ALIVE,
+				 reg, reg, 2000, FW_ALIVE_TIMEOUT_US);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dp->dev, "failed to loaded the FW reg = %x\n",
+			      reg);
+		return -EINVAL;
+	}
+
+	/*
+	 * FIXME (CDNS): how are the characteristics/features of the host
+	 * defined? Will they be always hardcoded?
+	 */
+	/* FIXME: link rate 2.7; num_lanes = 2, */
+	/* FIXME: read capabilities from PHY */
+	/* FIXME: get number of lanes */
+	dp->host.link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+	dp->host.lanes_cnt = LANE_4 | SCRAMBLER_EN;
+	dp->host.volt_swing = VOLTAGE_LEVEL_3;
+	dp->host.pre_emphasis = PRE_EMPHASIS_LEVEL_2;
+	dp->host.pattern_supp = PTS1 | PTS2 | PTS3 | PTS4;
+	dp->host.fast_link = 0;
+	dp->host.lane_mapping = LANE_MAPPING_FLIPPED;
+	dp->host.enhanced = true;
+
+	dp->bridge.of_node = dp->dev->of_node;
+	dp->bridge.funcs = &cdn_mhdp_bridge_funcs;
+
+	ret = cdn_dp_set_firmware_active(dp, true);
+	if (ret) {
+		DRM_DEV_ERROR(dp->dev, "active ucpu failed: %d\n", ret);
+		return ret;
+	}
+
+	/* __simu_phy_reset(dp->regs); */
+
+	ret = readl_poll_timeout(dp->regs + SW_EVENTS0, reg,
+				 reg & DPTX_HPD_EVENT, 500,
+				 HPD_EVENT_TIMEOUT);
+	if (ret) {
+		dev_err(dp->dev, "no HPD received %d\n", reg);
+		return -ENODEV;
+	}
+
+	drm_bridge_add(&dp->bridge);
+
+	/* __simu_configure2_mhdp(dp->regs); */
+
+	return 0;
+}
+
 static int cdn_dp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
+	struct resource *res;
 	struct cdn_dp_data *dp_data;
 	struct cdn_dp_port *port;
 	struct cdn_dp_device *dp;
@@ -1161,7 +2036,24 @@ static int cdn_dp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	dp->dev = dev;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dp->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dp->regs)) {
+		DRM_DEV_ERROR(dev, "ioremap reg failed\n");
+		return PTR_ERR(dp->regs);
+	}
+
 	match = of_match_node(cdn_dp_dt_ids, pdev->dev.of_node);
+	if (!match)
+		return -EINVAL;
+
+	dp->mhdp_ip = !strcmp("cdns,mhdp", match->compatible);
+
+	if (dp->mhdp_ip) {
+		cdn_mhdp_probe(dp);
+		goto skip_phy_init;
+	}
+
 	dp_data = (struct cdn_dp_data *)match->data;
 
 	for (i = 0; i < dp_data->max_phy; i++) {
@@ -1194,6 +2086,8 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	mutex_init(&dp->lock);
 	dev_set_drvdata(dev, dp);
 
+skip_phy_init:
+
 	cdn_dp_audio_codec_init(dp, dev);
 
 	return component_add(dev, &cdn_dp_component_ops);
@@ -1202,10 +2096,23 @@ static int cdn_dp_probe(struct platform_device *pdev)
 static int cdn_dp_remove(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
+	int ret;
 
 	platform_device_unregister(dp->audio_pdev);
-	cdn_dp_suspend(dp->dev);
-	component_del(&pdev->dev, &cdn_dp_component_ops);
+
+	if (dp->mhdp_ip) {
+		drm_bridge_remove(&dp->bridge);
+
+		ret = cdn_dp_set_firmware_active(dp, false);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev, "disabling fw failed: %d\n",
+				      ret);
+			return ret;
+		}
+	} else {
+		cdn_dp_suspend(dp->dev);
+		component_del(&pdev->dev, &cdn_dp_component_ops);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index f57e296..9c43f6d 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -69,6 +69,25 @@ struct cdn_dp_port {
 	u8 id;
 };
 
+struct cdn_mhdp_host {
+	unsigned int	link_rate;
+	u8	lanes_cnt;
+	u8	volt_swing;
+	u8	pre_emphasis;
+	u8	pattern_supp;
+	u8	fast_link;
+	u8	lane_mapping;
+	u8	enhanced;
+};
+
+struct cdn_mhdp_sink {
+	unsigned int	link_rate;
+	u8	lanes_cnt;
+	u8	pattern_supp;
+	u8	fast_link;
+	u8	enhanced;
+};
+
 struct cdn_dp_device {
 	struct device *dev;
 	struct drm_device *drm_dev;
@@ -108,5 +127,11 @@ struct cdn_dp_device {
 
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	bool sink_has_audio;
+	bool mhdp_ip;
+
+	struct cdn_mhdp_host host;
+	struct cdn_mhdp_sink sink;
+	struct drm_bridge bridge;
+	struct drm_dp_aux aux;
 };
 #endif  /* _CDN_DP_CORE_H */
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index b061cfc..52a284b 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -1060,7 +1060,7 @@ int cdn_dp_register_write(struct cdn_dp_device *dp, u32 addr, u32 value)
 }
 
 int cdn_dp_register_write_field(struct cdn_dp_device *dp, u32 addr,
-		u8 index, u8 nbits, u32 value)
+				u8 index, u8 nbits, u32 value)
 {
 	u8 msg[10];
 	int ret;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index b5472ad..135f36e 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -388,6 +388,10 @@
 #define LANE_MAPPING_NORMAL			0x1b
 #define LANE_MAPPING_FLIPPED			0xe4
 #define ENHANCED				1
+#define LANE_1					BIT(0)
+#define LANE_2					BIT(1)
+#define LANE_4					BIT(2)
+#define SSC					BIT(3)
 #define SCRAMBLER_EN				BIT(4)
 
 #define	FULL_LT_STARTED				BIT(0)
-- 
1.7.1

