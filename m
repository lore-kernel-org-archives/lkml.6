Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE9CECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B158E20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="f2RLSgYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B158E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIOA4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:56:18 -0400
Received: from mail-by2nam03on0045.outbound.protection.outlook.com ([104.47.42.45]:2496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbeIOA4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YegmdnTSv4ch7+Xdjr1vv941EScAafPDsrXlryMNAII=;
 b=f2RLSgYvIIrhEDkllnhItss9s8gpFWKAnJb9n0qblx3Bc/EoPBWg81I6b8oteEvOkUrsmlo4gPQUsz/lIJMhUWN5tfFCZpUTBxvBkW1vDaC+wiRGZ9pflI/F/EwegCpGkkR6KwJxIoy1msWurkEMAo9U4tDQ9eN71jla+Uzg1Jg=
Received: from MWHPR0201CA0063.namprd02.prod.outlook.com
 (2603:10b6:301:73::40) by SN6PR02MB4768.namprd02.prod.outlook.com
 (2603:10b6:805:90::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.19; Fri, 14 Sep
 2018 19:40:20 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0063.outlook.office365.com
 (2603:10b6:301:73::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Fri, 14 Sep 2018 19:40:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 19:40:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46553 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0twx-0001YF-06; Fri, 14 Sep 2018 12:40:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0twr-0006TC-Se; Fri, 14 Sep 2018 12:40:13 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8EJe4kY022782;
        Fri, 14 Sep 2018 12:40:04 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0twg-0006EA-57; Fri, 14 Sep 2018 12:40:02 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Fri, 14 Sep 2018 12:39:48 -0700
Message-ID: <1536953990-12755-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
References: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(51416003)(336012)(7696005)(76176011)(77096007)(6666003)(5660300001)(106002)(106466001)(8676002)(26005)(50466002)(48376002)(305945005)(186003)(63266004)(54906003)(110136005)(126002)(7416002)(16586007)(47776003)(2201001)(44832011)(316002)(81156014)(81166006)(50226002)(36756003)(9786002)(478600001)(8936002)(36386004)(72206003)(446003)(11346002)(2906002)(4326008)(2616005)(426003)(356003)(107886003)(39060400002)(486006)(476003)(14444005)(107986001)(921003)(83996005)(1121003)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4768;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT007;1:t1sn995Ev+BW/aNJXEUzefn647e/rJF+JGgygDBD3ZaW9bQN/WbdS23oG1bcDOCIZk3PUVnH+wei1XKX5MyBhaV9ZpxrQD/rUyltwLmtc66VTyneMpttSCyhkxaIxpbh
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e8773b-7730-4f16-69fe-08d61a79e793
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4768;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;3:DtoTMQnuwtFw9MIV6GHHnUt772l6wLfSnY0jpDb0/XVEqfo17ZhofBxn/OL8YAXRB1JyNt24gP0B1PAs0Fae1ir5qFFPUTNJJMpyj5lnfWR/7AQbJFM1RhdQxMSiGuGZm/KNzcbQOmO/HB3vDDlYHvn8b7sAsrSoWRMWxEb4SbIskXlDvgxT322ZS+FYBC6s3wfUXGb4Vvp4csyevdHBgZkPlzKOmR6R21XlG0zT07/XpRor7NoQxdr1V01Qoha0vVI2JAqTLJNrtAIWqXFIWKFUCuV/U2a44IJVKF8B04L1QcUHSn7eezQ6UiZ8AOfRpePCiAnYGWASS/05bJSx8FYmKgU5h/urSNSjhrRjXDM=;25:if6KXeOwDCePZBCEfi8pNyToLod/dvt72CVFqAaAVAyGdwbOete2FIENSDFC3C66ogsCkkeskwBdyRA8YUh0c7NLP+bCMFlCCVX8DgucMFNA5ARqY+CgzG0rcX2uIw8vnSRf4zZMU4Kh/eosuP8K2ej0CF9jTZrnt/deu3bSm9gBEkxgZMHyCnS0BMNjtiAMw+esikPLDkJKEEpHZK/LIeUBlt87+zD8esO9DP+RwQD6bOCIiK4wpyizCKbL1PzfkfR8sYSJytvD3JpPF+oJ3C9Y2+19q7a5/Fj07qE79u4KJuSugPkKjRb+0ONK3XnY9Gh4h2hdAJQWbjt9wzq7Mw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4768:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;31:LwFfiMipeTahpV23Yi4iYJ6Iyu+8DoCg7wou63yAoMFfj9oH1tAUSLHkce22RIZ3NQvwWbWVMbotkIH+96GQMH+Pcsfqh3yq74cVs9wZcY+mQMLURw2MIzjmjoYQuc5DBNN8YeA0Y8woJ1izYwkjTFjLgBEEvEX0rfxcFlF94pH2fqFAQJw+lo2YUIPqkzH3kXxm7u3r39RZqNG5RhoUU1s2tca4QtIyPzKis/ANgFQ=;20:2I5EZla9LhfwdQdz9fYHR0Mss/UP5hrK8qEMNIEkAu7FSCZEgFZFqJ6N6icKLg7kjBAQv2001vQ0fJVp5/h/9vCgLe2XMl/z16Wc+U1k4SacfgWcHpgq6Td87sx5y3AR8f8nng4Yd+Blx/e38GkXotVf7jozpUzD0sXGvWJaZaofoRP+4vxzKoc0IglvXD9oJll6D6lxcYSTfN3CefqX00wqpIow2oHiUZYxNzL+0OW6cy3MuGi+THJ8RhKN5FOtQv+U52oYBpXL6ripk7HjcVFaPvgyTvhdqwTiwUjZVb5XuDWuXTc7Oop9fh+yqryu1dC9Vq4WgZuxDYbCTThD9UkFOpLGaRhdEursE600s47MnJw1/8P2BV77XYcygYBRVqEC11PWojWRKtBvAB+RXGVqlBSxXFSjjNxopxDEIuwiwMBDaSZCYBu40eIH/gPGqBtRHpZGPd5JwxZI+TE7592Jqajt9obNpx5r+FQil7XtA4sFk8tawvOzbf4IsujK
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB476853C72FA1885E285CCF6FB8190@SN6PR02MB4768.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:SN6PR02MB4768;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4768;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;4:eYfDrxXpMFjyyVNH98vHfbi9sCnDbd0FWGu4ahHn6ceslq+jsHIO56bRNOxuA74F4/AA+TDB4Kcf1VmQXCVdnTPTWYNNQKPNkaHDsxuUxG2ZDPloO67KUu9yssfic9Q4ymxD0+3FNb5q3f3N0plbMG908iaYirOYD337MPsWolbYQ/cnAmAfR6VS7Cfd9F3ZYblCINwDDjHSd2EAAGo4osFxfTUr8noMaw6NtuDosKD4R9QVZk7FubmQtCcFG0TXkeVjdQNV8xXVVTV/QIR/a9MsCMGYf1RYXJcXpxqsuBR5OoxgPRrC+8tt2mN6XJeP
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4768;23:nwLpNnntjmgpipqblO5bIfBbVqfwfu81eCmIMhwlC?=
 =?us-ascii?Q?8YA/4Im+UsUV576lI0ZRN9llMAl8pUE9tmjYbPwg0gDVDGzjRE/gvdTDaonm?=
 =?us-ascii?Q?AB5DguahWtm1F0DWwP5O6kKR4h5pXg/izDNcXNYbIBzlTh0hX6Wm4Z0+MQRx?=
 =?us-ascii?Q?dGcAxeMt0UyDc8H+Ks+4EBJ/ZHkGjutj7ZmKvidzVJMG9bpqrfLPbA4PFe9M?=
 =?us-ascii?Q?687zJSsWSGX1I9iXtDLSR7xrtgYt0LWfxKl/Kr1+kvW5I+GEtzmwXRVYNOWV?=
 =?us-ascii?Q?HGv04X6/cwsvx6jpnk4nepjCvCHWf+5Y/C8cxd1IpRiy/G5q5BXxankwNq7d?=
 =?us-ascii?Q?MTvhLercXz66Xp6DYwTWLG5tbDGKvZVm7qga1QaJcAgPXXpvXfHEym9gui4h?=
 =?us-ascii?Q?yRQelhGzKaqnLuO4oIpQin4mANRmsv3ruza9DPLjSZVvOQoMMBhJMQbJoTh0?=
 =?us-ascii?Q?Y3NPB6PgxAuN1kZJEJneLd+fT9XuS3CgLiocSAjY7IHlwuz1ioLaI6ZqEfOU?=
 =?us-ascii?Q?ezOf+Sl4/5uNqLAT7eO0LYRFGBKaftLY/vJoIdyPpMRwCi4QxybmFAFT1IZD?=
 =?us-ascii?Q?4cJaw7erBAkP4+rslF5yPPBEDU2EDckL21zboP6b7oplgnKS58DNKcutJedi?=
 =?us-ascii?Q?txF+v+V4EFfCz73c+OnUUC15+zCRDvZzX1pqLg38EleY5quJ7bs2kVNAY9AS?=
 =?us-ascii?Q?Q39miNqcV/0asu33MC6WDL8RyXB4MtoWmUfbvA9vSh0PYXgw57D9O5TTmcfO?=
 =?us-ascii?Q?sfM/KwYstSj49PY74CX9ZBNTpvR62T//Vg50w7QBDlWL4aDYmJMsegsILa+d?=
 =?us-ascii?Q?v4HmB/rd4kEZxfZ2XSAQTlzuPS4oog14ooavX95+bCnCdUwYj4rWj6JtTFLh?=
 =?us-ascii?Q?hBasXV2xhNfz3TT781GoC8cyB+fq871GSRJ6n31eZ6+BiPAGJvQYKFO5lzsf?=
 =?us-ascii?Q?T4tXWjgX2a+0CP+8jx24ztvHQm4/+m4yt43SBfRPZqB3bn/LqS6E85UNGT8r?=
 =?us-ascii?Q?k9QVRUZ/v1tdmAbbkA/sODhdA5yxAZlm9/ENPgS5VjrPvAo/ZiRL/x3O0ffn?=
 =?us-ascii?Q?Vlv6bg3cghnAHYXugRxNp8cikUSgW/BA7vThyGIFtrrXqrntSxoLmIQJnOls?=
 =?us-ascii?Q?DpDUhtSuBNjctlla3gyxN1U999tLzU8JfL4DRZVnQegeKK6ecAtZhtGyPvmu?=
 =?us-ascii?Q?+uripznIEdSG2MUruhqu75dlRsyi+VxGL8RM+vTcuA8/WZtDtv9zfcd68nj2?=
 =?us-ascii?Q?94QIHWTftHtOlDO51qMgOADI7l/EAl4dIEbQj9x+0qC+Dphthj7/P6EQWzph?=
 =?us-ascii?Q?2DlvNZn+h0Lcw+PLiWFRQZPY59p3Mv5x6O6c7Hc3J3J?=
X-Microsoft-Antispam-Message-Info: LPWg69Wkv6oEaJp33Vkl6otMAKgjNTJ76HfS/m56L80gBhrluxNhOMVXni4EcHS43kS3CKlQVbx73IOT0li2OHn2crhCISOIqhG4Cjm+XbpMEUGeA2OGVDUrAIHaSBbV8Pp2ydO2gkyWgPDo4v1EWeb443x+OnGjj9sagapSmTttpzZHN44BhT6cOpy/NFJxShUDg3/KWre8HRD6aWH4jhh1QXKUyw+7tE9DpHK9SuxvQpQwABlq72nso2f4a/42wd5HPJUAzlNBD+Y4oUrK+QBkBWZZXtzLlX7xh/DO0NQFoTrA5jpwbZLg04PvwE4yrcQQX6aG5sP54m7pMxRVu57yQq/jOedM+WHWP8q0AmE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4768;6:S3Yowdf5EZccHPiwztCaXWgw/v3+LQYHeL4rKB9Bnt8NyXq0BNgjf3EGf1yf1EOIzkbHljq6/3VVJa9JTZO9vr0HQKvcovEP1CpwED9qXuQlTK+OlyzQNvZYYjfJrhoUlCZ1M5/9FbqxZMqfZ8a975Ilqtkp38rRiMXzSarVhz1GSykl6eyF6CbwOhWiBAv2foli7W+0iTpizFTwC16KW/kEY5ZOOe0W9Dd3htC9R6mvo8Mv7ZNLIx9EcUzVsqDRSWUwWpZO8IRLtKni7R9hb/JG/CdQrV4qbF9ZzosGPNW4OIOFeT2FD7anBIktx/oSm4/cTt6lCFOULdXItbeduyebqvpV1BBme6O4dg/1FXpCHnUE9mcHAHc5NguscqQt824MXwR+2ZoNYVTPQ/zTiZCnB0MALThNXYLvhAQtJlKduORvxhbomvj751XUaB6ZuOBslh8yawmbBtzoLGEd2Q==;5:by0z5cDtx+y8mYy5qIcNUEgzKjfqt2d+qVz77CFc2lvEPwfRk6FReWDsX4Zp8MB/2/PTNEnKKxy8jXbi11AsxUJlhIgHecQAePnPVPFKDygzdsMBdS47qFyv/73vneGiKzp151vsYJOCodAH9f83E5LC+ynbO5SjqeONWjsE6RI=;7:DAeyXMHlpgWrGESqaDNOHUxnaJXorRtfqDQu7l+1pT/h3mUhFu0xlo1sVB2HJ1HN7j429HVc+4uKKnyOilYIyjvd9D0jwRluenxcjL1Nr7fP91G+6WdAhahHrVXq7mcKLEUOVWQ6bU6uKIrdlW35YYI0/zGw7S4lBss7YOGGd4gD0A5BbPaV31ukhn2V4UfOBLdJQQhZYLAkE42U2nVFcZ3AtZ3t1yOSkI+b+0xb/uLB5nOmhqHM3DWoHmJHEWvV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 19:40:19.6347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e8773b-7730-4f16-69fe-08d61a79e793
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/power/reset/xlnx,zynqmp-power.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 0000000..925d17d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -0,0 +1,22 @@
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupts:		Interrupt specifier
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
-- 
2.7.4

