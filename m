Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F48D2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CHAspphv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F48D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeJ2VBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:01:50 -0400
Received: from mail-cys01nam02on0048.outbound.protection.outlook.com ([104.47.37.48]:3920
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729223AbeJ2VBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RompURKGcBwRRIJnoY1J6QkGFQcj6zNdJfMzxYPkc4=;
 b=CHAspphvrm6UOmVqvm0Ov3K6Nffx1GcBHNNz8qfo9s15pbeQr3c+d5U3sMrkU0NArtaj2WlIN+y3DfS7vhoFuhUOolqK/FZ/0Be6aqJ8nVeLlS4AXly3zZ2uYnETh54OFdZ2v6egMZWffS1oaIbcg16wC24kNpTBcTIUOrlD/WI=
Received: from MWHPR02CA0004.namprd02.prod.outlook.com (2603:10b6:300:4b::14)
 by DM5PR0201MB3511.namprd02.prod.outlook.com (2603:10b6:4:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.25; Mon, 29 Oct
 2018 12:11:11 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR02CA0004.outlook.office365.com
 (2603:10b6:300:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.21 via Frontend
 Transport; Mon, 29 Oct 2018 12:11:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 29 Oct 2018 12:11:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gH6Nx-0001MD-5N; Mon, 29 Oct 2018 05:11:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gH6Ns-0007q7-2M; Mon, 29 Oct 2018 05:11:04 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9TCAqNf008133;
        Mon, 29 Oct 2018 05:10:53 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gH6Ng-0007lV-6U; Mon, 29 Oct 2018 05:10:52 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 5BEBC12147A; Mon, 29 Oct 2018 17:40:51 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <olof@lixom.net>, <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <linus.walleij@linaro.org>,
        <vilhelm.gray@gmail.com>, <geert@linux-m68k.org>,
        <freeman.liu@spreadtrum.com>, <rdunlap@infradead.org>,
        <tglx@linutronix.de>, <baolin.wang@linaro.org>,
        <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH v3 2/3] iio: adc: Add Xilinx AMS driver
Date:   Mon, 29 Oct 2018 17:40:25 +0530
Message-ID: <1540815026-1012-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
References: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(575784001)(8676002)(4744004)(356004)(103686004)(6266002)(106002)(186003)(106466001)(7416002)(446003)(5660300001)(90966002)(81166006)(6666004)(81156014)(36756003)(426003)(110136005)(42186006)(486006)(53946003)(44832011)(11346002)(316002)(476003)(126002)(2616005)(305945005)(54906003)(336012)(47776003)(63266004)(16586007)(4326008)(8936002)(2201001)(478600001)(36386004)(72206003)(26005)(50466002)(50226002)(14444005)(51416003)(76176011)(39060400002)(52956003)(48376002)(2906002)(107986001)(921003)(2101003)(83996005)(1121003)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT046;1:hMYeY/g6M2H+3gnMtwNlhas8wyHCMRiTidigwwsH8zHWHnw/ImvpMideNPPOMLtNGmo/Z9agWWS7Lnq6RzWXRtlm11lI3OCxSKrXDLXjV0Oj3GKwaHD8FiB9osbFe/cp
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50290d08-fe85-4412-22e4-08d63d979d3c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:SYSPXqdTzOLUwH8qeZKPbcJTNEy5pwCFCRagotc4SxZgqDBuBzd/VKhEgWAmd0b/a5bKEYSjXn5CtPQE5JgZhFCKnCfdt2lHRGapWgnbVqLNQePL7jiNnK/K/RNrvb0ZFs7tKsciJfvMLEkTmfrhFh8viT9/yD1VYSJ161xiPXoOhEoUB533lSvSjPoOak1LBiBrvkd2puLIYn0hyGvT7NPRoPDZ0KBk1rGx6CZSkYf8r5w/rIFx7RMqU4Vj1icqRz1SH7iGZwfB7YLwz4YVALHGGd4K/zj6LCrvayxECDfhXr08MfVswjKwYSal3m3SddlIC9tXRuQotGRTEmYNBxKoQ0pUdcpgzUKt8FDilKk=;25:/zyzgGSbeObo41kCiCN3bSwK6b4Hh1EWL9y2djicxGTRLp5WffRkrObSW1Wmqg0/U2lhyYurnFNUYB1mUpVEvMe43loLgu4ytNQv6F7Pj4W2btge5fafHbwGqCAQJdHoO1vO67SGFFZCdkslgDx+rahjpeC5pJlP26WpCsr0H8wve+V2fe9AdqTt2nSZ1u4inxSEX37Xh+SU8MMbb9uuIlBX9V61MFo7p9upOoazyJTKScvKfDYc1bmLuNo94F593QS8oRUwjZ84vj6Q4bH2q0tKvKmRGpGcxjsmI9XcaYau+XBU7d5+o5sU52dzOG1Fis9xP5j14LEHXTuHd1+OjA==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:yw0qxgUGT9KVzLU7jwRPhe7yN1nKWwA6Uvvfn0yY9xI50ItT3TlOM0nPb/Cdu312WMdSafRX68739qg/YZeiIFvkEm79hYwN8moQN1BenBItcv/UPEp1HSgil1k7aLgaIQXdEe8c6+hUHXi6JB0pR96h71SfCs9MqrJgvwhYgcgpivoL46ekddgDLzXUeSZ1JfLWbez7o/Bo3XuuzyJJQJ5NK0gIsWXyWFqmsNHSfeo=;20:j3DrAXcEa3UeZDlcYgoLS7vBjaDlv4kDTV+vWCMghMbilDZB8mOB0F8PgaEl6B/0JwQtz8AEL0TMrsTun8Ml18CvzCRs7bCFCDQAhRGH/ZiD46Y7p6eD7hzE3uujUihBGg+rvPTd69SM4RxVafpV7pUUVtTIagxGfHOQmcFVUsIfJ8TsLUIK0Pa2WwLOQRI2uZdFm0TioueE/3gLsAdL0ZeSx7bvPPZWTZdmhEF2s7ivff+lc1XIIUtclndQnUogb8sWO4krRILnU1OYDasjrV9uUAVWT3/jkwuxZXl09CB8mcCGew//jNS2wbYvEzRbZz6cuuTyTA76DAAyUlFH/RtJHi9yBDQQOYPd01t3xUt+zquEhhjD8+8YaxJbxw+sSjIva4nLgYppJtL5ElJDiViOBRsJN8g3oFYpEB+Eg55shnAZGKeeqUb7iYbJd14Ge6/uTQM2x5AAR9sEM7t28JK58gpcy7oSQSNL16D3W6teeYfaqZ7A09g8VCs1Oabj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB351171134DFE6FA4D3554937C1F30@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3511;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:7f2KCVlpJ9qZ5lkOJH3u+IHXp1Cyv5x7jW703/SHzP/pgKut1pFms+gouAs5Yb1C93k5wP5ghxwBZCSR+Mo+Q5XmaIqOjaLLs7DLhilBZ3aYrz5WP6M3oPrXL0grdBRMbpoikJK6jeDYVyFvCqtsh/H0Iqh7awg6AKsgIqcpuuUE3oRD2B6eJXsjDfsARQY+ghVqxVokTBESjSvpyuI8b3tkaaacklTzxPpRKHcU7D/9tv4f867hI4/RyX8ScXwZVsL8O8kmusl4FNOZs/Js/oaSRhbuBasOV/pB2Qdl/AiJa4n2bfutEsUXzLgGzLhseUuTaAw5u2kA0vqvS3V6/cySTPyDp0V4RLn/SiI9NyM=
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3511;23:QqA0rWecftKogOb3eS7B9hd+d0G8ykPpiVXjhjm?=
 =?us-ascii?Q?+e/L47u+kb8IIK0fsEvPrB5VNdzQ92Fn7Di83I6OfJ9YrNp3VIAb/5pKkN78?=
 =?us-ascii?Q?BazyKiAJa/L5wp5Y8XfU651/+zUPiX4wN/bzyp0D9vkipWupXUduUzCSSq5E?=
 =?us-ascii?Q?ZJUwa+VX8YfqZscIfVrXLZfO9+uoH7cDx58Q7UJ+vOGc+AOR7ScCCibEQfO+?=
 =?us-ascii?Q?rWdP4JhlLXXpEBbY1J+uvuDFLJjUeqqzKmrwPhKNfXWHbnCz4WjU1p8DbrfO?=
 =?us-ascii?Q?rX8EWpDcCHlRe7qVthqvEXt1wBQ5wH3hEjeJch6I7fZTHIhLrzQ/491nMO9A?=
 =?us-ascii?Q?JtTf40/0I5NSgPIfHoTuGOYChFBm3Eyj8hP9VMX/C220PfeHJgm3b3bTF0tU?=
 =?us-ascii?Q?zAv8RRzobMBPlgNyX/zARw2sNDNLrIKydLVaEP7ErjfKvRHtWJPSTVE4FIBO?=
 =?us-ascii?Q?MGDhXiKeXElMVo6mXD9siJiwb/V/fejboYYqrVtfsLRKeLzDsZ4xs1S36oE4?=
 =?us-ascii?Q?2YjomC1MdCgYDoyLahKWQJTDPGQ2dpgFaeKlAib9dBrKqkMCPSEyoyYyG7fV?=
 =?us-ascii?Q?yo7jRlLhelA0ULG5NI2axrMCYfJiXUj+RW1T/hzGvD+AI9kN3m/6cfko1hqt?=
 =?us-ascii?Q?sP1gJ3mNluMPywb2tP4M/GHi2PWPGwq26JC4D9MNgzXJfPjusSXEkGNRrFV8?=
 =?us-ascii?Q?QEqtxtvSgj032doGbN8k+01/VjqBMoJqTM2T3yZP4rmB/2kP2sxAMRqWgOXM?=
 =?us-ascii?Q?vRniWDEpzqXyWfevnVDSpsOGanGIdOOdbHX0Ud3sDIf3Jh6FytiNslF3seOR?=
 =?us-ascii?Q?j9jAMPimY48efV1C64JY6ons5GsNPvrfeHW6lnl+Xd6cByEeLdTtd50Pl5CT?=
 =?us-ascii?Q?z95tj0kEuV6jDtw21u7u8JbalOrt/AvcP1zTiaB2n6u2zwhamqZrXIrHlg7v?=
 =?us-ascii?Q?ydk1c+CLdePiTkAdZCFkC0erhJi5w7HIdLAvJprkR6D3ib6NwGxXKKUkJtaf?=
 =?us-ascii?Q?PDa2rKQNhR7D7bNZQCOJm7x2PKWXdZUSJyI8gvLboWnYKqpWg3Ui+a690KV8?=
 =?us-ascii?Q?FOT9CLin8JvUtrQO7wkq3Xo9o4+SOCdqMy+oINISrwl+YUlS0S9wQIq/1n55?=
 =?us-ascii?Q?jPrH70EeMwj5XD1TiR3qYwEBiKKYsFFDsRou1tSJzv4EyMXIYzRShKONnXgJ?=
 =?us-ascii?Q?GopVQ5Trzi+ZE1iAd/IEDND34l9ZA1kc+Lc0d5LGN/wVft3WVrPQCfLlambk?=
 =?us-ascii?Q?fDcPSjo39VpdDXnfTliPrGExRPShpuuUGeEieaGDxA4t9el/qx6qJQYwMu++?=
 =?us-ascii?Q?mv0CE2vtz67LeEXKldSgQHRASy54P/R4NhQFYnJiuwx6JK0XLQxqUaWCX9sG?=
 =?us-ascii?Q?ag9ZGSkwaht7aMRg3Ye/eezScmj6/8CxnJXz/ikkbEXjrGryhfVVKsBg1o53?=
 =?us-ascii?Q?tKodwgSB0dg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3uClmVfK+mgzYXrh1poBG42igDj8zs1G2M1Hi9GNBcsq77hCPkJnbFY5UZgfFCtdr6f/tCYh7G7mgUXYQxAaSFY4Q4Dpc18ENiCXSFVqcJ+3K3G3yqyH8kBXKv0ySKkRSSLU68DHG3dOuIgAu4pRWLOjHiQdHy8sq3Z251CtLp9cLtkdPexolPm5FDxwd39d7Md+NJ5mOvsCppf8TUdejZhAWga8pxb3kXpDEhjYPtqRJxcNhS112FysSHZWSOehUj347YsMMj8F53DNAwGhKR73UEMCfy+Ny5wsrEGoRDUZ+cdSTg1DD8PQTrAG+MuRvHY6v/azpxlC99eDODtI68I1+sLp3epOcrUsUt6mEe0=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:lRwbnojtkRhU1EuL4+7E/RurrfXT+ltG5ojjM+WKVUt99JunyAJT5YPQ7ZC3GnMfB9QiZdFAMaUFy4dc0ARH2Sv+2nK/VbuXOroEhFYPmQryhhcnRgY3iVKb6zyEoN9AQyZYFzyBBHl08kd5BkVLsDPYjRuDALnyPzB6gjhd/JM3c2QDIn7uxByuyumH3VZ0GtCvit7+SlKSiG13mBCa/++AQZGxw7+dlZ1/5Dj8Fx1eXk4gwFzt2rNOUyJmAR5pxzd69HmH42NfOI/lEN4mHeMNkxSwyEKBohpm1cUjRj9kfIapS0G/oGWzEAcmcZjFJ26Xug/koNq70rfXEnhAP5Tr5g/zRnloP66+HGZh/VM/gGTpx3O5shIhJVK4HvekZMQ5UTtk8BzhmAouX4awxTt0xOTcSQXsQC1K9njSuAv9y+hzVazDYKXwOgHPyal0tXvqdYIvXi0k+FJ+57JE5g==;5:dt1Uz5vtar8KN0DPFY37aedpIwRx6i+Qp49qDd2L4cSLlCLxEujgD53vJIIh90CLhudfRvauo3ttKJ97Cr4EzZMizNDo+ssbXMRE5FVi6/Z0Y7GRNheTt9kT0xt/OzGq2vb8zbSlwSS7dY/eVJ6TLrvs45NG/dHNdrnD5O8M2ek=;7:tvSUjleRmeuTwT8SECXapxRWcLfM2yLXxL/vjZp6m3gSF3586B3KtnAntJu+/KHaHwocYnrnoaLTwek0/s/Jxmh7Ll2F8W88RcA7iIkT/liIhdSV4mzKJM/EQmV7O6DVCv8+OcrWdnpARfq6zDwYwg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 12:11:09.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50290d08-fe85-4412-22e4-08d63d979d3c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMS includes an ADC as well as on-chip sensors that can be used to
sample external voltages and monitor on-die operating conditions, such
as temperature and supply voltage levels. The AMS has two SYSMON blocks.
PL-SYSMON block is capable of monitoring off chip voltage and
temperature.
PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
from external master. Out of these interface currently only DRP is
supported.
Other block PS-SYSMON is memory mapped to PS.
The AMS can use internal channels to monitor voltage and temperature as
well as one primary and up to 16 auxiliary channels for measuring
external voltages.
The voltage and temperature monitoring channels also have event
capability which allows to generate an interrupt when their value falls
below or raises above a set threshold.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/Kconfig      |   10 +
 drivers/iio/adc/Makefile     |    1 +
 drivers/iio/adc/xilinx-ams.c | 1343 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1354 insertions(+)
 create mode 100644 drivers/iio/adc/xilinx-ams.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 4a75492..8f7dd62 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -941,4 +941,14 @@ config XILINX_XADC
 	  The driver can also be build as a module. If so, the module will be called
 	  xilinx-xadc.
 
+config XILINX_AMS
+	tristate "Xilinx AMS driver"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to have support for the Xilinx AMS.
+
+	  The driver can also be built as a module. If so, the module will be called
+	  xilinx-ams.
+
 endmenu
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 03db7b5..fbfcc45 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -85,4 +85,5 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
new file mode 100644
index 0000000..fee1d66
--- /dev/null
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -0,0 +1,1343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx AMS driver
+ *
+ *  Copyright (C) 2017-2018 Xilinx, Inc.
+ *
+ *  Manish Narani <mnarani@xilinx.com>
+ *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+static const unsigned int AMS_UNMASK_TIMEOUT_MS = 500;
+
+/* AMS registers definitions */
+#define AMS_ISR_0			0x010
+#define AMS_ISR_1			0x014
+#define AMS_IER_0			0x020
+#define AMS_IER_1			0x024
+#define AMS_IDR_0			0x028
+#define AMS_IDR_1			0x02c
+#define AMS_PS_CSTS			0x040
+#define AMS_PL_CSTS			0x044
+
+#define AMS_VCC_PSPLL0			0x060
+#define AMS_VCC_PSPLL3			0x06C
+#define AMS_VCCINT			0x078
+#define AMS_VCCBRAM			0x07C
+#define AMS_VCCAUX			0x080
+#define AMS_PSDDRPLL			0x084
+#define AMS_PSINTFPDDR			0x09C
+
+#define AMS_VCC_PSPLL0_CH		48
+#define AMS_VCC_PSPLL3_CH		51
+#define AMS_VCCINT_CH			54
+#define AMS_VCCBRAM_CH			55
+#define AMS_VCCAUX_CH			56
+#define AMS_PSDDRPLL_CH			57
+#define AMS_PSINTFPDDR_CH		63
+
+#define AMS_REG_CONFIG0			0x100
+#define AMS_REG_CONFIG1			0x104
+#define AMS_REG_CONFIG3			0x10C
+#define AMS_REG_SEQ_CH0			0x120
+#define AMS_REG_SEQ_CH1			0x124
+#define AMS_REG_SEQ_CH2			0x118
+
+#define AMS_TEMP			0x000
+#define AMS_SUPPLY1			0x004
+#define AMS_SUPPLY2			0x008
+#define AMS_VP_VN			0x00c
+#define AMS_VREFP			0x010
+#define AMS_VREFN			0x014
+#define AMS_SUPPLY3			0x018
+#define AMS_SUPPLY4			0x034
+#define AMS_SUPPLY5			0x038
+#define AMS_SUPPLY6			0x03c
+#define AMS_SUPPLY7			0x200
+#define AMS_SUPPLY8			0x204
+#define AMS_SUPPLY9			0x208
+#define AMS_SUPPLY10			0x20c
+#define AMS_VCCAMS			0x210
+#define AMS_TEMP_REMOTE			0x214
+
+#define AMS_REG_VAUX(x)			(0x40 + 4*(x))
+
+#define AMS_PS_RESET_VALUE		0xFFFF
+#define AMS_PL_RESET_VALUE		0xFFFF
+
+#define AMS_CONF0_CHANNEL_NUM_MASK	GENMASK(6, 0)
+
+#define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
+#define AMS_CONF1_SEQ_DEFAULT		(0 << 12)
+#define AMS_CONF1_SEQ_CONTINUOUS	(2 << 12)
+#define AMS_CONF1_SEQ_SINGLE_CHANNEL	(3 << 12)
+
+#define AMS_REG_SEQ0_MASK		0xFFFF
+#define AMS_REG_SEQ2_MASK		0x003F
+#define AMS_REG_SEQ1_MASK		0xFFFF
+#define AMS_REG_SEQ2_MASK_SHIFT		16
+#define AMS_REG_SEQ1_MASK_SHIFT		22
+
+#define AMS_REGCFG1_ALARM_MASK		0xF0F
+#define AMS_REGCFG3_ALARM_MASK		0x3F
+
+#define AMS_ALARM_TEMP			0x140
+#define AMS_ALARM_SUPPLY1		0x144
+#define AMS_ALARM_SUPPLY2		0x148
+#define AMS_ALARM_SUPPLY3		0x160
+#define AMS_ALARM_SUPPLY4		0x164
+#define AMS_ALARM_SUPPLY5		0x168
+#define AMS_ALARM_SUPPLY6		0x16c
+#define AMS_ALARM_SUPPLY7		0x180
+#define AMS_ALARM_SUPPLY8		0x184
+#define AMS_ALARM_SUPPLY9		0x188
+#define AMS_ALARM_SUPPLY10		0x18c
+#define AMS_ALARM_VCCAMS		0x190
+#define AMS_ALARM_TEMP_REMOTE		0x194
+#define AMS_ALARM_THRESHOLD_OFF_10	0x10
+#define AMS_ALARM_THRESHOLD_OFF_20	0x20
+
+#define AMS_ALARM_THR_DIRECT_MASK	0x01
+#define AMS_ALARM_THR_MIN		0x0000
+#define AMS_ALARM_THR_MAX		0xffff
+
+#define AMS_NO_OF_ALARMS		32
+#define AMS_PL_ALARM_START		16
+#define AMS_ISR0_ALARM_MASK		0xFFFFFFFFU
+#define AMS_ISR1_ALARM_MASK		0xE000001FU
+#define AMS_ISR1_EOC_MASK		0x00000008U
+#define AMS_ISR1_INTR_MASK_SHIFT	32
+#define AMS_ISR0_ALARM_2_TO_0_MASK	0x07
+#define AMS_ISR0_ALARM_6_TO_3_MASK	0x78
+#define AMS_ISR0_ALARM_12_TO_7_MASK	0x3F
+#define AMS_CONF1_ALARM_2_TO_0_SHIFT	1
+#define AMS_CONF1_ALARM_6_TO_3_SHIFT	5
+#define AMS_CONF3_ALARM_12_TO_7_SHIFT	8
+
+#define AMS_PS_CSTS_PS_READY		0x08010000U
+#define AMS_PL_CSTS_ACCESS_MASK		0x00000001U
+
+#define AMS_PL_MAX_FIXED_CHANNEL	10
+#define AMS_PL_MAX_EXT_CHANNEL		20
+
+#define AMS_INIT_TIMEOUT_US		10000
+
+/*
+ * Following scale and offset value is derived from
+ * UG580 (v1.7) December 20, 2016
+ */
+#define AMS_SUPPLY_SCALE_1VOLT		1000
+#define AMS_SUPPLY_SCALE_3VOLT		3000
+#define AMS_SUPPLY_SCALE_6VOLT		6000
+#define AMS_SUPPLY_SCALE_DIV_BIT	16
+
+#define AMS_TEMP_SCALE			509314
+#define AMS_TEMP_SCALE_DIV_BIT		16
+#define AMS_TEMP_OFFSET			-((280230L << 16) / 509314)
+
+enum ams_alarm_bit {
+	AMS_ALARM_BIT_TEMP,
+	AMS_ALARM_BIT_SUPPLY1,
+	AMS_ALARM_BIT_SUPPLY2,
+	AMS_ALARM_BIT_SUPPLY3,
+	AMS_ALARM_BIT_SUPPLY4,
+	AMS_ALARM_BIT_SUPPLY5,
+	AMS_ALARM_BIT_SUPPLY6,
+	AMS_ALARM_BIT_RESERVED,
+	AMS_ALARM_BIT_SUPPLY7,
+	AMS_ALARM_BIT_SUPPLY8,
+	AMS_ALARM_BIT_SUPPLY9,
+	AMS_ALARM_BIT_SUPPLY10,
+	AMS_ALARM_BIT_VCCAMS,
+	AMS_ALARM_BIT_TEMP_REMOTE
+};
+
+enum ams_seq {
+	AMS_SEQ_VCC_PSPLL,
+	AMS_SEQ_VCC_PSBATT,
+	AMS_SEQ_VCCINT,
+	AMS_SEQ_VCCBRAM,
+	AMS_SEQ_VCCAUX,
+	AMS_SEQ_PSDDRPLL,
+	AMS_SEQ_INTDDR
+};
+
+enum ams_ps_pl_seq {
+	AMS_SEQ_CALIB,
+	AMS_SEQ_RSVD_1,
+	AMS_SEQ_RSVD_2,
+	AMS_SEQ_TEST,
+	AMS_SEQ_RSVD_4,
+	AMS_SEQ_SUPPLY4,
+	AMS_SEQ_SUPPLY5,
+	AMS_SEQ_SUPPLY6,
+	AMS_SEQ_TEMP,
+	AMS_SEQ_SUPPLY2,
+	AMS_SEQ_SUPPLY1,
+	AMS_SEQ_VP_VN,
+	AMS_SEQ_VREFP,
+	AMS_SEQ_VREFN,
+	AMS_SEQ_SUPPLY3,
+	AMS_SEQ_CURRENT_MON,
+	AMS_SEQ_SUPPLY7,
+	AMS_SEQ_SUPPLY8,
+	AMS_SEQ_SUPPLY9,
+	AMS_SEQ_SUPPLY10,
+	AMS_SEQ_VCCAMS,
+	AMS_SEQ_TEMP_REMOTE,
+	AMS_SEQ_MAX
+};
+
+#define AMS_SEQ(x)		(AMS_SEQ_MAX + (x))
+#define AMS_VAUX_SEQ(x)		(AMS_SEQ_MAX + (x))
+
+#define AMS_PS_SEQ_MAX		AMS_SEQ_MAX
+#define PS_SEQ(x)		(x)
+#define PL_SEQ(x)		(AMS_PS_SEQ_MAX + (x))
+
+#define AMS_CHAN_TEMP(_scan_index, _addr, _ext) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.address = (_addr), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_OFFSET), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.event_spec = ams_temp_events, \
+	.num_event_specs = ARRAY_SIZE(ams_temp_events), \
+	.scan_index = (_scan_index), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 12, \
+		.storagebits = 16, \
+		.shift = 4, \
+		.endianness = IIO_CPU, \
+	}, \
+	.extend_name = _ext, \
+}
+
+#define AMS_CHAN_VOLTAGE(_scan_index, _addr, _ext, _alarm) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.address = (_addr), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.event_spec = (_alarm) ? ams_voltage_events : NULL, \
+	.num_event_specs = (_alarm) ? ARRAY_SIZE(ams_voltage_events) : 0, \
+	.scan_index = (_scan_index), \
+	.scan_type = { \
+		.realbits = 10, \
+		.storagebits = 16, \
+		.shift = 6, \
+		.endianness = IIO_CPU, \
+	}, \
+	.extend_name = _ext, \
+}
+
+#define AMS_PS_CHAN_TEMP(_scan_index, _addr, _ext) \
+	AMS_CHAN_TEMP(PS_SEQ(_scan_index), _addr, _ext)
+#define AMS_PS_CHAN_VOLTAGE(_scan_index, _addr, _ext) \
+	AMS_CHAN_VOLTAGE(PS_SEQ(_scan_index), _addr, _ext, true)
+
+#define AMS_PL_CHAN_TEMP(_scan_index, _addr, _ext) \
+	AMS_CHAN_TEMP(PL_SEQ(_scan_index), _addr, _ext)
+#define AMS_PL_CHAN_VOLTAGE(_scan_index, _addr, _ext, _alarm) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(_scan_index), _addr, _ext, _alarm)
+#define AMS_PL_AUX_CHAN_VOLTAGE(_auxno, _ext) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(_auxno)), \
+			AMS_REG_VAUX(_auxno), _ext, false)
+#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr, _ext) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(AMS_SEQ(_scan_index))), \
+			_addr, _ext, false)
+
+struct ams {
+	void __iomem *base;
+	void __iomem *ps_base;
+	void __iomem *pl_base;
+	struct clk *clk;
+	struct device *dev;
+	struct mutex lock;
+	unsigned int alarm_mask;
+	unsigned int masked_alarm;
+	u64 intr_mask;
+	int irq;
+	struct delayed_work ams_unmask_work;
+};
+
+static inline void ams_ps_update_reg(struct ams *ams, unsigned int offset,
+				     u32 mask, u32 data)
+{
+	u32 val;
+
+	val = readl(ams->ps_base + offset);
+	writel((val & ~mask) | (data & mask), ams->ps_base + offset);
+}
+
+static inline void ams_pl_update_reg(struct ams *ams, unsigned int offset,
+					 u32 mask, u32 data)
+{
+	u32 val;
+
+	val = readl(ams->pl_base + offset);
+	writel((val & ~mask) | (data & mask), ams->pl_base + offset);
+}
+
+static void ams_update_intrmask(struct ams *ams, u64 mask, u64 val)
+{
+	ams->intr_mask &= ~mask;
+	ams->intr_mask |= (val & mask);
+
+	writel(~(ams->intr_mask | ams->masked_alarm), ams->base + AMS_IER_0);
+	writel(~(ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT),
+			ams->base + AMS_IER_1);
+	writel(ams->intr_mask | ams->masked_alarm, ams->base + AMS_IDR_0);
+	writel(ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT,
+			ams->base + AMS_IDR_1);
+}
+
+static void ams_disable_all_alarms(struct ams *ams)
+{
+	/* disable PS module alarm */
+	if (ams->ps_base) {
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
+				  AMS_REGCFG1_ALARM_MASK);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
+				  AMS_REGCFG3_ALARM_MASK);
+	}
+
+	/* disable PL module alarm */
+	if (ams->pl_base) {
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1,
+				    AMS_REGCFG1_ALARM_MASK,
+				    AMS_REGCFG1_ALARM_MASK);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG3,
+				    AMS_REGCFG3_ALARM_MASK,
+				    AMS_REGCFG3_ALARM_MASK);
+	}
+}
+
+static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
+{
+	u32 cfg;
+	unsigned long pl_alarm_mask;
+
+	if (ams->ps_base) {
+		/* Configuring PS alarm enable */
+		cfg = ~((alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
+			       AMS_CONF1_ALARM_2_TO_0_SHIFT);
+		cfg &= ~((alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
+				AMS_CONF1_ALARM_6_TO_3_SHIFT);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
+				  cfg);
+
+		cfg = ~((alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
+				AMS_ISR0_ALARM_12_TO_7_MASK);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
+				  cfg);
+	}
+
+	if (ams->pl_base) {
+		pl_alarm_mask = (alarm_mask >> AMS_PL_ALARM_START);
+		/* Configuring PL alarm enable */
+		cfg = ~((pl_alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
+			       AMS_CONF1_ALARM_2_TO_0_SHIFT);
+		cfg &= ~((pl_alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
+				AMS_CONF1_ALARM_6_TO_3_SHIFT);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1,
+				AMS_REGCFG1_ALARM_MASK, cfg);
+
+		cfg = ~((pl_alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
+				AMS_ISR0_ALARM_12_TO_7_MASK);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG3,
+				AMS_REGCFG3_ALARM_MASK, cfg);
+	}
+
+	mutex_lock(&ams->lock);
+	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
+	mutex_unlock(&ams->lock);
+}
+
+static void ams_enable_channel_sequence(struct ams *ams)
+{
+	int i;
+	unsigned long long scan_mask;
+	struct iio_dev *indio_dev = iio_priv_to_dev(ams);
+
+	/*
+	 * Enable channel sequence. First 22 bits of scan_mask represent
+	 * PS channels, and next remaining bits represent PL channels.
+	 */
+
+	/* Run calibration of PS & PL as part of the sequence */
+	scan_mask = 0x1 | BIT(AMS_PS_SEQ_MAX);
+	for (i = 0; i < indio_dev->num_channels; i++)
+		scan_mask |= BIT(indio_dev->channels[i].scan_index);
+
+	if (ams->ps_base) {
+		/* put sysmon in a soft reset to change the sequence */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_DEFAULT);
+
+		/* configure basic channels */
+		writel(scan_mask & AMS_REG_SEQ0_MASK,
+				ams->ps_base + AMS_REG_SEQ_CH0);
+		writel(AMS_REG_SEQ2_MASK &
+			(scan_mask >> AMS_REG_SEQ2_MASK_SHIFT),
+			ams->ps_base + AMS_REG_SEQ_CH2);
+
+		/* set continuous sequence mode */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_CONTINUOUS);
+	}
+
+	if (ams->pl_base) {
+		/* put sysmon in a soft reset to change the sequence */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				    AMS_CONF1_SEQ_DEFAULT);
+
+		/* configure basic channels */
+		scan_mask = scan_mask >> AMS_PS_SEQ_MAX;
+		writel(scan_mask & AMS_REG_SEQ0_MASK,
+				ams->pl_base + AMS_REG_SEQ_CH0);
+		writel(AMS_REG_SEQ2_MASK &
+				(scan_mask >> AMS_REG_SEQ2_MASK_SHIFT),
+				ams->pl_base + AMS_REG_SEQ_CH2);
+		writel(AMS_REG_SEQ1_MASK &
+				(scan_mask >> AMS_REG_SEQ1_MASK_SHIFT),
+				ams->pl_base + AMS_REG_SEQ_CH1);
+
+		/* set continuous sequence mode */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				AMS_CONF1_SEQ_CONTINUOUS);
+	}
+}
+
+static int ams_init_device(struct ams *ams)
+{
+	u32 reg;
+	int ret;
+
+	/* reset AMS */
+	if (ams->ps_base) {
+		writel(AMS_PS_RESET_VALUE, ams->ps_base + AMS_VP_VN);
+
+		ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
+					 (reg & AMS_PS_CSTS_PS_READY) ==
+					 AMS_PS_CSTS_PS_READY, 0,
+					 AMS_INIT_TIMEOUT_US);
+		if (ret)
+			return ret;
+
+		/* put sysmon in a default state */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_DEFAULT);
+	}
+
+	if (ams->pl_base) {
+		writel(AMS_PL_RESET_VALUE, ams->pl_base + AMS_VP_VN);
+
+		ret = readl_poll_timeout(ams->base + AMS_PL_CSTS, reg,
+					 (reg & AMS_PL_CSTS_ACCESS_MASK) ==
+					 AMS_PL_CSTS_ACCESS_MASK, 0,
+					 AMS_INIT_TIMEOUT_US);
+		if (ret)
+			return ret;
+
+		/* put sysmon in a default state */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				    AMS_CONF1_SEQ_DEFAULT);
+	}
+
+	ams_disable_all_alarms(ams);
+
+	/* Disable interrupt */
+	ams_update_intrmask(ams, ~0, ~0);
+
+	/* Clear any pending interrupt */
+	writel(AMS_ISR0_ALARM_MASK, ams->base + AMS_ISR_0);
+	writel(AMS_ISR1_ALARM_MASK, ams->base + AMS_ISR_1);
+
+	return 0;
+}
+
+static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
+{
+	u8 channel_num = 0;
+
+	switch (offset) {
+	case AMS_VCC_PSPLL0:
+		channel_num = AMS_VCC_PSPLL0_CH;
+		break;
+	case AMS_VCC_PSPLL3:
+		channel_num = AMS_VCC_PSPLL3_CH;
+		break;
+	case AMS_VCCINT:
+		channel_num = AMS_VCCINT_CH;
+		break;
+	case AMS_VCCBRAM:
+		channel_num = AMS_VCCBRAM_CH;
+		break;
+	case AMS_VCCAUX:
+		channel_num = AMS_VCCAUX_CH;
+		break;
+	case AMS_PSDDRPLL:
+		channel_num = AMS_PSDDRPLL_CH;
+		break;
+	case AMS_PSINTFPDDR:
+		channel_num = AMS_PSINTFPDDR_CH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set single channel, sequencer off mode */
+	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+			AMS_CONF1_SEQ_SINGLE_CHANNEL);
+
+	/* write the channel number */
+	ams_ps_update_reg(ams, AMS_REG_CONFIG0, AMS_CONF0_CHANNEL_NUM_MASK,
+			channel_num);
+	return 0;
+}
+
+static int ams_read_vcc_reg(struct ams *ams, unsigned int offset, u32 *data)
+{
+	u32 reg;
+	int ret;
+
+	ret = ams_enable_single_channel(ams, offset);
+	if (ret)
+		return ret;
+
+	ret = readl_poll_timeout(ams->base + AMS_ISR_1, reg,
+				 (reg & AMS_ISR1_EOC_MASK) == AMS_ISR1_EOC_MASK,
+				 0, AMS_INIT_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	*data = readl(ams->base + offset);
+	ams_enable_channel_sequence(ams);
+
+	return 0;
+}
+
+static int ams_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&ams->lock);
+		if (chan->scan_index >= (AMS_PS_SEQ_MAX * 3)) {
+			ret = ams_read_vcc_reg(ams, chan->address, val);
+			if (ret) {
+				mutex_unlock(&ams->lock);
+				return -EINVAL;
+			}
+		} else if (chan->scan_index >= AMS_PS_SEQ_MAX)
+			*val = readl(ams->pl_base + chan->address);
+		else
+			*val = readl(ams->ps_base + chan->address);
+		mutex_unlock(&ams->lock);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			switch (chan->address) {
+			case AMS_SUPPLY1:
+			case AMS_SUPPLY2:
+			case AMS_SUPPLY3:
+			case AMS_SUPPLY4:
+				*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			case AMS_SUPPLY5:
+			case AMS_SUPPLY6:
+				if (chan->scan_index < AMS_PS_SEQ_MAX)
+					*val = AMS_SUPPLY_SCALE_6VOLT;
+				else
+					*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			case AMS_SUPPLY7:
+			case AMS_SUPPLY8:
+				*val = AMS_SUPPLY_SCALE_6VOLT;
+				break;
+			case AMS_SUPPLY9:
+			case AMS_SUPPLY10:
+				if (chan->scan_index < AMS_PS_SEQ_MAX)
+					*val = AMS_SUPPLY_SCALE_3VOLT;
+				else
+					*val = AMS_SUPPLY_SCALE_6VOLT;
+				break;
+			case AMS_VCC_PSPLL0:
+			case AMS_VCC_PSPLL3:
+			case AMS_VCCINT:
+			case AMS_VCCBRAM:
+			case AMS_VCCAUX:
+			case AMS_PSDDRPLL:
+			case AMS_PSINTFPDDR:
+				*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			default:
+				*val = AMS_SUPPLY_SCALE_1VOLT;
+				break;
+			}
+			*val2 = AMS_SUPPLY_SCALE_DIV_BIT;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_TEMP:
+			*val = AMS_TEMP_SCALE;
+			*val2 = AMS_TEMP_SCALE_DIV_BIT;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		/* Only the temperature channel has an offset */
+		*val = AMS_TEMP_OFFSET;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
+{
+	int offset = 0;
+
+	if (scan_index >= AMS_PS_SEQ_MAX)
+		scan_index -= AMS_PS_SEQ_MAX;
+
+	if (dir == IIO_EV_DIR_FALLING) {
+		if (scan_index < AMS_SEQ_SUPPLY7)
+			offset = AMS_ALARM_THRESHOLD_OFF_10;
+		else
+			offset = AMS_ALARM_THRESHOLD_OFF_20;
+	}
+
+	switch (scan_index) {
+	case AMS_SEQ_TEMP:
+		return AMS_ALARM_TEMP + offset;
+	case AMS_SEQ_SUPPLY1:
+		return AMS_ALARM_SUPPLY1 + offset;
+	case AMS_SEQ_SUPPLY2:
+		return AMS_ALARM_SUPPLY2 + offset;
+	case AMS_SEQ_SUPPLY3:
+		return AMS_ALARM_SUPPLY3 + offset;
+	case AMS_SEQ_SUPPLY4:
+		return AMS_ALARM_SUPPLY4 + offset;
+	case AMS_SEQ_SUPPLY5:
+		return AMS_ALARM_SUPPLY5 + offset;
+	case AMS_SEQ_SUPPLY6:
+		return AMS_ALARM_SUPPLY6 + offset;
+	case AMS_SEQ_SUPPLY7:
+		return AMS_ALARM_SUPPLY7 + offset;
+	case AMS_SEQ_SUPPLY8:
+		return AMS_ALARM_SUPPLY8 + offset;
+	case AMS_SEQ_SUPPLY9:
+		return AMS_ALARM_SUPPLY9 + offset;
+	case AMS_SEQ_SUPPLY10:
+		return AMS_ALARM_SUPPLY10 + offset;
+	case AMS_SEQ_VCCAMS:
+		return AMS_ALARM_VCCAMS + offset;
+	case AMS_SEQ_TEMP_REMOTE:
+		return AMS_ALARM_TEMP_REMOTE + offset;
+	}
+
+	return 0;
+}
+
+static const struct iio_chan_spec *ams_event_to_channel(
+		struct iio_dev *indio_dev, u32 event)
+{
+	int scan_index = 0, i;
+
+	if (event >= AMS_PL_ALARM_START) {
+		event -= AMS_PL_ALARM_START;
+		scan_index = AMS_PS_SEQ_MAX;
+	}
+
+	switch (event) {
+	case AMS_ALARM_BIT_TEMP:
+		scan_index += AMS_SEQ_TEMP;
+		break;
+	case AMS_ALARM_BIT_SUPPLY1:
+		scan_index += AMS_SEQ_SUPPLY1;
+		break;
+	case AMS_ALARM_BIT_SUPPLY2:
+		scan_index += AMS_SEQ_SUPPLY2;
+		break;
+	case AMS_ALARM_BIT_SUPPLY3:
+		scan_index += AMS_SEQ_SUPPLY3;
+		break;
+	case AMS_ALARM_BIT_SUPPLY4:
+		scan_index += AMS_SEQ_SUPPLY4;
+		break;
+	case AMS_ALARM_BIT_SUPPLY5:
+		scan_index += AMS_SEQ_SUPPLY5;
+		break;
+	case AMS_ALARM_BIT_SUPPLY6:
+		scan_index += AMS_SEQ_SUPPLY6;
+		break;
+	case AMS_ALARM_BIT_SUPPLY7:
+		scan_index += AMS_SEQ_SUPPLY7;
+		break;
+	case AMS_ALARM_BIT_SUPPLY8:
+		scan_index += AMS_SEQ_SUPPLY8;
+		break;
+	case AMS_ALARM_BIT_SUPPLY9:
+		scan_index += AMS_SEQ_SUPPLY9;
+		break;
+	case AMS_ALARM_BIT_SUPPLY10:
+		scan_index += AMS_SEQ_SUPPLY10;
+		break;
+	case AMS_ALARM_BIT_VCCAMS:
+		scan_index += AMS_SEQ_VCCAMS;
+		break;
+	case AMS_ALARM_BIT_TEMP_REMOTE:
+		scan_index += AMS_SEQ_TEMP_REMOTE;
+		break;
+	}
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].scan_index == scan_index)
+			break;
+
+	return &indio_dev->channels[i];
+}
+
+static int ams_get_alarm_mask(int scan_index)
+{
+	int bit = 0;
+
+	if (scan_index >= AMS_PS_SEQ_MAX) {
+		bit = AMS_PL_ALARM_START;
+		scan_index -= AMS_PS_SEQ_MAX;
+	}
+
+	switch (scan_index) {
+	case AMS_SEQ_TEMP:
+		return BIT(AMS_ALARM_BIT_TEMP + bit);
+	case AMS_SEQ_SUPPLY1:
+		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
+	case AMS_SEQ_SUPPLY2:
+		return BIT(AMS_ALARM_BIT_SUPPLY2 + bit);
+	case AMS_SEQ_SUPPLY3:
+		return BIT(AMS_ALARM_BIT_SUPPLY3 + bit);
+	case AMS_SEQ_SUPPLY4:
+		return BIT(AMS_ALARM_BIT_SUPPLY4 + bit);
+	case AMS_SEQ_SUPPLY5:
+		return BIT(AMS_ALARM_BIT_SUPPLY5 + bit);
+	case AMS_SEQ_SUPPLY6:
+		return BIT(AMS_ALARM_BIT_SUPPLY6 + bit);
+	case AMS_SEQ_SUPPLY7:
+		return BIT(AMS_ALARM_BIT_SUPPLY7 + bit);
+	case AMS_SEQ_SUPPLY8:
+		return BIT(AMS_ALARM_BIT_SUPPLY8 + bit);
+	case AMS_SEQ_SUPPLY9:
+		return BIT(AMS_ALARM_BIT_SUPPLY9 + bit);
+	case AMS_SEQ_SUPPLY10:
+		return BIT(AMS_ALARM_BIT_SUPPLY10 + bit);
+	case AMS_SEQ_VCCAMS:
+		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
+	case AMS_SEQ_TEMP_REMOTE:
+		return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
+	}
+
+	return 0;
+}
+
+static int ams_read_event_config(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir)
+{
+	struct ams *ams = iio_priv(indio_dev);
+
+	return (ams->alarm_mask & ams_get_alarm_mask(chan->scan_index)) ? 1 : 0;
+}
+
+static int ams_write_event_config(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  int state)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int alarm;
+
+	alarm = ams_get_alarm_mask(chan->scan_index);
+
+	mutex_lock(&ams->lock);
+
+	if (state)
+		ams->alarm_mask |= alarm;
+	else
+		ams->alarm_mask &= ~alarm;
+
+	ams_update_alarm(ams, ams->alarm_mask);
+
+	mutex_unlock(&ams->lock);
+
+	return 0;
+}
+
+static int ams_read_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info, int *val, int *val2)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
+
+	mutex_lock(&ams->lock);
+
+	if (chan->scan_index >= AMS_PS_SEQ_MAX)
+		*val = readl(ams->pl_base + offset);
+	else
+		*val = readl(ams->ps_base + offset);
+
+	mutex_unlock(&ams->lock);
+
+	return IIO_VAL_INT;
+}
+
+static int ams_write_event_value(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info, int val, int val2)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int offset;
+
+	mutex_lock(&ams->lock);
+
+	/* Set temperature channel threshold to direct threshold */
+	if (chan->type == IIO_TEMP) {
+		offset = ams_get_alarm_offset(chan->scan_index,
+					      IIO_EV_DIR_FALLING);
+
+		if (chan->scan_index >= AMS_PS_SEQ_MAX)
+			ams_pl_update_reg(ams, offset,
+					    AMS_ALARM_THR_DIRECT_MASK,
+					    AMS_ALARM_THR_DIRECT_MASK);
+		else
+			ams_ps_update_reg(ams, offset,
+					  AMS_ALARM_THR_DIRECT_MASK,
+					  AMS_ALARM_THR_DIRECT_MASK);
+	}
+
+	offset = ams_get_alarm_offset(chan->scan_index, dir);
+	if (chan->scan_index >= AMS_PS_SEQ_MAX)
+		writel(val, ams->pl_base + offset);
+	else
+		writel(val, ams->ps_base + offset);
+
+	mutex_unlock(&ams->lock);
+
+	return 0;
+}
+
+static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
+{
+	const struct iio_chan_spec *chan;
+
+	chan = ams_event_to_channel(indio_dev, event);
+
+	if (chan->type == IIO_TEMP) {
+		/*
+		 * The temperature channel only supports over-temperature
+		 * events
+		 */
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			iio_get_time_ns(indio_dev));
+	} else {
+		/*
+		 * For other channels we don't know whether it is a upper or
+		 * lower threshold event. Userspace will have to check the
+		 * channel value if it wants to know.
+		 */
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			iio_get_time_ns(indio_dev));
+	}
+}
+
+static void ams_handle_events(struct iio_dev *indio_dev, unsigned long events)
+{
+	unsigned int bit;
+
+	for_each_set_bit(bit, &events, AMS_NO_OF_ALARMS)
+		ams_handle_event(indio_dev, bit);
+}
+
+/**
+ * ams_unmask_worker - ams alarm interrupt unmask worker
+ * @work :		work to be done
+ *
+ * The ZynqMP threshold interrupts are level sensitive. Since we can't make the
+ * threshold condition go way from within the interrupt handler, this means as
+ * soon as a threshold condition is present we would enter the interrupt handler
+ * again and again. To work around this we mask all active threshold interrupts
+ * in the interrupt handler and start a timer. In this timer we poll the
+ * interrupt status and only if the interrupt is inactive we unmask it again.
+ */
+static void ams_unmask_worker(struct work_struct *work)
+{
+	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
+	unsigned int status, unmask;
+
+	mutex_lock(&ams->lock);
+
+	status = readl(ams->base + AMS_ISR_0);
+
+	/* Clear those bits which are not active anymore */
+	unmask = (ams->masked_alarm ^ status) & ams->masked_alarm;
+
+	/* clear status of disabled alarm */
+	unmask |= ams->intr_mask;
+
+	ams->masked_alarm &= status;
+
+	/* Also clear those which are masked out anyway */
+	ams->masked_alarm &= ~ams->intr_mask;
+
+	/* Clear the interrupts before we unmask them */
+	writel(unmask, ams->base + AMS_ISR_0);
+
+	ams_update_intrmask(ams, 0, 0);
+
+	mutex_unlock(&ams->lock);
+
+	/* if still pending some alarm re-trigger the timer */
+	if (ams->masked_alarm)
+		schedule_delayed_work(&ams->ams_unmask_work,
+				      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
+}
+
+static irqreturn_t ams_irq(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct ams *ams = iio_priv(indio_dev);
+	u32 isr0;
+
+	isr0 = readl(ams->base + AMS_ISR_0);
+
+	/* only process alarms that are not masked */
+	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->masked_alarm);
+
+	if (!isr0)
+		return IRQ_NONE;
+
+	/* clear interrupt */
+	writel(isr0, ams->base + AMS_ISR_0);
+
+	/* Mask the alarm interrupts until cleared */
+	ams->masked_alarm |= isr0;
+	ams_update_intrmask(ams, 0, 0);
+
+	ams_handle_events(indio_dev, isr0);
+
+	schedule_delayed_work(&ams->ams_unmask_work,
+			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_event_spec ams_temp_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+static const struct iio_event_spec ams_voltage_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec ams_ps_channels[] = {
+	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP, NULL),
+	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP_REMOTE, AMS_TEMP_REMOTE, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, NULL),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, NULL),
+};
+
+static const struct iio_chan_spec ams_pl_channels[] = {
+	AMS_PL_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP, NULL),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFP, AMS_VREFP, NULL, false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFN, AMS_VREFN, NULL, false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VP_VN, AMS_VP_VN, NULL, false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, NULL, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, NULL, true),
+	AMS_PL_AUX_CHAN_VOLTAGE(0, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(1, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(2, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(3, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(4, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(5, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(6, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(7, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(8, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(9, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(10, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(11, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(12, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(13, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(14, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(15, NULL),
+};
+
+static const struct iio_chan_spec ams_ctrl_channels[] = {
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0, NULL),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3, NULL),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCINT, AMS_VCCINT, NULL),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCBRAM, AMS_VCCBRAM, NULL),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCAUX, AMS_VCCAUX, NULL),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_PSDDRPLL, AMS_PSDDRPLL, NULL),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_INTDDR, AMS_PSINTFPDDR, NULL),
+};
+
+static int ams_get_ext_chan(struct device_node *chan_node,
+			    struct iio_chan_spec *channels, int num_channels)
+{
+	struct device_node *child;
+	unsigned int reg;
+	int ret;
+
+	for_each_child_of_node(chan_node, child) {
+		ret = of_property_read_u32(child, "reg", &reg);
+		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL)
+			continue;
+
+		memcpy(&channels[num_channels], &ams_pl_channels[reg +
+		       AMS_PL_MAX_FIXED_CHANNEL], sizeof(*channels));
+
+		if (of_property_read_bool(child,
+					  "xlnx,bipolar"))
+			channels[num_channels].scan_type.sign =	's';
+
+		num_channels++;
+	}
+
+	return num_channels;
+}
+
+static int ams_init_module(struct iio_dev *indio_dev, struct device_node *np,
+			   struct iio_chan_spec *channels)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	struct device_node *chan_node;
+	int num_channels = 0;
+
+	if (of_device_is_compatible(np, "xlnx,zynqmp-ams-ps")) {
+		ams->ps_base = of_iomap(np, 0);
+		if (!ams->ps_base)
+			return -ENXIO;
+
+		/* add PS channels to iio device channels */
+		memcpy(channels + num_channels, ams_ps_channels,
+		       sizeof(ams_ps_channels));
+		num_channels += ARRAY_SIZE(ams_ps_channels);
+	} else if (of_device_is_compatible(np, "xlnx,zynqmp-ams-pl")) {
+		ams->pl_base = of_iomap(np, 0);
+		if (!ams->pl_base)
+			return -ENXIO;
+
+		/* Copy only first 10 fix channels */
+		memcpy(channels + num_channels, ams_pl_channels,
+		       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
+		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
+
+		chan_node = of_get_child_by_name(np, "xlnx,ext-channels");
+		if (chan_node)
+			num_channels = ams_get_ext_chan(chan_node, channels,
+							num_channels);
+
+		of_node_put(chan_node);
+	} else if (of_device_is_compatible(np, "xlnx,zynqmp-ams")) {
+		/* add AMS channels to iio device channels */
+		memcpy(channels + num_channels, ams_ctrl_channels,
+				sizeof(ams_ctrl_channels));
+		num_channels += ARRAY_SIZE(ams_ctrl_channels);
+	} else {
+		return -EINVAL;
+	}
+
+	return num_channels;
+}
+
+static int ams_parse_dt(struct iio_dev *indio_dev, struct platform_device *pdev)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	struct iio_chan_spec *ams_channels, *dev_channels;
+	struct device_node *child_node = NULL, *np = pdev->dev.of_node;
+	int ret, vol_ch_cnt = 0, temp_ch_cnt = 0, i, rising_off, falling_off;
+	unsigned int num_channels = 0;
+
+	/* Initialize buffer for channel specification */
+	ams_channels = kzalloc(sizeof(ams_ps_channels) +
+			       sizeof(ams_pl_channels) +
+			       sizeof(ams_ctrl_channels), GFP_KERNEL);
+	if (!ams_channels)
+		return -ENOMEM;
+
+	if (of_device_is_available(np)) {
+		ret = ams_init_module(indio_dev, np, ams_channels);
+		if (ret < 0)
+			goto err;
+
+		num_channels += ret;
+	}
+
+	for_each_child_of_node(np, child_node) {
+		if (of_device_is_available(child_node)) {
+			ret = ams_init_module(indio_dev, child_node,
+					      ams_channels + num_channels);
+			if (ret < 0)
+				goto err;
+
+			num_channels += ret;
+		}
+	}
+
+	for (i = 0; i < num_channels; i++) {
+		if (ams_channels[i].type == IIO_VOLTAGE)
+			ams_channels[i].channel = vol_ch_cnt++;
+		else
+			ams_channels[i].channel = temp_ch_cnt++;
+
+		if (ams_channels[i].scan_index < (AMS_PS_SEQ_MAX * 3)) {
+			/* set threshold to max and min for each channel */
+			falling_off = ams_get_alarm_offset(
+					ams_channels[i].scan_index,
+					IIO_EV_DIR_FALLING);
+			rising_off = ams_get_alarm_offset(
+					ams_channels[i].scan_index,
+					IIO_EV_DIR_RISING);
+			if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
+				writel(AMS_ALARM_THR_MIN,
+						ams->pl_base + falling_off);
+				writel(AMS_ALARM_THR_MAX,
+						ams->pl_base + rising_off);
+			} else {
+				writel(AMS_ALARM_THR_MIN,
+						ams->ps_base + falling_off);
+				writel(AMS_ALARM_THR_MAX,
+						ams->ps_base + rising_off);
+			}
+		}
+	}
+
+	dev_channels = devm_kzalloc(&pdev->dev, sizeof(*dev_channels) *
+				    num_channels, GFP_KERNEL);
+	if (!dev_channels) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	memcpy(dev_channels, ams_channels,
+	       sizeof(*ams_channels) * num_channels);
+	indio_dev->channels = dev_channels;
+	indio_dev->num_channels = num_channels;
+
+	ret = 0;
+err:
+	kfree(ams_channels);
+
+	return ret;
+}
+
+static const struct iio_info iio_pl_info = {
+	.read_raw = &ams_read_raw,
+	.read_event_config = &ams_read_event_config,
+	.write_event_config = &ams_write_event_config,
+	.read_event_value = &ams_read_event_value,
+	.write_event_value = &ams_write_event_value,
+};
+
+static const struct of_device_id ams_of_match_table[] = {
+	{ .compatible = "xlnx,zynqmp-ams" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ams_of_match_table);
+
+static int ams_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct ams *ams;
+	struct resource *res;
+	int ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ams));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ams = iio_priv(indio_dev);
+	mutex_init(&ams->lock);
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->name = "xilinx-ams";
+
+	indio_dev->info = &iio_pl_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ams-base");
+	ams->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ams->base))
+		return PTR_ERR(ams->base);
+
+	ams->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ams->clk))
+		return PTR_ERR(ams->clk);
+	clk_prepare_enable(ams->clk);
+
+	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
+
+	ret = ams_init_device(ams);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize AMS\n");
+		goto err_probe;
+	}
+
+	ret = ams_parse_dt(indio_dev, pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failure in parsing DT\n");
+		goto err_probe;
+	}
+
+	ams_enable_channel_sequence(ams);
+
+	ams->irq = platform_get_irq_byname(pdev, "ams-irq");
+	ret = request_irq(ams->irq, &ams_irq, 0, "ams-irq", indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register interrupt\n");
+		goto err_probe;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_irq_free;
+
+	return 0;
+
+err_irq_free:
+	free_irq(ams->irq, indio_dev);
+
+err_probe:
+	cancel_delayed_work(&ams->ams_unmask_work);
+	clk_disable_unprepare(ams->clk);
+
+	return ret;
+}
+
+static int ams_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct ams *ams = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	free_irq(ams->irq, indio_dev);
+	cancel_delayed_work(&ams->ams_unmask_work);
+	clk_disable_unprepare(ams->clk);
+
+	return 0;
+}
+
+static int __maybe_unused ams_suspend(struct device *dev)
+{
+	struct ams *ams = iio_priv(dev_get_drvdata(dev));
+
+	clk_disable_unprepare(ams->clk);
+
+	return 0;
+}
+
+static int __maybe_unused ams_resume(struct device *dev)
+{
+	struct ams *ams = iio_priv(dev_get_drvdata(dev));
+
+	clk_prepare_enable(ams->clk);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ams_pm_ops, ams_suspend, ams_resume);
+
+static struct platform_driver ams_driver = {
+	.probe = ams_probe,
+	.remove = ams_remove,
+	.driver = {
+		.name = "xilinx-ams",
+		.pm = &ams_pm_ops,
+		.of_match_table = ams_of_match_table,
+	},
+};
+module_platform_driver(ams_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Xilinx, Inc.");
-- 
2.1.1

