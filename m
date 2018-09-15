Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EABCECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BB7208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Z1w+v0pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BB7208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeIOTtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:49:46 -0400
Received: from mail-eopbgr710060.outbound.protection.outlook.com ([40.107.71.60]:27599
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeIOTtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcVzG+1iI7WYvwcHjeFBJrsUGTqeXQXevwGSyAjg0KI=;
 b=Z1w+v0pH8B7tFw0we6s73oZ6CP3+ZwJuU6I8emtAayZZxpNZEXr9BbjIXJWZA1xlOgtrytu/iuCzuZu2ymD+X2h5N4ODqo+OKvtByYCegdyCDYc3VBbx1n/VQUZbnbxy/TlXdJ54xnRBdeE1Ra7SqOAv/Tqnut+YqEI7z5IzcpY=
Received: from SN4PR0201CA0062.namprd02.prod.outlook.com
 (2603:10b6:803:20::24) by BL0PR02MB4465.namprd02.prod.outlook.com
 (2603:10b6:208:4a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Sat, 15 Sep
 2018 14:30:31 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by SN4PR0201CA0062.outlook.office365.com
 (2603:10b6:803:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Sat, 15 Sep 2018 14:30:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bag-0003To-66; Sat, 15 Sep 2018 07:30:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bab-0004qu-1x; Sat, 15 Sep 2018 07:30:25 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEUHfI031449;
        Sat, 15 Sep 2018 07:30:17 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1BaS-0004kT-Qe; Sat, 15 Sep 2018 07:30:17 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 08C9F604AD; Sat, 15 Sep 2018 20:00:16 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 1/8] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Sat, 15 Sep 2018 19:59:54 +0530
Message-ID: <1537021801-23896-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(336012)(54906003)(90966002)(8936002)(478600001)(81166006)(186003)(6266002)(36756003)(2906002)(50226002)(81156014)(39060400002)(26005)(51416003)(11346002)(107886003)(106002)(110136005)(48376002)(50466002)(426003)(446003)(4326008)(126002)(76176011)(486006)(16586007)(15760500003)(5660300001)(316002)(2616005)(356003)(6666003)(36386004)(42186006)(47776003)(305945005)(8676002)(63266004)(103686004)(476003)(106466001)(52956003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4465;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT009;1:HZMqoCLwG8ZdgPtgU7kh7I+v169KhRS4gNOa8+cKpXj3Z85f7qpCDDoE4tiMAfbkLz9nbs7M3Fyy0TDm0f7oddPS8xSWNb+ZbPbcI9lJKf85HQslMXUDbeF1YSMYMtYJ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f03dd0a-fbab-45e2-ca3d-08d61b17ca33
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4465;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4465;3:YV3MQdBcID9/5ErRYHwzyxIjzyCrRiT/VXPkpdpidGvNUhNlrsA4y2VAPmbnCEujtoceVqW4LAGSEYLLPMY4U0Vmcff/5QOKOhE3RIojGv/viZhWwu7+3GgQQZLdcjpwGi6n6hfhOFJroJ83P6nioItHQTXA8Aditcwyl0y5yYd0IQVEUorg9XxvvMojJ2lnJNlK4PrhXnz65WCq6e81tm458pX6GY62YAZIL/xIyoqVy+xxRU59KN7fAGElfsoZ24IfBIu9qJ7TrjQPnVjRYoAf9/nmhk1cmw1pkAJHTOfaqB77mF9eNx+PjbHOlThH1+Fu47hfM268T5rZhwqrQU+aA6J9F23voKXB97dxLkA=;25:ebFcvS/0G4lZvgAXPPAyKZZDWV1lFu+wGpgFtdD92dQ1tjcFQLBOiSc0Uallx/dgy79Y2grN5wlreYI1qKLeGW5bsIYGhT/rCNwHFUWZI39NozaQKTMOtTlKbW9D5jjQEYWNKn73Eu6ayXralPg+uhh4fyzm3byQu3DT0mvdcZ4TETASYssV0cxPevwbx6dsWKpNmRB1NHDYGn/Pmq7NyYEdcDTYLlkhCJKcJlFIUexEvxkoWDcMjvJT+LykLdMcMUCkjVgzGPrl8I7WTbD/8pDtoSibeid41jP2Ul6rsVSrRW+EdD3rNYuZDsCC/mGcQ8Xj4gcJ7PhZeEDXTnifjg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4465:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4465;31:XCl2wi+5gYIybDlgDU4SJFeVY+Vn+eJDAoBtm+RoIrlf1bQEpGgALHCHVheYfK0083ljVLIe54sOgShnaWtDexVNSebUHI0VhOpm0dRFmFQlLESCb41DuRHA1X7ZKyOq0R6Ckd7rU4cEokyi25wtJ+Fd4gyG3BGbB4GCbE7wO/ersFNFfK4Cbxu8WX9AAFD6qwzGgMHotkkyGVLP4wkYhof4tjPPPPxrwFU3jW8Reok=;20:qSYisLm1FowOu/v9ou9xxZlr/93dxDHp53i26N+mUjy9fthXBhREng8qhtCJGgAza8MZj6PNSrt7nGTnFewCGiK5ksETC+TxxKvvmOSg1DcC7gbJKSCI36HyI0+WmaEtEoUD5gILLb9p37qWkj2U6jYGu7odp7ezm0rjAj+sV1HBIMUSSTC3SMqsTphc3v74dHeLjgmX/qa6vBuoEfUvmZNPHDF6kwAOSIVhGRm0uShUrm1Hlf2GYC0mnp1g1/yryotyLF6t3K+rgXnysUcbO8ss0BeE5eNO4MWghIFh3ry4u+DocTIDrgSCjW6DRdGIQNq15kO18QtxL3P3OgMAaW7Xd+PEJ2G2WXL+jaMgiZMU1qYN73hPH5Y7Ks7b1bIFzW7vjw0vFcbf6ZU3A5ibXUrAGbzaWaVQiWp50fS25Bg/3srLjOwYYnZcRNEWZE1HwdgjqHWM1s7sVZLItakpkfe+egUzDVTmn7kQZg9IQmAa9EMoQ2IqICJLDCFnxIA0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4465505DC427A7B59465A80AA7180@BL0PR02MB4465.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:BL0PR02MB4465;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4465;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4465;4:gXI8FtNHG6uQtE7F0nbxsZu2LLTWmZ3tUEOZJcUhQCzthVDo+cteeaDWJnTxfr6FfFyw29mKawCTacya2bFs4mn6+0PYAv8PDdoQVRlYV7EKX1IAJVC49V6+GiPtuKXU+KWJLfn5ld+UPNl7tSeM3/VUTqjIbiFXFW/V0m2lpZLaP2RpstK6L55k4W9KrFQSLA3nWJvidpNwOFe0M1Od98ImKqyTpLNywWeQZ8UifM8JIpK10xZtFhsH3tREVZICag/ZtJHhaGV68B/+lwV3Q7LiXZB7kYdiIGdU3MLF5+s4kx9k3EKRjD54grUHt4bO
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4465;23:+d13QTLiBnWbjLNFh+oKY5fSNZ1jbbs6bIpTpmYtV?=
 =?us-ascii?Q?1hrt8RzG+abRboFWWFlWN76+HLDMTgmW9sww0RJSUy1/ImCVQUWPjvMIokRR?=
 =?us-ascii?Q?8uwF18m3TaLqXMhehpJEHaGvwy+qIsFcb6wB4NdRWpt4afimxTsNKzrXUEPx?=
 =?us-ascii?Q?2O6KYZmF46OiewOcapGOXBxF42HLpCfMM5ky8DgaxSztOFKAD6gnJsfFbu+F?=
 =?us-ascii?Q?eU8O8VBEwofM2N3/+BPKc+gaDJigbeD61MTIUwLpxENGvBs3JQ/WVKhQhxDM?=
 =?us-ascii?Q?7nDPmzv4Tf5HAAPZrL99pWq3CvNfKeNd/ws5OTzOBL4jTIZSwP5DRKy+yFAA?=
 =?us-ascii?Q?zXNNKL7U/yXJE81dLA6QA+fEmul9rpu5ytWIyqk3o5obVAiluC+dTUK+9k39?=
 =?us-ascii?Q?Gm2aLcFMpa1ytKSmyhyOVrl3l81Qiin1j9tSCg/tRK4k8wr0GMqdx5LnSGpi?=
 =?us-ascii?Q?Y1nQxYQb2yz0EzGo0olvKvF5E6wi3m8DaHl/NJnd81qyAzKsZ27QKTlSWMFP?=
 =?us-ascii?Q?8heLKzTJ1jNJuOOLzpNTuzUBiA22l7TIft9vXQdPHjUHwmrsRHF7kXTH8bDk?=
 =?us-ascii?Q?FTC7wIwTrj4XYRVgkqjqKhtuKVAXYwyBzu8wPokx5xzv+IS3ITiVyO0FaH/D?=
 =?us-ascii?Q?TF2T37nCKEgA4cI2hfufOiK0/dE7pUXjf6sAXPObufpZhVorcbU35rxLBBhA?=
 =?us-ascii?Q?N+qlMMHd1achbb2liUXCVvsnJjFtGs5WRD80R7ucaY9EJOsjWqq37qEJmNTD?=
 =?us-ascii?Q?7/OS4KT4RYCuwXDmtoLZmDpZ33jEatn+XTnO45AdpFXxUb/ZKvVJ+FxA+0Ad?=
 =?us-ascii?Q?yLnQ6sQp3FNI6I+y2p79KI8jDJOM6YHvNlrsXTeT5k5RbK63n50DAg9zXWcy?=
 =?us-ascii?Q?MUvWScEJgwuDcaRdyksJwUhMKTqQhZRzzbbjuFUNC+/bZBL6WhWb3bajdk/M?=
 =?us-ascii?Q?Xc4s0L8XIrUVYbvXyfuaFhprbF9GWgyPTWaEaGzq3kSWUKsm+ZE/BZsjT7KG?=
 =?us-ascii?Q?sRQQ5y9Kb7M6vByyPbUDvT/W7rvlz0p7pQV1vhj1yeSdB84OQCkWaE4i5tDX?=
 =?us-ascii?Q?0qcw9gf12tMeAM2RcW/DuFzk2HBsXQ2tU4DiBhtK3uEF0xcv2TsGY/YPLpJn?=
 =?us-ascii?Q?G+a/ytNpTfKdAgHlb4v1TwuE2RjUKTFPTOxer9TsUPmSOMs++tQ07ubPwT43?=
 =?us-ascii?Q?hYeGgslNaH/Eiob+H84opmaGTPivlEJc+Yb?=
X-Microsoft-Antispam-Message-Info: mfz1kZ8LLKOg+CtKueBAbBLzHuWC1/8ha+bK9lV6uDuAWmfwRxLGB1CD5V6Koc6vxUwk+g0cd113AC0S5XN2Ja3fNQXCi2aDeA2CEUGnrniJW6eX1Rxkbz305T2xM4Pgs7tQoRok8rSBhX01Tllk5p8KPXNPhlGWWnFH7+hSbcLt7tUrGOJPn9HYkMY+/v2cpmB0KW+o6imqosaPQd/+BzqDBEEFK3CY8yZNs8LhGPqft/fycPBsF2WkOepi+TljogBIRTp6dmh3FiO7UEdjfE0kI3Oc4iqePqsj/84FmIeCTRVmGJaKnwLamQc5/N8GVedkvIjVSGHUouz/cBnlPmqynch2986rCNCa3mWTMVI=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4465;6:BTZggho2xDuQZm1aRCvHb8uN/BZ70GjI0TSUjPzeuG24CWlK2DNM14f2wU527z5zhpwvxCAmkeOVO+PUhT6eno28BimLZbOYOA+K5UDMplu3whkoeje8/VoZtQytqMQl4PqiXij72ZytpC+9wFIGxO1jI/KUNpE4ZK807n9/Ru9zhkfbCN8wDKqaaBzRythDOipocaZNuQfy6E5SKRDRPIN9oSrE4BMmUKFwQLz6xiImm8EiIBj9R2k33R9wehk4FKxSJBP5f54ZP2oDIa68IL1h1hPBmatjxMvDtXrsH5LaTQt3sjUYsIRG5Hy9GOi4sJyKCPBgdGOFVLOlbacwuccrhN+OkJ2jteubN8VxhYdPZISrLGHDvLxLZ+JNnR8UbeijtnCKAWZqmHBpeUB7hivvThupoy9X2C/Ktm3pH9CF//H2pBMgRnbQleNv/2Hdat2ZK0wkTYhF1dr0Oj8IJQ==;5:heeRu+erUGrBWmTNk0QnHOpugy6RUuP+p0UKCNci3z6nWgkdpf3OFgiHhWAugg1DoGx43VKml6Jv0rofpw02P+aP7JWDpMIjW9jZcrgRGV73GFneK360Mq0U+74Ip+uFQoxWTBcrKPUaDbM5/1yytUY8X7o+bT1hXoSom0Dv/MU=;7:s2wjSQQ7d9DyCoasDII8a4QHisUTiEJsFMHtynFG3EfYlVy2EOSCc1KWzQv0em4lNXgmwNULJI1DLzl+6r6FYOk3YWQMyPnWUfyZV5Y8jO0Ki/kYpMK52hOdd9ZaIoHG7FYVeTr3Ca/bFRvi4ELc0IwECB7SgQVb9Y6y4J6Gj9wopIgAzbXNyuq4RtGjo8tMbcaiGLMzjVqcc1WX/aM8w0AxqRSnFwUiV6MN9A7NW+K3E0XkzcNuKZdVBbdfBCBZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:30.7593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f03dd0a-fbab-45e2-ca3d-08d61b17ca33
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Availability of TRB's is calculated using dwc3_calc_trbs_left(), which
determines total available TRB's based on the HWO bit set in a TRB.

In the present code, __dwc3_prepare_one_trb() is called with a TRB which
needs to be prepared for transfer. This __dwc3_prepare_one_trb() calls
dwc3_calc_trbs_left() to determine total available TRBs and set IOC bit
if the total available TRBs are zero. Since the present working TRB (which
is passed as an argument to __dwc3_prepare_one_trb() )  doesn't yet have
the HWO bit set before calling dwc3_calc_trbs_left(), there are chances
that dwc3_calc_trbs_left() wrongly calculates this present working TRB
as free(since the HWO bit is not yet set) and returns the total available
TRBs as greater than zero (including the present working TRB). This could
be a problem.

This patch corrects the above mentioned problem in __dwc3_prepare_one_trb()
by increementing the dep->trb_enqueue at the last (after preparing the TRB)
instead of increementing at the start and setting the IOC bit only if the
total available TRBs returned by dwc3_calc_trbs_left() is 1 . Since we are
increementing the dep->trb_enqueue at the last, the present working TRB is
also considered as available by dwc3_calc_trbs_left() and non zero value is
returned . So, according to the modified logic, when the total available
TRBs is equal to 1 that means the total available TRBs in the pool are 0.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v5:
	1. None

 Changes in v4:
	1. Corrected the commit message as suggested by "Thinh Nguyen"

 Changes in v3:
	1. Corrected the logic for setting HWO bit as suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed the commit message
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 032ea7d..8a1622b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -911,8 +911,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -991,7 +989,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1002,6 +1000,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.1.1

