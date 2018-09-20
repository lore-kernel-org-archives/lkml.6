Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B942BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AE621531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DHGgxJrp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QVld4Gh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AE621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbeITUmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:42:20 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49856 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732302AbeITUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:42:19 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KEsejL031597;
        Thu, 20 Sep 2018 07:56:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=hjL0HcJlrHS+QHQ9gpcTxXY+m/wkl6HxzYfeVuu+FlM=;
 b=DHGgxJrpd5CVLnWV64Mr3IeRnQLY3rEDhrZmefod9vsMOUQrvKf7Jb24QCjdt7WKoWeK
 fo49nrkoQ+vEundeqxws+EwsgzyEPeD0z4Uj9kS3ntaZBmSrKkBWDb8ePxRKf+X/+Kqz
 VG000oPoTGdOwB5FNTprFQ+nQa3mTJjHEZIFaNUVRs6l1KUUpyDaiPQHdw/Xko30Fi/7
 0q9tUTH4imxzmRaTmeL7S33TZAyaIF8LzCpRnutA2GxmJ6VneRSti2cpVUuWJVvf/0AX
 J9eCMIBFnkXf8We2YT/fdSWDBYka7H8IHyRxlVBu4O/ov6eJ0NcJ6BPo5lKXrMNskOjL 7A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0052.outbound.protection.outlook.com [216.32.181.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mgwnvk5t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 07:56:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjL0HcJlrHS+QHQ9gpcTxXY+m/wkl6HxzYfeVuu+FlM=;
 b=QVld4Gh12OsNErX6pcR8ZdtMr6vF3gcXKbEDdAxGhCwbzvx+XTtHVa0lqlXAZ6ye+G/3vvyAFcuWbQdKilZbk5RxghO2O38OhIa+aDZoOjUMBiKuciL3PnnebvW4VQTQqs2WJt+8Kf3CnQFGPSjzMl547RSp4oq5o0nIzXXKDYo=
Received: from BYAPR07CA0002.namprd07.prod.outlook.com (2603:10b6:a02:bc::15)
 by DM5PR07MB2953.namprd07.prod.outlook.com (2603:10b6:3:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 14:56:02 +0000
Received: from CO1NAM05FT031.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::209) by BYAPR07CA0002.outlook.office365.com
 (2603:10b6:a02:bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Thu, 20 Sep 2018 14:56:02 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT031.mail.protection.outlook.com (10.152.96.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1185.5 via Frontend Transport; Thu, 20 Sep 2018 14:56:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEtsWS002306
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 20 Sep 2018 07:56:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 20 Sep 2018 16:56:04 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 20 Sep 2018 16:56:03 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEttUG022372;
        Thu, 20 Sep 2018 15:55:55 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8KEtswp022357;
        Thu, 20 Sep 2018 15:55:54 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <pgaj@cadence.com>, <ltyrala@cadence.com>,
        <stelford@cadence.com>, <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v4 5/5] drm: bridge: add support for Cadence MHDP DPI/DP bridge
Date:   Thu, 20 Sep 2018 15:54:40 +0100
Message-ID: <1537455288-20223-6-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1537455288-20223-1-git-send-email-dkos@cadence.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(36092001)(199004)(189003)(246002)(50466002)(36756003)(76176011)(305945005)(7636002)(48376002)(105596002)(7416002)(5024004)(14444005)(478600001)(53946003)(106466001)(2906002)(51416003)(8676002)(5660300001)(50226002)(356003)(26826003)(8936002)(6666003)(476003)(86362001)(575784001)(4326008)(47776003)(186003)(486006)(87636003)(26005)(42186006)(16586007)(126002)(2201001)(54906003)(110136005)(11346002)(336012)(446003)(316002)(426003)(2616005)(921003)(83996005)(2101003)(1121003)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2953;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT031;1:EvX8pAjsF8kZrOnVmDiKddYjqgtz5dolS+G6tELrhAVIYddbRNfjhBwTW/zgNMSyHMNoeWu0COH3qjLp9jxILDggB06iDEc5isl/jUHH25DVK5skJebVBUjHcMzh42h7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72a73840-43f5-46bd-36ab-08d61f092ee1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:DM5PR07MB2953;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;3:HZGyUCNyfHm/YSFSZXDsS2v6smslkGT510tgYd9qtu5mXI5W/p/60Bk+xmuhTaBniW2i3VVd7q6pcQVIVdyYIUynxt5Ha1haz3dko0vQT9NR/yzktaGvLGntyMYBQhY5Tt23sMbZX27+vPIKje6X61txXwEvV8OLJE/FBt+jq0zAwMLqeKC/lzqDzq8t4dAct0dmRESPgyiuABWyYEKOTLI3vY2wfes+AVKsshs8F+6wtFShiWuYA7T2+ns7jRnfMn5M3/Eo+ukYTwMadsTG+kB7K4IMQFQQ5UymfMc4RzyxMVjc3SJbnAPslFz565smSGiqcfkJQzblXdM+OhybjAvCO+EELZt62WbKDoRFAQ4=;25:XE9D/Gs1wxdtDBH42msbmuzOm9UIr6e3lx6nRg1I06n5jyNIQxlkb2Ohw+AiRk342ulUMi0wiEQtW6i5vIz/ClbDFWl/YueZo6rq9IDxWjV1pwVdieK7S85fZdhkMeDEdc914tjWvnDhas2r0QvQZ6gpOLxqwU64X4Jbwu7b2iBoWGdTAuXnFjfaNT8I3d1rXS7rIV/d9/gLflX/pU69K14Ns7PmHc22F9FxnL2CzPO2vMmI96qlfPjmJQyVGY7Ubz2XwPEo4xu4B1PXTKWsPDGaqdOfJThEiPeUG3MzW4JvT38pBcLa1Zppjr1AsRf5/c+GAIjne+LRL10neyzQcw==
X-MS-TrafficTypeDiagnostic: DM5PR07MB2953:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;31:bj9Ao7pH9GnWAEJ2QMJwHQ4DnW/dnv2S/je8XQt0ScBxe3lHzcWtqqn7TByNV/zbaVIOye7L5LFFASB5e62EvG4Z/BRYqkgx4RsQyD+7K97UH9uf9dBETsFTqHNXgC5nPMKlWBc4qucBARmtnJc9UkL45jZplAOd+Ialwu95QdmoMwMI7H+VhB8pT5JQGb2dfAhy+WI5AeV2wAOaADMI/GEZeorx6J0i/sNt5F8cHIk=;20:8z4dKThwEmyFmSBJciDWlv7jLilpxSsbOJJ3RyH3+tRQvHwNUFvSn1pXMy5v8F4BUnCi+mVeKGEhdDyNPcmPE0nXijQLycaDamYjL6wbZiaob0lu52WceR69agzLMvO7R0XJi5CPiaRN9pYqdHC5k/xMWZG3lvLXLhMUB7h4UF3akPehOhA9lK9E71xc4JYrz4hhE1dFC6SjKv99PNDzOP4DO8sh13dJfRxR/LfYDM2PdFKXSQMlieHGXMKa4+4vgXfVxMX/lL0ptYFkEwQ46q6rKqgDkxVcNeogRtBUJinmaQbI9y2Od62yvm8o8wqFYkY9P/YtNZpr/qtk/sTsoUwVc9FWPfzGQHjktdFvm6FxDZBeqZKuc5ixmH1EadXlu2vSIUndNLSgtjyo9Of0o1ABrwOGvI7iZ/Wo+DXD9L/lTOsvqEOzuLORiEQiF/hxcUJWHLyJa5+y3H2W5Se7a/gd6aMpGTS8zcGMODcT2ylVsZOTG6SoVNPGKf243mhT
X-Microsoft-Antispam-PRVS: <DM5PR07MB2953B9AA7EB2002796AFA92DCD130@DM5PR07MB2953.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93003095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DM5PR07MB2953;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2953;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;4:GJrNPUfrQ06igoYlQq/DOFyKRGHM5cD1/Yll5G9zhNSEHHwnBv8WFPvdtGjR1TZv2kGY6DiGhI4PJ16+aP+YcqYta4zKL3M2cLi+RMtCiu3jSjMWZg/G9Bg3BY/hjk8R5JT8Jdsw9sp9pZ+dxtkaJf0hiYCuTwt2lsta3mvy7MJyGVWUWVxM0PA7/MMQrDQbCLCXs5qQg17Yhkq9qLRMvKEoYRY6nGgscGmtwOWu76lNzPgkJGxfu4RsY+xiC9QfmyQN0pppiup8QLNdq55cnt+HQb+o3U4XLSi+YDf8LUJ0quSmIl49AFG+cNfY1MTn46JaVzyzrKuPpdlrnkoE05FYLAywZ/xldln7miOEMVk=
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2953;23:popEjJkZTv3IHKyICCet2JPOHVfi76T3NW7krSv+D?=
 =?us-ascii?Q?XbauyCfM6wXnwr64C7wPkCO680tjh7DksZCxWqr1O4+ohotTtSwn9gAwl6Y6?=
 =?us-ascii?Q?Vmj7cQlvbIbpN6JrrpSsEiVleDGR9xNHKXs10oFfMJQPyQ9PZVCY+B+k6ysC?=
 =?us-ascii?Q?SUwB3s4fY1LJmtTd1Ht6rFHMlmleN0pXvRWIJYuX8OKJwQHZGZBsqT7EzSJ4?=
 =?us-ascii?Q?t2Tj1XMt8HVDbLaPien0+0yne36bZH19DA+MGEPVNYsbrrDnOsRMFsFlE36r?=
 =?us-ascii?Q?8KSj/faygMmHIDHBPTbSsLENeFIF7p11Jdk8rHHL1C7TB39uaV4IJGmnOAXe?=
 =?us-ascii?Q?tK0zyTG+/jbAmN1CSHLf+m7VGTi1hqYDtiXxdhw03HKf2eUizJK3ScY+eOYy?=
 =?us-ascii?Q?hSwOJlujdG8A/RRYoTZgh22hun0T2sYh5oGUWQe+UDCzhxC78LzNExLhEEQb?=
 =?us-ascii?Q?ZaKF8JsEI5UwaGP5ywVhHpBUSFkY2dYRilEyRaelGeOjnjPbNC6NoLBMRbVH?=
 =?us-ascii?Q?iG03+Xrq16o5V/eysrE80VXWW2yvpBN1aUXf/sH/q0rbYd5dbXG0BRXdGDxk?=
 =?us-ascii?Q?w7wob1NPqkYwkuBCfdmEIHZ/TnNHeag2Qfw569XINlbJfRCYGnpOaDhFoPvf?=
 =?us-ascii?Q?YuUg+tMr7v+BJL4Fw0Xx58vVzeQT8DOebhexegwIdYO/vbZaLHrLUFD5QM5e?=
 =?us-ascii?Q?kWQy9HJd4OMouijlJDD6+ucYQwteznCDwwhdMZSTAdpEMIHAngezTeW2lYv8?=
 =?us-ascii?Q?XbG7f7dwdryasBpiXcOBNG8amDgOjy9vljresglG2RGb1nW06X1Ii5QtU8Jk?=
 =?us-ascii?Q?aTnaYBHid3jpTCBCtyJ+kzZFHSLUPCoEpgsYMCEgHM26+oCLeBBjuleIEaBe?=
 =?us-ascii?Q?B/TrMyswAmKN/QziRMrQrw4bHBztFBs8v7GfbYlEWLY5fUQWQlDK7YCSYijb?=
 =?us-ascii?Q?eQhcTwECiFNEiWjwv7o4p+k5UN7YkSIG5aQvtqPeHBVbbYMf599fa8kMzDka?=
 =?us-ascii?Q?9aOP3H2elGCyUp5uUnzCp8i2Nq27aOVw8A5QHYqPS+4YLSFgHaEpJow6zBpL?=
 =?us-ascii?Q?5SSg9Se0hqi+3vns8NU2d32wsvj4UJIh9kdI5OPddYEG90xfhfpYPeimzkgN?=
 =?us-ascii?Q?5xl5cvouZWaYBpFf1LA1Fu0zhuKcuMxzTcscJWt/uneFvAebLgts/r6uUVWQ?=
 =?us-ascii?Q?TKUPD/QGXJxe0vJohXjXwUvWM2qDQNBokSTlMbiRlDXU7PmLGTR2I+o1VG2k?=
 =?us-ascii?Q?yLYnnUmNppUQm3oUq63y5FhPsEuDjBBSDgH2kmB?=
X-Microsoft-Antispam-Message-Info: AsogwvbDfvqwmP0aQvm7S8xOmDDpTKeysngSQDZxu92H8RUUybqqGI6qmCQjMhHkiVwBpor3MxN3KFZjHZnKMKZic2VOU8qG/WlAVBdeCYMBMCQ5fCGR0l6F8w5+hQOyz0D8zb5Y7u0vaglbl/aSaBj3IaKdsW+cEUYBodQ7rok1+1FH7vHQcZXyF30Iv4kNlk6S7/4onLLTvA32Q4KJAKyJYpQFMuVQrZBoVpLW5jMN0c7PE1loguLJCfmnhVRt27Gc/2Jel1SHB985MJzbL523Sa8njGuqPs6biLDALkwpVxZObNg6xHvGHOJzNsgph/v/Lu8VEzEmx19wKugqg/wtBvElbtn/w/+9aYGzIlTv1BdvzUiCzmr6PKp89BTEASWZwKTAPvlkrkvp/dqCLw==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;6:q1QTf99KooEWi02FLE68jL+D47UfjOtjL4/xsMy3K+klhcD4UVaOC2MS89/sNqiVimI77tZDgkHM1AUZD6YRgwyHgu3q7DmwPSd7EpjgHszMbB8OAtBthpIKlKXXDRcphT7yJl+nBsCs7tR6DF9eqLalA9hkQT020JfVzkn4q588GeOTXdEbRwKOMcbH9HP0QiEPTKQoft7XQZlXr5x4dRwwTAtp9NUBZRJ2icR3WyiEUyM1njFSzIrYSafdkOhszCzVCiEnzzfnt9kZw8WDQ2u9ytw5zi965nZXER7cKi3IZJefpSE2fvu06FWAvj57tpkjg4HTTjGbTNJzcnU4CaW3nnMNgdEM1WWbFXHm6nismyVIL5rxR87uSIDe+74wRlwYanQG25WIIfNHqYOVa1h/R5jQ5MIJbGv6L/5vUVzvBmJuRU6M+DpEW4puo1Dp+Ls9e/GG2SXWOpPrZLuSgw==;5:t7P0c/LWVZxNwOZ7SlscDiIsHqQittLKiYP67NI6cUyKNRPm9jUXxdxUciwo70dNL1CImz84Yy5nVI6w8x01j9d9MJSPlvUklOQM37/ojUn+XkoJHT3Q/iNjHqkj5kY78of2eX7Rmq4jlO1UG1MnCmPLVpoPEpmvYnjLn2LX94U=;7:RMyEV4PhRfSqasqtXXZM38if2DScBVc6w6xuZUnpACtUIg2GBxUw0FJIX4VwN2EgCZBireUyi05yYjYPzT3KzpDV2FS+pVRhf0qwxi/k6E99Mzi60YAZOEXqpUYpgLv+5FBMptL5/e59iGikeKajwnB9X+PsfDKaSbB2BnYHN6bH7bjOnzDnq0XoPth5mkBKLExQ+9hOPT9FdmvINuyB58OFd5rplDUojfPktc9sO3r5xirxxUbgbxlylSI1I1tt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;20:N2W7t8kNXdTwexQGd9tsrAsSlZOKCPNDjIDq2K+KfwBA5/BVl7/yxHaZAb7mpcKlR3MbeDW2TSbeAL8DZjh5yDCYS3vbq67pp4Ko5en4WP7Lt3iVsq0fatgUnnVax7bigMApfeLU6B21oQVUYXxK8t9e2yaQjB3VgfNJ6y+UpKrjP/FVs0P15Y0ROO3UeSFTsgD3BW8uA7WHwVEziqyGqgPqbqYN6IigErqgIAVEVBw4e61wW3hcyRUeRrWKlyFP
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 14:56:01.5244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a73840-43f5-46bd-36ab-08d61f092ee1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2953
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809200148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

This adds basic support for Cadence MHDP DPI to DP bridge.

Basically, it takes a DPI stream as input and output it encoded in DP
format. It's missing proper HPD, HDCP and currently supports only
SST mode.

Changes made in the low level driver (cdn-dp-reg.*):
- moved it to from drivers/gpu/drm/rockchip to
  drivers/gpu/drm/bridge/cdns-mhdp-common.*
- functions for sending/receiving commands are now public
- added functions for reading registers and link training
  adjustment

Changes made in RK's driver (cdn-dp-core.*):
- Moved audio_info and audio_pdev fields from cdn_dp_device to
  cdns_mhdp_device structure.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 .../cdns-mhdp-common.c}                       |  137 +-
 .../cdns-mhdp-common.h}                       |   21 +-
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1308 +++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig              |    4 +-
 drivers/gpu/drm/rockchip/Makefile             |    4 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |   16 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |    4 +-
 9 files changed, 1486 insertions(+), 20 deletions(-)
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.c => bridge/cdns-mhdp-common.c} (87%)
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.h => bridge/cdns-mhdp-common.h} (95%)
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 9eeb8ef0b174..90a4810a8c96 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -35,6 +35,15 @@ config DRM_CDNS_DSI
 	  Support Cadence DPI to DSI bridge. This is an internal
 	  bridge and is meant to be directly embedded in a SoC.
 
