Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED76C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3882146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AXUOEXfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfBAWJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:09:31 -0500
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:1447
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfBAWJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw5hHpT8Y8oC0drDRboRs3tOy5YpvmOIY05EPAoTZX0=;
 b=AXUOEXfwhQvI9TaDfrCZ1gqwqQLU7LTtQZqmie7SQkBwkHxsdhN6j4qQEJqJcvdi4/kW71I8TSrvhBqXVNUAkJT/lmk6yeQtHC59sD3HpEfIz/m3A/idQA21wJxTKfhLu5wMlQqC44v/7tAx8KdcfG4mKHRQOsUz8C6nlQPLYeM=
Received: from DM6PR02CA0020.namprd02.prod.outlook.com (2603:10b6:5:1c::33) by
 SN1PR02MB2157.namprd02.prod.outlook.com (2a01:111:e400:7a48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.20; Fri, 1 Feb
 2019 22:09:16 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR02CA0020.outlook.office365.com
 (2603:10b6:5:1c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.20 via Frontend
 Transport; Fri, 1 Feb 2019 22:09:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 1 Feb 2019 22:09:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40519 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gpgzq-0005vt-8i; Fri, 01 Feb 2019 14:09:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gpgzl-0000P8-5X; Fri, 01 Feb 2019 14:09:09 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x11M8wV8027121;
        Fri, 1 Feb 2019 14:08:59 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gpgza-0000LK-Nb; Fri, 01 Feb 2019 14:08:58 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v4 3/3] drivers: soc: xilinx: Add ZynqMP power domain driver
Date:   Fri, 1 Feb 2019 14:08:50 -0800
Message-ID: <1549058930-18644-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
References: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(189003)(199004)(356004)(8676002)(81166006)(81156014)(8936002)(2906002)(44832011)(426003)(446003)(51416003)(50226002)(476003)(2616005)(126002)(11346002)(36756003)(106466001)(336012)(7696005)(486006)(47776003)(478600001)(106002)(76176011)(48376002)(305945005)(50466002)(107886003)(110136005)(77096007)(39060400002)(63266004)(54906003)(9786002)(72206003)(14444005)(36386004)(5024004)(16586007)(30864003)(4326008)(186003)(6666004)(316002)(26005)(2201001)(7416002)(921003)(42866002)(107986001)(83996005)(2101003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2157;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT063;1:YozjsxclgA1ln4nwc6gcsvXaCkbNAmBAeRdLJaOrRhm4UxfXaX3sij75eCakNiacUYHosZF2WMZLYTuUWc6xyWnw46qoTA2DIZtutUP6fsWOOP7J2aXMck6CPmnQGVpLZzAu5fGOVgR2bGGCE/5j5SSxpUX1W/OmClRhJu0TuWM=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc51f936-ba3f-43a1-10c2-08d68891e75f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR02MB2157;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;3:LO7QwSYotUwxDPGSbkOa1dwMzAH6LdUkDuiCVwWR8fBx4weYCmB21xbfsje8N1+E9V9S5sXJ3EAHNSSVf9AzddghbJDzeTTOjYJ97Mx6Gc9SnweusdwLxEvf5WqLASUTKfdkQ6DzvMvZ645iEg0LE2OQEBKitJrcTMkj/WRM0MGquEr13GrfCKqeTRwuMsKQQ8a+ptMUFjjS41+J32GW/0+MHwd/Ki97QlcnGwtgTMS5J3jz5y57XObMO7/dPytZ/w3TZUCcuX/FjJleEAiJmnJY/NZw5nTN5U9c2Sp2/Txd4rsDsMBXOKlg+toYgJMHw0vmpvm51USRup7MG9708m2oBzSTiYaoR772iTa4kP7oWRZhnNgFSMkiGev/e6dg;25:v34nXIo0RNnEF0Bqmz2k9S31Oa8yi4LhFV938V4FpjS8vbDzONhqIXoM4l7zFM3G4Zb+HUtNGp0V71IUsKG2gV6TrRqYZEXgmIlIUKjS1JWzyR8r3KHtGRK1wxHTrg3jcSOUYmh+8pgR5P2OlCLw4ellM5QGkbMluwq7KiC79EB7WdYGTzJemscj/btgKbSW0LN88jmCgp9CRNcTpG/7R+qqxH6ST3Ngs6JAwShxDg9eImBuyiZXScdqgs0ajGktoQhn1BxDa8ZW0f+DORuDE+jjiRCsS010nlqP0VJ8phb0Qz8uFKS+qZr3f4IUrBvrEQbFmn/Sdi5/jeUW3w5FCQ==
X-MS-TrafficTypeDiagnostic: SN1PR02MB2157:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;31:dZoCLjrKEF4wH6J+7JLnx5O/e0XUDadJS2R1G4lSUqTkOxroCCjDxioMVpC9iRUnnfeQ/0cvDZNueVZYmdd/MqtfT7zNqE5UFTL2LlJHXoROMIeX2QdMDFuZIUMa6zKVZ13SNRRBQZWipZsQ7iqjUKWe3Wqwlum3vGWvv+4BsCl6j2u+gFnK4fYgmR8HK1laiGdMZfFRKzBzPr/Y1oSF6WPXb8h9EcPPozx/e38ZSdk=;20:FlqYq1gLtd6X+id/fJl015F7Mlg85OBv3FOmCzjGYkyr8eUCKWx226k9d1RNLEJGERhuaBYzow3TcRYJLgTJ5rb3v4QWEHPvamcdI5fJGUY6fCHwS22HERhHQsMHajCWVWqNPlS//HoGVq8SXY6f/SVPH74h+4Ljep0huRwgvXIyLhSuARlcr6HhSdbFb6C6fE/rzq5CjjKZ0l7AdAk4JwuZItVT1Wh3bhfEZiCA0VTrN+9Htx9/rIyTiEEpJ94gWCh5thm3MlJeBm4MQTWfGKUGEdP5nVuMoAIlXW68y6JrdImnBbxXBJVUMJ32rKd4KehgEwgD7qqYAdn2heJCv+L7Bg7f/1xX+miBb2UVay3+0x1eIHuCiusDXu3SL+kmo+co2WHGqgja7fOjRlclHoqs4ebPNDraUs7e9hoA9LA0zc8DlxqH4ZEbxPxC8vAelEsIcMUFzFLu/kL2ihQAiClBqh7oR7HYgp+yzCMsSh9JNjaA/ExnTx1ciRYXw5Rm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB21579E4E7DA019FAE865881BB8920@SN1PR02MB2157.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;4:ob3pOZfDtPIgF81pzpG4l8DRik80+IyzvF1YexQue999F6Mxn5btYw1pZW0Jib67kI9raeZUtzwai2+hvRKLHk+P0bSCaRNoUVZMmp/XFL+b42lSsS+90XKmLVgsMvv7X0DWoJiKZpbjVhXbK2uKsHFt6dMjpVSTsctA8gw51M8lKRq4OCvna8gOwUXkZSzT/FNKZeybqq/M1iQ1HrEGKjwzEXVuz7YRHKyxYkS2bwrohKqylGbHnhfFu7Bdi26XSCpusnc4SMIU4mHX8kJxkr+PSfb0Lo6TOmB/ivFcp0SW4bgh6erIJ8O2WzMOZNJb
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB2157;23:UY1Rs1qI4kafroajYLf83cYaGf8LS04ZMWS86B8BR?=
 =?us-ascii?Q?UUsx83qefFoiqjKjPeLjNtf0pgbwG7z25UdfP6j9MxqY1ljVnFJW2hMj0wIH?=
 =?us-ascii?Q?sp2tGInXZYjWqzdiVPTEhGGSoef5k4ZUiZyqiv/M7TAi9dDpAYO1vKJ5eTft?=
 =?us-ascii?Q?OZjIJup5SNsy2zoC9cmIpMtvKWwS99UJaFchhGeDoOaipRPbwlZQhtoejyX6?=
 =?us-ascii?Q?i2gaHYjTFXJulSd6hzXkGu02D0csK9ukydcTlUP31Z+FpuEKqTJAOL+LosKq?=
 =?us-ascii?Q?zAHuOI4Kd+2dI+UIxz51bfkj+S7uu+JkYHDy5NlR4ZUDLqWgBiPo1OuGOsJO?=
 =?us-ascii?Q?dtGx9ag6ToCyHzz9RDOMOu8fDAaevb+g6c4C4P96pbpkm+a0J1AH/n8PVWFr?=
 =?us-ascii?Q?E2JKCDercN3tLKzSEDCrr13ZpN2OR28GJRUdravAlzi5ZWKRndGJqFU+LY9C?=
 =?us-ascii?Q?af9Ys7ieZ/llCZok8cfD6I00fOPhCr+C5j4I/xGuZSxWIgKGG9sirXd4jg5j?=
 =?us-ascii?Q?34RGURgLAcD6/8iAMSg38Qf2EJqAQgWDk+kFgAf4cTekt/BmSVQvev1Xw+YV?=
 =?us-ascii?Q?zEELLV9kjBXW+K7+qzwrwm0E9VXsA02VsVn6spJEO0pQCPy3EveOCruMXmh5?=
 =?us-ascii?Q?2reqhDXe+ftkrdJyxlv4VGOLnZ6O3J+9BvtCPQHTK6pshQE5A4/uBzccm6Ny?=
 =?us-ascii?Q?f2iUTEEK+ictp4FT28W6rX5R5/WoH/P0IX1B29My6RmIMah+A/T0anjM8bD/?=
 =?us-ascii?Q?W8zPqL5W+LPRBISNkSlmtdP0jl7hegFo0L2SDocgQR8OsjVp2dcIZYtvyDdt?=
 =?us-ascii?Q?/XaHIOoa/jOzNiif9RDQruSN5xSDs2QeoQGEUIFlZRHoWIps639MuOfx0xLA?=
 =?us-ascii?Q?lmi17cjWgBWpEjBKtMcJkT8HzYv3JyL4zAOUHlEW6EQbAa/67mvs/Rl6yz7v?=
 =?us-ascii?Q?Bj3jSRMlrIEQpmm0hmEwlKvWxigrTpfjqzf+e4fRjH8E6vhKDJ+cjkaMYQDb?=
 =?us-ascii?Q?bfNocBzQlvXMn9pPGmsSRYFQwMld5uk/clDtSoE0o8rBpPxE+wEtGXSJbUEI?=
 =?us-ascii?Q?Ton5qhZMYkc8etrNzLCMXWUF4Ci8ysKUTYRbRnA2bCsySj0KaWuROVrQX61B?=
 =?us-ascii?Q?AfsOkrCaK08X5cE8OSmLq4/Hl4ZqvjCUksZ/EyQdsewNCoDgnlGrG1dgRkmS?=
 =?us-ascii?Q?UWc2XFQyxkcpMzCBnXfaDRbJF/VLEAP2L+1za7n6gkw3ATNTUawotU4KZn2W?=
 =?us-ascii?Q?jILXKRlrTpZk/Q6BTJgEgf2/+N0P/nJUuNa/HVAhgXiu5nLCI1kJW7bcDK/A?=
 =?us-ascii?Q?S2RMGiu1UHJmJqfbuRKmqWGYXT7gqQBgrslBH9HXREp6i4xCRIqiEp7t5Gwt?=
 =?us-ascii?Q?Ktcpg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nqTjHkUs9B5S5Dz1LuzeIuX6EBv0LxDR3zzSHS2MoJRxGq//XM0aLMMTMTZ8cXLCaidVTRgCpCk77sraXF7jZ5uEBi2QtgSj9l7t2+7iJD+guaUv/vfDBnR2czGvmgw5KbxXHF8CDxi32FomxWHQ9w6r44bXQKVLaBEGJ6aXDr2Fthc99I2hrxqh9c7dL0JiDUScZBgWZzdLIBU1rXcFs954F+kMCaVehc9/KxDCYNEIOHzMLxCYPAfZCl4IZGuDU+e2ZU0T+n8t/US9ssbApj3/uH8BJekSZ7imxF4ED4KQZrmXtoR8QpdlVIQThjETjExL3jVfcH9M2U1/AYwokpg8DN6LZUpnxcanuH82mqD13GAYaCB/CMEq5j6knUKEb8YSexFxasTjIUQncHGTMDURGIYmU1bUj87pH4JxEEI=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;6:3/Ga5YKyrWhJgs+mgBFzmZt/j0pICZmz3VT2vEsDN5J29TyuLMKszySwvJbuN0LuIIZI/HqfXwiXS50mHc8LVeygoYP6OMdmwyqAUB577TrG2b3uf/lA4/bvzN8oz98iH7D1BC6K9/EYM44fN/aIAWYEwkVvOX5BjMXhLluo74bD+bjeSzPKFQaNqwiZDl4Alb1xjI/WIYxf/gRNy9a7z0Jpt2lYE4+G6jgnrfuQWsdnwK0af00gfZiq/xNTUshHt2Hg2HtlV9aH/vul8geyU3u1XRACrQxUqDvBP7e+VwZ4b917k4RyLQdbj2R0gF7/hHh6Lo7CCkpl8iLLeSjia5d34nN9aT1meqmpriy+VbCano6I76Ku8XuD4ApUaQyNFyjB/TgwpsZOXpcNMboaOy7DjMjus/sSJldh4z0qmWxhXXJKW8uhT/EWud2iuRsN8N0mK2jl9g3C6B3yJvl/bw==;5:bjefww6BWhtGB9w9CKM1o7EpbLqIZ5VZQY8n3tEgUzB8gXoHk7AIAXzm2egxZ+Z8xiE0PGkh8N0tSFkCaRczekAjykcTu77PuY+y9w4QWMAtvNSySfzVHhUKqEnyExQWXwEBMarwfT0ze6u53RQnIB2omnCZq/5ZWsq+tZr/GsibDD1jpmBnqi/2l6uAPa/FUAr0hv6hPsztp1+9R0PuYw==;7:CX0N4T88TKgYOZj1UzZwGo+MwbbRUkD0i5Yd99LsyH1OW9kJW7WtI9YTlQYcZsvn4zG2bOPhyLLj605pY+/Jb1bIPnb83P0g33IuNT61CBA5+CXb9yBYtBljWHroIO7dwBtqEgi3LP1lkUCsA+pBeg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 22:09:14.7271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc51f936-ba3f-43a1-10c2-08d68891e75f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zynqmp-genpd driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/Kconfig        |   1 +
 drivers/firmware/xilinx/zynqmp.c       |  15 ++
 drivers/soc/xilinx/Kconfig             |   9 +
 drivers/soc/xilinx/Makefile            |   1 +
 drivers/soc/xilinx/zynqmp_pm_domains.c | 321 +++++++++++++++++++++++++++++++++
 5 files changed, 347 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index 8f44b9c..bd33bbf 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -6,6 +6,7 @@ menu "Zynq MPSoC Firmware Drivers"
 
 config ZYNQMP_FIRMWARE
 	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	select MFD_CORE
 	help
 	  Firmware interface driver is used by different
 	  drivers to communicate with the firmware for
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 6660b8c..dab1350 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -23,6 +24,12 @@
 #include <linux/firmware/xlnx-zynqmp.h>
 #include "zynqmp-debug.h"
 
+static const struct mfd_cell firmware_devs[] = {
+	{
+		.name = "zynqmp_power_controller",
+	},
+};
+
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
  * @ret_status:		PMUFW return code
@@ -665,11 +672,19 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 	zynqmp_pm_api_debugfs_init();
 
+	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
+			      ARRAY_SIZE(firmware_devs), NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
+		return ret;
+	}
+
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int zynqmp_firmware_remove(struct platform_device *pdev)
 {
+	mfd_remove_devices(&pdev->dev);
 	zynqmp_pm_api_debugfs_exit();
 
 	return 0;
diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 5025e0e..01e76b5 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -28,4 +28,13 @@ config ZYNQMP_POWER
 	  power management callbacks from firmware.
 	  If in doubt, say N.
 
+config ZYNQMP_PM_DOMAINS
+	bool "Enable Zynq MPSoC generic PM domains"
+	default y
+	depends on PM && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
+	select PM_GENERIC_DOMAINS
+	help
+	  Say yes to enable device power management through PM domains
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index 428b9db..f66bfea 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
 obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
+obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
new file mode 100644
index 0000000..354d256
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ZynqMP Generic PM domain support
+ *
+ *  Copyright (C) 2015-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define ZYNQMP_NUM_DOMAINS		(100)
+/* Flag stating if PM nodes mapped to the PM domain has been requested */
+#define ZYNQMP_PM_DOMAIN_REQUESTED	BIT(0)
+
+/**
+ * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
+ * @gpd:		Generic power domain
+ * @node_id:		PM node ID corresponding to device inside PM domain
+ * @flags:		ZynqMP PM domain flags
+ */
+struct zynqmp_pm_domain {
+	struct generic_pm_domain gpd;
+	u32 node_id;
+	u8 flags;
+};
+
+/**
+ * zynqmp_gpd_is_active_wakeup_path() - Check if device is in wakeup source
+ *					path
+ * @dev:	Device to check for wakeup source path
+ * @not_used:	Data member (not required)
+ *
+ * This function is checks device's child hierarchy and checks if any device is
+ * set as wakeup source.
+ *
+ * Return: 1 if device is in wakeup source path else 0
+ */
+static int zynqmp_gpd_is_active_wakeup_path(struct device *dev, void *not_used)
+{
+	int may_wakeup;
+
+	may_wakeup = device_may_wakeup(dev);
+	if (may_wakeup)
+		return may_wakeup;
+
+	return device_for_each_child(dev, NULL,
+			zynqmp_gpd_is_active_wakeup_path);
+}
+
+/**
+ * zynqmp_gpd_power_on() - Power on PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called before devices inside a PM domain are resumed, to
+ * power on PM domain.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_power_on(struct generic_pm_domain *domain)
+{
+	int ret;
+	struct zynqmp_pm_domain *pd;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+	ret = eemi_ops->set_requirement(pd->node_id,
+					ZYNQMP_PM_CAPABILITY_ACCESS,
+					ZYNQMP_PM_MAX_QOS,
+					ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+	if (ret) {
+		pr_err("%s() %s set requirement for node %d failed: %d\n",
+		       __func__, domain->name, pd->node_id, ret);
+		return ret;
+	}
+
+	pr_debug("%s() Powered on %s domain\n", __func__, domain->name);
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_power_off() - Power off PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called after devices inside a PM domain are suspended, to
+ * power off PM domain.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
+{
+	int ret;
+	struct pm_domain_data *pdd, *tmp;
+	struct zynqmp_pm_domain *pd;
+	u32 capabilities = 0;
+	bool may_wakeup;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	/* If domain is already released there is nothing to be done */
+	if (!(pd->flags & ZYNQMP_PM_DOMAIN_REQUESTED)) {
+		pr_debug("%s() %s domain is already released\n",
+			 __func__, domain->name);
+		return 0;
+	}
+
+	list_for_each_entry_safe(pdd, tmp, &domain->dev_list, list_node) {
+		/* If device is in wakeup path, set capability to WAKEUP */
+		may_wakeup = zynqmp_gpd_is_active_wakeup_path(pdd->dev, NULL);
+		if (may_wakeup) {
+			dev_dbg(pdd->dev, "device is in wakeup path in %s\n",
+				domain->name);
+			capabilities = ZYNQMP_PM_CAPABILITY_WAKEUP;
+			break;
+		}
+	}
+
+	ret = eemi_ops->set_requirement(pd->node_id, capabilities, 0,
+					ZYNQMP_PM_REQUEST_ACK_NO);
+	/**
+	 * If powering down of any node inside this domain fails,
+	 * report and return the error
+	 */
+	if (ret) {
+		pr_err("%s() %s set requirement for node %d failed: %d\n",
+		       __func__, domain->name, pd->node_id, ret);
+		return ret;
+	}
+
+	pr_debug("%s() Powered off %s domain\n", __func__, domain->name);
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_attach_dev() - Attach device to the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to attach
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
+				 struct device *dev)
+{
+	int ret;
+	struct zynqmp_pm_domain *pd;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->request_node)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	/* If this is not the first device to attach there is nothing to do */
+	if (domain->device_count)
+		return 0;
+
+	ret = eemi_ops->request_node(pd->node_id, 0, 0,
+				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+	/* If requesting a node fails print and return the error */
+	if (ret) {
+		pr_err("%s() %s request failed for node %d: %d\n",
+		       __func__, domain->name, pd->node_id, ret);
+		return ret;
+	}
+
+	pd->flags |= ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	pr_debug("%s() %s attached to %s domain\n", __func__,
+		 dev_name(dev), domain->name);
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_detach_dev() - Detach device from the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to detach
+ */
+static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
+				  struct device *dev)
+{
+	int ret;
+	struct zynqmp_pm_domain *pd;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->release_node)
+		return;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	/* If this is not the last device to detach there is nothing to do */
+	if (domain->device_count)
+		return;
+
+	ret = eemi_ops->release_node(pd->node_id);
+	/* If releasing a node fails print the error and return */
+	if (ret) {
+		pr_err("%s() %s release failed for node %d: %d\n",
+		       __func__, domain->name, pd->node_id, ret);
+		return;
+	}
+
+	pd->flags &= ~ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	pr_debug("%s() %s detached from %s domain\n", __func__,
+		 dev_name(dev), domain->name);
+}
+
+static struct generic_pm_domain *zynqmp_gpd_xlate
+				(struct of_phandle_args *genpdspec, void *data)
+{
+	struct genpd_onecell_data *genpd_data = data;
+	unsigned int i, idx = genpdspec->args[0];
+	struct zynqmp_pm_domain *pd;
+
+	pd = container_of(genpd_data->domains[0], struct zynqmp_pm_domain, gpd);
+
+	if (genpdspec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	/* Check for existing pm domains */
+	for (i = 0; i < ZYNQMP_NUM_DOMAINS; i++) {
+		if (pd[i].node_id == idx)
+			goto done;
+	}
+
+	/**
+	 * Add index in empty node_id of power domain list as no existing
+	 * power domain found for current index.
+	 */
+	for (i = 0; i < ZYNQMP_NUM_DOMAINS; i++) {
+		if (pd[i].node_id == 0) {
+			pd[i].node_id = idx;
+			break;
+		}
+	}
+
+done:
+	if (!genpd_data->domains[i] || i == ZYNQMP_NUM_DOMAINS)
+		return ERR_PTR(-ENOENT);
+
+	return genpd_data->domains[i];
+}
+
+static int zynqmp_gpd_probe(struct platform_device *pdev)
+{
+	int i;
+	struct genpd_onecell_data *zynqmp_pd_data;
+	struct generic_pm_domain **domains;
+	struct zynqmp_pm_domain *pd;
+	struct device *dev = &pdev->dev;
+
+	pd = devm_kcalloc(dev, ZYNQMP_NUM_DOMAINS, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	zynqmp_pd_data = devm_kzalloc(dev, sizeof(*zynqmp_pd_data), GFP_KERNEL);
+	if (!zynqmp_pd_data)
+		return -ENOMEM;
+
+	zynqmp_pd_data->xlate = zynqmp_gpd_xlate;
+
+	domains = devm_kcalloc(dev, ZYNQMP_NUM_DOMAINS, sizeof(*domains),
+			       GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	for (i = 0; i < ZYNQMP_NUM_DOMAINS; i++, pd++) {
+		pd->node_id = 0;
+		pd->gpd.name = kasprintf(GFP_KERNEL, "domain%d", i);
+		pd->gpd.power_off = zynqmp_gpd_power_off;
+		pd->gpd.power_on = zynqmp_gpd_power_on;
+		pd->gpd.attach_dev = zynqmp_gpd_attach_dev;
+		pd->gpd.detach_dev = zynqmp_gpd_detach_dev;
+
+		domains[i] = &pd->gpd;
+
+		/* Mark all PM domains as initially powered off */
+		pm_genpd_init(&pd->gpd, NULL, true);
+	}
+
+	zynqmp_pd_data->domains = domains;
+	zynqmp_pd_data->num_domains = ZYNQMP_NUM_DOMAINS;
+	of_genpd_add_provider_onecell(dev->parent->of_node, zynqmp_pd_data);
+
+	return 0;
+}
+
+static int zynqmp_gpd_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.parent->of_node);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_power_domain_driver = {
+	.driver	= {
+		.name = "zynqmp_power_controller",
+	},
+	.probe = zynqmp_gpd_probe,
+	.remove = zynqmp_gpd_remove,
+};
+module_platform_driver(zynqmp_power_domain_driver);
+
+MODULE_ALIAS("platform:zynqmp_power_controller");
-- 
2.7.4

