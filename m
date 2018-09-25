Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A22C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF652087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Fnym/DwL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="sW/xH7LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF652087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeIYPW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:22:56 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44806 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727606AbeIYPWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:22:55 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8P9EZCp017144;
        Tue, 25 Sep 2018 02:15:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=48uZw/gNhHvVq64SIoXnupfa/mJYZ+o3F6Ryu/42IVM=;
 b=Fnym/DwLIv7T5cf09yLP6+e8ryCWz8ohMEDRqremn05KRgdBHV2EKzubNNZnu5+XAani
 aUwljlI83ZW3Y4SR/xoVrPnR6OVseppUM27344gwrpm55xjqV2D6UTRkYpQ0BWeANLPV
 nScyEPwftjabpHjA4qL+kj7eD5Teo8QyPGLCfFHEWIbmxigB5W40mL0b4QK4urhMwd5h
 UTYvHeCacY49YQl1bVndclwKr4dl2PXOHSITgfe9ytUy7USVHkVtJNbHoxrojkBjdvIv
 aulFmP+nkrMRtlCiQmcYyM3VfcXYEGnvUV08qNALlAFer++J/2kZT8cha2S8zdYz/OKQ rA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0119.outbound.protection.outlook.com [216.32.181.119])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mnhax4fjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Sep 2018 02:15:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48uZw/gNhHvVq64SIoXnupfa/mJYZ+o3F6Ryu/42IVM=;
 b=sW/xH7LEDWGWz46sPEFCcH0QyiI5RQschAIkPAvdZpaJj7sktz+RorF4xiD6fnmHDyYrAmzONJCobk0ihbUM6lCqygK1FiKO/YYJi7BTKPPsnqx0XRoEt2RskCPe5Gpfb27MQARSMb9wUJq2xdRgq2nFlWXMxP+X/MORZdgw/H4=