+config DRM_CDNS_MHDP
+	tristate "Cadence DPI/DP bridge"
+	select DRM_KMS_HELPER
+	select DRM_PANEL_BRIDGE
+	depends on OF
+	help
+	  Support Cadence DPI to DP bridge. This is an internal
+	  bridge and is meant to be directly embedded in a SoC.
+
 config DRM_DUMB_VGA_DAC
 	tristate "Dumb VGA DAC Bridge support"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 4934fcf5a6f8..e802fdb85750 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -16,4 +16,7 @@ obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
 obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
 obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
+obj-$(CONFIG_DRM_CDNS_MHDP) += mhdp8546.o
 obj-y += synopsys/
+
+mhdp8546-objs := cdns-mhdp-common.o cdns-mhdp.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
similarity index 87%
rename from drivers/gpu/drm/rockchip/cdn-dp-reg.c
rename to drivers/gpu/drm/bridge/cdns-mhdp-common.c
index c1a76e6fff88..88cb248b9de4 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
@@ -19,8 +19,10 @@
 #include <linux/iopoll.h>
 #include <linux/reset.h>
 
-#include "cdn-dp-core.h"
-#include "cdn-dp-reg.h"
+#include <drm/drm_print.h>
+#include <drm/drm_modes.h>
+
+#include "cdns-mhdp-common.h"
 
 #define CDNS_DP_SPDIF_CLK		200000000
 #define FW_ALIVE_TIMEOUT_US		1000000
@@ -33,6 +35,7 @@ void cdns_mhdp_set_fw_clk(struct cdns_mhdp_device *mhdp, unsigned long clk)
 {
 	writel(clk / 1000000, mhdp->regs + SW_CLK_H);
 }
