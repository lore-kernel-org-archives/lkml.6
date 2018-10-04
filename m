Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9864C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCB920877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Mpd37Jmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCB920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJDWaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:08 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:55783
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbeJDWaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMxgXdpaNgAtH53DtPuEZr/rZOAcaWNlw0OvpH0MhTY=;
 b=Mpd37JminP5MdOffOmvovErovj6CHRLE/kliRJTSdNvKGXFaqFsHODg6XRQESJg+0h6Q58hTvqspCU0gVl8ZgnI2cpD4Xl+aLx7yjUB1SaB7Mq07JS+YiRZcmLhgaD8IniCkUMVZnTTULMoYTaHK4o8gCEU1IPhc5qiAOIOd40I=
Received: from MWHPR0201CA0092.namprd02.prod.outlook.com
 (2603:10b6:301:75::33) by DM6PR02MB5115.namprd02.prod.outlook.com
 (2603:10b6:5:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.23; Thu, 4 Oct
 2018 15:36:12 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR0201CA0092.outlook.office365.com
 (2603:10b6:301:75::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.20 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 15:36:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85ff-0001Oc-Ja; Thu, 04 Oct 2018 08:36:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fa-0000EC-FY; Thu, 04 Oct 2018 08:36:06 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94Fa37b031106;
        Thu, 4 Oct 2018 08:36:03 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fX-0000D4-By; Thu, 04 Oct 2018 08:36:03 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 740A2121465; Thu,  4 Oct 2018 21:06:02 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 09/10] arm64: zynqmp: Add DDRC node
Date:   Thu, 4 Oct 2018 21:05:27 +0530
Message-ID: <1538667328-9465-10-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(376002)(136003)(2980300002)(438002)(189003)(199004)(5660300001)(52956003)(47776003)(44832011)(575784001)(316002)(42186006)(103686004)(356003)(305945005)(4326008)(14444005)(7416002)(2201001)(6266002)(16586007)(48376002)(90966002)(50466002)(72206003)(6666003)(478600001)(426003)(36756003)(336012)(63266004)(110136005)(54906003)(26005)(106002)(186003)(126002)(36386004)(2906002)(486006)(81166006)(81156014)(76176011)(8676002)(51416003)(50226002)(446003)(2616005)(8936002)(11346002)(106466001)(476003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5115;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:juvDfuz8INP5YTDKknMU1Ngk0zWVbk4NpV30l1giIo5JpSWunLpAwewyGivfm1jar6nq03idJPxdV6KAn9QJJR+4RlDu/KKD9gDvqOoKsa8Wz+ctMtWTbrbPtLqdzVel
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd5318f5-83d8-41fd-e5e0-08d62a0f1d50
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5115;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5115;3:qk+Lt0Aye4Ww4GPrcTdpYxU+e7h1FnaCiFf4f2bd9NbhH2jEeoxz8vSlAsqYGsbVMg9xz984xg8PHuNHG6kv6mWZsRtDBc5yrieoGgYkWjkUqO//lXvSgi6ESLg8m3fs/5eyftRcwxMhUMzxfRlmbKuG218Jt5qWPUXqaDUlnQXQnE7MYuPkaBPivcOOTwLxslMucbB02ZI6KaxkrjVo+glO+CEbm5N3tKVIGDripnwWhMnfxh6x7NfJQVAuPJc1cQHbfhjZVk5xHke0GmlEhvjn/EchmEUwYej8hTjXC+TlRCMzhqme1Mjt9kwpcbpIsQQJ77UCG0XiRYpxrL8U0G0WAcC5VXFYkk3FfF7dDTQ=;25:Uk99tP6Q40cfyrSZLCftX+gIlKMrHdCLjcQQ+C2P7qfnfRvFkiy151XV2c8T9cE0IuRqKaNZSibYOuPdaZkZOvKSh1ZmssNJ4b7ja9akPKjp8MHAuwB9/Z8+4DFbpX8REpbB/foEWpnWEW7xxIGqb7FHl/bl6jx5QOdL09uuKaIQlv4CYO4aR0m7OFqDhrZYPLRxgHmF/DhBs+MoQBlHKR2kJTaVsKXVoibAJ7f8KP89Ku3p16Q6ps+PHx7ZKvUgY0BkTHf89klL69UKrN7ABUJkFoy0MFIerDiA8sLuzhLUZcnzxBhF1jxKg/ciHjrzABdC8LEJN0dz8EZ7WL0WSQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5115:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5115;31:JFN9ZKW1y0xfnR798ttg6JixbxvwasPQxqLia9Mi/SOAo0JMYPUGWUcjKbKjYIhFFAcLlSWScBS4T3iCE1E4rd5E5bPni1DteLOid75f8lWCCUp4XcPTOp3gwLG9iZmZoY+OPpkM765y0NAWZYp9cAnVs+x10ydSpq+qWe4vuXWa+jmPhMYT3AbvtFdoDv0pYgDmQyKxvELjRgxipfsW4seoYMALJmyjudoA6o8p22A=;20:0/zm4r1qQbf/G9nHg+SOjxox9OsJ+mEwVy7xeXrvXA7FbjToZVDL1ApiQVAbWj1Rf98L2mWmbGCSJJjH7jKCfHezum8sq7SujsyVblO2oz1dVn8IriyQn816i8qBdqG1YnlcT4dhFwSM41AuVadZbSFyq2hWvvwdpYDz7ArLakqHtuqvDZqynCFAarN8exhpvqO6VN1TeiU+RFfVn1KBFmwHJevFvVlSQkNCkVj79KDcMH7N4IcQGNkQdUGqT4qYyR8dthdpLixyt4BtTMlmRYi648/vuYM4xRfS7BeO+/HDb1eCx1JOdqtu8bctxVByG1KBHqzUg0AVBdFWkTEkOHoEb3x+qmHFButhHx8gyKBuyZg4hjsAtdoX93/BSq0EQxfrg7PeX/sYdI85BGt7+fJSlzu7fCrlrpLtqlrJwHNCVR7vrbeWifqZxI0bO2cWCZ47RG8/V0fvarn3FLjG884bLG5X4LHFku5zAPe6qkMzvLayGDxVgcwQxb0Bdoft
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB51151B80649E31628D9E8186C1EA0@DM6PR02MB5115.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM6PR02MB5115;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5115;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5115;4:B2Zd3o1qhgtCN+X0PKFJaqu/EtQAPGDhE0h3SYEqKtggwCsIjfnnXe1zvD+1Gm9V2ZUjDWagaJJxtGkk4sHlN8g2AfK3ADH3Qm0Dr8MfjvxbiRkDMhmu3LjF7Sn2mXv3q5mcq+pIM7OZDfjSXKfzf2JZpoQWxcBLcfTrBZN5+PVUf9zJq6MGH78DXfqBD+93qqAXPm9ulVXxEKBU8H7JHJAJwliK+OLnAmx9OJ/HQLdoMH9pRpEr/qg2LpM8h4ClDSvjdT9LAN8rPtc4R/Khga9GX+yr5GW2Bx0Sc7jvBvppVeMh4ZcRXdjY82HhzhYx
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB5115;23:DFVhiu7WOMUSHOau1WPQ3FWOgaWnob+4+QOKsIkgm?=
 =?us-ascii?Q?Qup8Z6VGljChhAqTNASCutxXdCmscc6F/HiFXJACoqq9JgH0eiOQapiFRHCw?=
 =?us-ascii?Q?/pPMQ0Ns3eDceJ+13V7SBuZeHnFE+kHtG7XoirwUTFyw2Eq5IJYnA68yNeKC?=
 =?us-ascii?Q?g4nNvoyyiCu5M3FfzdacerG4Qv1iJBzcoiQl+9LATiG73HpFW8tq2HByi0bM?=
 =?us-ascii?Q?9XSHvvxvrTqoOe7XNf49mPQMrsuwwtgdatVeLpyZgtJ7ss1omhdS5xyEZXEb?=
 =?us-ascii?Q?HiUhjxY9/TEnledoHqv+t2l5EYZ8loQ3+l24mNacjdEalVrQ9BiRrX3Ucvjf?=
 =?us-ascii?Q?CcdwPRlSbQXjB0F94oSxP14U0cgFbBTkB1UMGhiGMNlI2TlEPWGeroHPkl47?=
 =?us-ascii?Q?WCGmizo2mK2Ad6akLop7xkL4ItKQxx7hzGbXeNQzKC4WP+Il2FBINGGtC6uT?=
 =?us-ascii?Q?GEOGcasN6p9UdKLwyUkLvxObC6gROHigF6SbPPNGNHtbAtGmtaV3swLBRO6T?=
 =?us-ascii?Q?/+Feu5CcqgGKumdH0qFJ06KNGoMXol4O4ijbh53TS/AuSpv4EZ3Z6uVD5G+u?=
 =?us-ascii?Q?/TfKMCEaOQW8d/UkPeUMJtoeRveI6lx++lQI4dEZXcadkSYkJUTgudKnbvC5?=
 =?us-ascii?Q?3110sD9saDy9OB62Zg0k1rFC90gWbei0U7TGctWZ9MRbii7hIH+M9Eg8P4VL?=
 =?us-ascii?Q?QgwbLM+9Uw97qCnSJn/UD+s4zyqV3s7H7s1KbLJRzW1ds7vnnEJmIcd86t9N?=
 =?us-ascii?Q?9bie80L8hKDKNaRcNbOz+rZqace+9SZ9MuB24BVLCb30w0y/OtJnCEEQUu8l?=
 =?us-ascii?Q?OtQLrgZoX1c4okXV82AvD9HEj2+MHzzggsRL3aodJVWrgNXZBB2wL4sTKxbB?=
 =?us-ascii?Q?WIDWaijf0iy0KMGdWWn6XeqQWT/5357nf2uQX1sHjksF6V/yPbdfYS+1ISh5?=
 =?us-ascii?Q?tf2qqAK+/L6HH6zwi/3oOskFkf3NkYL/F0wpYIPWvQL+BMWCEGUQtBlGImHW?=
 =?us-ascii?Q?dqbKYQ15UjsRjbNyJtvqK6CYFQ8YakREYGJQh4FaSObmLtr0ohV9R2tX2Qps?=
 =?us-ascii?Q?+JPg8VZoo2M05w1NigWflGJitum+D8hTo/BBDULNttYIUryCufYrA6R8CuE4?=
 =?us-ascii?Q?RrDob0yHIOKIIciRpTjcQjZXvZEwF6EROtWc6CvW2/QxpJ4vOKleGA6UYG/E?=
 =?us-ascii?Q?JfFehdTDkvLtNxW01mopCo9JV9BibeNBwCO01CKaMT5SJcIFljUTULytmJ3T?=
 =?us-ascii?Q?aiMrMfVz831fZlcWVzcUm2WjT/mulXhh35F7VHs?=
X-Microsoft-Antispam-Message-Info: wP+0z3VCkVSMv2yPiK/VYmcBS/JUi219Q/VezzZFaqTvvJ0Q0O+rAxFLuo+fbgWiQx5GwFR5yUMxygws9/ccttiyuk6pMA0/eRPYpSh/ferfadKIMjtwc1+dTOg6B/v92EpYUJr9o315seStZRxBMMzBbQ5sZ7E3GDVDsznmc7ZCTHD4gv3r9gpFe2iKfcGC65dH6iVRqLABjlSSWkacoJHLYpP+w32ZBR23aHl9TSvyDIPNtIBKC26086HDESBLiPHmQOLkN0nCiFuOwrsgDxyqWdImZyoHe4bMX/uewxSHZLZNEgeLz7aYEnWRoSkLdpGhag75/32JrAh11PMQ78YFasqS5lEo/vwRtxOg3to=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5115;6:16Y8ZBrj5lTbI8C2MLQoOR817gmAWcDD6MldDpX5LZufODcu7KmCb591HOZGdtmtxYu3evq2YM+6yDu9702kSgtXvsRd8Wy3blHbs3fuZvkSc4JPUNDqIHeUAZl3noWkWyhI0IT5J4OqPH+wOC6JtusC4ofj+k2j4CpaCt9aqeFlPBnL7cKVxA/EObBoljnpo2UuhMCC6qUkjMkrsyTn2n09MZ/uZaZ4VYsaJCQtjsv/Y6hRiB29xPVCKUpptYwp4SpO8vrbJzyujaI2YoKeXKFb7RV/TS4l1RQ7nO13P4fBK3EKyl2897n2GP4wornN3w5Ngm5Q/pyBR/lAnvlKo6C9lT1q8dj65vnexF3aNQxPL4xNcuXGz6qj/IxI/tsVbZPi9UbJ1imYVo+MBt8cWtTbAfvxI6aimg0rwUDpnbLtbu6BN2SDev0nFMpJbk62JQa70PUS1Y7Uz5pMJ0yoIg==;5:coHc//7tWjOu9FDfG2JmaXn7R3hjSsGUtkZ0eJKMOXScFAv4xFyF0nUKaC0y3FJwwLQqQUmkprBplzmnAdii28VAAzw1xgfmmZGimYT4Acm6ZjwRUMLFGVsQPyhR/cuByGFOdG3cvGcHCA5Hb3lXuEwb+iZKifTSeuBpd6yb0+A=;7:ZO20lKM+t/3TD08p/cXltUzmfxN4rxA+L2ZOATA2b7hMIns3uW27WpTqVma8jsh1zJtyKXsu/u87QavNOyhlfIjKYUYBsCS0XYnUaa4lWIIszHuVxCfp676mReB++M3lYOBu1By7hzvHvJvVdDto7PSgbzPkednD4MIWg94IERKfPBHmInnuAQGK2exnqsvZ8bsQAJDSRtsYtMww/h6U4UvQRoCe7zAXby4eZbe4V1qMRZ4XTWi+ziqFrpsSQa0X
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:12.2345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5318f5-83d8-41fd-e5e0-08d62a0f1d50
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ddrc memory controller node in dts. The size mentioned in dts is
0x30000, because we need to access DDR_QOS INTR registers located at
0xFD090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..a81d3b16 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,6 +355,13 @@
 			xlnx,bus-width = <64>;
 		};
 
+		mc: memory-controller@fd070000 {
+			compatible = "xlnx,zynqmp-ddrc-2.40a";
+			reg = <0x0 0xfd070000 0x0 0x30000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 112 4>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.1.1

