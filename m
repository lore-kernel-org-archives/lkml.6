Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC4920850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3E90Nurr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfAHNVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:21:42 -0500
Received: from mail-eopbgr690087.outbound.protection.outlook.com ([40.107.69.87]:23027
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbfAHNVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UyHTGPFcuZ9g7YAcOj5lzBpvod2Zaavs5sZwFVGVcg=;
 b=3E90NurrXvOOd9HI4SzRrmveSon2cTVMRj+Cjs9Fe07cgHI+fq2uYwQdRA3e+8gnA+ssdFY23z0OKi0ubIAQGz9qdLqqmsTISClhPYPki0b+OA0ZfCe6D471tIriqu0uHopPKNnKMq3cfvJ0/dG++2fmsiBSkf8Z81cWgXIi70k=
Received: from BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16)
 by DM6SPR01MB0037.namprd02.prod.outlook.com (2603:10b6:5:61::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Tue, 8 Jan
 2019 13:21:35 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BL0PR02CA0003.outlook.office365.com
 (2603:10b6:207:3c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.9 via Frontend
 Transport; Tue, 8 Jan 2019 13:21:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Tue, 8 Jan 2019 13:21:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ggrJx-0004eF-U3; Tue, 08 Jan 2019 05:21:29 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ggrJs-0004s1-RC; Tue, 08 Jan 2019 05:21:24 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x08DLNlx030358;
        Tue, 8 Jan 2019 05:21:23 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ggrJq-0004r0-La; Tue, 08 Jan 2019 05:21:23 -0800
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as
 IRQ controller
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Nava kishore Manne <navam@xilinx.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Borsodi Petr <Petr.Borsodi@i.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
 <20190107164210.3ecf37e8@windsurf>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <91dd25ac-52b8-bed9-4c5b-d4fb02cccf18@xilinx.com>
Date:   Tue, 8 Jan 2019 14:21:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107164210.3ecf37e8@windsurf>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(199004)(189003)(107886003)(2906002)(14444005)(6246003)(6306002)(64126003)(2616005)(4326008)(31686004)(31696002)(39060400002)(11346002)(446003)(65826007)(426003)(478600001)(93886005)(230700001)(336012)(8936002)(5660300001)(7416002)(63266004)(476003)(126002)(229853002)(77096007)(110136005)(106002)(9786002)(58126008)(305945005)(36756003)(81156014)(81166006)(8676002)(316002)(966005)(106466001)(486006)(186003)(26005)(65956001)(65806001)(6666004)(54906003)(36386004)(47776003)(44832011)(50466002)(2486003)(23676004)(356004)(76176011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6SPR01MB0037;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT020;1:nuUWrHdJwkdnN0awJjQBhMOH2WLc5hMBzowGQeNat673n0Sxl9KuVSJbzunsyhlWD6IgZenKYK3V2nH/NFWxPudThWMdg8BM0DoKGFFDdL3Rru+sQypvJRviCw5ph2FO
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5027950b-a8d9-49c9-65ee-08d6756c3621
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6SPR01MB0037;
X-Microsoft-Exchange-Diagnostics: 1;DM6SPR01MB0037;3:t1nlQhh8usUTQkNJNfPcezcgIeAYq2dp/FC+z4vEjkhQYvqd1m1vuN1LCynide49Aq4uTEi9HpFWkJ8LGvQNpETI91kEm6VdHdU8BanboedHFW2xhcYit8R1cro3NkhRIa3i6gL2KZGOv0fDkXa8XYq8Z3FJwyafNpZ6gSBMn7DAf0XtrBIADb8wQayMuTQ+kXPy6FyO6YuX5/4MIm2bGFUGBwi6LNCKsE22S7NeRoASgDoaX8eHKU3fYmfnw7f+9XrzsvRufZtkSnuTPTS+Ue4dYotYK0N+eAbC+9H3CZj1evWPjDi1McN6TR5zL0uShnP6/krmH6vcyABGyILW7clq4yXtw+WVaU/UZB0nIBz/8BjUs1Hsjq4HrFSBA/sv;25:lLIrcZJat05G00bYfQw2R3ejyzPHrI3W7qyL5rRp0xyp6O+OHSIdeS/GKIUWamUwmz10Jg8SZEsR2xcYVpCaCNuC0H2e9zvH3q+Is+l7a+JmdfHF4fZwdeMIuOom2EY6ahHERkL6jR/mUwY07XEkTN0ii7SMod5TVRBWFwhIEro+l3RZ8sm2FAyb6PhyNxPIRPzN+bHPLpZFooF7QOdJ9Op867L+nyVmv2B1z7MdCC2RjKmeef2zUVuhymOhNRgCLvsWG8stYerFBro39iw+kCML6LFz3OGuINb1crXuA5huXyaOi81F08PlY999xeIqbY2DpblwVkJPxeam3ndJoA==
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0037:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6SPR01MB0037;31:8zLxMn9UfcDLnskStblc4DxsGKmcXVOvcWeK//1zNt9F4eM5JgXumqK0pD40OrlenT76k3DwSWk3zxLj4upi+PWpFCKB6W73VWvQ1V2B/1OEl+wF6ZYMzlOoUQoOhJL+e9ze5jfcwOCN6E0lDzNt+EuJk1BNrIRWU+Zv4eb33qzR9ZJF2aw6yXQercfvxCX3wq+vpCjaKiiBgcVOvPyOX/5nxfjHwIHp/4XjOMYx0UQ=;20:5TnbpZVnSIMbokcoM5cbYldWR8w8C5Ev/8k44QR/0540/SIfxkBt3lO2CT5TSewfFCSFiOYsEdLm3tEmX4YxP81N1AqiVlgDIi4L07X/0A2jxEYdrTQ0ivejavXoZApqpd/PlafcPThSFhIDuJMaEmhg3cd/JVhw0yip4h/D28zcfzDNV1Cd9RgdF+8auXejtkcyqd2pNUULYy2V5I4gDW/hD1Z4Blr3o4DEcySLdgfJu0ikj7ZU20jcHJwx2wrvDZ3V0KlE42b7aRUPzyWoghGtEZghDkCAoe4aeNXwF2A8lpEfItXArCUPqhBUENyx4ig6cyYmlc6iwzwVJD7T8rLxkEDBoAPr0BWKpxH8JkRiJRAxBETirDORvSc5ZkcSJmQ2IQEBX3Tq/v5Z+t6V2f376KCnLQ2vx6Ms6jk5GEuboUIpn+W8XYRzU/Ue5bVHuwgLnS0saCHZ6Jl9UX0LdFXY/mW4iqPh+/ThBMwMhLej6tBrznu00cdK/Lvcjevc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6SPR01MB003754FDA34D0FE1D3D5CF77C68A0@DM6SPR01MB0037.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6SPR01MB0037;4:CYW4G+p6zZTysdW/plc3MLRqIq/evbAOOiadXMbsFBvI7+m56oXNcbMuhye5JKqps5YcyW45qGpaqgeQcsvRYnPsqjVn8aIAaU5wA5LpasOZDwQuMdiHuNxU1jo7n3pVX1tvU0zU5op68QNqct4D++51yLrDsV990VYeWCnQDdOzOnW5ZRccu78kcZdRyymJIQCoNf/uuHwOeqrPkdSXfqOeHM0634pUr9WBPhbRZZ8WxqUQ1FW1FpmjOJJ6s1BFme4uEvgNO1z0QgVABWTWoDGyoq4ViBXiYFpi4/Zf+0X3ALHhyBBXd3s6rAm95qEH
X-Forefront-PRVS: 0911D5CE78
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZTUFIwMU1CMDAzNzsyMzo5d0pCWE4vb09vQkY1ZVA4VjdXTng3dlBK?=
 =?utf-8?B?RDFMZTg0Z1ozQU0rTW1QSzJVdW9leTF3SHozV1NXbU1sb1ROMmF0b2pNYUs1?=
 =?utf-8?B?dnFUYmxhN0hQTitmaG9iK2RqWVdiaDhZL21rOEN3b1B2UFVsY1I3Qm51eEh1?=
 =?utf-8?B?TWMwcmd5WEZoVGVBREIwcUY3a0RqUFo3UUZJUjlBR21DYmVQd2ZWVTl4L0FI?=
 =?utf-8?B?MTExM0o1dHliTjlRMm8yR2ZuU1NUS2lnV21MLzRpOXQ0OTZuU0hjR2twL1l4?=
 =?utf-8?B?RlFycjVoMjRlczEremlTMkZ3NWc4MnVSR0xKdzhvZVVsYzdSbEh1TU1LdXBq?=
 =?utf-8?B?dEhyQndacFNtdmNyb3VPVnJ3eDkvNnJEcGJFMDFIY2FGQVplNEltT0xVVXJC?=
 =?utf-8?B?T0M0QitHSUR6bnZzWGdvUXcvQklTNjV2Yk1GTGtBNUx3bk1uK3Y4WFluNEVS?=
 =?utf-8?B?anp1dUd2Q1BJNEJxUlNYNnE3UHFxZ1R1YUZYRmROZ2tpQ3laclc2NGJucDcz?=
 =?utf-8?B?eVFhTDZsN0NXUWZUSlNlRksvSVBKL3VBcnJjeTlmcDhkSDZyZFMvSDFuZFpW?=
 =?utf-8?B?czdJTW15SlAzRmpBU1dmM1lsZ2lLcjcvSVlqRVFSVEk0eUVvc2IzOWs0dC9O?=
 =?utf-8?B?Yks3TUcwWXJHY3g3dkY0bmZpbThaS1dzSklJVVhZZzN6Tmt1WS8rMmZnejZz?=
 =?utf-8?B?TUNnQktlOWdYOGREQmcyNlZKUWdHYUdrdmJBVUhHbkVHZzZWUklPNHBNWmF4?=
 =?utf-8?B?dzAyeU1zQ2FJaGg2dGNoTkFSYlBqSjhTbWNpWHYyRkJ3VzVJRDJPTnlDL2Mw?=
 =?utf-8?B?aGh0d3pxbjN1b2F1TkltQkQwL2l3OHN4Z2pndVV6T3crOGNIb3BoM21iaUs4?=
 =?utf-8?B?Y2ZGWU9mclhJVXN1UTFhcHZNRHdFM1NLWmpVY1RMem9yYjc2UWNwbmJjRzgz?=
 =?utf-8?B?K0pDRHpuTzFxekZOMHJFR2t6K3BCbk5vSjhiNW5oV3ljS1M2RGorRm9lcjBJ?=
 =?utf-8?B?RHV4a0MrQWNiK1ovUzE2OTlGUDB3Vk5sMERaQWZCdm5KSmJkeDMxWUxyRFBs?=
 =?utf-8?B?eGNiMUFBZFdCWnEzblo4QWh0VjQ3VmdOVjZLa0JUQndiNGlsQjBpcDQ5eisz?=
 =?utf-8?B?S2x5MjZTV0t4YUlscjU0TXdzUDBzdEhMMDluZnpoKzNOSllvdDEwb0RjUUgx?=
 =?utf-8?B?eGpYdG1pVkZReWdxdmFvdkVrdkFBbWRoOWhqQkliTitXb2ZGWm02MlVVbUpV?=
 =?utf-8?B?Wmc0Z0htQXVQSitMTHAyNHF3RDBybzhoc29UNDhUdWI2RjNkM1hSTXZEQnM3?=
 =?utf-8?B?YlJLRGg2cldoUk80c2RDc1NscGQyYVlpUEtzSmNqc0pTcTFlZnpvZzQ2aGNM?=
 =?utf-8?B?ZFR1akJDNHpTbnY4VEU3VWhyckpTWFN6TExTcW5TL3U3a2ZlbWFGZ1JTOFBq?=
 =?utf-8?B?SEd0ZTcvall2Vlk4dENNSWxkdmFYWTJlNDRabWtyNVVueDgxRGVYTzVPSzFK?=
 =?utf-8?B?YzAvaHNERWdQVHFmS2N0YjdsamgrVlpQTUFmajE2MElSeVVselFNejJKWDZu?=
 =?utf-8?B?VnVSZHk1c0VZS0xURjFpd1E3ZFh3OHltN1ZWU1p1bHlCOUllMFJkaGtrY1Z6?=
 =?utf-8?B?WXY2RHdVYjluZm95bEV5aXJqQ2NITldXbFRvbFU2enB5MDVDVXo2Y0hLK3J4?=
 =?utf-8?B?V0dpTUFxQ0l0UFl6UTI4N3gvSko0REVvV0ZuR1FoRXRiZElRVm1vOGJGNXRF?=
 =?utf-8?B?R1crMXFQRHlQTzFzbDQ5SmxEUlNEV0ZEQk9tMlZucllsd0UrZ3J5RVRITCtk?=
 =?utf-8?B?SmxTM1RIQ1lSL1NUYk4xZThjTng5ZEs5N3BhTVhlbmY5MEhiay9WQzRtL0Jj?=
 =?utf-8?Q?copQPIDN4rQo=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: EM0igRHvSXs1DcEIv27/MpZEkPk9G8HsChE6yt38hHQXzyW/DoGhB5Nig0ICf5yP1n9AyiFodxHQOIchNzIAH0kciMcVE6gNEwS8L/bR9mmmaSlL3v7JGhxa3h4s1XdzPAnO0i6KdNv6DjU6CQ2u/kEvnwAfaKrVhfWEcltOnp+778ZERlXN3P4fUvUmCIMmkkesDh10WdKGB0jvDGyV/UUue8t9KAgkCVf/9+6QHmVC7+6Hed5qB2Q4+YBE9HtLaeNyUXh35ntLH1TM3yDGtQH8sw/Dw0ZbZMx3OXmkXKZJRjupcN4IpXYKj9gWDP90
X-Microsoft-Exchange-Diagnostics: 1;DM6SPR01MB0037;6:LNnYtKrw40GET1J+Ok4N2Pn5FTDrBxS3UBIgBpklaMiLc658HkIo22pv6MU9Gi1f9OXHpeMPoFlH6oJApsvTQ3IgLt7/SYKGNgaLjCiJM6oNLvpJYWPrJyqIwo3lTJfAyOG87ll6Tzk1yDUJ1ttyNKAfkFrmvuGRsJ85y6yKubiaTi43GyfhRh3kpHdA/BOxOtjA/7dPHohrS/ys10Pmz6pojSiTE60W14VNZ7ChQIOlSLvzpuFwrOcE0l9A6LM/35xiszj1nuIHrBf2gKM9Ua1ujvqxlvkVLWjncLBQTGBupUxK/iSK3csPFDL+l8y6DAUAitvQNw6mo8sNbeOSmFjeYq44fpzgAZEF2dB7stpw0/eKH6IVVmHv/hNxXZVZGKckOzhqEt/Zcw+gquS1C8WjmOEpXTd0kyZ/Y49Qg1l2neGgPhs7ShIvJQm0VZBdozZ+0t0d302pDvnUXfx3Ug==;5:s5+tyZ0ngNy3oZwUn0aH20OOu8xkuHz1OcxEh+A0gCyKrcUnD5n7GAOBmpneF6VrMj/FtRcDkz0371CQmFprdve+fqDnYQ1jaPw144TwV8qItM7yzGRLsuBx2igAI3S6z2+mCT2OJbVS60Gc9tdcl4zT0V47AA8Tzi/wzjseYRA+zBsT48scXNfM+4WruW6roMZBRkESV/0YBsw+Wqcs1A==;7:OZBDz4bVWpo3uAOIkmPuf2Wplg8mhENs+LqrzdLNOcTl2bccDwDQujQHWUo4WAOLm6nmzorvXSd+DbxIGncyJ/mFYgQkQZaXrInSLZywWUpa9Yj7Jj8ki7e9wFNriPE/iU2cYdKtRKUuuQc9b5WnQQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2019 13:21:30.6610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5027950b-a8d9-49c9-65ee-08d6756c3621
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB0037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 01. 19 16:42, Thomas Petazzoni wrote:
> Hello,
> 
> I am reviving this old thread, because the proposed patch (almost)
> solves the problem I recently reported with the bad interaction of
> runtime PM with the Zynq GPIO driver (see
> https://www.spinics.net/lists/linux-gpio/msg35437.html).
> 
> On Mon, 14 Aug 2017 16:33:09 +0200, Michal Simek wrote:
> 
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 9568708a550b..a08a044fa4aa 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -1647,14 +1647,22 @@ static void gpiochip_irq_unmap(struct irq_domain
>> *d, unsigned int irq)
>>  static int gpiochip_irq_reqres(struct irq_data *d)
>>  {
>>         struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
>> +       int ret;
>>
>>         if (!try_module_get(chip->gpiodev->owner))
>>                 return -ENODEV;
>>
>> +       ret = pm_runtime_get_sync(chip->parent);
>> +       if (ret < 0) {
>> +               module_put(chip->gpiodev->owner);
>> +               return ret;
>> +       }
>> +
>>         if (gpiochip_lock_as_irq(chip, d->hwirq)) {
>>                 chip_err(chip,
>>                         "unable to lock HW IRQ %lu for IRQ\n",
>>                         d->hwirq);
>> +               pm_runtime_put(chip->parent);
>>                 module_put(chip->gpiodev->owner);
>>                 return -EINVAL;
>>         }
>> @@ -1666,6 +1674,7 @@ static void gpiochip_irq_relres(struct irq_data *d)
>>         struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
>>
>>         gpiochip_unlock_as_irq(chip, d->hwirq);
>> +       pm_runtime_put(chip->parent);
>>         module_put(chip->gpiodev->owner);
>>  }
> 
> This patch almost solves the problem. It doesn't work as-is, because it
> assumes that runtime PM is used by all GPIO controllers, which is not
> the case. When runtime PM is not enabled, pm_runtime_get_sync() fails
> with -EACCES, and the whole gpiochip_irq_reqres() function aborts.
> 
> The following patch works fine in my case (a MMC card detect signal is
> connected to a pin of a PCA GPIO expander over I2C, whose INT# pin is
> itself connected to a GPIO pin of the Zynq SoC).
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 20887c62fbb3..bd9a81fc8d56 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -27,6 +27,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/poll.h>
>  #include <linux/timekeeping.h>
> +#include <linux/pm_runtime.h>
>  #include <uapi/linux/gpio.h>
>  
>  #include "gpiolib.h"
> @@ -3540,12 +3541,23 @@ int gpiochip_reqres_irq(struct gpio_chip *chip, unsigned int offset)
>         if (!try_module_get(chip->gpiodev->owner))
>                 return -ENODEV;
>  
> +       if (pm_runtime_enabled(chip->parent)) {
> +               ret = pm_runtime_get_sync(chip->parent);
> +               if (ret < 0) {
> +                       module_put(chip->gpiodev->owner);
> +                       return ret;
> +               }
> +       }
> +
>         ret = gpiochip_lock_as_irq(chip, offset);
>         if (ret) {
>                 chip_err(chip, "unable to lock HW IRQ %u for IRQ\n", offset);
> +               if (pm_runtime_enabled(chip->parent))
> +                       pm_runtime_put(chip->parent);
>                 module_put(chip->gpiodev->owner);
>                 return ret;
>         }
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_reqres_irq);
> @@ -3553,6 +3565,8 @@ EXPORT_SYMBOL_GPL(gpiochip_reqres_irq);
>  void gpiochip_relres_irq(struct gpio_chip *chip, unsigned int offset)
>  {
>         gpiochip_unlock_as_irq(chip, offset);
> +       if (pm_runtime_enabled(chip->parent))
> +               pm_runtime_put(chip->parent);
>         module_put(chip->gpiodev->owner);
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_relres_irq);
> 
> However, I must say that from a design perspective, I am not a big fan
> of this solution. Indeed for the normal GPIO ->request() and ->free()
> hooks, it is currently the GPIO driver itself that is responsible for
> runtime PM get/put, so it would be weird to have the runtime PM get/put
> for the IRQ request/free be done by the GPIO core.
> 
> I believe that either the GPIO core should be in charge of the entire
> runtime PM interaction, or it should entirely be the responsibility of
> each GPIO controller driver. Having a mixed solution seems very
> confusing.
> 
> Let me know which direction should be taken so that I can submit a
> proper patch to hopefully resolve this issue.

I think it is up to Linus to say which way he wants to go. We found that
way which omap is using.

In connection to this old patch. I think I have tested it later and
wasn't able to replicate it that's why I stop keep track on this.

Thanks,
Michal