+EXPORT_SYMBOL(cdns_mhdp_set_fw_clk);
 
 void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp)
 {
@@ -82,6 +85,7 @@ void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp)
 	/* enable Mailbox and PIF interrupt */
 	writel(0, mhdp->regs + APB_INT_MASK);
 }
+EXPORT_SYMBOL(cdns_mhdp_clock_reset);
 
 static int cdns_mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
 {
@@ -189,7 +193,56 @@ static int cdns_mhdp_mailbox_send(struct cdns_mhdp_device *mhdp, u8 module_id,
 	return 0;
 }
 
-static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
+int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value)
+{
+	u8 msg[4], resp[8];
+	int ret;
+
+	if (addr == 0) {
+		ret = -EINVAL;
+		goto err_reg_read;
+	}
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_GENERAL,
+				     GENERAL_REGISTER_READ,
+				     sizeof(msg), msg);
+	if (ret)
+		goto err_reg_read;
+
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_GENERAL,
+						 GENERAL_REGISTER_READ,
+						 sizeof(resp));
+	if (ret)
+		goto err_reg_read;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, resp, sizeof(resp));
+	if (ret)
+		goto err_reg_read;
+
+	/* Returned address value should be the same as requested */
+	if (memcmp(msg, resp, sizeof(msg))) {
+		ret = -EINVAL;
+		goto err_reg_read;
+	}
+
+	*value = (resp[4] << 24) | (resp[5] << 16) | (resp[6] << 8) | resp[7];
+
+err_reg_read:
+	if (ret) {
+		DRM_DEV_ERROR(mhdp->dev, "Failed to read register.\n");
+		*value = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(cdns_mhdp_reg_read);
+
+int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 {
 	u8 msg[6];
 
@@ -202,8 +255,9 @@ static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
 				      DPTX_WRITE_REGISTER, sizeof(msg), msg);
 }
+EXPORT_SYMBOL(cdns_mhdp_reg_write);
 
-static int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
 				   u8 start_bit, u8 bits_no, u32 val)
 {
 	u8 field[8];
@@ -220,6 +274,7 @@ static int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
 	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
 				      DPTX_WRITE_FIELD, sizeof(field), field);
 }
+EXPORT_SYMBOL(cdns_mhdp_reg_write_bit);
 
 int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
 			u32 addr, u8 *data, u16 len)
@@ -252,6 +307,7 @@ int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
 err_dpcd_read:
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_dpcd_read);
 
 int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 {
@@ -286,6 +342,7 @@ int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 		DRM_DEV_ERROR(mhdp->dev, "dpcd write failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_dpcd_write);
 
 int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
 			    u32 i_size, const u32 *d_mem, u32 d_size)
@@ -328,6 +385,7 @@ int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
 
 	return 0;
 }
+EXPORT_SYMBOL(cdns_mhdp_load_firmware);
 
 int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 {
@@ -362,6 +420,7 @@ int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 		DRM_DEV_ERROR(mhdp->dev, "set firmware active failed\n");
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_firmware_active);
 
 int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip)
 {
@@ -391,6 +450,7 @@ int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip)
 		DRM_DEV_ERROR(mhdp->dev, "set host cap failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_host_cap);
 
 int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp)
 {
@@ -408,11 +468,13 @@ int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_event_config);
 
 u32 cdns_mhdp_get_event(struct cdns_mhdp_device *mhdp)
 {
 	return readl(mhdp->regs + SW_EVENTS0);
 }
+EXPORT_SYMBOL(cdns_mhdp_get_event);
 
 int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 {
@@ -440,6 +502,7 @@ int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 	DRM_DEV_ERROR(mhdp->dev, "get hpd status failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_get_hpd_status);
 
 int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 			  unsigned int block, size_t length)
@@ -482,6 +545,7 @@ int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_get_edid_block);
 
 static int cdns_mhdp_training_start(struct cdns_mhdp_device *mhdp)
 {
@@ -580,6 +644,7 @@ int cdns_mhdp_train_link(struct cdns_mhdp_device *mhdp)
 			  mhdp->link.num_lanes);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_train_link);
 
 int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active)
 {
@@ -595,6 +660,7 @@ int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_video_status);
 
 static int cdns_mhdp_get_msa_misc(struct video_info *video,
 				  struct drm_display_mode *mode)
@@ -797,6 +863,7 @@ int cdns_mhdp_config_video(struct cdns_mhdp_device *mhdp)
 		DRM_DEV_ERROR(mhdp->dev, "config video failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_config_video);
 
 int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 			 struct audio_info *audio)
@@ -831,6 +898,7 @@ int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 
 	return 0;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_stop);
 
 int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable)
 {
@@ -842,6 +910,7 @@ int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_mute);
 
 static void cdns_mhdp_audio_config_i2s(struct cdns_mhdp_device *mhdp,
 				       struct audio_info *audio)
@@ -977,3 +1046,63 @@ int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 		DRM_DEV_ERROR(mhdp->dev, "audio config failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_config);
+
+int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp,
+			u8 nlanes, u16 udelay, u8 *lanes_data, u8 *dpcd)
+{
+	u8 payload[7];
+	u8 hdr[5]; /* For DPCD read response header */
+	u32 addr;
+	u8 const nregs = 6; /* Registers 0x202-0x207 */
+	int ret;
+
+	if (nlanes != 4 && nlanes != 2 && nlanes != 1) {
+		DRM_DEV_ERROR(mhdp->dev, "invalid number of lanes: %d\n",
+			      nlanes);
+		ret = -EINVAL;
+		goto err_adjust_lt;
+	}
+
+	payload[0] = nlanes;
+	payload[1] = (u8)(udelay >> 8);
+	payload[2] = (u8)udelay;
+
+	payload[3] = lanes_data[0];
+	if (nlanes > 1)
+		payload[4] = lanes_data[1];
+	if (nlanes > 2) {
+		payload[5] = lanes_data[2];
+		payload[6] = lanes_data[3];
+	}
+
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_ADJUST_LT,
+				     sizeof(payload), payload);
+	if (ret)
+		goto err_adjust_lt;
+
+	/* Yes, read the DPCD read command response */
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_READ_DPCD,
+						 sizeof(hdr) + nregs);
+	if (ret)
+		goto err_adjust_lt;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, hdr, sizeof(hdr));
+	if (ret)
+		goto err_adjust_lt;
+
+	addr = (hdr[2] << 24) | (hdr[3] << 8) | hdr[4];
+	if (addr != DP_LANE0_1_STATUS)
+		goto err_adjust_lt;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, dpcd, nregs);
+
+err_adjust_lt:
+	if (ret)
+		DRM_DEV_ERROR(mhdp->dev, "Failed to adjust Link Training.\n");
+
+	return ret;
+}
+EXPORT_SYMBOL(cdns_mhdp_adjust_lt);
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/bridge/cdns-mhdp-common.h
similarity index 95%
rename from drivers/gpu/drm/rockchip/cdn-dp-reg.h
rename to drivers/gpu/drm/bridge/cdns-mhdp-common.h
index 3cb40d719515..c5a5c4fa7fc4 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-common.h
@@ -12,10 +12,13 @@
  * GNU General Public License for more details.
  */
 
-#ifndef _CDN_DP_REG_H
-#define _CDN_DP_REG_H
+#ifndef CDNS_MHDP_COMMON_H_
+#define CDNS_MHDP_COMMON_H_
 
 #include <linux/bitops.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_bridge.h>
 
 #define ADDR_IMEM		0x10000
 #define ADDR_DMEM		0x20000
@@ -327,6 +330,7 @@
 #define GENERAL_TEST_ECHO               0x02
 #define GENERAL_BUS_SETTINGS            0x03
 #define GENERAL_TEST_ACCESS             0x04
+#define GENERAL_REGISTER_READ           0x07
 
 #define DPTX_SET_POWER_MNG			0x00
 #define DPTX_SET_HOST_CAPABILITIES		0x01
@@ -346,6 +350,7 @@
 #define DPTX_SET_LINK_BREAK_POINT		0x0f
 #define DPTX_FORCE_LANES			0x10
 #define DPTX_HPD_STATE				0x11
+#define DPTX_ADJUST_LT				0x12
 
 #define FW_STANDBY				0
 #define FW_ACTIVE				1
@@ -517,6 +522,9 @@ struct cdns_mhdp_device {
 	struct clk		*spdif_clk;
 	struct reset_control	*spdif_rst;
 
+	struct platform_device	*audio_pdev;
+	struct audio_info	audio_info;
+
 	struct drm_dp_aux	aux;
 	struct cdns_mhdp_host	host;
 	struct cdns_mhdp_sink	sink;
@@ -551,4 +559,11 @@ int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable);
 int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 			   struct audio_info *audio);
