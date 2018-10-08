Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2906C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E5C20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="g+RukjZU";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ClsIsRX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E5C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIFAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:00:04 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:46618 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725759AbeJIFAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:00:04 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98LXqv5015040;
        Mon, 8 Oct 2018 14:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=B48oPreDbFkq+4o9lFdsZbBdnWc5Npwn1JW2C1SQLjY=;
 b=g+RukjZU5W4K/6FDTsBGms6Zr85eO2u3qR5SIgAv4s8p35e1FBdXYDp7pi0n0FOuUfcn
 W8hqEciblfdfWrTq5dlyRGgxSzW3904rqtuwieVQ0hlrfGFC/hupxDS0xXP/cnM4K+MR
 oJanzVhwxO2CXeSE41kqI6auOqv0E2Va9/mTrgCVVSnrZEHGzLMlG+ZCf4FEtP8WXtB+
 4+HFdN/UTmWAdBNBazXfidNOtSG4CiOijWjNMu3QQo+4foPePhkKeLa61s09fOvd+VC7
 k4/xr49NiA0tlNEOHT2sPQEpIVnR6ahh0hoTzCX/XGiau6tsBLUIV1zTjwuqIJLu32Ea 8g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0081.outbound.protection.outlook.com [216.32.181.81])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mxtts2y17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Oct 2018 14:43:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B48oPreDbFkq+4o9lFdsZbBdnWc5Npwn1JW2C1SQLjY=;
 b=ClsIsRX4jSPSuGfhlm9Tgby3yV2fuSVncE3Hs1FhWKCokpxalJVienpdkfpNY/nDKojE88xj0+beu76M9BDaOtXkrdl/6E7ePrCnO+MXJlcK2lP1Y/V3GH0026WIe/NWgz+T0CX2qEgK9PK6VP3VjqTNRGZORoM8NyqiTNXi/eI=
