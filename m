Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5B8C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AA3214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vEtKIV9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AA3214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJIBfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:35:10 -0400
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:31366
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbeJIBfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vCzQhuRHarQbbE3PXhCcPtrd6OcslaCWvAzyxXFERs=;
 b=vEtKIV9Dh37kklH228I6wFA2/tZq8LJAu+dtApGF71/ZGUboqIYuDklMDIygW8GXtoeIm7+nAqQDRO0R3izzy7xyiFRqnpYq/NEw7F10r3jMA5JwHKzdD9Fn42jnlv2WPew6hkcdaVtI7wcJ5K9kONEn2DgmnVcJvZfGgIuj/YI=
Received: from SN4PR0201CA0015.namprd02.prod.outlook.com
 (2603:10b6:803:2b::25) by SN1PR0201MB1918.namprd02.prod.outlook.com
 (2a01:111:e400:5223::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.21; Mon, 8 Oct
 2018 18:22:06 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0015.outlook.office365.com
 (2603:10b6:803:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Mon, 8 Oct 2018 18:22:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Mon, 8 Oct 2018 18:22:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAL-0006B8-Sg; Mon, 08 Oct 2018 11:22:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAG-0004DT-NR; Mon, 08 Oct 2018 11:21:56 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w98ILtjT014470;
        Mon, 8 Oct 2018 11:21:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g9aAF-0004D8-A1; Mon, 08 Oct 2018 11:21:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v6 3/4] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date:   Mon, 8 Oct 2018 11:21:45 -0700
Message-ID: <1539022906-18073-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
References: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(2201001)(106002)(356003)(36756003)(2906002)(16586007)(316002)(72206003)(305945005)(7696005)(54906003)(76176011)(51416003)(110136005)(48376002)(47776003)(50466002)(336012)(63266004)(9786002)(476003)(426003)(44832011)(486006)(50226002)(8936002)(2616005)(126002)(106466001)(81156014)(81166006)(26005)(186003)(8676002)(14444005)(478600001)(6666003)(4326008)(11346002)(446003)(77096007)(5660300001)(107886003)(36386004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1918;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT049;1:ssdfUDQ/E4TJIvsY+ykWwOS+J/Ny66wAyJZj9hdlwKVbHm188c9I+bUEA8QjPnsj0EYyDi3Ut8Pgm4jkj9ONiSwUYKLx91KsfFpV6NuSLzghS6mFzL6kRTpqwpALYQZg
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf7053fe-15fb-4fa0-98ab-08d62d4af387
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN1PR0201MB1918;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1918;3:mTEofeNyTQ+hDTqc8Vrche0FgGUnfQ6tsQoIVCgIeinhz9S2RrunDDoRqdQyoNlJMOjrWpAGaHw0ByUsz0tSkDv8hIwIamNcj4rNM1QbFGe5K3krfqe4JP9F2ONIXB2x1y5vj6ZD2BrqNX0szIUXw3NnZRK+/WD56nGhytQvJ4f130rTiLAXI3Jp5QWWdemzdOJtJiFT6nZ1szRUffdxYH41ejUTWVLV/A/a/rtiLJK3BQVvMQJdTyPmoS533flTUFJcwhUiBqHOK2x0bghDg+wmSPEm8BGj5vyOxgNuLe0WkR2cdvAYnBfK1wJhylH1pfuoDVw6uQ/9ozhN5BmnV3F+Rltqw0HnnXZo1HxKZBI=;25:FP/9PC8ChwMnHhnCq4jTcHfJH9BzFiNoU+W5BEV1q9ZR1otOUo3r7cUwIV2k1zALqCKC22kxCAbX+4ihDe7/ibrzdGblPU9AjGk+uVjeZ9JuFE0mFnCEsAzvpT8ch/9rzcoBwLTxCG1+/6RVUOFV5P3uB6ozoWnBIq5vW6bOO2kn4Y3uEm/1LtJ44S+FXRv6gMpJeo0HSW+OTSUW2/P7uv0lxKqrDtQsKsBtrI16qjJsNUx4kQmVvIstuZut5laxeNR5nTeikFnkd8WROHF+hw7tvoh/dyQ1ce/L+KrPbRzV5qcdxKrMHanpBz2Z/ZPQ/m1YH7wkhDjYT3UBaxxzOw==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1918:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1918;31:NqWci6vQFUy956z6jUndbl9gsUdcRn7JCHlrRlmsmNVwuH1earvYoXBvAAg/Xjak//v5BgqnbHs5dQxeGU/zIzHAdn7lDZsh6yOXpo70i6pC3KoKOAbyVgD+DauBJ2KKf4C6GyyeNNZhsHuo1l6Lu5QC2EwSOukG8MKt6rNcjZlmJ/wzyFOC1wCLwL/ccSpmruZUihU7WGQYkBzXwR7dil4QTIHgCE510Uq7GUosnfo=;20:wL3ishwmaG38coZiYcdvU5BoMF9Ygovt6eCIj2WHmBOTlRXOsnj6pa3zJ2uQzwQcUEIh0zEX1ZhJSXQPLQb0a/nZKTehFF5zK4FyLZw9G68RaTzSlc0K71fj0MEkLF908eWYItmqjrUwOOR+QPw7GyMo395qT+B87fQsVGQLGAodINvPc75T7Xso4yZJbAsFhDwa2lF0noSh4vu8S2R814WMMObpUTv4lxHdYMpGKDW7p05Ed4lN/k1LxweoqFf21LOiFVLnCK9/Mw8kpPBJuB5/+Jv//AsdG2n8CNtE09JWzXLGkdYa0zuVFigqP63mx5IBOyx9zzk1YqK4XzxZeV+KAlCqh87OG6oGJS7ydePjc0exT0K31Jg5z+7F1lgzLOw1+eqNU6VdEDZREv23wXYCNMCPMeGO6KRUaPFiAlb8uXCZGgQmFicI8tZKOpGtpJGNfqmLdmc0ZFnak8+1gQkdd9srmJjqRDuh+kIkgfDSLwebkzCpZA0yNIub6Q1U
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB1918A76FAC07247CE19DFBA9B8E60@SN1PR0201MB1918.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:SN1PR0201MB1918;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1918;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1918;4:6oTieOKukECOkDa+C2r2bMaiLUIfNzXjE+XmBDIWefbilna2ilnRQDytImeTPHfFyuPs7KMuaLZPnF9fGPWKetAToIjt8lOAJYqkcjVmmAR9pi3VGY1Bni7/wC1jg2ymhTf8tkXIkvFiIPcVZpJPX2ORlB9oHQTy83xBbB2T0ajX1HAXWC1PT6cv9ukka9So29b1g8uizz5OEcmru4CPPDyX30BJLC+qeYcpRwMmgAgufGfltENmEhSjieYYadzcOF0AajCCqZNfz7akIKTr2HGWeTDpfgGA32WxSltijAXKYSsEOIWn8f+h3iclALrx
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0201MB1918;23:yELfLy2FwNtXD7sYjAqvUpSd4Q/gl3p++t/Jxwj?=
 =?us-ascii?Q?P7oWzgzAszbz1njAbFfGmu1z6oMJBcCK0wbhJ+IjZ8qyjsp8ObCja+ZbxJxc?=
 =?us-ascii?Q?6BZYXwnla/6glNV1dRK0+vb3v9eXvLNidTS12bpucl18eawKLPMqLmQleX3S?=
 =?us-ascii?Q?1v7d9r8ZCbOoul+DQLDNWR7VcrrdBggCEpPkgNosRrRxhlS059ORKSR37UCm?=
 =?us-ascii?Q?xXrrsxX2P6Qm5zKxzOVcySqmvxNgAjxuDGygeDV6zjs+YjsmJKgatPxQhWV9?=
 =?us-ascii?Q?+n8G8ENfRAJXocVfOj5HONYJQ8s3hIKo0spBiyijd9HCDQW1EqV7MNq7ptt5?=
 =?us-ascii?Q?+XDk2ztSe/Z2tAeiPPU8uNhhOIqmLIPowkI/kicVVoGTeDsbkJZoK7RQ4HBk?=
 =?us-ascii?Q?8P+q7wZ+cL43qelXny11YO/7NpvMzdXsEgeKoKu1RMVHudDU+aa/ZwHjBZZv?=
 =?us-ascii?Q?p4ZjVsNhCgqNbHsAWBIpwuIrRAcmsUHFTWpgbhm0ko+dLkZxQv/oJurX6N2t?=
 =?us-ascii?Q?2pXrz7MvYS4pQaossycshbOgIGEowpYGjbQY1mLJ+ZKuM7M3X5ibvZoM889H?=
 =?us-ascii?Q?5z+vJp2hBQSFEcgnolgM7YSh/ljv0MG+dIgv7QylCrh2D8h+gZWMRD03Vwm5?=
 =?us-ascii?Q?j49AtpRihUzKcphoWhlYroVxLIhsYVPWOxlU3WZnP3zUmpuMXCBSb2nu3hDb?=
 =?us-ascii?Q?VahltA1eNHC7zeDVoAg9x5xbEz9v4IE4N4ncxegD5JmOHUzcSWJ6qk7ZiNwA?=
 =?us-ascii?Q?TOFWole4/6YCQu5mLET1f0bmPgTOUWPxojnRWBFtC2F4oa49SnKEfOM+NFp0?=
 =?us-ascii?Q?LKu+FaHjK5+Lij84NolSxuuO7vaBIspsgZRYP1WInGwpOt3iOR7kiYElGww8?=
 =?us-ascii?Q?9np8fU+hbpP1309rHSy1Z0J9jaUsNfUVPcYXUEUbz9ckqbL7ma2be+vk3upW?=
 =?us-ascii?Q?AHN9193s5kFvzi7RcnwushByco2WKyg4wqKg5bMP2DpiZd5PHDU5lr6Odu02?=
 =?us-ascii?Q?rokBMtOA3Zi+fxcme7ffDehwWgthOseRfZu1pUMjbpFaT2tbR/I1iZPhFnBi?=
 =?us-ascii?Q?tQ5Op1vJNrNp6WqcsePMmotjoC8pQqRls9rqiRWk0NWIgjVQObhc9nV6pX9x?=
 =?us-ascii?Q?JhXqgLzX/A5wPD/PIrwNMni1cc2NARdtsXVlvdNNnswKKWd4S4MRFkhUK/to?=
 =?us-ascii?Q?NsiYHeliWhDISjwo=3D?=
X-Microsoft-Antispam-Message-Info: P+LLN7+JybUybhBgJvw9Ci7XBaq5wdnUAYeqCEuigTj1oRFCbvsOqVLbEjuXGUeK84Odp6pvI0o+Bmwi8vFQMiGC+UCl+tkgE4MNe8EOVGNATf4rnStBs3h2ooGUXPZsnbE6NDecdVHvLjCeU7jZK7Glnjwf41cuhpt5fdOTFcDR4pqOYgHW+z4ecX+MxKMyygCPC23OVmhY1Bph/R6jLH6zI8o6fBLmYGEediE/xwYpH3upI9OSgWY2n7zJ4t7s7ccW42e5nFzK8wmiV1LPCztVpAVXU3NRRw+5IoebW55HGqragpONqayspIMDAIrpQ+YO/QdvzrMXbWjtFrh/dLjG64MRfq76xk2lWRgWBkE=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1918;6:3mP00iFy+YSyC2S8s2n7khgYGHgn/7ipfgcrpsEQqApw4g19Y4Lg+frXapKccxLCqo55GocdPmkwIleCMGQsMAKrBYLUeOXCtwWGMjx7YdkBxiTY5uapAK/yYgAVAbyCHVGjeQBgBgasqnKqAxNYZLK1BNwAjLdTAIX3GjYMMCWfMcIdwriuztCSX0scNzHPUTraRi4CpNrhoYJneCx+zO2rctOELNj3A/JWjO7aNhSdBMQvn9axcYZPKIxywFaXasaO5r9T9yeg5PASPAJ/bC3j+zQXpNNjKIyIIDmfxRYlSbmXyWj99zMOdpZcTal30Ha4LhEskghfarpC41hwbHaApvKWjgKuCrgQk1cvjqy5AofDssNUfz6jmB3kp7CKfr3HTjFd0kYQzX2ip/zleBcOGipoeCD3UOIwO1AYcKFdK9DTvOkBlz8AT+c2ECqW93Hr/LHSZIDrfXzAC7Js9A==;5:E+GBwSZB7Yzprlh4F0KOUto9DljKDDOtr0floJDE9Ieq7TedG3bQRQIN6ffFEJyRr0gz3T9atoGugooPx+V0RL/MkrzctNX+43fRHtFQVK9cwjGWrvFXzNLIR2TvzTs/saGpCle4hU6how2A7z241jwbh2OFGNDiVHow6oWp2uY=;7:DKpE2Iuzq6GJdVEGWXB+glJjscdPMJoEhUXDckqaGXLIyTpH0DJDgAQwt4+gQdIgy/2yq/MB7z1OF38G+4WysUUwytlbTv3UFTpmbAfmqiBxoYHIZEDjem3cpHL0DRN17cmvx/I515iw0P2kObTnMOd9inwwZBR+psLBP1QJCsveWZDOMhExb7DTafOOjqu4yeXWJwO7YmMuXdyFful8wF3Q2/SnvP0xw5bEt8Swa4a11zrPA6ERSMDpU3WtTrGd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 18:22:02.8270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7053fe-15fb-4fa0-98ab-08d62d4af387
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..614bac5 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk: clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4