-#endif /* _CDN_DP_REG_H */
+int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value);
+int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val);
+int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+				   u8 start_bit, u8 bits_no, u32 val);
+int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp, u8 nlanes,
+			u16 udelay, u8 *lanes_data,
+			u8 *dpcd);
+#endif /* CDNS_MHDP_COMMON_H_ */
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
new file mode 100644
index 000000000000..24e8fee3d79a
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
@@ -0,0 +1,1308 @@
+// SPDX-License-Identifier: GPL v2
+/*
+ * Cadence MHDP DP bridge driver.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Quentin Schulz <quentin.schulz@free-electrons.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+
+#include <sound/hdmi-codec.h>
+
+#include "cdns-mhdp-common.h"
+
+#define DEBUG_MSG
+
+#define FW_NAME					"cadence/mhdp8546.bin"
+
+#define CDNS_APB_CFG				0x00000
+#define CDNS_APB_CTRL				(CDNS_APB_CFG + 0x00)
+#define CDNS_MAILBOX_FULL			(CDNS_APB_CFG + 0x08)
+#define CDNS_MAILBOX_EMPTY			(CDNS_APB_CFG + 0x0c)
+#define CDNS_MAILBOX_TX_DATA			(CDNS_APB_CFG + 0x10)
+#define CDNS_MAILBOX_RX_DATA			(CDNS_APB_CFG + 0x14)
+#define CDNS_KEEP_ALIVE				(CDNS_APB_CFG + 0x18)
+#define CDNS_KEEP_ALIVE_MASK			GENMASK(7, 0)
+
+#define CDNS_SW_CLK_L				(CDNS_APB_CFG + 0x3c)
+#define CDNS_SW_CLK_H				(CDNS_APB_CFG + 0x40)
+#define CDNS_SW_EVENT0				(CDNS_APB_CFG + 0x44)
+#define CDNS_DPTX_HPD				BIT(0)
+
+#define CDNS_SW_EVENT1				(CDNS_APB_CFG + 0x48)
+#define CDNS_SW_EVENT2				(CDNS_APB_CFG + 0x4c)
+#define CDNS_SW_EVENT3				(CDNS_APB_CFG + 0x50)
+
+#define CDNS_DPTX_CAR				(CDNS_APB_CFG + 0x904)
+#define CDNS_VIF_CLK_EN				BIT(0)
+#define CDNS_VIF_CLK_RSTN			BIT(1)
+
+#define CDNS_SOURCE_VIDEO_INTERFACE		0x00b00
+#define CDNS_BND_HSYNC2VSYNC			(CDNS_SOURCE_VIDEO_INTERFACE + \
+						 0x00)
+#define CDNS_IP_DTCT_WIN			GENMASK(11, 0)
+#define CDNS_IP_DET_INTERLACE_FORMAT		BIT(12)
+#define CDNS_IP_BYPASS_V_INTERFACE		BIT(13)
+
+#define CDNS_HSYNC2VSYNC_POL_CTRL		(CDNS_SOURCE_VIDEO_INTERFACE + \
+						 0x10)
+#define CDNS_H2V_HSYNC_POL_ACTIVE_LOW		BIT(1)
+#define CDNS_H2V_VSYNC_POL_ACTIVE_LOW		BIT(2)
+
+#define CDNS_DPTX_PHY_CONFIG			0x02000
+#define CDNS_PHY_TRAINING_EN			BIT(0)
+#define CDNS_PHY_TRAINING_TYPE(x)		(((x) & GENMASK(3, 0)) << 1)
+#define CDNS_PHY_SCRAMBLER_BYPASS		BIT(5)
+#define CDNS_PHY_ENCODER_BYPASS			BIT(6)
+#define CDNS_PHY_SKEW_BYPASS			BIT(7)
+#define CDNS_PHY_TRAINING_AUTO			BIT(8)
+#define CDNS_PHY_LANE0_SKEW(x)			(((x) & GENMASK(2, 0)) << 9)
+#define CDNS_PHY_LANE1_SKEW(x)			(((x) & GENMASK(2, 0)) << 12)
+#define CDNS_PHY_LANE2_SKEW(x)			(((x) & GENMASK(2, 0)) << 15)
+#define CDNS_PHY_LANE3_SKEW(x)			(((x) & GENMASK(2, 0)) << 18)
+#define CDNS_PHY_COMMON_CONFIG			(CDNS_PHY_LANE1_SKEW(1) | \
+						CDNS_PHY_LANE2_SKEW(2) |  \
+						CDNS_PHY_LANE3_SKEW(3))
+#define CDNS_PHY_10BIT_EN			BIT(21)
+
+#define CDNS_DPTX_FRAMER			0x02200
+#define CDNS_DP_FRAMER_GLOBAL_CONFIG		(CDNS_DPTX_FRAMER + 0x00)
+#define CDNS_DP_NUM_LANES(x)			(x - 1)
+#define CDNS_DP_FRAMER_EN			BIT(3)
+#define CDNS_DP_RATE_GOVERNOR_EN		BIT(4)
+#define CDNS_DP_NO_VIDEO_MODE			BIT(5)
+#define CDNS_DP_DISABLE_PHY_RST			BIT(6)
+#define CDNS_DP_WR_FAILING_EDGE_VSYNC		BIT(7)
+
+#define CDNS_DP_SW_RESET			(CDNS_DPTX_FRAMER + 0x04)
+#define CDNS_DP_FRAMER_TU			(CDNS_DPTX_FRAMER + 0x08)
+#define CDNS_DP_FRAMER_TU_SIZE(x)		(((x) & GENMASK(6, 0)) << 8)
+#define CDNS_DP_FRAMER_TU_VS(x)			((x) & GENMASK(5, 0))
+#define CDNS_DP_FRAMER_TU_CNT_RST_EN		BIT(15)
+
+#define CDNS_DPTX_STREAM			0x03000
+#define CDNS_DP_MSA_HORIZONTAL_0		(CDNS_DPTX_STREAM + 0x00)
+#define CDNS_DP_MSAH0_H_TOTAL(x)		(x)
+#define CDNS_DP_MSAH0_HSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_HORIZONTAL_1		(CDNS_DPTX_STREAM + 0x04)
+#define CDNS_DP_MSAH1_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAH1_HSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAH1_HDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_0			(CDNS_DPTX_STREAM + 0x08)
+#define CDNS_DP_MSAV0_V_TOTAL(x)		(x)
+#define CDNS_DP_MSAV0_VSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_1			(CDNS_DPTX_STREAM + 0x0c)
+#define CDNS_DP_MSAV1_VSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAV1_VSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAV1_VDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_MISC			(CDNS_DPTX_STREAM + 0x10)
+#define CDNS_DP_STREAM_CONFIG			(CDNS_DPTX_STREAM + 0x14)
+#define CDNS_DP_RATE_GOVERNOR_STATUS		(CDNS_DPTX_STREAM + 0x2c)
+#define CDNS_DP_RG_TU_VS_DIFF(x)		((x) << 8)
+
+#define CDNS_DP_HORIZONTAL			(CDNS_DPTX_STREAM + 0x30)
+#define CDNS_DP_H_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_H_H_TOTAL(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_0			(CDNS_DPTX_STREAM + 0x34)
+#define CDNS_DP_V0_VHEIGHT(x)			(x)
+#define CDNS_DP_V0_VSTART(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_1			(CDNS_DPTX_STREAM + 0x38)
+#define CDNS_DP_V1_VTOTAL(x)			(x)
+#define CDNS_DP_V1_VTOTAL_EVEN			BIT(16)
+
+#define CDNS_DP_FRAMER_PXL_REPR			(CDNS_DPTX_STREAM + 0x4c)
+#define CDNS_DP_FRAMER_6_BPC			BIT(0)
+#define CDNS_DP_FRAMER_8_BPC			BIT(1)
+#define CDNS_DP_FRAMER_10_BPC			BIT(2)
+#define CDNS_DP_FRAMER_12_BPC			BIT(3)
+#define CDNS_DP_FRAMER_16_BPC			BIT(4)
+#define CDNS_DP_FRAMER_PXL_FORMAT		0x8
+#define CDNS_DP_FRAMER_RGB			BIT(0)
+#define CDNS_DP_FRAMER_YCBCR444			BIT(1)
+#define CDNS_DP_FRAMER_YCBCR422			BIT(2)
+#define CDNS_DP_FRAMER_YCBCR420			BIT(3)
+#define CDNS_DP_FRAMER_Y_ONLY			BIT(4)
+
+#define CDNS_DP_FRAMER_SP			(CDNS_DPTX_STREAM + 0x10)
+#define CDNS_DP_FRAMER_VSYNC_POL_LOW		BIT(0)
+#define CDNS_DP_FRAMER_HSYNC_POL_LOW		BIT(1)
+#define CDNS_DP_FRAMER_INTERLACE		BIT(2)
+
+#define CDNS_DP_LINE_THRESH			(CDNS_DPTX_STREAM + 0x64)
+#define CDNS_DP_VB_ID				(CDNS_DPTX_STREAM + 0x68)
+#define CDNS_DP_VB_ID_INTERLACED		BIT(2)
+
+#define CDNS_DP_FRONT_BACK_PORCH		(CDNS_DPTX_STREAM + 0x78)
+#define CDNS_DP_BACK_PORCH(x)			(x)
+#define CDNS_DP_FRONT_PORCH(x)			((x) << 16)
+
+#define CDNS_DP_BYTE_COUNT			(CDNS_DPTX_STREAM + 0x7c)
+
+#define CDNS_DPTX_GLOBAL			0x02300
+#define CDNS_DP_LANE_EN				(CDNS_DPTX_GLOBAL + 0x00)
+#define CDNS_DP_LANE_EN_LANES(x)		GENMASK(x - 1, 0)
+#define CDNS_DP_ENHNCD				(CDNS_DPTX_GLOBAL + 0x04)
+
+#define CDNS_MHDP_IMEM				0x10000
+#define CDNS_MHDP_DMEM				0x20000
+
+#define CDNS_DP_TRAINING_PATTERN_4		0x7
+
+/* 3min delay because of EDID mb being VERY slow */
+/* FIXME: should be >615000 when upstreaming */
+#define CDNS_TIMEOUT_MAILBOX			(1000 * 1000 * 60 * 3)
+
+/* FIXME: Should be 2000 */
+#define CDNS_KEEP_ALIVE_TIMEOUT			40000
+#define CDNS_SW_EVENT0_TIMEOUT			40000
+
+static const struct of_device_id mhdp_ids[] = {
+	{ .compatible = "cdns,mhdp8546", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mhdp_ids);
+
+#define CDNS_LANE_1				BIT(0)
+#define CDNS_LANE_2				BIT(1)
+#define CDNS_LANE_4				BIT(2)
+#define CDNS_SSC				BIT(3)
+#define CDNS_SCRAMBLER				BIT(4)
+
+#define CDNS_VOLT_SWING(x)			((x) & GENMASK(1, 0))
+#define CDNS_FORCE_VOLT_SWING			BIT(2)
+
+#define CDNS_PRE_EMPHASIS(x)			((x) & GENMASK(1, 0))
+#define CDNS_FORCE_PRE_EMPHASIS			BIT(2)
+
+#define CDNS_SUPPORT_TPS(x)			BIT((x) - 1)
+
+#define CDNS_FAST_LINK_TRAINING			BIT(0)
+
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_0(x)	((x) & GENMASK(1, 0))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_1(x)	((x) & GENMASK(3, 2))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_2(x)	((x) & GENMASK(5, 4))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_3(x)	((x) & GENMASK(7, 6))
+#define CDNS_LANE_MAPPING_NORMAL		0xe4
+#define CDNS_LANE_MAPPING_FLIPPED		0x1b
+
+#define CDNS_DP_MAX_NUM_LANES			4
+#define CDNS_DP_TEST_VSC_SDP			(1 << 6) /* 1.3+ */
+#define CDNS_DP_TEST_COLOR_FORMAT_RAW_Y_ONLY	(1 << 7)
+
+static inline struct cdns_mhdp_device *connector_to_mhdp(
+	struct drm_connector *conn)
+{
+	return container_of(conn, struct cdns_mhdp_device, connector);
+}
+
+static inline struct cdns_mhdp_device *bridge_to_mhdp(
+	struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct cdns_mhdp_device, bridge);
+}
+
+static unsigned int max_link_rate(struct cdns_mhdp_host host,
+				  struct cdns_mhdp_sink sink)
+{
+	return min(host.link_rate, sink.link_rate);
+}
+
+static u8 eq_training_pattern_supported(struct cdns_mhdp_host host,
+					struct cdns_mhdp_sink sink)
+{
+	return fls(host.pattern_supp & sink.pattern_supp);
+}
+
+static ssize_t mhdp_transfer(struct drm_dp_aux *aux,
+			     struct drm_dp_aux_msg *msg)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(aux->dev);
+	int ret;
+
+	if (msg->request != DP_AUX_NATIVE_WRITE &&
+	    msg->request != DP_AUX_NATIVE_READ)
+		return -ENOTSUPP;
+
+	if (msg->request == DP_AUX_NATIVE_WRITE) {
+		int i;
+
+		for (i = 0; i < msg->size; ++i) {
+			ret = cdns_mhdp_dpcd_write(mhdp,
+						   msg->address + i,
+						   *((u8 *)msg->buffer + i));
+			if (!ret)
+				continue;
+
+			DRM_DEV_ERROR(mhdp->dev, "Failed to write DPCD\n");
+
+			return i;
+		}
+	} else {
+		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
+					  msg->buffer, msg->size);
+		if (ret) {
+			DRM_DEV_ERROR(mhdp->dev, "Failed to read DPCD\n");
+			return 0;
+		}
+	}
+
+	return msg->size;
+}
+
+static int cdns_mhdp_get_modes(struct drm_connector *connector)
+{
+	struct cdns_mhdp_device *mhdp = connector_to_mhdp(connector);
+	struct edid *edid;
+	int num_modes;
+
+	edid = drm_do_get_edid(connector, cdns_mhdp_get_edid_block, mhdp);
+
+	drm_connector_update_edid_property(connector, edid);
+
+	num_modes = drm_add_edid_modes(connector, edid);
+
+	return num_modes;
+}
+
+static const struct drm_connector_helper_funcs cdns_mhdp_conn_helper_funcs = {
+	.get_modes = cdns_mhdp_get_modes,
+};
+
+static enum drm_connector_status cdns_mhdp_detect(struct drm_connector *conn,
+						  bool force)
+{
+	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
+	enum drm_connector_status status = connector_status_disconnected;
+	int ret;
+
+	ret = cdns_mhdp_get_hpd_status(mhdp);
+	if (ret > 0)
+		status = connector_status_connected;
+	else if (ret < 0)
+		dev_err(mhdp->dev, "Failed to obtain HPD state\n");
+
+	return status;
+}
+
+static const struct drm_connector_funcs cdns_mhdp_conn_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.reset = drm_atomic_helper_connector_reset,
+	.destroy = drm_connector_cleanup,
+	.dpms = drm_helper_connector_dpms,
+	.detect = cdns_mhdp_detect,
+};
+
+static int cdns_mhdp_attach(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct drm_connector *conn = &mhdp->connector;
+	int ret;
+
+	conn->polled = DRM_CONNECTOR_POLL_CONNECT |
+		DRM_CONNECTOR_POLL_DISCONNECT;
+
+	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to init connector\n");
+		return ret;
+	}
+
+	drm_connector_helper_add(conn, &cdns_mhdp_conn_helper_funcs);
+
+	ret = drm_connector_attach_encoder(conn, bridge->encoder);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to attach connector to encoder\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+enum pixel_format {
+	PIXEL_FORMAT_RGB = 1,
+	PIXEL_FORMAT_YCBCR_444 = 2,
+	PIXEL_FORMAT_YCBCR_422 = 4,
+	PIXEL_FORMAT_YCBCR_420 = 8,
+	PIXEL_FORMAT_Y_ONLY = 16,
+};
+
+static void mhdp_link_training_init(struct cdns_mhdp_device *mhdp)
+{
+	u32 reg32;
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	/* Reset PHY configuration */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_ENHNCD,
+			    mhdp->sink.enhanced & mhdp->host.enhanced);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LANE_EN,
+			    CDNS_DP_LANE_EN_LANES(mhdp->link.num_lanes));
+
+	drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG,
+			    CDNS_PHY_COMMON_CONFIG |
+			    CDNS_PHY_TRAINING_EN |
+			    CDNS_PHY_TRAINING_TYPE(1) |
+			    CDNS_PHY_SCRAMBLER_BYPASS);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_1 | DP_LINK_SCRAMBLING_DISABLE);
+}
+
+static void mhdp_get_adjust_train(struct cdns_mhdp_device *mhdp,
+				  u8 link_status[DP_LINK_STATUS_SIZE],
+				  u8 lanes_data[CDNS_DP_MAX_NUM_LANES])
+{
+	unsigned int i;
+	u8 adjust, max_pre_emphasis, max_volt_swing;
+
+	max_pre_emphasis = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis)
+		<< DP_TRAIN_PRE_EMPHASIS_SHIFT;
+	max_volt_swing = CDNS_VOLT_SWING(mhdp->host.volt_swing);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
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
+static void mhdp_set_adjust_request_voltage(
+	u8 link_status[DP_LINK_STATUS_SIZE], int lane, u8 volt)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
+		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_VOLTAGE_SWING_LANE0_MASK << s);
+	link_status[idx] |= volt << s;
+}
+
+static void mhdp_set_adjust_request_pre_emphasis(
+	u8 link_status[DP_LINK_STATUS_SIZE], int lane, u8 pre_emphasis)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
+		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_PRE_EMPHASIS_LANE0_MASK << s);
+	link_status[idx] |= pre_emphasis << s;
+}
+
+static void mhdp_adjust_requested_eq(struct cdns_mhdp_device *mhdp,
+				     u8 link_status[DP_LINK_STATUS_SIZE])
+{
+	unsigned int i;
+	u8 pre, volt, max_pre = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+	   max_volt = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		volt = drm_dp_get_adjust_request_voltage(link_status, i);
+		pre = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		if (volt + pre > 3)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							3 - pre);
+		if (mhdp->host.volt_swing & CDNS_FORCE_VOLT_SWING)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							max_volt);
+		if (mhdp->host.pre_emphasis & CDNS_FORCE_PRE_EMPHASIS)
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     max_pre);
+	}
+}
+
+static bool mhdp_link_training_channel_eq(struct cdns_mhdp_device *mhdp,
+					  u8 eq_tps,
+					  unsigned int training_interval)
+{
+	u8 lanes_data[CDNS_DP_MAX_NUM_LANES], fail_counter_short = 0;
+	u8 dpcd[DP_LINK_STATUS_SIZE];
+	u32 reg32;
+
+	dev_dbg(mhdp->dev, "Link training - Starting EQ phase\n");
+
+	/* Enable link training TPS[eq_tps] in PHY */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_EN |
+		CDNS_PHY_TRAINING_TYPE(eq_tps);
+	if (eq_tps != 4)
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   (eq_tps != 4) ? eq_tps | DP_LINK_SCRAMBLING_DISABLE :
+			   CDNS_DP_TRAINING_PATTERN_4);
+
+	drm_dp_dpcd_read_link_status(&mhdp->aux, dpcd);
+
+	do {
+		mhdp_get_adjust_train(mhdp, dpcd, lanes_data);
+
+		cdns_mhdp_adjust_lt(mhdp, mhdp->link.num_lanes,
+				    training_interval, lanes_data, dpcd);
+
+		if (!drm_dp_clock_recovery_ok(dpcd, mhdp->link.num_lanes))
+			goto err;
+
+		if (drm_dp_channel_eq_ok(dpcd, mhdp->link.num_lanes)) {
+			dev_dbg(mhdp->dev,
+				"Link training: EQ phase succeeded\n");
+			return true;
+		}
+
+		fail_counter_short++;
+
+		mhdp_adjust_requested_eq(mhdp, dpcd);
+	} while (fail_counter_short < 5);
+
+err:
+	dev_dbg(mhdp->dev,
+		"Link training - EQ phase failed for %d lanes and %d rate\n",
+		mhdp->link.num_lanes, mhdp->link.rate);
+
+	return false;
+}
+
+static void mhdp_adjust_requested_cr(struct cdns_mhdp_device *mhdp,
+				     u8 link_status[DP_LINK_STATUS_SIZE],
+				     u8 *req_volt, u8 *req_pre)
+{
+	unsigned int i, max_volt = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+		     max_pre = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		if (mhdp->host.volt_swing & CDNS_FORCE_VOLT_SWING)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							max_volt);
+		else
+			mhdp_set_adjust_request_voltage(link_status, i,
+							req_volt[i]);
+
+		if (mhdp->host.pre_emphasis & CDNS_FORCE_PRE_EMPHASIS)
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     max_pre);
+		else
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     req_pre[i]);
+	}
+}
+
+static void mhdp_validate_cr(struct cdns_mhdp_device *mhdp, bool *cr_done,
+			     bool *same_before_adjust, bool *max_swing_reached,
+			     u8 before_cr[DP_LINK_STATUS_SIZE],
+			     u8 after_cr[DP_LINK_STATUS_SIZE], u8 *req_volt,
+			     u8 *req_pre)
+{
+	unsigned int i;
+	u8 tmp, max_volt = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+	   max_pre = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis), lane_status;
+	bool same_pre, same_volt;
+
+	*same_before_adjust = false;
+	*max_swing_reached = false;
+	*cr_done = true;
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
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
+static bool mhdp_link_training_clock_recovery(struct cdns_mhdp_device *mhdp)
+{
+	u8 lanes_data[CDNS_DP_MAX_NUM_LANES], fail_counter_short = 0,
+	   fail_counter_cr_long = 0;
+	u8 dpcd[DP_LINK_STATUS_SIZE];
+	bool cr_done;
+
+	dev_dbg(mhdp->dev, "Link training starting CR phase\n");
+
+	mhdp_link_training_init(mhdp);
+
+	drm_dp_dpcd_read_link_status(&mhdp->aux, dpcd);
+
+	do {
+		u8 requested_adjust_volt_swing[CDNS_DP_MAX_NUM_LANES] = {},
+		   requested_adjust_pre_emphasis[CDNS_DP_MAX_NUM_LANES] = {};
+		bool same_before_adjust, max_swing_reached;
+
+		mhdp_get_adjust_train(mhdp, dpcd, lanes_data);
+
+		cdns_mhdp_adjust_lt(mhdp, mhdp->link.num_lanes, 100,
+				    lanes_data, dpcd);
+
+		mhdp_validate_cr(mhdp, &cr_done, &same_before_adjust,
+				 &max_swing_reached, lanes_data, dpcd,
+				 requested_adjust_volt_swing,
+				 requested_adjust_pre_emphasis);
+
+		if (max_swing_reached)
+			goto err;
+
+		if (cr_done) {
+			dev_dbg(mhdp->dev,
+				"Link training: CR phase succeeded\n");
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
+		 * Voltage swing/pre-emphasis adjust requested
+		 * during CR phase
+		 */
+		mhdp_adjust_requested_cr(mhdp, dpcd,
+					 requested_adjust_volt_swing,
+					 requested_adjust_pre_emphasis);
+	} while (fail_counter_short < 5 && fail_counter_cr_long < 10);
+
+err:
+	dev_dbg(mhdp->dev,
+		"Link training: CR phase failed for %d lanes and %d rate\n",
+		mhdp->link.num_lanes, mhdp->link.rate);
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
+static int mhdp_link_training(struct cdns_mhdp_device *mhdp,
+			      unsigned int video_mode,
+			      unsigned int training_interval)
+{
+	u32 reg32;
+	u8 eq_tps = eq_training_pattern_supported(mhdp->host, mhdp->sink);
+
+	while (1) {
+		if (!mhdp_link_training_clock_recovery(mhdp)) {
+			if (drm_dp_link_rate_to_bw_code(mhdp->link.rate) !=
+			    DP_LINK_BW_1_62) {
+				dev_dbg(mhdp->dev,
+					"Reducing link rate during CR phase\n");
+				lower_link_rate(&mhdp->link);
+				drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+				continue;
+			} else if (mhdp->link.num_lanes > 1) {
+				dev_dbg(mhdp->dev,
+					"Reducing lanes number during CR phase\n");
+				mhdp->link.num_lanes >>= 1;
+				mhdp->link.rate = max_link_rate(mhdp->host,
+								mhdp->sink);
+				drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+				continue;
+			}
+
+			dev_dbg(mhdp->dev,
+				"Link training failed during CR phase\n");
+			goto err;
+		}
+
+		if (mhdp_link_training_channel_eq(mhdp, eq_tps,
+						  training_interval))
+			break;
+
+		if (mhdp->link.num_lanes > 1) {
+			dev_dbg(mhdp->dev,
+				"Reducing lanes number during EQ phase\n");
+			mhdp->link.num_lanes >>= 1;
+			drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+			continue;
+		} else if (drm_dp_link_rate_to_bw_code(mhdp->link.rate) !=
+			   DP_LINK_BW_1_62) {
+			dev_dbg(mhdp->dev,
+				"Reducing link rate during EQ phase\n");
+			lower_link_rate(&mhdp->link);
+			drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+			continue;
+		}
+
+		dev_dbg(mhdp->dev, "Link training failed during EQ phase\n");
+		goto err;
+	}
+
+	dev_dbg(mhdp->dev, "Link training successful\n");
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   (mhdp->host.lanes_cnt & CDNS_SCRAMBLER) ? 0 :
+			   DP_LINK_SCRAMBLING_DISABLE);
+
+	/* SW reset DPTX framer */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 1);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 0);
+
+	/* Enable framer */
+	/* FIXME: update when MST supported, BIT(2) */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
+			    CDNS_DP_FRAMER_EN |
+			    CDNS_DP_NUM_LANES(mhdp->link.num_lanes) |
+			    CDNS_DP_DISABLE_PHY_RST |
+			    CDNS_DP_WR_FAILING_EDGE_VSYNC |
+			    (!video_mode ? CDNS_DP_NO_VIDEO_MODE : 0));
+
+	/* Reset PHY config */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	return 0;
+err:
+	/* Reset PHY config */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	return -EIO;
+}
+
+static void cdns_mhdp_disable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+
+	cdns_mhdp_set_video_status(mhdp, 0);
+
+	drm_dp_link_power_down(&mhdp->aux, &mhdp->link);
+}
+
+static void cdns_mhdp_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct drm_display_mode *mode;
+	struct drm_display_info *disp_info = &mhdp->connector.display_info;
+	enum pixel_format pxlfmt;
+	int pxlclock;
+	unsigned int rate, tu_size = 30, vs, vs_f, bpp, required_bandwidth,
+		     available_bandwidth, dp_framer_sp = 0, msa_horizontal_1,
+		     msa_vertical_1, bnd_hsync2vsync, hsync2vsync_pol_ctrl,
+		     misc0 = 0, misc1 = 0, line_thresh = 0, pxl_repr,
+		     front_porch, back_porch, msa_h0, msa_v0, hsync, vsync,
+		     dp_vertical_1, line_thresh1, line_thresh2;
+	u32 resp;
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
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_SET_POWER, 1);
+
+	drm_dp_link_probe(&mhdp->aux, &mhdp->link);
+
+	dev_dbg(mhdp->dev, "Set sink device power state via DPCD\n");
+	drm_dp_link_power_up(&mhdp->aux, &mhdp->link);
+	/* FIXME (CDNS): do we have to wait for 100ms before going on? */
+	mdelay(100);
+
+	mhdp->sink.link_rate = mhdp->link.rate;
+	mhdp->sink.lanes_cnt = mhdp->link.num_lanes;
+	mhdp->sink.enhanced = !!(mhdp->link.capabilities &
+				 DP_LINK_CAP_ENHANCED_FRAMING);
+
+	drm_dp_dpcd_read(&mhdp->aux, DP_DPCD_REV, reg0, size);
+
+	mhdp->sink.pattern_supp = CDNS_SUPPORT_TPS(1) | CDNS_SUPPORT_TPS(2);
+	if (drm_dp_tps3_supported(reg0))
+		mhdp->sink.pattern_supp |= CDNS_SUPPORT_TPS(3);
+	if (drm_dp_tps4_supported(reg0))
+		mhdp->sink.pattern_supp |= CDNS_SUPPORT_TPS(4);
+
+	mhdp->sink.fast_link = !!(reg0[DP_MAX_DOWNSPREAD] &
+				  DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
+
+	mhdp->link.rate = max_link_rate(mhdp->host, mhdp->sink);
+	mhdp->link.num_lanes = min_t(u8, mhdp->sink.lanes_cnt,
+				     mhdp->host.lanes_cnt & GENMASK(2, 0));
+
+	reg8 = reg0[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_MASK;
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
+		dev_err(mhdp->dev,
+			"wrong training interval returned by DPCD: %d\n", reg8);
+		return;
+	}
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
+
+	dp_framer_global_config = be32_to_cpu(resp);
+
+	video_mode = !(dp_framer_global_config & CDNS_DP_NO_VIDEO_MODE);
+
+	if (dp_framer_global_config & CDNS_DP_FRAMER_EN)
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
+				    dp_framer_global_config &
+				    ~CDNS_DP_FRAMER_EN);
+
+	/* Spread AMP if required, enable 8b/10b coding */
+	amp[0] = (mhdp->host.lanes_cnt & CDNS_SSC) ? DP_SPREAD_AMP_0_5 : 0;
+	amp[1] = DP_SET_ANSI_8B10B;
+	drm_dp_dpcd_write(&mhdp->aux, DP_DOWNSPREAD_CTRL, amp, 2);
+
+	if (mhdp->host.fast_link & mhdp->sink.fast_link) {
+		/* FIXME: implement fastlink */
+		dev_dbg(mhdp->dev, "fastlink\n");
+	} else {
+		if (mhdp_link_training(mhdp, video_mode,
+				       training_interval_us)) {
+			dev_err(mhdp->dev, "Link training failed. Exiting.\n");
+			return;
+		}
+	}
+
+	rate = mhdp->link.rate / 1000;
+
+	/* FIXME: what about Y_ONLY? how is it handled in the kernel? */
+	if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		pxlfmt = PIXEL_FORMAT_YCBCR_444;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		pxlfmt = PIXEL_FORMAT_YCBCR_422;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB420)
+		pxlfmt = PIXEL_FORMAT_YCBCR_420;
+	else
+		pxlfmt = PIXEL_FORMAT_RGB;
+
+	/* if YCBCR supported and stream not SD, use ITU709 */
+	/* FIXME: handle ITU version with YCBCR420 when supported */
+	if ((pxlfmt == PIXEL_FORMAT_YCBCR_444 ||
+	     pxlfmt == PIXEL_FORMAT_YCBCR_422) && mode->crtc_vdisplay >= 720)
+		misc0 = DP_YCBCR_COEFFICIENTS_ITU709;
+
+	switch (pxlfmt) {
+	case PIXEL_FORMAT_RGB:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDNS_DP_FRAMER_RGB << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_RGB;
+		break;
+	case PIXEL_FORMAT_YCBCR_444:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR444 << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr444 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case PIXEL_FORMAT_YCBCR_422:
+		bpp = disp_info->bpc * 2;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR422 << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr422 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case PIXEL_FORMAT_YCBCR_420:
+		bpp = disp_info->bpc * 3 / 2;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR420 << CDNS_DP_FRAMER_PXL_FORMAT;
+		break;
+	default:
+		bpp = disp_info->bpc;
+		pxl_repr = CDNS_DP_FRAMER_Y_ONLY << CDNS_DP_FRAMER_PXL_FORMAT;
+	}
+
+	switch (disp_info->bpc) {
+	case 6:
+		misc0 |= DP_TEST_BIT_DEPTH_6;
+		pxl_repr |= CDNS_DP_FRAMER_6_BPC;
+		break;
+	case 8:
+		misc0 |= DP_TEST_BIT_DEPTH_8;
+		pxl_repr |= CDNS_DP_FRAMER_8_BPC;
+		break;
+	case 10:
+		misc0 |= DP_TEST_BIT_DEPTH_10;
+		pxl_repr |= CDNS_DP_FRAMER_10_BPC;
+		break;
+	case 12:
+		misc0 |= DP_TEST_BIT_DEPTH_12;
+		pxl_repr |= CDNS_DP_FRAMER_12_BPC;
+		break;
+	case 16:
+		misc0 |= DP_TEST_BIT_DEPTH_16;
+		pxl_repr |= CDNS_DP_FRAMER_16_BPC;
+		break;
+	}
+
+	/* find optimal tu_size */
+	required_bandwidth = pxlclock * bpp / 8;
+	available_bandwidth = mhdp->link.num_lanes * rate;
+	do {
+		tu_size += 2;
+
+		vs_f = tu_size * required_bandwidth / available_bandwidth;
+		vs = vs_f / 1000;
+		vs_f = vs_f % 1000;
+		/*
+		 * FIXME (CDNS): downspreading?
+		 * It's unused is what I've been told.
+		 */
+	} while ((vs == 1 || ((vs_f > 850 || vs_f < 100) && vs_f != 0) ||
+		  tu_size - vs < 2) && tu_size < 64);
+
+	if (vs > 64)
+		return;
+
+	bnd_hsync2vsync = CDNS_IP_BYPASS_V_INTERFACE;
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		bnd_hsync2vsync |= CDNS_IP_DET_INTERLACE_FORMAT;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_BND_HSYNC2VSYNC, bnd_hsync2vsync);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
+	    mode->flags & DRM_MODE_FLAG_PHSYNC)
+		hsync2vsync_pol_ctrl = CDNS_H2V_HSYNC_POL_ACTIVE_LOW |
+			CDNS_H2V_VSYNC_POL_ACTIVE_LOW;
+	else
+		hsync2vsync_pol_ctrl = 0;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_HSYNC2VSYNC_POL_CTRL,
+			    hsync2vsync_pol_ctrl);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_TU,
+			    CDNS_DP_FRAMER_TU_VS(vs) |
+			    CDNS_DP_FRAMER_TU_SIZE(tu_size) |
+			    CDNS_DP_FRAMER_TU_CNT_RST_EN);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_PXL_REPR, pxl_repr);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		dp_framer_sp |= CDNS_DP_FRAMER_INTERLACE;
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		dp_framer_sp |= CDNS_DP_FRAMER_HSYNC_POL_LOW;
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		dp_framer_sp |= CDNS_DP_FRAMER_VSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_SP, dp_framer_sp);
+
+	front_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	back_porch = mode->crtc_htotal - mode->crtc_hsync_end;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRONT_BACK_PORCH,
+			    CDNS_DP_FRONT_PORCH(front_porch) |
+			    CDNS_DP_BACK_PORCH(back_porch));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_BYTE_COUNT,
+			    mode->crtc_hdisplay * bpp / 8);
+
+	msa_h0 = mode->crtc_htotal - mode->crtc_hsync_start;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_0,
+			    CDNS_DP_MSAH0_H_TOTAL(mode->crtc_htotal) |
+			    CDNS_DP_MSAH0_HSYNC_START(msa_h0));
+
+	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	msa_horizontal_1 = CDNS_DP_MSAH1_HSYNC_WIDTH(hsync) |
+		CDNS_DP_MSAH1_HDISP_WIDTH(mode->crtc_hdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		msa_horizontal_1 |= CDNS_DP_MSAH1_HSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_1,
+			    msa_horizontal_1);
+
+	msa_v0 = mode->crtc_vtotal - mode->crtc_vsync_start;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_0,
+			    CDNS_DP_MSAV0_V_TOTAL(mode->crtc_vtotal) |
+			    CDNS_DP_MSAV0_VSYNC_START(msa_v0));
+
+	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	msa_vertical_1 = CDNS_DP_MSAV1_VSYNC_WIDTH(vsync) |
+		CDNS_DP_MSAV1_VDISP_WIDTH(mode->crtc_vdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		msa_vertical_1 |= CDNS_DP_MSAV1_VSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_1, msa_vertical_1);
+
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	    mode->crtc_vtotal % 2 == 0)
+		misc1 = DP_TEST_INTERLACED;
+	if (pxlfmt == PIXEL_FORMAT_Y_ONLY)
+		misc1 |= CDNS_DP_TEST_COLOR_FORMAT_RAW_Y_ONLY;
+	/* FIXME: use VSC SDP for Y420 */
+	/* FIXME: (CDNS) no code for Y420 in bare metal test */
+	if (pxlfmt == PIXEL_FORMAT_YCBCR_420)
+		misc1 = CDNS_DP_TEST_VSC_SDP;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_MISC, misc0 | (misc1 << 8));
+
+	/* FIXME: to be changed if MST mode */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_STREAM_CONFIG, 1);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_HORIZONTAL,
+			    CDNS_DP_H_HSYNC_WIDTH(hsync) |
+			    CDNS_DP_H_H_TOTAL(mode->crtc_hdisplay));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_0,
+			    CDNS_DP_V0_VHEIGHT(mode->crtc_vdisplay) |
+			    CDNS_DP_V0_VSTART(msa_v0));
+
+	dp_vertical_1 = CDNS_DP_V1_VTOTAL(mode->crtc_vtotal);
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	    mode->crtc_vtotal % 2 == 0)
+		dp_vertical_1 |= CDNS_DP_V1_VTOTAL_EVEN;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_1, dp_vertical_1);
+
+	cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_VB_ID, 2, 1,
+				(mode->flags & DRM_MODE_FLAG_INTERLACE) ?
+				CDNS_DP_VB_ID_INTERLACED : 0);
+
+	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
+	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
+	line_thresh = line_thresh1 - line_thresh2 / mhdp->link.num_lanes;
+	line_thresh = (line_thresh >> 5) + 2;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LINE_THRESH,
+			    line_thresh & GENMASK(5, 0));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_RATE_GOVERNOR_STATUS,
+			    CDNS_DP_RG_TU_VS_DIFF((tu_size - vs > 3) ?
+						       0 : tu_size - vs));
+
+	cdns_mhdp_set_video_status(mhdp, 1);
+}
+
+static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
+	.enable = cdns_mhdp_enable,
+	.disable = cdns_mhdp_disable,
+	.attach = cdns_mhdp_attach,
+};
+
+static int load_firmware(struct cdns_mhdp_device *mhdp, const char *name,
+			 unsigned int addr)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, name, mhdp->dev);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to load firmware (%s), ret: %d\n",
+			name, ret);
+		return ret;
+	}
+
+	memcpy_toio(mhdp->regs + addr, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	return 0;
+}
+
+static int cdns_mhdp_audio_hw_params(struct device *dev, void *data,
+				     struct hdmi_codec_daifmt *daifmt,
+				     struct hdmi_codec_params *params)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	struct audio_info audio = {
+		.sample_width = params->sample_width,
+		.sample_rate = params->sample_rate,
+		.channels = params->channels,
+	};
+	int ret;
+
+	if (daifmt->fmt != HDMI_I2S) {
+		DRM_DEV_ERROR(dev, "Invalid format %d\n", daifmt->fmt);
+		return -EINVAL;
+	}
+
+	audio.format = AFMT_I2S;
+
+	ret = cdns_mhdp_audio_config(mhdp, &audio);
+	if (!ret)
+		mhdp->audio_info = audio;
+
+	return 0;
+}
+
+static void cdns_mhdp_audio_shutdown(struct device *dev, void *data)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cdns_mhdp_audio_stop(mhdp, &mhdp->audio_info);
+	if (!ret)
+		mhdp->audio_info.format = AFMT_UNUSED;
+}
+
+static int cdns_mhdp_audio_digital_mute(struct device *dev, void *data,
+					bool enable)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+
+	return cdns_mhdp_audio_mute(mhdp, enable);
+}
+
+static int cdns_mhdp_audio_get_eld(struct device *dev, void *data,
+				   u8 *buf, size_t len)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+
+	memcpy(buf, mhdp->connector.eld,
+	       min(sizeof(mhdp->connector.eld), len));
+
+	return 0;
+}
+
+static const struct hdmi_codec_ops audio_codec_ops = {
+	.hw_params = cdns_mhdp_audio_hw_params,
+	.audio_shutdown = cdns_mhdp_audio_shutdown,
+	.digital_mute = cdns_mhdp_audio_digital_mute,
+	.get_eld = cdns_mhdp_audio_get_eld,
+};
+
+static int mhdp_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct cdns_mhdp_device *mhdp;
+	struct clk *clk;
+	int ret;
+	unsigned int reg;
+	unsigned long rate;
+	u32 resp;
+
+	struct hdmi_codec_pdata codec_data = {
+		.i2s = 1,
+		.max_i2s_channels = 8,
+		.ops = &audio_codec_ops,
+	};
+
+	mhdp = devm_kzalloc(&pdev->dev, sizeof(struct cdns_mhdp_device),
+			    GFP_KERNEL);
+	if (!mhdp)
+		return -ENOMEM;
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "couldn't get clk: %ld\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	mhdp->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, mhdp);
+
+	drm_dp_aux_init(&mhdp->aux);
+	mhdp->aux.dev = &pdev->dev;
+	mhdp->aux.transfer = mhdp_transfer;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mhdp->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(mhdp->regs))
+		return PTR_ERR(mhdp->regs);
+
+	platform_set_drvdata(pdev, mhdp);
+
+	ret = load_firmware(mhdp, FW_NAME, CDNS_MHDP_IMEM);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(clk);
+	writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
+	writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
+
+	/* Leave debug mode */
+	writel(0, mhdp->regs + CDNS_APB_CTRL);
+
+	/*
+	 * Wait for the KEEP_ALIVE "message" on the first 8 bits.
+	 * Updated each sched "tick" (~2ms)
+	 */
+	ret = readl_poll_timeout(mhdp->regs + CDNS_KEEP_ALIVE, reg,
+				 reg & CDNS_KEEP_ALIVE_MASK, 500,
+				 CDNS_KEEP_ALIVE_TIMEOUT);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"device didn't give any life sign: reg %d\n", reg);
+		return -EIO;
+	}
+
+	/*
+	 * FIXME (CDNS): how are the characteristics/features of the host
+	 * defined? Will they be always hardcoded?
+	 */
+	/* FIXME: link rate 2.7; num_lanes = 2,	 */
+	/* FIXME: read capabilities from PHY */
+	mhdp->host.link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+	mhdp->host.lanes_cnt = CDNS_LANE_4 | CDNS_SCRAMBLER;
+	mhdp->host.volt_swing = CDNS_VOLT_SWING(3);
+	mhdp->host.pre_emphasis = CDNS_PRE_EMPHASIS(2);
+	mhdp->host.pattern_supp = CDNS_SUPPORT_TPS(1) |
+		CDNS_SUPPORT_TPS(2) | CDNS_SUPPORT_TPS(3) |
+		CDNS_SUPPORT_TPS(4);
+	mhdp->host.fast_link = 0;
+	mhdp->host.lane_mapping = CDNS_LANE_MAPPING_FLIPPED;
+	mhdp->host.enhanced = true;
+
+	mhdp->bridge.of_node = pdev->dev.of_node;
+	mhdp->bridge.funcs = &cdns_mhdp_bridge_funcs;
+
+	/* Init events to 0 as it's not cleared by FW at boot but on read */
+	readl(mhdp->regs + CDNS_SW_EVENT0);
+	readl(mhdp->regs + CDNS_SW_EVENT1);
+	readl(mhdp->regs + CDNS_SW_EVENT2);
+	readl(mhdp->regs + CDNS_SW_EVENT3);
+
+	/* Activate uCPU */
+	ret = cdns_mhdp_set_firmware_active(mhdp, true);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to activate DP\n");
+		return ret;
+	}
+
+	mhdp->audio_pdev = platform_device_register_data(
+			   mhdp->dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
+			   &codec_data, sizeof(codec_data));
+
+	/* Enable VIF clock for stream 0 */
+	cdns_mhdp_reg_read(mhdp, CDNS_DPTX_CAR, &resp);
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
+			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
+
+	/* Loop over HDP change */
+	/*
+	 * FIXME: does not work when put in mhdp_bridge_enable.
+	 * Where should we put it?
+	 */
+	/* Is it still needed with use of mb message HPD STATUS? */
+	ret = readl_poll_timeout(mhdp->regs + CDNS_SW_EVENT0, reg,
+				 reg & CDNS_DPTX_HPD, 500,
+				 CDNS_SW_EVENT0_TIMEOUT);
+	if (ret) {
+		dev_err(mhdp->dev, "no HPD received %d\n", reg);
+		return -ENODEV;
+	}
+
+	drm_bridge_add(&mhdp->bridge);
+
+	return 0;
+}
+
+MODULE_FIRMWARE(FW_NAME);
+
+static int mhdp_remove(struct platform_device *pdev)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	platform_device_unregister(mhdp->audio_pdev);
+
+	drm_bridge_remove(&mhdp->bridge);
+
+	ret = cdns_mhdp_set_firmware_active(mhdp, false);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to de-activate DP\n");
+		return ret;
+	}
+
+	/* FIXME: check for missing functions */
+
+	return 0;
+}
+
+static struct platform_driver mhdp_driver = {
+	.driver	= {
+		.name		= "cdns-mhdp",
+		.of_match_table	= of_match_ptr(mhdp_ids),
+	},
+	.probe	= mhdp_probe,
+	.remove	= mhdp_remove,
+};
+module_platform_driver(mhdp_driver);
+
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_DESCRIPTION("Cadence MHDP DP bridge driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cdns-mhdp");
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc76217ee4..129b0529f3e1 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -27,7 +27,9 @@ config ROCKCHIP_ANALOGIX_DP
 
 config ROCKCHIP_CDN_DP
         bool "Rockchip cdn DP"