Received: from SN4PR0701CA0001.namprd07.prod.outlook.com
 (2603:10b6:803:28::11) by DM6PR07MB4412.namprd07.prod.outlook.com
 (2603:10b6:5:bf::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Tue, 25 Sep
 2018 09:15:35 +0000
Received: from CO1NAM05FT035.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by SN4PR0701CA0001.outlook.office365.com
 (2603:10b6:803:28::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.20 via Frontend
 Transport; Tue, 25 Sep 2018 09:15:34 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT035.mail.protection.outlook.com (10.152.96.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1185.5 via Frontend Transport; Tue, 25 Sep 2018 09:15:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9FVAp019564
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Sep 2018 02:15:32 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Sep 2018 11:15:38 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 25 Sep 2018 11:15:38 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9FUcr008472;
        Tue, 25 Sep 2018 10:15:30 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8P9FUPU008469;
        Tue, 25 Sep 2018 10:15:30 +0100
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
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <rafalc@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>
Subject: [PATCH v5 4/5] dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
Date:   Tue, 25 Sep 2018 10:13:34 +0100
Message-ID: <1537866837-4408-5-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1537866837-4408-1-git-send-email-dkos@cadence.com>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(36092001)(189003)(199004)(2616005)(7416002)(26826003)(87636003)(478600001)(126002)(186003)(26005)(246002)(486006)(2906002)(7636002)(356003)(305945005)(336012)(476003)(106466001)(50466002)(426003)(47776003)(16586007)(54906003)(5660300001)(50226002)(105596002)(316002)(48376002)(110136005)(76176011)(446003)(2201001)(575784001)(11346002)(8676002)(86362001)(36756003)(51416003)(42186006)(8936002)(4326008)(921003)(21314002)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4412;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT035;1:FHImCbhDYGfL6k60orw3a7lTZcHNqPO5u5RuGSN636d+uc1f2FCl3CGKRluDeO5nJjOVE8HOLqq8KfoZKDmIy2DP2myd0BE8ZT2eTPnVdE7rEEwT8xczoBcb1Faln3wQ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0f1e673-abaf-4462-44d9-08d622c77331
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4412;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;3:aZpLOxIae38d3KsKrjTItqM1zmQm3TDxb2ZO31uO4cQL07+acaaIASH2lY7xTfH9pwahFCCr838rRyYNiy4gEG7wn83SaMPPoy7n4EelYf7ewmoOnbyg13pQmDYGqmURKHXmnqOCf2R7nhsiCNk/qLGM3JrB43Ko/4iV8FAPVOcG1wiUrvgEyv4JfeeMBA0Nt440h93h367gA1rOLi5KNQ5IlrPpooX7OfDpclVrHoH5jeArIEXPiA9zGodxscGF+7JrWMc45J0ChB1nt1eBoJ0jT4mc7sVmJppxJ1iyST+b7IzoCxzw1HMnp0VzPJYzFi7AUyMJNSDJrqPk5Si2+dRqqPlANuKKHrnTxOF5Eww=;25:VYAkU2IgTEZJxeh/7uBq/I+mS+TBZokhQc4v8xkq85qn/rpef5d5gjHrosWlVeGS2xuN8DWf3VdMbrLUKK3S8+utjWmP/AyznXYPw6ARsmUh3gO0V2TpX4wx5O82Vry8zY86OkZbj6PPeosSlV1BP8NnReee6Mqv0q7rJPvzMUqx94HJG8nbwLbqKvcv/ZR6qPAVBCSQO0eUHM7/DlyK3GcfCdq416jxyspzUJQsVxVEusXb43SvmnG7qSNSO0qZskvSpZFkeu5ahdBMKK3A2xZ0ukt3wwD/kc0rpZ9uJlLjMOOmIBuNAPsS4EFfVMtQlz+HsLswFl5WdYPafz6xMA==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4412:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;31:/rKLutjkkh0eB81e/2dRjYckprUrBiTi0/OV8SmKTu8yvDMxWsa0KmfzIRdHhKp4ed7/VUc5naD4zvr9qbHzx67AvspyXCe8fR6D4FwOFLLgqFYz++K5lxk0O0qV6qrW188zZg0++8iN0inGccJ9yW19Gn7OeT0ocZoAIHih2tEJ0vEn3bsi2pY3diG60Dmumax79DF4Y4zXALZfJdAL9f5EsYrNC4p6qFiAbNW1Qqo=;20:wGAlYuawsFJgQ7wclgYriLnEFcVE2QIdmjnNzqQAxinmuUdK7mrpSdv73wf71oc52e37Z7u6FGot80Gr38s7+159zfEZeJdGUn7ciMGBTakBe2VW2KqWrW4UZnqdXS1+0IT5o9iwm6nBW84SMBFmykZlCvyk/iwcB3K9rC7DPb9hLjO/6oJE844xXoMpapKJkk418R0LSgreaDKnoM/q52lSY6Qb1XEetf7Ghk2uC1let1uEezeZXBc7Yo/PYZLnD6JHuVXImZ5B50tS3FBwPGlL2ewkigXw2cz+pWzHLcVny/U+/w9dCMMZots9u3b0lxhYWLYy2cFXdklTRb2PFH7PFpc6Chwuu6MWsEqtOQLYs7Zb2o+QeEKS6YkKyxBukqehsdbFDTPQiY5f9E/Eb1WrL51ldUSiPDj3ucLaoFs4D84fri2RMxy55A6AHJPL/tgyoEtR0oiP4k1JiD7yYhEayGfE0nlw8w0lsuSk36HFMOhJfNND4HBxhRVePlyI
X-Microsoft-Antispam-PRVS: <DM6PR07MB4412CB98A4B66BD034011B26CD160@DM6PR07MB4412.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:DM6PR07MB4412;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4412;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;4:gyTv2Yo5Xtjt96xZ29Z8CfR2qezmgbxiKJiDhQ1IEbBIszPX7VqRacfquMmeBsD3nhBV8CQ9sVNdd+yBGe3s0GoaTblHVdOf7xLsPYP9haqFeHXrbSL3Fd6HdprlpE5Ylc57h4C7/s4SFk2oUnNavRvx65xJMpIBoWm5l5iqgWRY2Sqx/KlBO5w3OyIlG4YUzHxn+ujdR30GszzcbXp2vLc8MhMqcL0iAj+hAIW79O0QnuS7bs/2Qraz2UhQ08jT/BdNHcQJC8LoA4c0xv+mJOvsbYaW3TXXz3RSv9swTxTHj2+Oo1kzwu77bVsUc48hLMJBr1SkQ5Ia/BIh7bHepkoHdEio2u+toPWa753/1E4=
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4412;23:/zIqz7busujTxjmxa530NaOJXKZMFT1q6GDYk+zve?=
 =?us-ascii?Q?pGoMBh6f5XAEvTnUSJV6GZn87AKg4aCACv1iO2gcxtPFuO+gkZPEy4+wCQrR?=
 =?us-ascii?Q?KxRTOWYYOg2G2mQMyD2zcCur2ipgP8vaAfdrIfwjjbbHIMxDoyx+NKbl3aHJ?=
 =?us-ascii?Q?SzXM4csuFCkvaKVJiCD6jSo/Rv90hk1h7kfO9Pk3chxfxnPphUECMuQzPKCZ?=
 =?us-ascii?Q?AdwoVbrWWjPsZwdMoabeaQi1j+te+nSqPWN8kVHtGMDibN3VHaWeMD9BM+r7?=
 =?us-ascii?Q?feSWukUGCE92WKfWVLjk5m+oIxKcFQnbIO1TRPKhF7G8gvYKd9XC5jABzliG?=
 =?us-ascii?Q?84FsihVwvn8T6ocldlpV+3t8K/cXVzimZ5P0yPGQf7Q0r5wXyVRjmTnu2ZzU?=
 =?us-ascii?Q?HH9QVjUV9TXIw7EU/iLowGh3UHYAHezsnROZh24YQhg6no8l2FCY8aAgYUMZ?=
 =?us-ascii?Q?HL1N0JqgRqPwNqrObC5WjYULUyCEFraBFOSWeyjm/Fb97aRpjj/SVxC2vFwh?=
 =?us-ascii?Q?uHSVAo92sVcRBw7Z8py/x/D5apDgwMsZFxBi5qs3YAYjmORlRV44mvMRXBWG?=
 =?us-ascii?Q?H2wduV09R50CvSUZuZje7pXhZsGBYNBwpVUp9UuPJ/5ly/+uF7CocEFce4jw?=
 =?us-ascii?Q?kqrB5FwkawZ3U4GbR0+EubVi3BhDVQdnsiLWoszaktUskYT3XWctANijO0uZ?=
 =?us-ascii?Q?AzGEVhOhuS1agMyCou5ZEqmk+2UwGK6m2UdmCFoRq1as85CLtcb1r+HoNAaL?=
 =?us-ascii?Q?I3GtXCs09Ir6ZCBcsRoEcGRMXWVkW58cCkIzdbLHKANnS90Y4T26g9KVY5P2?=
 =?us-ascii?Q?KEy0EI7Gw1aQBA4ukZRijCgeKQxrHPfe1QnFzr0jQw40lRM+TaTAjH6rzd8s?=
 =?us-ascii?Q?JjdPaQ9fX5nf6gzVyNe1R+Xu36qKE6W7iqPpKkz5mkcG7rgWPCAtwfCjj4jC?=
 =?us-ascii?Q?AS9E50sLGmuthiO1TsONiKu95k6U7rGP5GKNCJgGPs6xwGuo/bnmtA5a7GtP?=
 =?us-ascii?Q?SqfDkraHygjLKWk8aladzvrRoz+VGeszx6NqMFtH4MeLJsfdRz8uy5cdaKyy?=
 =?us-ascii?Q?gvnsVkvDV8AwPTE1fO2ZSJcN3LA1ZXPcCFxxL9u9sznfgePCyKVNroywq6Gf?=
 =?us-ascii?Q?bORlOC9DGeYltkKk2QRaS9pidier9BP4AfX9rJvR16mD5pJBehIayqA8cuL2?=
 =?us-ascii?Q?aVTdYJm23w62So=3D?=
X-Microsoft-Antispam-Message-Info: N/E8ujfLo6eR3G33O1BDZhCj6IktSRcebLk2nrQHxFoJ+97fZm7LF4FuqR9IKAG1AtO579BSEQfX96ExtoMzjySeAIQdkDd1GYfNp8dtOw6uZo9nfMP/5fpz3jQy9j29SXOfUKpBGrVZvQBpbdUjkJtm4pDyOFF886k8EuaRTjEoLg6yPKbKvg880oKvBW5/0l6p/vWWwro6oj8Hsz568iUW+BOydLDpmlF3v3o+tr+jofhz9RRcgYVKyyuPxVd8jt/kN3H8ZCxp3xy3RLv6XEac/S4RSyLkdsa84jXm93DwXb/TQpnW/RBJpxEEHVT+3UsR1Un+7HdZprEcfwYi9oLkVWLAuXpqdyILiFHNPYrfPC/Jnb1GmN8xdP8ucR0ejwtXsbsVh1JBJaKSjjp+fA==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;6:TzLYA7gwdyKZqF+KudPw/ViNrbAJxylpxn/k6LnmBK7naiKErJ+1oi+ftOB/W5n0OosqTbTX9IggOEUEWNu6DFZ8uwv8S4QiZOtg1MpXsdzhIARMGxCeXlWHfHjn84RiR6NC3g31VJWF1KxIdVOZH2evs1IWEv2D5yAPKFUBpjoCLLEKGFvB9yZar8wwr0yCIYuId1zXMOt1hmV8IQHlqcgPcTx7XFiEqAwE3t0r0NbzHRbGEehYwLC0KlYNUWHONPbjPuNuRkTOctQEm15tRpQHZVuS2R3TMlZpTrUyq58a8el0TGHAxvjsp05GJaCzoqIIvReMSoXDQqpTZeny+XenKFhFaFYyDKroTrKXlgEDreDmTnvlhc+ja3TxfrGO2vhWiWJ+mosZ0ir355FfF/JcTaHK61xwQNNCh+NNmsMuuyoxPnqrTYqrDbWyCn1WYIc1bKGXPGsXAHkm+Khd9g==;5:X/luEtEHK53kyhuhke8Jyb/dODdL5HODRdFa84yQBcdawIrfQXetvLvd2DBLfgozmPuhrFTtyoRw78H6ZPTI75y49j5xHrtad4TQkREsKI6KeJlSP2VxIwaPWVXMiis8zG8YDHLVycfbAd4+TiJqN+pSu9rd4uuzUeHLmBkQvp4=;7:Ta3m50/L0MgoPuFBbwgCvYP9kvrP2ahqt+GXVMAes8o4j2grhT+X26gFZAB6FbjktiQEFGWxTMAlEZws0o4CfUSx3/+rVgI7Abn81rVS3OJKP87Y/Z4PSmKiunCBVrUMdU08LeN/NlcYElzGb3UISZNnBOYeA6L6Uzf7t5HWy4SiX/ehnD0xIEbXTtUQpG0h/DAwpsVCpi1z0rR4+fl5IeikXeA/SMZ+0S/zEhfHfb3KcEn0IccGBBYhE0j9e12s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;20:7cSP8/ibmCjr7S01Pp3UChQrxx9bvDGKVtcs4t9qkzIQaWledYDdE3cRKJRLyP5XfmmPBe6bE0hIcOX7SiV13AGuNfzT1gbMdhj+krqsTjD80II5X4hCKbedowH2C7I2xA8gsBS8AX9xvjnxqMUNCM1gkRhgfNPkNqQ5ITSZbk8kZIWSjgNJsM8iMtEkLdTY1dF5glv3ZvzPPpU46uWQyMh0XflgiLZrX9/FWcrONoQJsyp5d8impq3+mrUy1kM8
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:15:34.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f1e673-abaf-4462-44d9-08d622c77331
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4412
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=802 adultscore=4
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809250096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

Document the bindings used for the Cadence MHDP DPI/DP bridge.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
new file mode 100644
index 000000000000..f8334c520b98
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
@@ -0,0 +1,43 @@
+Cadence MHDP bridge
+==========================
+
+The Cadence MHDP bridge is a DPI to DP bridge.
+
+Required properties:
+- compatible: should be "cdns,mhdp8546",
+- reg: physical base address and length of the controller's registers,
+- clocks: DP bridge clock, it's used by the IP to know how to translate
+	a number of clock cycles into a time (which is used to comply
+	with DP standard timings and delays),
+
+Required subnodes:
+- ports: Ports as described in Documentation/devictree/bindings/graph.txt
+	Port 0 - input port representing the DP bridge input
+	Port 1 - output port representing the DP bridge output
+
+Example:
+
+	mhdp: dp-bridge@f0fb000000 {
+		compatible = "cdns,mhdp8546";
+		reg = <0xf0 0xfb000000 0x0 0x1000000>;
+		clocks = <&mhdp_clock>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dp_bridge_input: endpoint {
+					remote-endpoint = <&xxx_dpi_output>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dp_bridge_output: endpoint {
+					remote-endpoint = <&xxx_dp_connector_input>;
+				};
+			};
+		};
+	};
-- 
2.17.1