Received: from CY1PR07CA0034.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::44) by DM5PR07MB2954.namprd07.prod.outlook.com
 (2603:10b6:3:a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Mon, 8 Oct
 2018 21:43:39 +0000
Received: from CO1NAM05FT027.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::209) by CY1PR07CA0034.outlook.office365.com
 (2a01:111:e400:c60a::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.23 via Frontend
 Transport; Mon, 8 Oct 2018 21:43:39 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT027.mail.protection.outlook.com (10.152.96.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.2 via Frontend Transport; Mon, 8 Oct 2018 21:43:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w98LhaOD003490
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 8 Oct 2018 14:43:37 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 8 Oct 2018 23:43:42 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 8 Oct 2018 23:43:42 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w98LhZ8q013557;
        Mon, 8 Oct 2018 22:43:35 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w98LhZZN013556;
        Mon, 8 Oct 2018 22:43:35 +0100
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
        "Piotr Sroka" <piotrs@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <rafalc@cadence.com>, <quentin.schulz@bootlin.com>,
        <jbergsagel@ti.com>
Subject: [PATCH v6 3/6] dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
Date:   Mon, 8 Oct 2018 22:42:09 +0100
Message-ID: <1539034953-11274-4-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1539034953-11274-1-git-send-email-dkos@cadence.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(199004)(189003)(36092001)(110136005)(54906003)(356003)(36756003)(47776003)(7636002)(16586007)(305945005)(246002)(5660300001)(7416002)(2201001)(6666003)(51416003)(86362001)(575784001)(76176011)(8936002)(8676002)(50226002)(26005)(48376002)(50466002)(105596002)(87636003)(316002)(42186006)(426003)(336012)(486006)(126002)(4326008)(26826003)(478600001)(2906002)(186003)(106466001)(11346002)(446003)(476003)(2616005)(21314002)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2954;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT027;1:MBve8mQrFi8k4b4eCb2yYmWfAzgHyXDQtmen+MV7boVmFUA4DNX7HPAgyEywQeuB60wS07S8NmZ1t7VONDzG45s1dssnFhMrnUY4PtSOYERQhP/QopV/f1A9QuICJ0uY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbcbda98-e503-4e34-efff-08d62d671ba5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:DM5PR07MB2954;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2954;3:uqFJoc72ItxMkiglzp6ovQMa7uNnTj9ZNQ93qqNyHS4otIdsZmQbjj89s8zozjbnQxKmA3bB4hthCQEvm4QykVKo5XhP4OY0djI/1wiQB6DeQFfAwhwpTODv0nksy3wkQ1t4bChfxxUpWjt5jfHCLjwPjF5zHWzbLrbNrayamTa7AGL4N+NOO44MHNSJZQcsJ3neJCnD3nLyz5XKz9eNYKiZmTynBu92yFTP6keMwIQJLkOc7NTuiwBJDUecME9vfOQxkDDZFsIF61Makp1V/5s30R3A/8562TvUmvwVVHciP3JXxQKvYuinAz2YPsDZF2GmfNfBoGjY5jX4is6ykgelhSQEhg5EfNMEkSRMqJg=;25:wBhviPDR+VExNRs54YBsiQHZt6Z8A4KGGn1K7crt7MFwWzHL07eRg0jMFUxTn5swlCHTHc0853trKOs4o7Ap5r3FFiBlS0m1Un5KS7M6eEQVx0YvFK409yQeG5MNuS7Iyb9Pw7BnkQlokddFUTZEE6srrtAgGHOojOw070pDM0ztcW6sSaK9KU2csUwihWpYNbtyCKl2R64AIz7gGuRXsMni87IgkqHKAopRYS42l/r2mENt98HW2JyW1h0qU6cJsEE6QJwXSkP9Q1rll3r7alkKpKG/E6nl5KyzJWM04Q5ckONEx1yuyr/uOuwo1JDkLGKHDxe9vHYIFQxKBYqXuw==
X-MS-TrafficTypeDiagnostic: DM5PR07MB2954:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2954;31:kkrsOILs2v0cvwRGDE53pZJhleEZ30rv7gQ/Yg2lX0ppyt780LDsC0zCSHKIr7FhIztFk8//ur4Sdx8XgAG8RgO8qS+rU9Eoj3f9iJlnqI+vE3LF0GsgFs359cH0gqNem/bC4hVBbhp8/hQ9bAzMOT4vYCpc1CaxB7f2wK2T4n9QHtoAu6pIQmR9ZS2vec57FuTtmv3Y6zo7ljwNLotzJr+LNBn1nyomTlcxH1GIz3M=;20:/myJff7YaVsUKwzbx+1ROee14duFf4ehl/hmzwDW0byjx3/40+X4ljnkahorWxg2p6SOZtp6Idak4LoDc2SUmV3+txqNFTGT2MIzFbd8PZ9vD/QL1y2tA/8VtR7fGo8U/qCXW8xb2nct5JvntS1CZLAQ2uEvQc3IaZr+ZOA0K/rM+PMsFz233I6dzWI66UPGDLd1LqgsAHNa3Vi7ECcOaSRpN04VHBVQo411eHZRqX4/tW0jcQHmP/8VTmDIbCeq45ZJ8CJE29oym1dYs9up7AtUzWrhqSz9DDJYB1tf3ioJdK4TCc+YkYgD2C25jCXufAayprzTfRNS8AG1DlmK6KGFSZu3jzdVbXeCj0jlXIqbv6/DTk+E4vtYM4qxmtvQuXPg1x9cEp069Vronx3UuD+1ePd21C2qE0lBV34EqOxQYrI/2JdtbNpUxzoeyNMrMp1HwIoUASNGarJ2rTKt5d7abZeaNJ+AMEYSysLNvWW8Avy/ykLYMQba+qdwOoJ8
X-Microsoft-Antispam-PRVS: <DM5PR07MB29547A2C507B0DB6F9EFA74CCDE60@DM5PR07MB2954.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:DM5PR07MB2954;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2954;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2954;4:wME7TkLmjPIgcGafMIftuL6y4VX6Kgi8vHHnij2jHIjuEyDgqNZLDTiEBmMrz49AhjHkJTjdIr4B0Hl/R6wI4IOTJqeGMBr50shbsQPk0Uchu7vAOywfR1u7sPbDO/YWoZDAi7dICPx8tR0NKzZvE4vUmkIT13pHjK0IQ0KXEGlGWZ6KaZsORlZ2rw5K1z3AuePye1anDK1cqwGaJHcybQ7uYtRrlg8bXs/LvgSm3oi6s1y4ot8ArDUgngd0O2nqHS33xi/fcVmpC40tRjQSlb1upiE5BY6zR4Ucz2HHu4waQyWKszMcQDQqjq4ujRbhq1rj7fYO2yI/I2r7DWbnI0Tx3b/n5xDqAMj8EQiwr9M=
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2954;23:Mmh3st6mtRgWJou9wlLW34ZnArTM1K612J7p0pnB+?=
 =?us-ascii?Q?yzeC9exGOq4ygwaCIbsrqyMm16pBvFc9tqahhBTXGQRkYlniNo0IR5tJ6jga?=
 =?us-ascii?Q?tY5gcp82lLPbihOL6jh66zzhUM5Tmk6N711wk2KJNLSZ8EMWq3/PkG/fxAGF?=
 =?us-ascii?Q?hI6PJmg08Zw4BoIE9yekD+IV/YZ0qB/Y8DDhO1DQYUHMZju2J1ms9L/4bZee?=
 =?us-ascii?Q?2oTcv1Fjf6DTzTk0l/ViPIeuZmOG8ntVMfluQWUqx63TE80Te0qNk82u5rgB?=
 =?us-ascii?Q?B+gV/bMNP6MzBrB2hI2yM6415VTW+VsXO8geUObhizT+I2b1uWuhDj/WeQB9?=
 =?us-ascii?Q?/LHCEVdZqJ3mHPE3LN9cVpuAJqnZ0yoflw4xWF4B5IOGcVfSSDwt0+huXn/z?=
 =?us-ascii?Q?RWh3JXZSzyAuBLutyTWuMA3BgA63G84KS6WyP3oRnYzIL7OHs1k2erD+EQ3N?=
 =?us-ascii?Q?20WfMf08lm5hvLiqFToFLloQNkknHu9QmQ14EU6KNM1T6FLjZ2c+JX8tktO9?=
 =?us-ascii?Q?ETscR3eYCVy1KFH90p0NjuHcTWPlyBI50GogQOhkRblNJqfihLRrZ/eto8ht?=
 =?us-ascii?Q?KHIkKKyynMQ44S5wyR0gu8kNY9LmHDZSrkTL/kLTSX3Ml7NBlfVVbfBxcnzP?=
 =?us-ascii?Q?qgd4ZU7EP75LfOjo7lkkJDFG2th9fzSiISio16n52ftdN44Fyp7amWj8TCNp?=
 =?us-ascii?Q?ks8QQ4R+Wj6WyPnh/Zgg4go2xdiU2GxUfwvRFZZvt16O6B25gX+LjJI39LrE?=
 =?us-ascii?Q?8xITlH7ksga3p8gRmH1v3w5bijW0dmbhLB/FPMIsxUU+EHQRldxlJ0nBi0L+?=
 =?us-ascii?Q?pqlid9adhCJqHFwgLRbPHK2vFcOxnMFvzZUx9deeE8Ej5AeqxcxGMWLinYIV?=
 =?us-ascii?Q?UWdgr0tNbC5rdaoWfxds3rf7CmZSF0KeWtf3XOEFtOQoh1aNaXzKvdYUVEjG?=
 =?us-ascii?Q?W5sCdRL3rnUdTvS9nZtt2fPXe/2mXjFsIYzE2u0/0gLGLFEuMasvNtQzWrJY?=
 =?us-ascii?Q?bfoDHd0oTpfr4PDF5UmATVRiUWGrPfrmDejtrAiNJ1q1Hh4kkUX53tRR6B3q?=
 =?us-ascii?Q?DjbHnPkTkexeCY3wIg0oJTXvTcdEoOv6L0gSTIJj0yuNz0+UhupHS+L2lgCM?=
 =?us-ascii?Q?KAyavG1TRSmwnJn9EFBcjsza03t8Cs/CAXhb5bOxMJJqg1EAPvGIJsgjnl2w?=
 =?us-ascii?Q?0EQl68FuP7SELUaJETbELOW1yyw3jt9nr3z?=
X-Microsoft-Antispam-Message-Info: Kn6dmf0PVPJjsWZ1t3EBk/J66dOuulDXOOYAj2QV8musPBI0JNATl4gl/kKffzN9ZRB7RVSbCy+TYzMabBEiD110t94On0z9kRqtYMX+a5EayLV5QIn3XSCXASzNCqjQ5k7NH91cJ9RWK3aqTNAeIBeYhWD/FFoAjsG9wOhQ/DtyHVWMne6CmJkjlMRP0h24OH9KGKbU0EtbP7QdmrY2tfCwi+N18Gx9gvQ2ijYdkGZuawAY6ybhXIUIfTY50Xd4OqjR//z4KiKeWmHJW/iapR38krEfAsqwU5K8tAOIoi7034VBp9gawiMXfmqAdkiFYOMGlVc0nnUJfd8y2iDHwxcFVD5D3Tep7AV+6rZOGQb3SnJqa0qcVZXmenJ+qkimPNSN9uhr+Lb0TJo3RVFH1g==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2954;6:woKlMm49yU9v3eAFXd4Rm3GcS+2QfZI2iSog/wUdqVf1QQ9dSooQEbWbhM5etVX9zThBM7sd5/HbMxbHL+7SMALgZpkmH6dg0NEfTgIFx76rBYUBFswrKOzSWZfZUB7o6G1cJ9o/Ms2fOcsZ9EIhDtAeuJYpEWgt7q4SbWGWvIKQVw9DCInMFe8w0XZjL57GF8477W2I0XIUXT/2sQQeFQIY1POeuOaD6TVwFGkBRscOresUb9vtk/IkeQIsmtPOzT8PaYUKRPR4NIxMp/+dGwItaL4xDZLJXAKDlriR2V1LtohdgnWi1Q4yTV/y9BQq8ZazH/RrhI0yP40Q/Ahdh7pA+hLhK7d2yXgy+g5Qq1t/pc7rhcNEI6blOzOPkbfsCOifP/GO3hUpA+70XWYyStUeo5VgDeunExmEK6CbHzPOUCSW5N/GEp/zVmy86VXZOPE0bbDR605t2p/699MYXw==;5:ZWt2WUpIn7sdRvLrS5tY30ywceQegRIlj7S17rQ4XMlrdxIFkH012cOm23PmYfJ38ZtDsAUKVF/71W/VMWV/pDVYqRxN5g0mNdBIi5grDPIp5Q4WOKH+6N5P2lCBenkOki3kyE/pXfSai7zU3wYCJAKMl0PWTYMDkVgrbqjoBMs=;7:5rf/b9MP0m0Yy6bpbP0soehJuKs8918KVqzW1TrSlV3WjRbFM+NYac3YNCpPDU0JlrI8Q3KpN+E4nJmnhsMUfuHuNtsc7GWl94XCH/oiQi/809hhTpsrlAlBitp5wA3dAoiz9+KHYD+vH3zW7q5eOVOPG3HVnTdxkxeDs4t/gcjNJLxbjOQ67ywe6DXyH2Hs0eYZtgpjflAdS7nCFgTvPY3poMYOdnaZ3K9majP7PSV8R650nXuMCF2NHP/SIOdO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2954;20:lysO16AgMNvM3up2zwaiDIhKonaBH729QiEAepV6e5CHiHxBNONrVGM8+kxT6zbbY5JR/ZbunO457CnWjbXAXlTW1N5y68tNi3+Iffjvdx3khVnoAl8ts6jgp0P7Xj1JE9czZpK1Y5KTxKo+M1JsM476r47B/mQOwVI5pm/OLwimb4pSKioy7LBGPzI3P3nZJ+DHOOE0lpGR6OOw7PNApUb/pbUfPzvMwQ5TVgoiThmJRfifgGjAm3nRPXyweJtG
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 21:43:38.2620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcbda98-e503-4e34-efff-08d62d671ba5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2954
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

Document the bindings used for the Cadence MHDP DPI/DP bridge.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