-	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
+	depends on DRM_ROCKCHIP=m
+	select EXTCON
+	select DRM_CDNS_MHDP
         help
 	  This selects support for Rockchip SoC specific extensions
 	  for the cdn DP driver. If you want to enable Dp on
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index a314e2109e76..16ba61ffca39 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -3,13 +3,15 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
+ccflags-y += -I$(src)/../bridge
+
 rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
 		rockchip_drm_gem.o rockchip_drm_psr.o \
 		rockchip_drm_vop.o rockchip_vop_reg.o
 rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
 
 rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
-rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
+rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index bf7e206326f0..343f381e3440 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -816,7 +816,7 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 
 	ret = cdns_mhdp_audio_config(&dp->mhdp, &audio);
 	if (!ret)
-		dp->audio_info = audio;
+		dp->mhdp.audio_info = audio;
 
 out:
 	mutex_unlock(&dp->lock);
@@ -832,9 +832,9 @@ static void cdn_dp_audio_shutdown(struct device *dev, void *data)
 	if (!dp->active)
 		goto out;
 
-	ret = cdns_mhdp_audio_stop(&dp->mhdp, &dp->audio_info);
+	ret = cdns_mhdp_audio_stop(&dp->mhdp, &dp->mhdp.audio_info);
 	if (!ret)
