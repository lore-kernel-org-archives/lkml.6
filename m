Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64143ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D5E214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Hg22vVsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D5E214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeIRTTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:19:13 -0400
Received: from mail-sn1nam01on0081.outbound.protection.outlook.com ([104.47.32.81]:60365
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729919AbeIRTTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMl++KedibBL476eDuffyeyiYx4RKcxCTVp4FzHH7KY=;
 b=Hg22vVsvLbSZUg/zjCysCIlKbC5SFUgz8LAm9lTAioLyNGrJiH2QGoO3AMBH/bbLkqbfyuekXk8lZ4Djocc2UWU1G/FFQaBo9Oe5aAMvbQlxFbRo9fl0hdRoHVbZ5fWsmQOVoptFtYtBj91JTBWrgRjbO049Yd4/tU6T7MAa90k=
Received: from CY4PR02CA0035.namprd02.prod.outlook.com (2603:10b6:903:117::21)
 by BL0PR02MB4468.namprd02.prod.outlook.com (2603:10b6:208:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Tue, 18 Sep
 2018 13:46:28 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by CY4PR02CA0035.outlook.office365.com
 (2603:10b6:903:117::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Tue, 18 Sep 2018 13:46:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Tue, 18 Sep 2018 13:46:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKh-0007Zx-1o; Tue, 18 Sep 2018 06:46:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKb-0002Ap-UZ; Tue, 18 Sep 2018 06:46:21 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8IDkI1m000427;
        Tue, 18 Sep 2018 06:46:18 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2GKY-00029b-BK; Tue, 18 Sep 2018 06:46:18 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 7A59C12142C; Tue, 18 Sep 2018 19:16:17 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <leoyang.li@nxp.com>, <sudeep.holla@arm.com>, <olof@lixom.net>,
        <amit.kucheria@linaro.org>, <rajanv@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 4/4] arm64: zynqmp: Add new SDHCI compatible string
Date:   Tue, 18 Sep 2018 19:15:39 +0530
Message-ID: <1537278339-9257-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
References: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(6266002)(6636002)(6666003)(446003)(336012)(426003)(42186006)(54906003)(7416002)(110136005)(51416003)(50226002)(26005)(106466001)(47776003)(106002)(6346003)(81156014)(76176011)(52956003)(36386004)(2201001)(81166006)(316002)(217873002)(8936002)(14444005)(63266004)(478600001)(48376002)(356003)(486006)(103686004)(16586007)(476003)(72206003)(186003)(36756003)(2906002)(50466002)(5660300001)(8676002)(90966002)(4326008)(11346002)(305945005)(2616005)(44832011)(126002)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4468;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT020;1:0M9E5e3pfSDtWIpPKTTffue+5rX2bIcp4CBzKvNh82LTXVX/3mJpxMPHVQSSfx8nDJeLV8JZK3n6HBL/a9QsOCLzG3f7QVjcrd8h0kiQQrgnl629GolNo3ywrMMAEvKA
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9711851b-b344-4f29-4470-08d61d6d2230
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4468;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;3:cIXG2FeollVXbRfe8aXSA7E3DU9V22N2zynvO7Q4KOeqNL+PeBGZwImo5TJbfhNLRHSDSSxsKWc1Z3CM82i0hndYAU1h7WEHuaPXqZRh2QJlOhAVIkN8HSzQcdPXs+EfeSiYuZdzYWlMund88G4y3QJipGMMNS7mTjHRloG3V4CaV7eL5GYRXY3nYYuShnNM1/9mSWbF/XgFEbI9gIT8iYmpiXTSTYhwlsFDiFcBlcrvIBGUcsgHVRCW/xe9FbUtEgyy+txKyJLk1SwhHoeJ2ZcxTQnWZdNXSFrNHuRyKQ0i+MaZdQXEUSJTGIRrLvatwMG6K2gG22BPdRHSJ4HPlLSONV92HLBYY1TO6i0eOt0=;25:BdXKF8E3YZmyPe7vR4eHx/2Ty6IapJZM4Oc63ZtTGMjBVUuS4accabYiToAlEojm0V43mjVcOnLzh9AV2vWpG2BZSzRzdHp7Fek7ZG2Vpkh7AQgsREgGfcKPhsvP4pXcuCKKNuRvwnYxwT5wPUAyDEe23RYkNbwpjOSh6p/8rl6Fj8Fv+HXekXksqZ/xc+8EZhE6nrZ+2PTj3mqomHfcRdUrEeTZp/26NZpb+h5KuDC2IrHcU9Hwd712HRK9UQ6QDPwTx4YUrWzZJV9mTxl0NThGg5OUTvzEhCZQ7d9gu99tWE3fejPLvxJX3T6SAnd23oehAD3+x6cxuV2W3Nx0ow==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4468:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;31:IpkOSJnUyJrES+9ZsYumfap6UvoW+3kR57f3hiBpDHXJWdKxuZvmpCCkwgYgE9ruNdLrn4K6MBvgfycydHe1wpbqAJISvg9i2P1uyAICPJAo6SSX5uo04Z2wZm2zO9qiGlypp759HBK7O5ykpCWBLu1i4U27PmANnQ8poKP6lWX4P41RHiX77O63p30H7FW4EZFvyNITv5SHQVzX+kaYuWGp2Zlms3pDyv5ZNWCC38A=;20:kusG/VE8D2jvm3vmEyfnNisaiuJ4zy+W+8IL2AFytCvn7CwgtsAODoBp7xzsgOFNnMAYVR446ufBa2m94+v2phXgMMfCHHQ6F/bBGCG2zBqUxNyEDGIGmxyoc4B6OUmW5NB86otkvAc5EvU3OIgWSjm9u8oX3oVAF5CFM69/ilVIEChXV54J72unZI6uqUNRrBckLIJtcrXmhYIU7NhgF84+64s3t+KbAw6hY3SLX33qVffjZLG4+at4EeKzxuD3KLwqHytjpPT1lc5Um1kYdYqnbSzOmrJguet9OQKzfvBxrPLMZtzaAsy0gZBo+5P4mfwxbK9rOifXjdkwDz3/rjhiInOfAsb8iSXUo39H+n1KbmUVrLLunD/LUn8M+o+O38CWdiC72lX4rJXv//ExwVj/vSQSomt2Pew0dknxN+coh5Ow9w2uuLen63ErglAdCy13IYYQiMMI6G70MEBO8laow7f9E42FXXiWYeiLTtrVwcEdKk63xx8XPM6Wxs92
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44685E1B5403B626481407C3C11D0@BL0PR02MB4468.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:BL0PR02MB4468;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4468;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;4:TfuWQPNy8nvZV/JffnaL445nbqIONae150WwPIhBvt5vMaabeTxFauvTp/MRQZeuWbQAj1vgO4VSipDZ/HHxky6fv6xXPxQ6hjmP9TQHvuiImZgY7ede+BLOI6aUzC8XiLQ99/JpOFznxACbIrH2fL3Dj5EnGVbwMASyB1ewPeVRq3PXwFAwWSrXiZorXDL3E2Hj+e8Ii2vJFEP1TCQh+ntorzzPTWrAahGSl8VTZ3sotNsjuio3uehjsJCBSJDW3Qw2iV7Yw0gmsKbDqsT8xD79gfJQ4AcS/534hNE1P+p9JCeMRUukl7MihGhuH4mc
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4468;23:R8FLuc/KRePb/I5ftCfaooRhA6JlRvOL6CfyLL2XR?=
 =?us-ascii?Q?9sNCwRbLQ0mRiZBi+fV6XvjSFAbYIWfATA9kFxgrxwt99J9ynaus+eWkXiRB?=
 =?us-ascii?Q?SJZJsMWdn+96CuUm15VHmX0x4jMedyFNld3qSuS+Rw5rUh8ULvXYkBQMuT5X?=
 =?us-ascii?Q?Bo+M7m52yxUDMidbgjUy+H1sRTYLIIqvycjGfRT23ReSWS/zxBKGs4shfKbB?=
 =?us-ascii?Q?/VYOEyyGM0zFT4hqjrzU5EDn0j/ryKCnUcqQC/z6J22yKAtWw5GumxwEl48e?=
 =?us-ascii?Q?6jTuuuGakDLQswluGbD7zxPX4+OTzM9mKsyxKBvKyZCXNfLatzTJa85SzgLQ?=
 =?us-ascii?Q?rgkz92wcOG9blygox475m0prnLT8JgC+6jCzvkzV0biRkGUafWnBQfMxx88f?=
 =?us-ascii?Q?RQ4t/Y0wDpA54r+GTtxZvf4KRpUef8ibctWqKahkh21+VdjZRegk4bjoeMru?=
 =?us-ascii?Q?NWRrtoCjnxKbwLl0bM4iX4Y7MpuTROgTztqj+vlqkUxHiYMOFk60KPsQjmwg?=
 =?us-ascii?Q?A5trpxnjvwNoKh+D7KqxopX5rBwJtz2bwIsLV0SewPmq8VOC2q3tLu/Tvv45?=
 =?us-ascii?Q?jOaulv52Wz3NXVUGKPERn53en77D58LKhn+OiIxluHFmAkBs8fj6lxqlgu/U?=
 =?us-ascii?Q?JTW2gv1hl6wiiUjwi8xYaVDG12/4L8sW9z7FeAIztt1Zy6MMaM7yAZC/cMbP?=
 =?us-ascii?Q?yWJCj5pEa1XKNHDl0DwXLyvaG/XkvQaEMaEg7AZOGuvaAoXUWIISSPRp11ra?=
 =?us-ascii?Q?7aPpYW16gTs6oPmJy0eDGevIWcVkvJPhWQ2KvL/WWqM3OPXhKigKEOTpaqFI?=
 =?us-ascii?Q?hMUP3SaHiK2yjXmXQSgLp3B5nfKUV/OnjVrD8i6XY0POYi+De3gXtk2afoaj?=
 =?us-ascii?Q?TmgSMeOroLtQkwEk/s07AwApEoh3CZBFKAZIn+MS76VKRLa5c/n7Pf+7fpyw?=
 =?us-ascii?Q?V5d9i/5oBmcz8IeV5KR6xML13p2ytvDvmn30J7dYrpMr74krl/lKxIhq4Fce?=
 =?us-ascii?Q?5ed7T4+26ISJZqMdD5PBHIUjQszD0b6tUM46leWV5mWQZAn0F0+jRQymO12I?=
 =?us-ascii?Q?dSUtpZHBEjvWNKM5qmLX0nwhFDNhe90tfOqQfWyrV45NkdGBU3RX3TWOBOo0?=
 =?us-ascii?Q?ACAfygO/ebgbKybyJjEvCnx948eISkM5tYsrkKxWp8kbHT31vOIXlF5uMSaS?=
 =?us-ascii?Q?iY+DIEG/NvKmmaqL7rqpH0BGrAbF87DKNVC7zd7i1DKCzMQGbmJshZhwhy7o?=
 =?us-ascii?Q?akqyfOv1H3c2KHEP72OMlZeCubFN5vicJeQ7A3bMs1fTrWwZWequid729Ux/?=
 =?us-ascii?Q?o9QaPXfMHo3EbLx3ulHwETO6ZHCewJ829im9/T4WJWSNvdAnHwqjabOJghv1?=
 =?us-ascii?Q?mTohg=3D=3D?=
X-Microsoft-Antispam-Message-Info: jYIX18MxATbID5sZ7Ht5kH2ckHGCKycggeKER0AL8DL9bcKrSJrfXIddcYdt98NnYL7TogB0Rfb8GLRfiRg6AK6wttuDEzWdPIGJXtoVygimat7ZgwtZNXA7aU+oa4oKva+aQhpwzK1kENkt4YqPJj3HzA65RFUxVGtzn4WambHyel9m6ZLfITLlEerYdZB74WEKK9QSxnL7fqKYWxyFzrrIoo1o58lSMmDiGO3P+MVJWT68zXVrCUWRvtQdmqdzudlZ2/3Axavp+BgicKl5Tufw6n1q9sIiR7CUoCoj9+fmzWRntIxjd8VKL3j4wog/fLYyMz/p4iKDBslKzfe4Tqy5U18iHF64bjfH7geCupE=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;6:og2wjoIeuFSP24gJmBP9INkUmOBAsrFR86RY8n8nMIpl7t1K0oJNKCVT1wXZU4pcJ+/dN57y3yF9nz7/cT6QiRlmNJpmDgQBy5YqEjedq0WdifYR4ee26VzzVIvj4ZktMUAbspSc78vJcGWp6T/b7Xx/bl4exO5mvNTQf5pv7m1m9zeUvJaOgVOkhUJvGL11uRNKtXZ4rWoA8v5mpHs/4nTVU8+f/b/TZ9ghlcRPEyFJth0dE2+q8p72yF1yHHT294OMJ3g6g+F4IP2izo5PI+3xa3HQyftSKKLzroPIOqUgsNuTZo8Bsyselxc+vLplkLcEMt3w2oWM2aXobCXI7JpYyHfQQuCrmGcgNPbeCOJGa4sFEB7kMN/3N6yxhvH0hYgIulm7VR8a3GoUIt8pt+61BkWeQogk9c2mdTcpEBsulijSk0qsXQCuJt09bqwza9NEVan16A2ZkSN/HCPqiA==;5:3tGoQnQmZXC3tIBUCufimowYLzID0N+E4mSRXMEJR5IrgXW291+Igm3WF/vO/7qIHICy4qN5wg7UrfnbXQ4cxSYZagcHYEBri4oiLwvxwazZ49VQiKx/h3/rzpkjEVw+54BEf++6BsSeB0qoIGEbRE30x98Zd2MgfX/1QYQXpXg=;7:jBbQTSwGIIsLbYdatdLNoidJlH+ty6TJLeD1gOVoAnPc41K/KzQBw/qGqhg8TXgotCtzOGP4dlpYawWdK9CSdxsLEVq8G0HJqy+ewdLRnHt76QrQtZfRkN1E0e+KoB45T9t8pfMJRt4zuzpdcbCifajUH0MlypG2rfIP2WehIr9wytpGeuBXG75gER9mCl+cgkIP66wK7h2SqzUR4LupHxiC5FnQUgKtU6oGbm0YH73qViUWrJD3p4oQ0W6SiMYe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:46:27.4389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9711851b-b344-4f29-4470-08d61d6d2230
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4468
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainline kernel has arasan compatible string now. Append this new
compatible string for ZynqMP SDHCI controller. Also add a required
property indicating ZynqMP SDHCI controller device ID.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..1def7e1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -485,21 +485,23 @@
 		};
 
 		sdhci0: sdhci@ff160000 {
-			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			xlnx,device_id = <0>;
 		};
 
 		sdhci1: sdhci@ff170000 {
-			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			xlnx,device_id = <1>;
 		};
 
 		smmu: smmu@fd800000 {
-- 
2.1.1