-		dp->audio_info.format = AFMT_UNUSED;
+		dp->mhdp.audio_info.format = AFMT_UNUSED;
 out:
 	mutex_unlock(&dp->lock);
 }
@@ -886,11 +886,11 @@ static int cdn_dp_audio_codec_init(struct cdn_dp_device *dp,
 		.max_i2s_channels = 8,
 	};
 
-	dp->audio_pdev = platform_device_register_data(
-			 dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
-			 &codec_data, sizeof(codec_data));
+	dp->mhdp.audio_pdev = platform_device_register_data(
+			      dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
+			      &codec_data, sizeof(codec_data));
 
-	return PTR_ERR_OR_ZERO(dp->audio_pdev);
+	return PTR_ERR_OR_ZERO(dp->mhdp.audio_pdev);
 }
 
 static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
@@ -1217,7 +1217,7 @@ static int cdn_dp_remove(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
-	platform_device_unregister(dp->audio_pdev);
+	platform_device_unregister(dp->mhdp.audio_pdev);
 	cdn_dp_suspend(dp->mhdp.dev);
 	component_del(&pdev->dev, &cdn_dp_component_ops);
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index bad65c2fe610..5ce5ad19c028 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -20,7 +20,7 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_panel.h>
 #include "rockchip_drm_drv.h"
-#include "cdn-dp-reg.h"
+#include "cdns-mhdp-common.h"
 
 #define MAX_PHY		2
 
@@ -45,7 +45,6 @@ struct cdn_dp_device {
 	struct cdns_mhdp_device mhdp;
 	struct drm_device *drm_dev;
 	struct drm_encoder encoder;
-	struct platform_device *audio_pdev;
 	struct work_struct event_work;
 	struct edid *edid;
 
@@ -64,7 +63,6 @@ struct cdn_dp_device {
 	struct reset_control *dptx_rst;
 	struct reset_control *apb_rst;
 	struct reset_control *core_rst;
-	struct audio_info audio_info;
 	struct cdn_dp_port *port[MAX_PHY];
 	u8 ports;
 	u8 lanes;
-- 
2.17.1

